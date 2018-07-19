<%--@include file="processDefinitionList.jsp"--%>
<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>
<%@page import="java.util.*"%>
<%@page import="org.uengine.util.dao.*"%>
<%@page import="org.uengine.persistence.dao.*"%>
<%@page import="org.uengine.persistence.processinstance.*"%>
<%@page import="org.uengine.ui.list.datamodel.DataMap"%>
<%@page import="org.uengine.ui.list.datamodel.DataList"%>
<%@page import="org.uengine.ui.list.datamodel.QueryCondition"%>
<%@page import="org.uengine.ui.list.util.HttpUtils"%>
<%@page import="org.uengine.ui.list.util.DAOListCursorUtil"%>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@ taglib uri="http://www.uengine.org/taglibs/bpm" prefix="bpm" %>

<%
	request.setCharacterEncoding("UTF-8");
	response.setHeader("Cache-Control", "no-cache");
%>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<%
	/***********************************************************************/
	/*                            Define                                   */
	/***********************************************************************/

	QueryCondition condition = new QueryCondition();
	DataList dl = null;

	// Work List BF.
//	WorkListBusinessFacade workListBF = null;

	// 占쏙옙占쏙옙占쏙옙 占쏙옙d.
	int intPageCnt = 10; 	// 占쏙옙 占쏙옙占쏙옙占쏙옙占�10占쏙옙 占쏙옙
	int nPagesetSize = 10;	// 占싹댐옙 占쏙옙占쏙옙占쏙옙 占쏙옙크 1~10占쏙옙占쏙옙
	int currentPage = reqMap.getInt("CURRENTPAGE", 1);
	int totalCount = 0;
	int totalPageCount = 0;

	// 占싯삼옙 占쏙옙d.
	String strTarget = reqMap.getString("TARGETCOND", "procins.instancename");
	String strKeyword = reqMap.getString("KEYWORDCOND", "");
	String strDateKeyStart=reqMap.getString("INIT_START_DATE", "");
	String strDateKeyEnd=reqMap.getString("INIT_END_DATE", "");
	String strDefCategoryId = reqMap.getString("DEFCATEGORYID", "");
	String strDefTypeId = reqMap.getString("DEFTYPEID", "");

	
	// d占쏙옙 占쏙옙d.
	String strSortColumn = reqMap.getString("SORT_COLUMN", "");
	String strSortCond = reqMap.getString("SORT_COND", "");
	String menuItemId=reqMap.getString("MENU_ITEMID","item_bpm");
//	String filtering = reqMap.getString("FILTERING","");
//	RequestContext reqCtx = new RequestContext(request);
//	User logdUser = reqCtx.getUser();
//	loggedUserCompanyId=   logdUser.getCompanyId();

	
	/***********************************************************************/
	/*                            Check & Set Parameter                    */
	/***********************************************************************/
//	reqMap.put("USER_ID",loggedUserId);
//	reqMap.put("USER_LOGIN_NAME",loggedUserLoginName);
//	reqMap.put("LOGGEDUSERCOMPANYID",loggedUserCompanyId);
	//reqMap.put("USER_ID","12345");	// test.
	//reqMap.put("FILTERING","");	// test.

	// Query Condition 占쏙옙d.
	condition.setMap(reqMap);
	condition.setOnePageCount(intPageCnt);
	condition.setPageNo(currentPage);

	
	
	
	/***********************************************************************/
	/*                            Business Call & Data 占쏙옙占쏙옙			       */
	/***********************************************************************/
	// Work List 占쏙옙환.
//	workListBF = new WorkListBusinessFacade();
//	if("item_bpm".equals(menuItemId)){
//		dl = workListBF.getWorkList(condition);
//	}
	//}else {
		//dl = workListBF.getWorkListSON(condition);
	//}
	/***********************************************************************/
	/*                            Error Check	                           */
	/***********************************************************************/
//	if( dl != null && dl.getErrCode() != null){
		//setError(request, dl.getErrCode());	// todo : Error 처占쏙옙.
//	}

	/***********************************************************************/
	/*                            View Process	                           */
	/***********************************************************************/
