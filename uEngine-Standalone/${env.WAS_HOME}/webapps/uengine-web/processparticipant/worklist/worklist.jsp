<%@include file="../../common/header.jsp"%>
<%@page import="org.uengine.util.dao.*"%>
<%@page import="org.uengine.persistence.dao.*"%>
<%@page import="org.uengine.webservices.worklist.*"%>
<%@include file="../../common/getLoggedUser.jsp"%>
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

	// ??? ??.
	int intPageCnt = 10; 	// ? ???? 10? ?
	int nPagesetSize = 10;	// ?? ??? ?? 1~10??
	int currentPage = reqMap.getInt("CURRENTPAGE", 1);
	int totalCount = 0;
	int totalPageCount = 0;

	// ?? ??.
	String strTarget = reqMap.getString("TARGETCOND", "procins.instancename", loggedUserLocale, loggedUserTimeZone);
	String strKeyword = reqMap.getString("KEYWORDCOND", "", loggedUserLocale, loggedUserTimeZone);
	String strDateKeyStart=reqMap.getString("INIT_START_DATE", "", loggedUserLocale, loggedUserTimeZone);
	String strDateKeyEnd=reqMap.getString("INIT_END_DATE", "", loggedUserLocale, loggedUserTimeZone);
	String strDefCategoryId = reqMap.getString("DEFCATEGORYID", "", loggedUserLocale, loggedUserTimeZone);
	String strDefTypeId = reqMap.getString("DEFTYPEID", "", loggedUserLocale, loggedUserTimeZone);

	
	// ?? ??.
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

	// Query Condition ??.
	condition.setMap(reqMap);
	condition.setOnePageCount(intPageCnt);
	condition.setPageNo(currentPage);

	
	
	
	/***********************************************************************/
	/*                            Business Call & Data ??			       */
	/***********************************************************************/
	// Work List ??.
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
		//setError(request, dl.getErrCode());	// todo : Error ??.
//	}

	/***********************************************************************/
	/*                            View Process	                           */
	/***********************************************************************/
//	totalCount = (int)dl.getTotalCount();
//	totalPageCount = dl.getTotalPageNo();

	/*************************************************************************/
	/*                             Get Parameter                             */
	/*************************************************************************/
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	String pd = reqMap.getString("processDefinition", "");
	String folder = reqMap.getString("folder", "");
	String filtering = reqMap.getString("filtering", "0");
	String dispPdNameNId = "";
	
	if ( !"".equals(folder) ) {
		dispPdNameNId += folder;
	}
	if ( !"".equals(pd) ) {
		dispPdNameNId += "("+pd+")";
	}
	
	/*************************************************************************/
	/*                             Set production version                    */
	/*************************************************************************/
	ProcessDefinitionRemote pdr = null;
	//replace with production version
	String pdver = null;
	String processName = "";
	
	if (!"".equals(pd)) {
		pdver = pm.getProcessDefinitionProductionVersion(pd);
		pdr = pm.getProcessDefinitionRemote(pdver);	
		processName = pdr.getName().getText();
	}
	/*************************************************************************/
	/*                             Set filter                                */
	/*************************************************************************/
	String[] filters = {
		GlobalContext.getLocalizedMessageForWeb("New_Work", loggedUserLocale, "Open"), 			"(wl.status = 'NEW' or wl.status = 'CONFIRMED' or wl.status = 'DRAFT')",
		//"In Progress", 			"(wl.status='COMPLETE' and pi.status <> 'Completed')",
		GlobalContext.getLocalizedMessageForWeb("Completed", loggedUserLocale, "Closed"),			"wl.status = 'COMPLETED'",
		GlobalContext.getLocalizedMessageForWeb("Cancelled", loggedUserLocale, "Cancelled"),			"wl.status = 'CANCELLED'",
		//"Reference",			"wl.status = 'REFERENCE'",
		GlobalContext.getLocalizedMessageForWeb("Reserved", loggedUserLocale, "Reserved"),				"wl.status = 'RESERVED'"
	};
	
	Properties removableStatus = new Properties();{
		removableStatus.setProperty("REFERENCE","".intern());
		removableStatus.setProperty("CANCELLED","".intern());
		removableStatus.setProperty("COMPLETED","".intern());
	}
	
	boolean useOracle = (DAOFactory.getInstance().getDBMSProductName().startsWith("Oracle"));
	boolean useDB2 = (DAOFactory.getInstance().getDBMSProductName().startsWith("DB2"));
	
	int filteringNo = 0;
	if (filtering != null && !"".equals(filtering)) {
		filteringNo = Integer.parseInt(filtering);
	}

	
	String filter = 
