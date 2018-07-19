
<html>
<head>

<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>
<%@include file="../../common/styleHeader.jsp"%>

<jsp:include page="../../scripts/formActivity.js.jsp" flush="false">
		<jsp:param name="rmClsName" value="<%=rmClsName%>" />
</jsp:include>

<%@page import="org.uengine.util.dao.*"%>
<%@page import="org.uengine.persistence.dao.*"%>
<%@page import="org.uengine.webservices.worklist.*"%>
<%@page import="org.uengine.ui.list.datamodel.DataMap"%>
<%@page import="org.uengine.ui.list.datamodel.DataList"%>
<%@page import="org.uengine.ui.list.datamodel.QueryCondition"%>
<%@page import="org.uengine.ui.list.util.HttpUtils"%>
<%@page import="org.uengine.ui.list.util.DAOListCursorUtil"%>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@ taglib uri="http://www.uengine.org/taglibs/bpm" prefix="bpm" %>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
	/***********************************************************************/
	/*                            Define                                   */
	/***********************************************************************/
	DataMap reqMap = HttpUtils.getDataMap(request, false);

	QueryCondition condition = new QueryCondition();
	DataList dl = null;

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

	/***********************************************************************/
	/*                            Check & Set Parameter                    */
	/***********************************************************************/
	// Query Condition ??.
	condition.setMap(reqMap);
	condition.setOnePageCount(intPageCnt);
	condition.setPageNo(currentPage);
	