//	totalCount = (int)dl.getTotalCount();
//	totalPageCount = dl.getTotalPageNo();
%>	
<%
	/*************************************************************************/
	/*                             Get Parameter                             */
	/*************************************************************************/
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	String pd = reqMap.getString("processDefinition", "");
//	if( pd == null ){
//		return;
//	}
	String folder = reqMap.getString("folder", "");
	String filtering = reqMap.getString("filtering", "0");
	String dispPdNameNId = "";
	if( !"".equals(folder) ){
		dispPdNameNId += folder;
	}
	if( !"".equals(pd) ){
		dispPdNameNId += "("+pd+")";
	}
	/*************************************************************************/
	/*                             Set production version                    */
	/*************************************************************************/
	ProcessDefinitionRemote pdr = null;
	//replace with production version
	String pdver = null;
	String processName = "";
	if(!"".equals(pd)){
		pdver = pm.getProcessDefinitionProductionVersion(pd);
		pdr = pm.getProcessDefinitionRemote(pdver);	
		processName = pdr.getName().getText();
	}
	/*************************************************************************/
	/*                             Set filter                                */
	/*************************************************************************/
	String[] filters = {
		GlobalContext.getLocalizedMessageForWeb("In_Progress", loggedUserLocale, "In Progress"), 			"( status <> 'Completed' or status <> 'Stopped')",
		GlobalContext.getLocalizedMessageForWeb("Completed", loggedUserLocale, "Completed"),			"status = 'Completed'",
		GlobalContext.getLocalizedMessageForWeb("Stopped", loggedUserLocale, "Stopped"),				"status = 'Stopped'",
		//"Referencing",			"",
	};
	
	int filteringNo = 0;
	if( filtering != null && !"".equals(filtering) ){
		filteringNo = Integer.parseInt(filtering);
	}
	String filter = "inst.instId in (select rootInstId from bpm_rolemapping where endpoint='" + loggedUserId + "')";
	if( !"".equals(filters[filteringNo*2 + 1]) ){
		filter += " and " + filters[filteringNo*2 + 1] ;
	}
	
	filter += " and inst.isdeleted=0";

%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/en_US.css">
	<link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/bbs.css">
	<script language="JavaScript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/bbs.js"></script>
	<script>
		function refresh( filtering ){
			var f = document.refreshForm;
			f.filtering.value=filtering;
			f.currentPage.value="1";
			f.action = "?";
			f.target = "_self";
			f.submit();
		}
		
		function viewProcInfo( instanceid ){
			var option = "width=500,height=400,scrollbars=yes,resizable=yes";
			var url = "../viewProcessInformation.jsp?omitHeader=yes&instanceId="+instanceid;
			window.open(url, "wihspace", option)
		}
		
		function selectProcess(){
			var url = "selectProcessDefinition_frame.jsp";
			var StrOption ;
			StrOption  = "dialogWidth:500px;dialogHeight:300px;";
			StrOption += "center:on;scroll:auto;status:off;resizable:no";
			var arrResult = new Array(2);
			arrResult = showModalDialog (url , window, StrOption);
			//arrResult = window.open (url , "", StrOption);
			if( arrResult != null && arrResult[0] != null ){
				var f = document.refreshForm;
				f.processDefinition.value=arrResult[0];
				f.folder.value=arrResult[1];
				document.all.processDefName.innerText = arrResult[1] + "(" + arrResult[0] + ")";
				refresh('<%=filtering%>');
			}
		}

		function goInstanceList() {
			var url = "worklist.jsp";
			document.refreshForm.action = url;
			document.refreshForm.submit();
		}

		function goInstanceList() {
			var url = "worklist.jsp?inputInstanceName=" + document.refreshForm.inputInstanceName.value;
			this.location.href = url;
		}
	</script>
	<LINK rel="stylesheet" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/form.css" type="text/css"/>
</head>
<body bgcolor="#eeeeee" alink="black" vlink="black" onload="setListForm(document.refreshForm);">
<%	
if( !"".equals(pd) ){
%>
<!-- h3><%=processName%></h3-->
<%
}
%>
<center>
<font class="gamma" color="navy">
	<input type="text" name="processDefName" id="processDefName" onclick="selectProcess();" style="cursor: pointer;" 
	value="<%=UEngineUtil.isNotEmpty(dispPdNameNId) ? dispPdNameNId : GlobalContext.getLocalizedMessageForWeb("click_to_filter", loggedUserLocale, "click to filter")%>" />
	&nbsp;
<% for (int i=0; i*2 < filters.length; i++) { %>													  
	<img align="middle" src="<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/tree-folder<%=(i==filteringNo ? "-open":"")%>.gif"> 
	<a href="javascript:refresh('<%=i%>');"><%=(i==filteringNo ? "<b>":"")%><%=filters[i*2]%><%=(i==filteringNo ? "</b>":"")%></a>
	&nbsp;
<% } %>
	&nbsp; &nbsp;
	[
		<a href="javascript: goInstanceList();"><%=GlobalContext.getLocalizedMessageForWeb("Workitem_View", loggedUserLocale, "Workitem View") %></a>
		| 
		<strong><%=GlobalContext.getLocalizedMessageForWeb("Process_View", loggedUserLocale, "Process View") %></strong> 
	]