//		   "((wl.dispatchOption=" + Role.DISPATCHINGOPTION_ALL    + " and wl.endpoint='" + loggedUserId + "')"
//		  +" or "
//		  +" (wl.dispatchOption=" + Role.DISPATCHINGOPTION_RACING + " and (select count(1) from bpm_roleMapping rm where rm.instId=wl.instId and rm.roleName=wl.roleName and rm.endpoint='" + loggedUserId + "') > 0))"

		   " (wl.endpoint='" + loggedUserId + "' "
		  +" or " 
		  +" (select count(1) from bpm_roleMapping rm where rm.instId=wl.instId and (rm.roleName=wl.roleName or rm.roleName=wl.refRoleName) and rm.endpoint='" + loggedUserId + "') > 0 )"
	;

		  
	if (useDB2) filter = "wl.endpoint='" + loggedUserId + "'";
	
	if ( !"".equals(filters[filteringNo*2 + 1]) ) {
		filter += " and " + filters[filteringNo*2 + 1] ;
	}
	
	filter += " and inst.isdeleted=0";
	
//	int filteringNo = 0;
//	String sql = "select wl.taskId, wl.title, wl.instId, wl.tool, wl.endpoint, wl.description, wl.startdate, wl.duedate, wl.enddate, wl.priority, wl.status, pi.name as procinstnm from bpm_worklist wl, bpm_procinst pi where ";
//	String myFilter = "wl.endpoint='" + loggedUserId + "' and wl.instid"+(useOracle?"(+)":"")+" = pi.instid and ";
//	String filtering = request.getParameter("filtering");
//	try{
//		filteringNo = Integer.parseInt(filtering);
//	} catch(Exception e){}
//	String filter = myFilter + filters[filteringNo*2 + 1] ;
//	sql = sql + filter + " order by wl.startdate desc";
//	System.out.println("SQL [WORK_LIST] : "  + sql);
%>
<html>
<head>
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
		
		function viewTaskInfo( taskid, instanceId, tracingTag ){
			var option = "width=500,height=400,scrollbars=yes,resizable=yes";
			var url = "workitemHandler.jsp?taskId="+taskid+"&instanceId="+instanceId+"&tracingTag="+tracingTag;
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
				f.processDefinition.value = arrResult[0];
				f.folder.value = arrResult[1];
				f.processDefName.value = arrResult[1] + "(" + arrResult[0] + ")";
				refresh('<%=filtering%>');
			}
		}

		function goInstanceList() {
			var url = "instancelist.jsp";
			document.refreshForm.action = url;
			document.refreshForm.submit();
		}
	</script>
	<LINK rel="stylesheet" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/form.css" type="text/css"/>
</head>
<body bgcolor="#eeeeee" alink="black" vlink="black" onload="setListForm(document.refreshForm);">
<form name="refreshForm" method="POST" action="?" style="margin: 0px">
<% if ( !"".equals(pd) ) { %>
	<h3><%=processName%></h3>
<% } %>

<center>
<font class="gamma" color="navy">
	<input type="text" name="processDefName" id="processDefName" onclick="selectProcess();" style="cursor: pointer;" 
	value="<%=UEngineUtil.isNotEmpty(dispPdNameNId) ? dispPdNameNId : GlobalContext.getLocalizedMessageForWeb("click_to_filter", loggedUserLocale, "Click to Filter")%>" />
	&nbsp;
