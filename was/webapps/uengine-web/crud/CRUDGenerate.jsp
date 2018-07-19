<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");
%>
<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<%@page import="javax.transaction.*"%>
<%@page import="org.uengine.formmanager.*"%>
<%@page import="org.uengine.contexts.HtmlFormContext"%>
<%@page import="org.uengine.contexts.MappingContext"%>
<%@page import="org.uengine.contexts.TextContext"%>
<%@page import="org.uengine.util.*"%>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%!
	public ScriptActivity createCloserScriptActivity(){
		ScriptActivity closerSA = new ScriptActivity();
		closerSA.setName("close window");
		closerSA.setScript("instance.getProcessTransactionContext().getServletResponse().getWriter().println(\"<script>window.close();opener.location.reload()</script>\")");
		
		return closerSA;
	}

%>
<%
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	String selectedTableName = request.getParameter("selectedTableName");
	String parentFolderID = request.getParameter("parentFolderID");
	int columnCount = Integer.parseInt(request.getParameter("columnCount"));
	String sql = "select ";
	String pkColumns =""; 
	String pkSource ="";
	String scriptSource = "<"+"%";
	String source="<table border=0>";
	String[] columnName = new String[columnCount];
	String[] displayName = new String[columnCount];
	Calendar c = Calendar.getInstance();
	long currentTime = c.getTimeInMillis();
	int pkCount=0;
	
	for(int i=0; i< columnCount ; i++){
		columnName[i]=request.getParameter("columnName_"+i);
		displayName[i]=request.getParameter("displayName_"+i);
		String seletedPk=request.getParameter("pk_"+i);
		if("on".equals(seletedPk)){
			pkColumns += columnName[i]+"/";
			pkCount++;
			pkSource += "<tr><td> </td><td><input type=hidden name=columnPk_"+columnName[i]+"></td></tr>";
			scriptSource +=" String pk"+pkCount+" =  request.getParameter(\"pk"+pkCount+"\");";
			//scriptSource +=" System.out.println(\"--------------------\"+pk"+pkCount+");";
			scriptSource +=" request.setAttribute(\"columnpk_"+columnName[i].toLowerCase()+"\", pk"+pkCount+");";
		}
		
		sql += columnName[i];//+" as "+displayName[i];
		if(i!=columnCount-1)
			sql +=", ";
		
		source += "<tr><td>"+displayName[i]+"</td><td><input type=text name=column_"+columnName[i]+"></td></tr>";
	}
	source +=pkSource;
	source +="</table>";
	scriptSource +="%"+">";
	source =scriptSource +source;
	
	sql += " from "+selectedTableName;
	
	StringTokenizer st = new StringTokenizer( pkColumns ,"/");
	int index=0;
	String[] pkColumn = new String[pkCount];
	while ( st.hasMoreTokens() ) {
		pkColumn[index++] = st.nextToken();
	}
	
	//add folder
	String folderName = "Set_Of_"+selectedTableName;
	String 	folderID = pm.addFolder(folderName, parentFolderID);
	System.out.println("parentFolderID :"+parentFolderID);
	pm.applyChanges();
	pm = processManagerFactory.getProcessManager();
	
	//create ModifyForm
	String definitionName = "ModifyForm_"+selectedTableName;
	String definitionFormAlias= "ModifyForm_Alias_"+selectedTableName+currentTime;
	String definition = source;
	String defVerId = FormUtil.deployFormDefinition(pm,definition,"1",definitionName,definitionFormAlias,folderID,"description","form",definition,"");
	pm.applyChanges();
	pm = processManagerFactory.getProcessManager();
	
	// ModifyForm makeProduction
	defVerId =defVerId.substring(0, defVerId.lastIndexOf("@"));
	pm.setProcessDefinitionProductionVersion(defVerId);
	
	//hidden
	String definitionId="";
	definitionId = pm.getProcessDefinitionIdByAlias(definitionFormAlias);
	pm.setVisibleProcessDefinition(definitionId, false);
	
	pm.applyChanges();
	pm = processManagerFactory.getProcessManager();