</font>
<%
	String strWorkName = request.getParameter("inputWorkName");
	String strInstanceName = request.getParameter("inputInstanceName");
	String strAddWhere = "";
	
	if (UEngineUtil.isNotEmpty(strWorkName)) {
		strAddWhere += " AND inst.defname LIKE '%" + strWorkName + "%' "; 
	} else {
		strWorkName = "";
	}
	
	if (UEngineUtil.isNotEmpty(strInstanceName)) {
		strAddWhere += " AND inst.name LIKE '%" + strInstanceName + "%' "; 
	} else {
		strInstanceName = "";
	}
	
	String sql;
	ListField[] listFields = null;
	
	HashMap colors = new HashMap(10);
	colors.put("Failed", "red");
	colors.put("Suspended", "yellow");
	colors.put("Skipped", "blue");
	colors.put("Ready", "green");
	colors.put("Running", "green");
	
	// Default fields.
	ListField[] defListFields = new ListField[6];
	defListFields[0] = new ListField(GlobalContext.getLocalizedMessageForWeb("Instance_Name", loggedUserLocale, "Instance Name"), new InstanceTableListFieldType("name"));
	defListFields[1] = new ListField(GlobalContext.getLocalizedMessageForWeb("Definition_Name", loggedUserLocale, "Definition Name"), new InstanceTableListFieldType("defname"));
	defListFields[2] = new ListField(GlobalContext.getLocalizedMessageForWeb("Start_Date", loggedUserLocale, "Start Date"), new InstanceTableListFieldType("startedDate"));
	defListFields[3] = new ListField(GlobalContext.getLocalizedMessageForWeb("Due_Date", loggedUserLocale, "Due Date"), new InstanceTableListFieldType("dueDate"));
	defListFields[4] = new ListField(GlobalContext.getLocalizedMessageForWeb("End_Date", loggedUserLocale, "End Date"), new InstanceTableListFieldType("finisheddate"));
	defListFields[5] = new ListField(GlobalContext.getLocalizedMessageForWeb("Information", loggedUserLocale, "Information"), new InstanceTableListFieldType("info"));
	
	if (pdver!=null){	
		ProcessDefinition pdObj = pm.getProcessDefinition(pdver);
		if(pdObj.getInstanceListFields()!=null && pdObj.getInstanceListFields().length > 0){
			listFields = pdObj.getInstanceListFields();
			
			HashMap joiningTables = new HashMap();
			joiningTables.put("BPM_PROCINST", "inst");
					
			ArrayList whereClauses = new ArrayList();
			ArrayList selectItems = new ArrayList();
			StringBuffer selectClause = new StringBuffer();
			StringBuffer fromClause = new StringBuffer();
			StringBuffer whereClause = new StringBuffer();
			
			int tableCnt = 0;
			
			selectItems.add("inst.INSTID");
			selectItems.add("inst.STATUS");
			selectItems.add("inst.startedDate");
			for(int i=0; i<listFields.length; i++){
				ListFieldType listFieldType = listFields[i].getListFieldType();
				if(listFieldType instanceof VariablePointingListFieldType){
					ProcessVariable pv = ((VariablePointingListFieldType)listFieldType).getVariable();
					org.uengine.contexts.DatabaseSynchronizationOption dso = pv.getDatabaseSynchronizationOption();
					
					String tableAlias;
					if(!joiningTables.containsKey(dso.getTableName().toUpperCase())){
						tableAlias = "t"+(++tableCnt);
						joiningTables.put(dso.getTableName().toUpperCase(), tableAlias);
						fromClause.append(" LEFT OUTER JOIN " + dso.getTableName().toUpperCase() + " " + tableAlias);
						fromClause.append(" ON inst." + dso.getCorrelatedFieldName() + "=" + tableAlias + "." + dso.getCorrelationFieldName());
					}else{
						tableAlias = (String)joiningTables.get(dso.getTableName().toUpperCase());
					}
					
					selectItems.add(tableAlias + "." + dso.getFieldName());
				}else if(listFieldType instanceof InstanceTableListFieldType){
					String strFieldName = ((InstanceTableListFieldType)listFieldType).getFieldName();		
					if( !"startedDate".equalsIgnoreCase(strFieldName) ){
						selectItems.add("inst." + strFieldName);
					}
				}
			}
			whereClauses.add("inst.defid=" + pdObj.getBelongingDefinitionId() );
			whereClauses.add(filter);
			
			String sep = "";
			for(int i=0; i<selectItems.size(); i++){
				selectClause.append(sep + selectItems.get(i));
				sep = ", ";
			}
	
			sep = "";
			for(int i=0; i<whereClauses.size(); i++){
				whereClause.append(sep + whereClauses.get(i));
				sep = " and ";
			}
			
			sql = "select " + selectClause + " from bpm_procinst inst" + fromClause 
				+ " where " + whereClause;
		}else{
			listFields = defListFields;
			sql = "select * from bpm_procinst inst" 
				+ " where inst.defid=" + pdObj.getBelongingDefinitionId() 
				+ " and " + filter;
		}
	}else{
		listFields = defListFields;
		sql = "select * from bpm_procinst inst" 
			+ " where " + filter;
	}
	
	sql += strAddWhere + " order by starteddate desc";