%>	
<%
	/*************************************************************************/
	/*                             Get Parameter                             */
	/*************************************************************************/
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	String pd = reqMap.getString("processDefinition", "");
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
	String pageType="workitem_view";
	if(!"".equals(pd)){
		pdver = pm.getProcessDefinitionProductionVersion(pd);
		pdr = pm.getProcessDefinitionRemote(pdver);	
		processName = pdr.getName().getText();
	}
	/*************************************************************************/
	/*                             Set filter                                */
	/*************************************************************************/
	String[] filters = {
		GlobalContext.getLocalizedMessageForWeb("new_work", loggedUserLocale, "New Work"), 			"(wl.status = 'NEW' or wl.status = 'CONFIRMED' or wl.status = 'DRAFT')",
		//"In Progress", 			"(wl.status='COMPLETE' and pi.status <> 'Completed')",
		GlobalContext.getLocalizedMessageForWeb("completed_work", loggedUserLocale, "Completed Work"),			"wl.status = 'COMPLETED'",
		GlobalContext.getLocalizedMessageForWeb("cancelled_work", loggedUserLocale, "Cancelled Work"),			"wl.status = 'CANCELLED'",
		//"Reference",			"wl.status = 'REFERENCE'",
		GlobalContext.getLocalizedMessageForWeb("reserved_work", loggedUserLocale, "Reserved Work"),				"wl.status = 'RESERVED'"
	};
	
	Properties removableStatus = new Properties();{
		removableStatus.setProperty("REFERENCE","".intern());
		removableStatus.setProperty("CANCELLED","".intern());
		removableStatus.setProperty("COMPLETED","".intern());
	}
	
	boolean useOracle = (DAOFactory.getInstance().getDBMSProductName().startsWith("Oracle"));
	boolean useDB2 = (DAOFactory.getInstance().getDBMSProductName().startsWith("DB2"));
	
	int filteringNo = 0;
	if( filtering != null && !"".equals(filtering) && !"undefined".equals(filtering) ){
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

		  
	if(useDB2) filter = "wl.endpoint='" + loggedUserId + "'";
	
	if( !"".equals(filters[filteringNo*2 + 1]) ){
		filter += " and " + filters[filteringNo*2 + 1] ;
	}
	
	filter += " and inst.isdeleted=0";
	
%>

	<LINK rel="stylesheet" href="../../style/form.css" type="text/css"/>
	<LINK rel="stylesheet" href="../../style/calendar-win2k-cold-1.css" type="text/css"/>

	<script type="text/javascript" src="../../scripts/calendar.js"></script>
	<script type="text/javascript" src="../../scripts/calendar-setup.js"></script>
	<script type="text/javascript" src="../../scripts/calendar-en.js"></script>

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
			var screenWidth = screen.width;
			var screenHeight = screen.Height;
			var windowWidth = 950;
			var windowHeight = 650;			
			var window_left = (screenWidth-windowWidth)/2; 
 			var window_top = (screenHeight-windowHeight)/2;	
	
			var option = "left=" + window_left + ", top=" + window_top + ", width=" + windowWidth + ", height=" + windowHeight + " ,scrollbars=yes,resizable=yes";
			var url = "workitemHandler.jsp?taskId="+taskid+"&instanceId="+instanceId+"&tracingTag="+tracingTag;
			var openedWih = window.open(url, "processView", option);

			openedWih.onclose = refresh;
		}
		
		
		function selectProcess(){
			var url = "../commonfilter/selectProcessDefinition_frame.jsp";
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

		function selectDate(name) {
	        Calendar.setup({
	            inputField 		:    name,    
	            ifFormat 		:    "y-mm-dd",     
	            button 			:    name + "_trigger",  
	            align 				:    "BC",           
	            singleClick 		:    true,
	            callback 			:    true
	        });
		}	
	</script>
	

<link href="../../style/default.css" rel="stylesheet" type="text/css">	
</head>
<body  alink="black" vlink="black" onLoad="setListForm(document.refreshForm);">

<form name="refreshForm" method="post" action="?">

<table border='0' width='98%' align="center" cellpadding='0' cellspacing='0'>
<tr>
  	<td valign='top'>

<fieldset class='block-labels' >
<legend><%=GlobalContext.getLocalizedMessageForWeb("workitem_search", loggedUserLocale, "WorkItem Search") %></legend>
	<span class="sectiontitle" >Search</span>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<col span="1" width="150" style="font-weight: bold; font-size: 12pt;">			
			<col span="1" width="*">
            <col span="1" width="180">
            
				<tr><td colspan="3" bgcolor="#97aac6" height="2"></td></tr>
				<tr>
					<td class="formtitle"><%=GlobalContext.getLocalizedMessageForWeb("period", loggedUserLocale, "period") %></td>
					<td class="formcon" ><input type='hidden' name='workitem_start_value_handler_class' size='15' />
        		<input type='text' name='workitem_start_date' size='15' value='' />
        		<img align="middle" src='../../processmanager/images/calendar.gif'  id='workitem_start_date_trigger' onclick='selectDate("workitem_start_date")' />
        		~<input type='hidden' name='workitem_end_value_handler_class' size='15' />
        		<input type='text' name='workitem_end_date' size='15' value='' />
        		<img align="middle" src='../../processmanager/images/calendar.gif'  id='workitem_end_date_trigger' onclick='selectDate("workitem_end_date")' />
        		
        		<script type="text/javascript">
        			selectDate("workitem_start_date");
        			selectDate("workitem_end_date");
        		</script></td>
					<td rowspan="5" align="center"><input type="button" name="button" style="width: 100px; height:60px;" 
	            value="<%=GlobalContext.getLocalizedMessageForWeb("search", loggedUserLocale, "Search") %>" onClick="disableFuncAlert()"
	            />  </td>
                  
				</tr>
				<tr bgcolor="#b9cae3"><td colspan="2"></td></tr>
				<tr>
					<td class="formtitle"><%=GlobalContext.getLocalizedMessageForWeb("initiator", loggedUserLocale, "Initiator") %></td>
					<td class="formcon" ><input type='hidden' name='search_user__which_is_xml_value' editable='false' size='1' >
					    <input readonly name='search_user_display' size='15' />
					    <img align="middle" onclick='searchPeopleObj("search_user")' 
        		src='<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/Toolbar-toblock.gif' /></td>
					</tr>
				<tr bgcolor="#b9cae3"><td colspan="2"></td></tr>
				<tr>
					<td class="formtitle"><%=GlobalContext.getLocalizedMessageForWeb("processdefinition", loggedUserLocale, "ProcessDefinition") %></td>
					<td class="formcon" ><%

	for(int i=0; i*2 < filters.length; i++){
		if(i==filteringNo){
%>	
					    <input type='text' name='processDefName' id='processDefName'size='15' >
					    <img align="middle" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/Toolbar-toblock.gif" onClick="selectProcess();" >
					    
    <%	
		}
	}
%></td>
					</tr>
				<tr><td colspan="3" bgcolor="#97aac6" height="2"></td></tr>
			</table>


</fieldset>  
<br>
<span class="sectiontitle" >List</span>
<%	
if( !"".equals(pd) ){
%>
<h3><%=processName%></h3>
<%
}
%>

<%
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
	
	
	if (pdver!=null){	
		ProcessDefinition pdObj = pm.getProcessDefinition(pdver);
		if(pdObj.getWorkListFields()!=null && pdObj.getWorkListFields().length > 0 ){
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
				+ " and inst.instid = wl.instid"
				+ " order by wl.startdate desc";
		}else{
			listFields = defListFields;
			sql = "select inst.name as procinstnm, wl.*"
				+ " from bpm_procinst inst, bpm_worklist wl"
				+ " where " + filter 
				+ " and inst.instid = wl.instid"
				+ " and inst.defid=" + pdObj.getBelongingDefinitionId() 
				+ " order by wl.startdate desc";
		}
	}else{
		listFields = defListFields;
		sql = "select inst.name as procinstnm, wl.*"
			+ " from bpm_procinst inst, bpm_worklist wl"
			+ " where " + filter 
			+ " and inst.instid = wl.instid"
			+ " order by wl.startdate desc";
	}
%>
<table width="100%">
  <tr>
    <td>
	  <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
		<tr class="tabletitle" align="center">
<%
	// Make Header.
	boolean isGray = false;
	if( listFields != null ){
		for(int i=0; i<listFields.length; i++){
%>
		  <th nowrap class="col-<%=i%>" align="center">
           <%=listFields[i].getDisplayName().getText(loggedUserLocale)%>
		  </th>
         
          	<th width="1"><img src="../../images/Common/tabletitleline.gif" width="2" height="27"></th>
			
<%
		}		
%>
		  <th class="col-<%=listFields.length %>"></th>
		</tr>
        
<%

		java.sql.Connection con = DefaultConnectionFactory.create().getConnection();
		try {
			dl = DAOListCursorUtil.executeList(sql, condition, new ArrayList(), con);
			totalCount = (int)dl.getTotalCount();
			totalPageCount = dl.getTotalPageNo();
		} catch(Exception e) {
			throw e;
		} finally {
			if ( con != null ){con.close();}
		}
	
		//while(wl.next()){
		if(totalCount > 0) {
			for ( int i=0; i<dl.size(); i++ ) {
				DataMap tmpMap = (DataMap)dl.get(i);
				String taskId = tmpMap.getString("taskid", "-");
				String bold = "NEW".equals(tmpMap.getString("status", "-")) ? "<b>" : "";
				String status = tmpMap.getString("status", "");
				String bgcolor = (isGray ? 
								"class=\"portlet-section-body\"" +
                                " onmouseover=\"this.className = 'portlet-section-body-hover';\"" + 
                                " onmouseout=\"this.className = 'portlet-section-body';\""
                                :
                                "class=\"portlet-section-alternate\"" +
                                " onmouseover=\"this.className = 'portlet-section-alternate-hover';\"" + 
                                " onmouseout=\"this.className = 'portlet-section-alternate';\""
                );
		        isGray = !isGray;
%>
	    <tr <%=bgcolor%> onClick="viewTaskInfo('<%=taskId%>', '<%= tmpMap.getString("instId","")%>', '<%= tmpMap.getString("TrcTag","")%>')" style="cursor:hand;">
<%
				for(int j=0; j<listFields.length; j++){
					String fieldValue="";
					
					// Date legnth cut
					if ( j == 2 || j == 3 || j == 4 ) {
						fieldValue = tmpMap.getString(listFields[j].getListFieldType().getFieldName(), "-");
						if ( fieldValue.length() > 10 )
							fieldValue = fieldValue.substring(0, 16);
					}
					else
						fieldValue = tmpMap.getString(listFields[j].getListFieldType().getFieldName(), "-", loggedUserLocale, loggedUserTimeZone);
%>
		  <td colspan="2">
		    <%=bold%><%=fieldValue == null? "-":fieldValue%>
		  </td>
          
          
<%	
				}
%>
          <td nowrap>
		    
		  </td>
		</tr>
<%

			}	// for( int i=0; i<dl.size(); i++ ){
		}	// if(totalCount > 0) {
	}	// if( listFields != null ){
%>
      </table>
    </td>
  </tr>
  <tr>
    <td align="center">
<% if (totalCount > 0) { %>	
	<!--	#####	????? start		#####	-->
	<br style="line-height:15px;">
	<bpm:page link="" totalcount="<%=totalCount%>" pagecount="<%=intPageCnt%>" pagelimit="<%=nPagesetSize%>" currentpage="<%=currentPage%>" />
	<br>
<% } %>
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

</td>
</tr>
</table>

</form>
</body>
</html>