////////////////////////////////////ADD ///////////////////////////////////////////////////////	
	//create AddDataProcess
	definitionName = "AddDataProcess_"+selectedTableName;
	String addDefinitionProcessAlias= "AddDataProcess_Alias_"+selectedTableName+currentTime;
	System.out.println("adddefinitionProcessAlias:"+addDefinitionProcessAlias)	;				
	ProcessDefinition addDataProcess = new ProcessDefinition();
	addDataProcess.setName(definitionName);
	addDataProcess.setAlias(addDefinitionProcessAlias);
	addDataProcess.setVolatile(true);
	//롤
	Role[] role = new Role[1];
	role[0] = new Role("Initiator");
	addDataProcess.setRoles(role);
	//변수선언
	ProcessVariable[] pv = new ProcessVariable[columnCount+1];
	for(int i=0; i <= columnCount ; i++){
		if(i==0){//폼변수
			pv[i]=new ProcessVariable();
			pv[i].setName("pvAddForm");
			pv[i].setType(HtmlFormContext.class);
			HtmlFormContext hfc = new HtmlFormContext();
			hfc.setFormDefId("["+definitionFormAlias+"]@"+defVerId);
			pv[i].setDefaultValue(hfc);
		}else{	//입력받은 값을 담을 변수들
			pv[i]=new ProcessVariable();
			pv[i].setName("pv"+displayName[i-1]);
			pv[i].setType(String.class);
		}
	}
	addDataProcess.setProcessVariables(pv);
	//formActvity 추가
	FormActivity AddForm = new FormActivity();
	AddForm.setName("AddForm");
	AddForm.setRole(new Role("Initiator"));
	//폼 변수 -> 변수 매핑
	MappingContext mc = new MappingContext();
	ParameterContext[] pc = new ParameterContext[columnCount];
	for(int i=0; i < columnCount ; i++){	
		pc[i]= new ParameterContext();
		ProcessVariable pvMapping = new ProcessVariable();
		String strTemp = columnName[i];
		strTemp = strTemp.toLowerCase();
		strTemp = "pvAddForm.column_"+strTemp;
		pvMapping.setName(strTemp);
		pc[i].setVariable(pvMapping);
		
		TextContext tc= new TextContext();
		tc.setText("pv"+displayName[i]);
		pc[i].setArgument(tc);
	}
	mc.setMappingElements(pc);
	AddForm.setMappingContext(mc);
	AddForm.setVariableForHtmlFormContext(pv[0]);
	
	addDataProcess.addChildActivity(AddForm);
	//DatabaseMappingActivity 추가
	DatabaseMappingActivity dma = new DatabaseMappingActivity();
	dma.setName("database mapping");
	mc = new MappingContext();
	pc = new ParameterContext[columnCount];
	for(int i=0; i < columnCount ; i++){	
		pc[i]= new ParameterContext();
		ProcessVariable pvMapping = new ProcessVariable();
		pvMapping.setName("pv"+displayName[i]);
		pc[i].setVariable(pvMapping);
		
		TextContext tc= new TextContext();
		String strTemp = columnName[i];
		strTemp = strTemp.toUpperCase();
		strTemp = selectedTableName+"."+strTemp;
		tc.setText(strTemp);
		pc[i].setArgument(tc);
	}
	mc.setMappingElements(pc);
	dma.setMappingContext(mc);
	addDataProcess.addChildActivity(dma);
	addDataProcess.addChildActivity(createCloserScriptActivity());
	//프로세스 추가
	definition = GlobalContext.serialize(addDataProcess, String.class);
	String addDefVerId = pm.addProcessDefinition(definitionName,1, "description", false, definition, folderID, "", addDefinitionProcessAlias);
	addDefVerId = addDefVerId.substring(0, addDefVerId.lastIndexOf("@"));

	pm.applyChanges();
	pm = processManagerFactory.getProcessManager();