%>
<table width="95%" border="0" cellpadding="1" cellspacing="0" >
  <tr>
    <td bgcolor="#B6CBEB">
	  <table border="0" cellpadding="3" cellspacing="0" width="100%">
	  <col span="1" align="left" width="250px">
	  <col span="1" align="left" width="160px">
	  <col span="1" align="center" width="110px">
	  <col span="1" align="center" width="110px">
	  <col span="1" align="center" width="110px">
	  <col span="1" align="center" width="*">
		<tr class="beta">
<%
	// Make Header.
	if( listFields != null ){
		for(int i=0; i<listFields.length; i++){
%>
		  <th nowrap>
            <font class="beta" ><%=listFields[i].getDisplayName().getText(loggedUserLocale)%></font>
		  </th>
<%
		}		
%>
		</tr>
<%
		System.out.println("sql=["+sql.toString()+"]");
//		ProcessInstanceDAO piDAO = (ProcessInstanceDAO)GenericDAO.createDAOImpl("java:/uEngineDS", sql, ProcessInstanceDAO.class);
//		piDAO.select();
		java.sql.Connection con = DefaultConnectionFactory.create().getConnection();
		try{
			dl = DAOListCursorUtil.executeList(sql, condition, new ArrayList(), con);
			totalCount = (int)dl.getTotalCount();
			totalPageCount = dl.getTotalPageNo();
		}catch(Exception e){
			throw e;
		}finally{
			if( con != null ){con.close();}
		}
		
		String style="bg";
		
//		while(piDAO.next()){
		if(totalCount > 0) {
			for( int i=0; i<dl.size(); i++ ){
				DataMap tmpMap = (DataMap)dl.get(i);
//				Long instId = piDAO.getInstId();
				String instId = tmpMap.getString("INSTID", "-");
//				String bold = ( "NEW".equals(piDAO.getStatus()) ? "<b>":"");
				String bold = ( "NEW".equals(tmpMap.getString("STATUS", "-")) ? "<b>":"");
%>
	    <tr class="<%=style%>" onclick="viewProcInfo('<%=instId%>')" style="cursor: pointer;" 
	    onmouseover="this.style.backgroundColor='#DDFFFF';" onmouseout="this.style.backgroundColor='';">
<%
				for(int j=0; j<listFields.length; j++){
//					Object fieldValue = listFields[j].getFieldValue(piDAO, null);
					String fieldValue = tmpMap.getString(listFields[j].getListFieldType().getFieldName(), "-");
%>
		  <td nowrap>
		    <font class="<%=style%>" ><%=bold%><%=fieldValue == null? "-":fieldValue%></font>
		  </td>
<%	
				}
%>
		</tr>
<%
				if(style.equals("bg")){
					style = "gamma";
				}else{
					style="bg";
				}
			}	// for( int j=0; j<dl.size(); j++ ){
		} 	// if(totalCount > 0) {
	}	// if( listFields != null ){
%>
      </table>
    </td>
  </tr>
  <tr>
    <td align="center">
<%
	if(totalCount>0){
%>	
	<!--	#####	占쌓븝옙占쏙옙抉占�start		#####	-->

	<br style="line-height:15px;">
	<bpm:page link="" totalcount="<%=totalCount%>" pagecount="<%=intPageCnt%>" pagelimit="<%=nPagesetSize%>" currentpage="<%=currentPage%>" />
<%
	}
%>
    </td>
  </tr>
</table>
<%
//	}
%>

<form name="refreshForm" method="POST" action="?" style="margin: 0px">
	<!-- Paging -->
	<input type="hidden" name="currentPage" value="<%=currentPage%>">
	<!-- Sort -->
	<input type="hidden" name="sort_column" value="<%=strSortColumn%>">
	<input type="hidden" name="sort_cond" value="<%=strSortCond%>">

	<input type="hidden" name="listURL" value="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/instancelist.jsp">
	<!-- 占싯삼옙 -->
	<input type="hidden" name="TARGETCOND" value="<%=strTarget%>">
	
	<input type="hidden" name="processDefinition" value="<%=pd%>">
	<input type="hidden" name="folder" value="<%=folder%>">
	<input type="hidden" name="filtering" value="<%=filtering%>">
	
	<strong>Instance Name : </strong>
	<input type="text" name="inputInstanceName" value="<%=strInstanceName %>" />
	<strong>Definition Name : </strong>
	<input type="text" name="inputWorkName" value="<%=strWorkName %>" />
	<input type="submit">
</form>

</center>
</body>
</html>