<% for (int i=0; i*2<filters.length; i++) { %>													  
	<img align="middle" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/tree-folder<%=(i==filteringNo ? "-open":"")%>.gif"> 
	<a href="javascript:refresh('<%=i%>');"><%=(i==filteringNo ? "<b>":"")%><%=filters[i*2]%><%=(i==filteringNo ? "</b>":"")%></a>
	&nbsp;
<% } %>
	&nbsp; &nbsp; [
		<b><%=GlobalContext.getLocalizedMessageForWeb("Workitem_View", loggedUserLocale, "Workitem View") %></b>
		| 
		<a href="javascript: goInstanceList();"><%=GlobalContext.getLocalizedMessageForWeb("Process_View", loggedUserLocale, "Process View") %></a> 
	]
</font>
<%

	String strWorkName = request.getParameter("inputWorkName");
	String strInstanceName = request.getParameter("inputInstanceName");
	String strAddWhere = "";
	
	if (UEngineUtil.isNotEmpty(strWorkName)) {
		strAddWhere += " AND wl.title LIKE '%" + strWorkName + "%' "; 
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
	ListField[] defListFields = new ListField[7];
	defListFields[0] = new ListField(GlobalContext.getLocalizedMessageForWeb("Title", loggedUserLocale, "Title") , new InstanceTableListFieldType("title"));
	defListFields[1] = new ListField(GlobalContext.getLocalizedMessageForWeb("Process_Instance", loggedUserLocale, "Process Instance") , new InstanceTableListFieldType("procinstnm"));
	defListFields[2] = new ListField(GlobalContext.getLocalizedMessageForWeb("Start_Date", loggedUserLocale, "Start Date"), new InstanceTableListFieldType("startdate"));
	defListFields[3] = new ListField(GlobalContext.getLocalizedMessageForWeb("Due_Date", loggedUserLocale, "Due Date"), new InstanceTableListFieldType("duedate"));
	defListFields[4] = new ListField(GlobalContext.getLocalizedMessageForWeb("End_Date", loggedUserLocale, "End Date"), new InstanceTableListFieldType("enddate"));
	defListFields[5] = new ListField(GlobalContext.getLocalizedMessageForWeb("Priority", loggedUserLocale, "Priority"), new InstanceTableListFieldType("priority"));
	defListFields[6] = new ListField(GlobalContext.getLocalizedMessageForWeb("Status", loggedUserLocale, "Status") , new InstanceTableListFieldType("status"));
	
	
	if (UEngineUtil.isNotEmpty(pdver)) {
		ProcessDefinition pdObj = pm.getProcessDefinition(pdver);
		if (pdObj.getWorkListFields() != null && pdObj.getWorkListFields().length > 0) {
			listFields = pdObj.getWorkListFields();
			
			HashMap joiningTables = new HashMap();
			joiningTables.put("BPM_PROCINST", "inst");

			ArrayList whereClauses = new ArrayList();
			ArrayList selectItems = new ArrayList();
			StringBuffer selectClause = new StringBuffer();
			StringBuffer fromClause = new StringBuffer();
			StringBuffer whereClause = new StringBuffer();
			
			int tableCnt = 0;
			
			selectItems.add("inst.name as procinstnm");
			selectItems.add("wl.taskId");
			selectItems.add("wl.status");
			selectItems.add("wl.startdate");
			
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
					
				}else if(listFieldType instanceof WorkListTableListFieldType){
					String strFieldName = ((WorkListTableListFieldType)listFieldType).getFieldName();		
					if( !"startdate".equalsIgnoreCase(strFieldName) ){
						selectItems.add("wl." + strFieldName);
					}
				}else if(listFieldType instanceof InstanceTableListFieldType){
					String strFieldName = ((InstanceTableListFieldType)listFieldType).getFieldName();		
					//if( !"startedDate".equalsIgnoreCase(strFieldName) ){
						selectItems.add("inst." + strFieldName);
					//}
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
			
			sql = "select "
				+ selectClause
				+ " from bpm_procinst inst, bpm_worklist wl "
				+ fromClause 
				+ " where " 
				+ whereClause 
				+ " and inst.instid = wl.instid";
		} else {
			listFields = defListFields;
			sql = "select inst.name as procinstnm, wl.*"
				+ " from bpm_procinst inst, bpm_worklist wl"
				+ " where " + filter 
				+ " and inst.instid = wl.instid"
				+ " and inst.defid=" + pdObj.getBelongingDefinitionId();
		}
	} else {
		listFields = defListFields;
		sql = "select inst.name as procinstnm, wl.*"
			+ " from bpm_procinst inst, bpm_worklist wl"
			+ " where " + filter 
			+ " and inst.instid = wl.instid";
	}
	
	sql += strAddWhere + " order by wl.startdate desc";
%>
<table width="95%" border="0" cellpadding="1" cellspacing="0" >
  <tr>
    <td bgcolor="#B6CBEB">
	  <table border="0" cellpadding="3" cellspacing="0" width="100%">
	  <col span="1" align="left" width="200px">
	  <col span="1" align="left" width="*">
	  <col span="1" align="center" width="125px">
	  <col span="1" align="center" width="125px">
	  <col span="1" align="center" width="125px">
	  <col span="1" align="center" width="60px">
	  <col span="1" align="left" width="55px">
	  <col span="1" align="left" width="40px">
	  
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
		  <td>&nbsp;</td>
		</tr>
<%
		System.out.println("sql=["+sql.toString()+"]");
//		WorkListDAO wl = (WorkListDAO)GenericDAO.createDAOImpl("java:/uEngineDS", sql, WorkListDAO.class);
//		wl.setEndpoint(loggedUserId);
//		wl.select();
	
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
	
		//while(wl.next()){
		if(totalCount > 0) {
			for( int i=0; i<dl.size(); i++ ) {
				DataMap tmpMap = (DataMap)dl.get(i);
				String taskId = tmpMap.getString("taskid", "-");
				String bold = ( "NEW".equals(tmpMap.getString("status", "-")) ? "<strong>" : "");
				String status = tmpMap.getString("status", "");
%>
	    <tr class="<%=style%>" onclick="viewTaskInfo('<%=taskId%>', '<%= tmpMap.getString("instId","")%>', '<%= tmpMap.getString("TrcTag","")%>')" 
	    style="cursor:pointer;" onmouseover="this.style.backgroundColor='#DDFFFF';" onmouseout="this.style.backgroundColor='';">
<%
				for (int j=0; j<listFields.length; j++) {
//					Object fieldValue = listFields[j].getFieldValue(piDAO, null);
					String fieldValue = tmpMap.getString(listFields[j].getListFieldType().getFieldName(), "-", loggedUserLocale, loggedUserTimeZone);
%>
		  <td nowrap>
		    <font class="<%=style%>" ><%=bold%><%=fieldValue == null? "-":fieldValue%></font>
		  </td>
<%	
				}
%>
          <td nowrap>
		    <font class="<%=style%>" >
<%
				if(removableStatus.containsKey(status)){
%>
				[<a href="removeWorkItem.jsp?taskId=<%=taskId%>">remove</a>]
<%
				}
%>
		    </font>
		  </td>
		</tr>
<%
				if(style.equals("bg")) style = "gamma";
				else style="bg";
			}	// for( int i=0; i<dl.size(); i++ ){
		}	// if(totalCount > 0) {
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
	<!--	#####	????? start		#####	-->

	<br style="line-height:15px;">
	
	<bpm:page link="" totalcount="<%=totalCount%>" pagecount="<%=intPageCnt%>" pagelimit="<%=nPagesetSize%>" currentpage="<%=currentPage%>" />
<%
	}
%>
    </td>
  </tr>
</table>

	<!-- Paging -->
	<input type="hidden" name="currentPage" value="<%=currentPage%>">
	<!-- Sort -->
	<input type="hidden" name="sort_column" value="<%=strSortColumn%>">
	<input type="hidden" name="sort_cond" value="<%=strSortCond%>">

	<input type="hidden" name="listURL" value="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/workllist.jsp">
	<!-- ?? -->
	<input type="hidden" name="TARGETCOND" value="<%=strTarget%>">
		
	<input type="hidden" name="processDefinition" value="<%=pd%>">
	<input type="hidden" name="folder" value="<%=folder%>">
	<input type="hidden" name="filtering" value="<%=filtering%>">
	
	<strong>Instance Name : </strong>
	<input type="text" name="inputInstanceName" value="<%=strInstanceName %>" />
	<strong>Work Name : </strong>
	<input type="text" name="inputWorkName" value="<%=strWorkName %>" />
	<input type="submit">
</center>

</form>
</body>
</html>