///////////////////////////////////update /////////////////////////////////////////////////////
	//create AddDataProcess
	definitionName = "UpdateDataProcess_"+selectedTableName;
	String updateDefinitionProcessAlias= "UpdateDataProcess_Alias_"+selectedTableName+currentTime;
	System.out.println("updatedefinitionProcessAlias:"+updateDefinitionProcessAlias)	;						
	ProcessDefinition UpdateDataProcess = new ProcessDefinition();
	UpdateDataProcess.setName(definitionName);
	UpdateDataProcess.setAlias(updateDefinitionProcessAlias);
	UpdateDataProcess.setVolatile(true);
	//롤
	UpdateDataProcess.setRoles(role);
	//변수선언
	ProcessVariable[] pvUpdate = new ProcessVariable[columnCount+1+pkCount];
	for(int i=0; i < pvUpdate.length ; i++){
		if(i==0){//폼변수
			pvUpdate[i]=new ProcessVariable();
			pvUpdate[i].setName("pvUpdateForm");
			pvUpdate[i].setType(HtmlFormContext.class);
			HtmlFormContext hfc = new HtmlFormContext();
			hfc.setFormDefId("["+definitionFormAlias+"]@"+defVerId);
			pvUpdate[i].setDefaultValue(hfc);
		}else if(i<pvUpdate.length-pkCount){//입력받은 값을 담을 변수들
			pvUpdate[i]=new ProcessVariable();
			pvUpdate[i].setName("pv"+displayName[i-1]);
			pvUpdate[i].setType(String.class);
		}else{	//pk변수
			pvUpdate[i]=new ProcessVariable();
			pvUpdate[i].setName("pk"+pkColumn[i-pvUpdate.length+pkCount]);
			pvUpdate[i].setType(String.class);
		}
	}
	UpdateDataProcess.setProcessVariables(pvUpdate);
	
	//scriptActivity 추가
	ScriptActivity[] sa = new ScriptActivity[pkCount];
	for(int i=0 ; i < pkCount ; i++){
		sa[i] = new ScriptActivity();
		String pkNames = "pk"+(i+1);
		sa[i].setName(pkNames);
		String scriptStr="return instance.getProcessTransactionContext().getServletRequest().getParameter(\""+pkNames+"\");";
		sa[i].setScript(scriptStr);
		sa[i].setOut(pvUpdate[i+pvUpdate.length-pkCount]);
		UpdateDataProcess.addChildActivity(sa[i]);
	}
	
	//SQLActivity1 추가
	SQLActivity sqlA1 = new SQLActivity();
	String SqlStmt = "select ";
	for(int i=0 ; i< columnCount ; i++){
		SqlStmt += columnName[i]+" as pv"+displayName[i];
		if(i+1 <columnCount)
			SqlStmt +=", ";
	}
	SqlStmt +=" from "+selectedTableName;
	String SqlStmtWhere =" where ";
	
	for(int i=0; i < pkColumn.length ; i++){
		SqlStmtWhere += pkColumn[i]+"=? ";
		if(i+1 <pkColumn.length )
			SqlStmtWhere +="And ";
	}
	SqlStmt+=SqlStmtWhere;
	sqlA1.setSqlStmt(SqlStmt);
	sqlA1.setQuery(true);
	ParameterContext[] sqlPc= new ParameterContext[pkCount];
	for(int i=0 ; i < pkCount ; i++){
		sqlPc[i]= new ParameterContext();
		sqlPc[i].setVariable(pvUpdate[i+pvUpdate.length-pkCount]);
	}
	sqlA1.setParameters(sqlPc);
	UpdateDataProcess.addChildActivity(sqlA1);
	
	//formActvity 추가
	FormActivity UpdateForm = new FormActivity();
	UpdateForm.setName("UpdateForm");
	UpdateForm.setRole(new Role("Initiator"));
	//폼 변수 -> 변수 매핑
	MappingContext mcUpdate = new MappingContext();
	ParameterContext[] pcUpdate = new ParameterContext[(columnCount*2)+pkCount];
	for(int i=0; i < columnCount ; i++){	
		pcUpdate[i]= new ParameterContext();
		ProcessVariable pvMapping = new ProcessVariable();
		String strTemp = columnName[i];
		strTemp = strTemp.toLowerCase();
		strTemp = "pvUpdateForm.column_"+strTemp;
		pvMapping.setName(strTemp);
		pcUpdate[i].setVariable(pvMapping);
		
		TextContext tc= new TextContext();
		tc.setText("pv"+displayName[i]);
		pcUpdate[i].setArgument(tc);
	}
	for(int i=columnCount; i < columnCount*2 ; i++){	
		pcUpdate[i]= new ParameterContext();
		ProcessVariable pvMapping = new ProcessVariable();
		pvMapping.setName("pv"+displayName[i-columnCount]);
		pcUpdate[i].setVariable(pvMapping);
		
		TextContext tc= new TextContext();
		String strTemp = columnName[i-columnCount];
		strTemp = strTemp.toLowerCase();
		strTemp =  "pvUpdateForm.column_"+strTemp;
		tc.setText(strTemp);
		pcUpdate[i].setArgument(tc);
	}
	for(int i=columnCount*2; i < columnCount*2+pkCount ; i++){	
		pcUpdate[i]= new ParameterContext();
		ProcessVariable pvMapping = new ProcessVariable();
		String strTemp = pkColumn[i-columnCount*2];
		strTemp = strTemp.toLowerCase();
		strTemp = "pvUpdateForm.columnpk_"+strTemp;
		pvMapping.setName(strTemp);
		pcUpdate[i].setVariable(pvMapping);
		
		TextContext tc= new TextContext();
		strTemp = "pk"+pkColumn[i-columnCount*2];
		tc.setText(strTemp);
		pcUpdate[i].setArgument(tc);
	}
	mcUpdate.setMappingElements(pcUpdate);
	UpdateForm.setMappingContext(mcUpdate);
	UpdateForm.setVariableForHtmlFormContext(pvUpdate[0]);
	UpdateDataProcess.addChildActivity(UpdateForm);
	
	//SQLActivity2 추가
	SQLActivity sqlA2 = new SQLActivity();
	SqlStmt = "update "+selectedTableName+" set ";
	for(int i=0 ; i< columnCount ; i++){
		SqlStmt += columnName[i]+"=? ";
		if(i+1 <columnCount)
			SqlStmt +=", ";
	}
	SqlStmt+=SqlStmtWhere;
	sqlA2.setSqlStmt(SqlStmt);
	
	ParameterContext[] sqlUpdatePc= new ParameterContext[columnCount+pkCount];
	for(int i=0 ; i < columnCount ; i++){
		sqlUpdatePc[i]= new ParameterContext();
		sqlUpdatePc[i].setVariable(pvUpdate[i+1]);
	}
	for(int i=columnCount ; i < pkCount+columnCount ; i++){
		sqlUpdatePc[i]= new ParameterContext();
		sqlUpdatePc[i].setVariable(pvUpdate[i+1]);
	}
	sqlA2.setParameters(sqlUpdatePc);
	UpdateDataProcess.addChildActivity(sqlA2);
	
	UpdateDataProcess.addChildActivity(createCloserScriptActivity());
	
	//프로세스 추가
	definition = GlobalContext.serialize(UpdateDataProcess, String.class);
	String updateDefVerId = pm.addProcessDefinition(definitionName,1, "description", false, definition, folderID, "", updateDefinitionProcessAlias);
	updateDefVerId = updateDefVerId.substring(0, updateDefVerId.lastIndexOf("@"));
		
	pm.applyChanges();
	pm = processManagerFactory.getProcessManager();
	
//////////////////////////////////delete////////////////////////////////////////////////////////	
	//create DeleteForm
	definitionName = "DeleteForm_"+selectedTableName;
	definitionFormAlias= "DeleteForm_Alias_"+selectedTableName+currentTime;	
	definition =  "<script>";
	definition += "function btnClick(object){";
	definition += "  if(document.forms[0].check[0].checked==true){";
	definition += "      document.forms[0].result.value=\"yes\"";
	definition += "  }else{";
	definition += "      document.forms[0].result.value=\"no\"";
	definition += "  }";
 	definition += "}";  
 	definition += "</script>";
	definition += scriptSource;
	definition += "<p align=center>Are&nbsp;you sure to delete this row ??</p>";
	definition += "<p align=center><input type=radio onclick=\"btnClick(this)\" name=check value=yes /> Yes&nbsp;&nbsp;or <input type=radio checked=checked onclick=\"btnClick(this)\" name=check value=no />no</p>";
	definition += "<p><input type=hidden name=result /></p>";
	definition += pkSource;

	defVerId = FormUtil.deployFormDefinition(pm,definition,"1",definitionName,definitionFormAlias,folderID,"description","form",definition,"");
	pm.applyChanges();
	pm = processManagerFactory.getProcessManager();
	
	// ModifyForm makeProduction
	defVerId =defVerId.substring(0, defVerId.lastIndexOf("@"));
	pm.setProcessDefinitionProductionVersion(defVerId);
	
	//hidden
	definitionId = pm.getProcessDefinitionIdByAlias(definitionFormAlias);
	pm.setVisibleProcessDefinition(definitionId, false);
	
	pm.applyChanges();
	pm = processManagerFactory.getProcessManager();
	
	//create DeleteDataProcess
	definitionName = "DeleteDataProcess_"+selectedTableName;
	String deleteDefinitionProcessAlias= "DeleteDataProcess_Alias_"+selectedTableName+currentTime;
	System.out.println("deletedefinitionProcessAlias:"+deleteDefinitionProcessAlias)	;					
	ProcessDefinition DeleteDataProcess = new ProcessDefinition();
	DeleteDataProcess.setName(definitionName);
	DeleteDataProcess.setAlias(deleteDefinitionProcessAlias);
	DeleteDataProcess.setVolatile(true);
	//롤
	DeleteDataProcess.setRoles(role);
	//변수선언
	ProcessVariable[] pvDelete = new ProcessVariable[pkCount+2];
	for(int i=0; i < pvDelete.length ; i++){
		if(i==0){//폼변수
			pvDelete[i]=new ProcessVariable();
			pvDelete[i].setName("pvDeleteForm");
			pvDelete[i].setType(HtmlFormContext.class);
			HtmlFormContext hfc = new HtmlFormContext();
			hfc.setFormDefId("["+definitionFormAlias+"]@"+defVerId);
			pvDelete[i].setDefaultValue(hfc);
		}else if(i==1){//결과 
			pvDelete[i]=new ProcessVariable();
			pvDelete[i].setName("pvResult");
			pvDelete[i].setType(String.class);
		}else{	//pk변수
			pvDelete[i]=new ProcessVariable();
			pvDelete[i].setName("pk"+pkColumn[i-2]);
			pvDelete[i].setType(String.class);
		}
	}
	DeleteDataProcess.setProcessVariables(pvDelete);	
	
	//formActivity 추가
	FormActivity deleteForm = new FormActivity();
	deleteForm.setName("DeleteForm");
	deleteForm.setRole(new Role("Initiator"));
	//폼 변수 -> 변수 매핑
	mc = new MappingContext();
	ParameterContext[] pcDelete = new ParameterContext[pkCount+1];
	for(int i=0; i < pcDelete.length ; i++){
		if(i==0){	
			pcDelete[i]= new ParameterContext();
			ProcessVariable pvMapping = new ProcessVariable();
			pvMapping.setName("pvDeleteForm.result");
			pcDelete[i].setVariable(pvMapping);
		
			TextContext tc= new TextContext();
			tc.setText("pvResult");
			pcDelete[i].setArgument(tc);
		}else{
			pcDelete[i]= new ParameterContext();
			ProcessVariable pvMapping = new ProcessVariable();
			String strTemp = pkColumn[i-1];
			strTemp = strTemp.toLowerCase();
			strTemp = "pvDeleteForm.columnpk_"+strTemp;
			pvMapping.setName(strTemp);
			pcDelete[i].setVariable(pvMapping);
		
			TextContext tc= new TextContext();
			strTemp = "pk"+pkColumn[i-1];
			tc.setText(strTemp);
			pcDelete[i].setArgument(tc);
		}
	}
	mc.setMappingElements(pcDelete);
	deleteForm.setMappingContext(mc);
	deleteForm.setVariableForHtmlFormContext(pvDelete[0]);
	
	DeleteDataProcess.addChildActivity(deleteForm);
	
	SwitchActivity SwitchA = new SwitchActivity();
	Condition[] con = new Condition[2];
	con[0]= new Or();
	con[0].getDescription().setText("yes");
	And and1 = new And();
	and1.addCondition(new Evaluate(pvDelete[1],"==","yes"));
	((Or)con[0]).addCondition(and1);

	con[1]= new Or();
	con[1].getDescription().setText("no");
	And and2 = new And();
	and2.addCondition(new Evaluate(pvDelete[1],"!=","yes"));
	((Or)con[1]).addCondition(and2);
	SwitchA.setConditions(con);
	
	//Skip
	EmptyActivity akip =new EmptyActivity();
	
	//SQLActivity 추가
	SQLActivity sqlA3 = new SQLActivity();
	SqlStmt ="delete from "+selectedTableName;
	SqlStmt+=SqlStmtWhere;
	sqlA3.setSqlStmt(SqlStmt);

	ParameterContext[] sqlDeletePc= new ParameterContext[pkCount];
	for(int i=0 ; i < pkCount ; i++){
		sqlDeletePc[i]= new ParameterContext();
		sqlDeletePc[i].setVariable(pvDelete[i+2]);
	}
	sqlA3.setParameters(sqlDeletePc);
	UpdateDataProcess.addChildActivity(sqlA1);
	
	
	SwitchA.addChildActivity(sqlA3);
	SwitchA.addChildActivity(akip);

	DeleteDataProcess.addChildActivity(SwitchA);
	DeleteDataProcess.addChildActivity(createCloserScriptActivity());
	
	//프로세스 추가
	definition = GlobalContext.serialize(DeleteDataProcess, String.class);
	String deleteDefVerId = pm.addProcessDefinition(definitionName,1, "description", false, definition, folderID, "", deleteDefinitionProcessAlias);
	deleteDefVerId = deleteDefVerId.substring(0, deleteDefVerId.lastIndexOf("@"));
		
	pm.applyChanges();
	pm = processManagerFactory.getProcessManager();	

	// ModifyForm makeProduction
	pm.setProcessDefinitionProductionVersion(addDefVerId);
	pm.setProcessDefinitionProductionVersion(updateDefVerId);
	pm.setProcessDefinitionProductionVersion(deleteDefVerId);
	pm.applyChanges();
	
	//hidden
	definitionId = pm.getProcessDefinitionIdByAlias(addDefinitionProcessAlias);
	pm.setVisibleProcessDefinition(definitionId, false);
	
	definitionId = pm.getProcessDefinitionIdByAlias(updateDefinitionProcessAlias);
	pm.setVisibleProcessDefinition(definitionId, false);
	
	definitionId = pm.getProcessDefinitionIdByAlias(deleteDefinitionProcessAlias);
	pm.setVisibleProcessDefinition(definitionId, false);
	

	String sourceListPage = CRUDAppGenerator.generateCRUDDataListPage(sql,addDefinitionProcessAlias,updateDefinitionProcessAlias,deleteDefinitionProcessAlias,columnName,pkColumn,displayName);
/*	BufferedWriter fileOut;
	try {
		fileOut = new BufferedWriter(new FileWriter("C:/DATA/WORK/uengine2.0.4f_03_LEP4/was/server/default/deploy/liferay-portal.ear/portal-web.war/html/uengine-web/crud/CRUDDataListTemplate.jsp"));
		fileOut.write(sourceListPage); 
		fileOut.close();
	} catch (IOException e) {
		e.printStackTrace();
	}
*/

	
	//create DataListForm
	definitionName = "DataListForm_"+selectedTableName;
	String dataListFormAlias= "DataListForm_Alias_"+selectedTableName+currentTime;
	definition = sourceListPage;
	defVerId = FormUtil.deployFormDefinition(pm,definition,"1",definitionName,dataListFormAlias,folderID,"description","form",definition,"");
	pm.applyChanges();
	pm = processManagerFactory.getProcessManager();
	
	// DataListForm makeProduction
	defVerId =defVerId.substring(0, defVerId.lastIndexOf("@"));
	pm.setProcessDefinitionProductionVersion(defVerId);
	pm.applyChanges();
	pm = processManagerFactory.getProcessManager();
	
%>
<html>
<head>
<script type/text="javascript">
	function sendRedirectPage() {
		setTimeout("sendUrl()", 2000);
	}

	function sendUrl() {
		
	
	}

</script>
</head>
<body>
<div id="center">
	<div class="boxtext">
	Object has been successfully saved ...
	</div>
</div>

</body>
</html>

<script type/text="javascript">
sendRedirectPage();
</script>