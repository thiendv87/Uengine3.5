<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="org.uengine.util.dao.*"%>
<%@ page import="org.uengine.persistence.dao.*"%>
<%@ page import="org.uengine.webservices.worklist.*"%>
<%@ page import="org.uengine.ui.list.datamodel.DataMap"%>
<%@ page import="org.uengine.ui.list.datamodel.DataList"%>
<%@ page import="org.uengine.ui.list.datamodel.QueryCondition"%>
<%@ page import="org.uengine.ui.list.util.HttpUtils"%>
<%@ page import="org.uengine.ui.list.util.DAOListCursorUtil"%>
<%@ page import="org.uengine.util.dao.DefaultConnectionFactory"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@ include file="../../common/header.jsp"%>
<%@ include file="../../common/getLoggedUser.jsp"%>
<%@ include file="../../common/styleHeader.jsp"%>
<%@ include file="../../lib/jquery/importJquery.jsp"%>
<%@ taglib uri="http://www.uengine.org/taglibs/bpm" prefix="bpm"%>
<jsp:include page="../../scripts/formActivity.js.jsp" flush="false">
	<jsp:param name="rmClsName" value="<%=rmClsName%>" />
</jsp:include>
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<%
	/***********************************************************************/
	/*                            Define                                   */
	/***********************************************************************/

	QueryCondition condition = new QueryCondition();
	DataList dl = null;

	int intPageCnt = 50;
	int nPagesetSize = 10;
	int currentPage = reqMap.getInt("CURRENTPAGE", 1);
	int totalCount = 0;
	int totalPageCount = 0;

	//String strTarget = reqMap.getString("TARGETCOND", "procins.instancename", loggedUserLocale, loggedUserTimeZone);
	//String strKeyword = reqMap.getString("KEYWORDCOND", "", loggedUserLocale, loggedUserTimeZone);
	//String strDateKeyStart=reqMap.getString("INIT_START_DATE", "", loggedUserLocale, loggedUserTimeZone);
	//String strDateKeyEnd=reqMap.getString("INIT_END_DATE", "", loggedUserLocale, loggedUserTimeZone);
	//String strDefCategoryId = reqMap.getString("DEFCATEGORYID", "", loggedUserLocale, loggedUserTimeZone);
	//String strDefTypeId = reqMap.getString("DEFTYPEID", "", loggedUserLocale, loggedUserTimeZone);

	
	//String strSortColumn = reqMap.getString("SORT_COLUMN", "");
	//String strSortCond = reqMap.getString("SORT_COND", "");
	//String menuItemId=reqMap.getString("MENU_ITEMID","item_bpm");

	/***********************************************************************/
	/*                            Check & Set Parameter                    */
	/***********************************************************************/
	// Query Condition.
	condition.setMap(reqMap);
	condition.setOnePageCount(intPageCnt);
	condition.setPageNo(currentPage);
	
	/*************************************************************************/
	/*                             Get Parameter                             */
	/*************************************************************************/
	String pd = reqMap.getString("processDefinition", "");
	//String folder = reqMap.getString("folder", "");
	String filtering = reqMap.getString("filtering", "0");
	//String dispPdNameNId = "";
	
	String processDefName = reqMap.getString("processDefName", "");
	String strWorkName = reqMap.getString("inputWorkName", "");
	String strInstanceName = reqMap.getString("inputInstanceName", "");
	String strWorkitemStartDate = reqMap.getString("workitem_start_date", "");
	String strWorkitemStartValueHandlerClass = reqMap.getString("workitem_start_value_handler_class", "");
	String strWorkitemEndDate = reqMap.getString("workitem_end_date", "");
	String strWorkitemEndValueHandlerClass = reqMap.getString("workitem_end_value_handler_class", "");
	String search_user_display = reqMap.getString("search_user_display", "");
	String search_user__which_is_xml_value = reqMap.getString("search_user__which_is_xml_value", "");
	String search_user = reqMap.getString("search_user", "");

	// Filter
	String processDefId = reqMap.getString("processDefId", "");
	String instanceInfo = reqMap.getString("instanceInfo", "");
	String endpointType = reqMap.getString("endpointType", "self");
	
	// Filter
	/*
	if ( !"".equals(folder) ) {
		dispPdNameNId += folder;
	}
	if ( !"".equals(pd) ) {
		dispPdNameNId += "("+pd+")";
	}
	*/

	StringBuffer strAddWhere = new StringBuffer();

	String simpleKeyWord = reqMap.getString("simpleKeyWord", "");
	if (UEngineUtil.isNotEmpty(simpleKeyWord)) {
		
		String lowerCaseFunctionName = "LCASE";
		String typeOfDBMS = DAOFactory.getInstance(null).getDBMSProductName().toUpperCase();
		if ("ORACLE".equals(typeOfDBMS) || "POSTGRES".equals(typeOfDBMS)) {
		    lowerCaseFunctionName = "LOWER";
		}
		
		String simpleKeyWordLowerCase = UEngineUtil.searchStringFilter(simpleKeyWord.toLowerCase()); 
		
		strAddWhere.append("\r\n AND ( ");
		strAddWhere.append("\r\n	").append(lowerCaseFunctionName).append("(wl.TITLE) 		LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR ");
		strAddWhere.append("\r\n	").append(lowerCaseFunctionName).append("(inst.DEFNAME) 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR ");
		strAddWhere.append("\r\n	").append(lowerCaseFunctionName).append("(inst.INFO) 		LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR "); 
		strAddWhere.append("\r\n	").append(lowerCaseFunctionName).append("(inst.NAME) 		LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR "); 
		strAddWhere.append("\r\n	").append(lowerCaseFunctionName).append("(inst.INITEP) 		LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR ");
		strAddWhere.append("\r\n	").append(lowerCaseFunctionName).append("(inst.INITRSNM) 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR ");
		strAddWhere.append("\r\n	").append(lowerCaseFunctionName).append("(inst.CURREP) 		LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR ");
		strAddWhere.append("\r\n	").append(lowerCaseFunctionName).append("(inst.CURRRSNM) 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ");
		strAddWhere.append("\r\n ) ");
		
	} else {
		if (UEngineUtil.isNotEmpty(strWorkName)) {
			strAddWhere.append("\r\n AND wl.title LIKE '%").append(UEngineUtil.searchStringFilter(strWorkName)).append("%' "); 
		}

		if (UEngineUtil.isNotEmpty(strInstanceName)) {
			strAddWhere.append("\r\n AND inst.name LIKE '%").append(UEngineUtil.searchStringFilter(strInstanceName)).append("%' "); 
		}

		if (UEngineUtil.isNotEmpty(strWorkitemStartDate)) {
			strAddWhere.append("\r\n AND inst.starteddate >= '").append(UEngineUtil.searchStringFilter(strWorkitemStartDate)).append("' "); 
		}

		if (UEngineUtil.isNotEmpty(strWorkitemEndDate)) {
			strAddWhere.append("\r\n AND inst.starteddate <= '").append(UEngineUtil.searchStringFilter(strWorkitemEndDate)).append("' "); 
		}
		
		if (UEngineUtil.isNotEmpty(search_user_display)) {
			strAddWhere.append("\r\n AND inst.initrsnm LIKE '%").append(UEngineUtil.searchStringFilter(search_user_display)).append("%' "); 
		}
		
		if (UEngineUtil.isNotEmpty(search_user)) {
			strAddWhere.append("\r\n AND inst.initep LIKE '%").append(UEngineUtil.searchStringFilter(search_user)).append("%' "); 
		}

		if(UEngineUtil.isNotEmpty(processDefName)){
			strAddWhere.append("\r\n AND inst.defname LIKE '%").append(UEngineUtil.searchStringFilter(processDefName)).append("%'");
		}
	}
	
	
	/*************************************************************************/
	/*                             Set production version                    */
	/*************************************************************************/
	ProcessDefinitionRemote pdr = null;
	//replace with production version
	String pdver = null;
	String processName = "";
	//String pageType = "workitem_view";
	
	ProcessManagerRemote pm = null; 
	
	try {
		pm = processManagerFactory.getProcessManager();
	
		if (UEngineUtil.isNotEmpty(pd)) {
			pdver = pm.getProcessDefinitionProductionVersion(pd);
			pdr = pm.getProcessDefinitionRemote(pdver);	
			processName = pdr.getName().getText();
		}
	} finally {
		pm.remove();
	}
	
	/*************************************************************************/
    /*                        DB Function set                                */
    /*************************************************************************/
	String typeOfDBMS = DAOFactory.getInstance().getDBMSProductName().toUpperCase();
    String sysdate = "SYSDATE";
    
    if ("ORACLE".equals(typeOfDBMS)) {
        sysdate = "SYSDATE";
    } else if ("HSQL".equals(typeOfDBMS)) {
        sysdate = "CURRENT_TIMESTAMP";
    } else if ("MYSQL".equals(typeOfDBMS)) {
        sysdate = "now()";
    } else if ("POSTGRES".equals(typeOfDBMS)) {
        sysdate = "CURRENT_TIMESTAMP";
    }
	
	/*************************************************************************/
	/*                             Set filter                                */
	/*************************************************************************/
	String[] filters = {
		GlobalContext.getMessageForWeb("New Work", loggedUserLocale),
		"wl.status in ('NEW', 'CONFIRMED')",
		GlobalContext.getMessageForWeb("Completed Work", loggedUserLocale),
		"wl.status = 'COMPLETED'",
		GlobalContext.getMessageForWeb("Cancelled Work", loggedUserLocale),
		"wl.status = 'CANCELLED'",
		GlobalContext.getMessageForWeb("Reserved Work", loggedUserLocale),
		"wl.status = 'RESERVED'",
		GlobalContext.getMessageForWeb("Delayed Work", loggedUserLocale),
		"(wl.status = 'NEW' or wl.status = 'CONFIRMED' or wl.status = 'DRAFT') AND WL.DUEDATE<="+sysdate,
		GlobalContext.getMessageForWeb("Saved Work", loggedUserLocale),
		"wl.status = 'DRAFT'"
		
		//"In Progress", 			"(wl.status='COMPLETE' and pi.status <> 'Completed')",
		//"Reference",			"wl.status = 'REFERENCE'",
	};
	
	/*
	Properties removableStatus = new Properties();{
		removableStatus.setProperty("REFERENCE","".intern());
		removableStatus.setProperty("CANCELLED","".intern());
		removableStatus.setProperty("COMPLETED","".intern());
	}
	*/
	
	//boolean useOracle = (DAOFactory.getInstance().getDBMSProductName().startsWith("Oracle"));
	//boolean useDB2 = (DAOFactory.getInstance().getDBMSProductName().startsWith("DB2"));
	
	int filteringNo = 0;
	if( filtering != null && !"".equals(filtering) && !"undefined".equals(filtering) ){
		filteringNo = Integer.parseInt(filtering);
	}
	
	if (filteringNo == 4) {
		if ("ORACLE".equals(typeOfDBMS))
			filters[filters.length-1] += " and (TO_CHAR(wl.duedate,'yyyy-MM-dd HH24:mm:ss') < TO_CHAR("+sysdate+",'yyyy-MM-dd HH24:mm:ss'))";
		else if ("HSQL".equals(typeOfDBMS))
			filters[filters.length-1] += " and (TO_CHAR(wl.duedate,'yyyy-MM-dd HH24:mm:ss') < TO_CHAR("+sysdate+",'yyyy-MM-dd HH24:mm:ss'))";
		else if ("MYSQL".equals(typeOfDBMS))
			filters[filters.length-1] += " and wl.duedate < "+sysdate;
		else if ("POSTGRES".equals(typeOfDBMS))
			filters[filters.length-1] += " and wl.duedate < "+sysdate;
	}

	
	String filter = "";
	
	if( !"".equals(filters[filteringNo*2 + 1]) ){
		filter += filters[filteringNo*2 + 1] ;
	}
	
	if (UEngineUtil.isNotEmpty(processDefId)) {
		filter += " and inst.defid=" + processDefId;
	}
	if (UEngineUtil.isNotEmpty(instanceInfo)) {
		filter += " and inst.info='"+instanceInfo+"'";
	}
	
	String filterName = "";
	if ("0".equals(filtering)) {
		filterName = GlobalContext.getMessageForWeb("New Work", loggedUserLocale);
	} else if ("1".equals(filtering)) {
		filterName = GlobalContext.getMessageForWeb("Completed Work", loggedUserLocale);
	} else if ("2".equals(filtering)) {
		filterName = GlobalContext.getMessageForWeb("Cancelled Work", loggedUserLocale);
	} else if ("3".equals(filtering)) {
		filterName = GlobalContext.getMessageForWeb("Reserved Work", loggedUserLocale);
	} else if ("4".equals(filtering)) {
		filterName = GlobalContext.getMessageForWeb("Delayed Work", loggedUserLocale);
	} else if ("5".equals(filtering)) {
		filterName = GlobalContext.getMessageForWeb("Saved Work", loggedUserLocale);
	}
%>
<title><%=filterName %></title>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/instanceList.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	setCalender("<%=loggedUserLocale%>", {buttonImage:"<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Icon/btn_calendar.gif"});
});
</script>
</head>
<body  alink="black" vlink="black" onLoad="setListForm(document.refreshForm);">
<div id="divSubSearch" style="display: none;" title="<%=GlobalContext.getMessageForWeb("Advanced Search", loggedUserLocale) %>">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <colgroup>
	        <col span="1" width="110" style="font-weight: bold; font-size: 12pt;">
	        <col span="1" width="220">
	        <col span="1" width="110">
	        <col span="1" width="*">
        </colgroup>
        <tr>
            <td class="formtitle"><%=GlobalContext.getMessageForWeb("Instance Name", loggedUserLocale) %></td>
            <td class="formcon"><input type="text" id="inputInstanceName" value="<%=strInstanceName %>" size='28' /></td>
            <td class="formtitle"><%=GlobalContext.getMessageForWeb("Work Name", loggedUserLocale) %></td>
            <td class="formcon"><input type="text" id="inputWorkName" value="<%=strWorkName %>" size='24' /></td>
        </tr>
        <tr bgcolor="#b9cae3">
            <td colspan="4" height="1"></td>
        </tr>
        <tr>
            <td class="formtitle"><%=GlobalContext.getMessageForWeb("Period", loggedUserLocale) %></td>
            <td class="formcon" >
                <input type='text' id="workitem_start_date" value="<%=strWorkitemStartDate %>" size="10" class='j_calendar' />
                ~ <input type='text' id="workitem_end_date" value="<%=strWorkitemEndDate %>" size="10" class='j_calendar' />
			</td>
            <td class="formtitle" ><%=GlobalContext.getMessageForWeb("ProcessDefinition", loggedUserLocale) %></td>
            <td class="formcon" ><input type='text' id='processDefName' size='24' value="<%=processDefName %>" onKeyDown="javascript:resetHiddenValue('ProcessDefinition');"/>
                <img align="middle" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/Toolbar-toblock.gif" onClick="selectProcess();" style="cursor: pointer;" />
			</td>
        </tr>
        <tr bgcolor="#b9cae3">
            <td colspan="4" height="1"></td>
        </tr>
        <tr>
            <td class="formtitle"><%=GlobalContext.getMessageForWeb("Initiator Name", loggedUserLocale) %></td>
            <td class="formcon" >
            	<input type="hidden" id='search_user__which_is_xml_value' name="search_user__which_is_xml_value" value="<%=search_user__which_is_xml_value %>" />
                <input type="text" id='search_user_display' name='search_user_display' size='28' value="<%=search_user_display%>" />
			</td>
            <td class="formtitle" ><%=GlobalContext.getMessageForWeb("Initiator Id", loggedUserLocale) %></td>
            <td class="formcon" >
            	<input type="text" id='search_user' name='search_user' size='24' value="<%=search_user %>" />
            </td>
        </tr>
    </table>
</div>
<form name="refreshForm" method="post" action="wl2_workList.jsp">
    <table border='0' width='98%' align="center" cellpadding='0' cellspacing='0'>
        <tr>
            <td valign='top'>
            	<fieldset class='block-labels' >
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                    	<td>
                <%
                if (UEngineUtil.isNotEmpty(pd)) {
				%>
                	<h3><%=processName%></h3>
                <%
				}
				%>
                    	</td>
                        <td align="right" style="padding:10px 0;">
                        	<table width="*" border="0" cellspacing="0" cellpadding="0">
                                <tr height="25" valign="middle">
                                    <td>
                                        <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitle.gif" width="70" height="25"></td>
                                    <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif" valign="middle">                        	
                                        <input type="text" name="simpleKeyWord" value="<%=simpleKeyWord%>" size='15'  style="background:#FFF;"/>
                                    </td>
                                    <td width="5" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif"></td>
                                    <td width="*" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif" valign="middle">
                                        <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchGo.gif" 
                                        alt="Search" align="middle" onClick="searchSimple();" style="cursor: pointer;" />
                                        <a href="wl2_workList.jsp?filtering=<%=filtering %>"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchRefresh.gif" 
                                        alt="reset" align="middle" /></a>
                                    </td>
                                    <td width="5" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif"></td>
                                    <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif">
                                        <a href="javascript: showDetailSearch('WorkList', '750', '100', '<%=GlobalContext.getMessageForWeb("Search Button", loggedUserLocale)%>', '<%=GlobalContext.getMessageForWeb("Close Button", loggedUserLocale)%>');" style="text-decoration:underline;"><%=GlobalContext.getMessageForWeb("Advanced Search", loggedUserLocale) %></a></td>
                                    <td>
                                        <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleRight.gif"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>

                
                </fieldset>
<%
	String sql;
	ListField[] listFields = null;
	/*
	HashMap colors = new HashMap(10);
	colors.put("Failed", "red");
	colors.put("Suspended", "yellow");
	colors.put("Skipped", "blue");
	colors.put("Ready", "green");
	colors.put("Running", "green");
	*/
	
	// Default fields.
	ListField[] defListFields = new ListField[8];
	defListFields[0] = new ListField(GlobalContext.getMessageForWeb("msg.Task", loggedUserLocale) , new InstanceTableListFieldType("title"));
	defListFields[1] = new ListField(GlobalContext.getMessageForWeb("Instance Name", loggedUserLocale) , new InstanceTableListFieldType("procinstnm"));
	defListFields[2] = new ListField(GlobalContext.getMessageForWeb("Initiator", loggedUserLocale) , new InstanceTableListFieldType("initrsnm"));
	defListFields[3] = new ListField(GlobalContext.getMessageForWeb("Start Date", loggedUserLocale), new InstanceTableListFieldType("startdate"));
	defListFields[4] = new ListField(GlobalContext.getMessageForWeb("Due Date", loggedUserLocale), new InstanceTableListFieldType("duedate"));
	defListFields[5] = new ListField(GlobalContext.getMessageForWeb("End Date", loggedUserLocale), new InstanceTableListFieldType("enddate"));
	defListFields[6] = new ListField(GlobalContext.getMessageForWeb("Priority", loggedUserLocale), new InstanceTableListFieldType("priority"));
	defListFields[7] = new ListField(GlobalContext.getMessageForWeb("Status", loggedUserLocale) , new InstanceTableListFieldType("status"));

/*
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
		selectItems.add("inst.initrsnm");
		selectItems.add("wl.taskId");
		selectItems.add("wl.status");
		selectItems.add("wl.startdate");
		
		for(int i=0; i<listFields.length; i++){
			ListFieldType listFieldType = listFields[i].getListFieldType();
			if(listFieldType instanceof VariablePointingListFieldType){
				ProcessVariable pv = ((VariablePointingListFieldType)listFieldType).getVariable();
				org.uengine.contexts.DatabaseSynchronizationOption dso = pv.getDatabaseSynchronizationOption();
				
				String tableAlias;
				if (!joiningTables.containsKey(dso.getTableName().toUpperCase())) {
					tableAlias = "t"+(++tableCnt);
					joiningTables.put(dso.getTableName().toUpperCase(), tableAlias);
					fromClause.append(" LEFT OUTER JOIN " + dso.getTableName().toUpperCase() + " " + tableAlias);
					fromClause.append(" ON inst." + dso.getCorrelatedFieldName() + "=" + tableAlias + "." + dso.getCorrelationFieldName());
				} else {
					tableAlias = (String)joiningTables.get(dso.getTableName().toUpperCase());
				}
				
				selectItems.add(tableAlias + "." + dso.getFieldName());
				
			} else if (listFieldType instanceof WorkListTableListFieldType) {
				String strFieldName = ((WorkListTableListFieldType)listFieldType).getFieldName();		
				if ( !"startdate".equalsIgnoreCase(strFieldName) ) {
					selectItems.add("wl." + strFieldName);
				}
			} else if (listFieldType instanceof InstanceTableListFieldType) {
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
			+ " from bpm_procinst inst, bpm_worklist wl  "
			+ fromClause 
			+ " where " 
			+ whereClause 
			+ " and inst.instid = wl.instid";
	} else {
		listFields = defListFields;
		sql = "select inst.name as procinstnm, inst.initrsnm, wl.*"
			+ " from bpm_procinst inst, bpm_worklist wl"
			+ " where " + filter 
			+ " and inst.instid = wl.instid"
			+ " and inst.defid=" + pdObj.getBelongingDefinitionId();
	}
} else {
*/	
	listFields = defListFields;
	sql = "\r\n select DISTINCT INST.NAME as procinstnm, INST.initrsnm, INST.INFO, WL.* FROM BPM_PROCINST INST, ";
	sql += "\r\n BPM_WORKLIST WL INNER JOIN BPM_ROLEMAPPING ROLE ON (WL.ROLENAME=ROLE.ROLENAME OR WL.REFROLENAME=ROLE.ROLENAME) ";
	if ("self".equals(endpointType)) {
		sql += "\r\n OR WL.ENDPOINT='" + loggedUserId + "' ";
	}
	sql += "\r\n where " + filter;
	sql += "\r\n AND WL.INSTID=INST.INSTID AND WL.INSTID=ROLE.INSTID AND INST.ISDELETED=0 AND INST.STATUS NOT IN ('Stopped', 'Failed') ";
	if ("self".equals(endpointType)) {
		sql += "\r\n AND ROLE.ENDPOINT='" + loggedUserId + "' ";
	}
//}

	sql += strAddWhere + "\r\n order by wl.startdate desc";
%>
                <table width="100%">
                    <tr>
                        <td><table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder" style="border-bottom:1px solid #C5D2E3;">
                                <tr class="tabletitle" align="center">
                                <%
								// Make Header.
								boolean isGray = false;
								if (listFields != null) {
									for (int i = 0; i < listFields.length; i++) {
								%>
	                                <th nowrap="nowrap" class="col-<%=i%>" align="center"> <%=listFields[i].getDisplayName().getText(loggedUserLocale)%></th>
	                                <th width="1"><img src="../../images/Common/tabletitleline.gif" width="2" height="27"></th>
	                            <% } %>
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
                                <tr <%=bgcolor%> style="cursor: pointer;"
	    onClick="viewTaskInfo('<%=taskId%>', '<%= tmpMap.getString("instId","")%>', '<%= tmpMap.getString("TrcTag","")%>', '<%=status%>')" >
                                    <%
				for(int j=0; j<listFields.length; j++){
					String fieldValue = "";
					fieldValue = tmpMap.getString(listFields[j].getListFieldType().getFieldName(), "-", loggedUserLocale, loggedUserTimeZone);
					
					//add start : YYYY-MM-DD HH:MM:SS to YYYY-MM-DD HH:MM by grayspec
					if (j >= 3 && j <= 5) {
						if (fieldValue.length() > 10) {
							fieldValue = fieldValue.substring(0,16);
						}
					}
					boolean delay = false;
					if (j == 4) {
						
						String endDate = tmpMap.getString(listFields[5].getListFieldType().getFieldName(), "-", loggedUserLocale, loggedUserTimeZone);
						if ("0".equals(filtering) || "4".equals(filtering)) {
							java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:MM");
							String todayDate = sdf.format(new java.util.Date());
							int dateCompare = fieldValue.compareTo(todayDate);
							if (dateCompare < 0)
								delay = true;
						}
					}
					//add end 
%>
                                    <td colspan="2" align="center"><%=bold%><font color="<%= (j==4) && (delay == true) ? "red" : "" %>"><%=(fieldValue == null) ? "-" : fieldValue%></font></td>
                                    <%	
				}
%>
                                </tr>
                                <%

			}	// for( int i=0; i<dl.size(); i++ ){
		}	// if(totalCount > 0) {
	}	// if( listFields != null ){
%>
                            </table></td>
                    </tr>
                    <tr>
                        <td align="center"><% if (totalCount > 0) { %>
                            <!--	#####	????? start		#####	-->
                            <br style="line-height:15px;">
                            <bpm:page link="" totalcount="<%=totalCount%>" pagecount="<%=intPageCnt%>" pagelimit="<%=nPagesetSize%>" currentpage="<%=currentPage%>" locale="<%=loggedUserLocale%>" />
                            <br>
                            <% } %></td>
                    </tr>
                </table>
                </td>
        </tr>
    </table>
    
	<input type="hidden" name="currentPage" value="<%=currentPage%>" />
	<input type="hidden" name="listURL" value="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/workllist.jsp" />
	<input type="hidden" name="processDefinition" value="<%=pd%>" />
	<input type="hidden" name="filtering" value="<%=filtering%>" />
	<input type="hidden" name="endpointType" value="<%=endpointType %>" />
	<!-- input type="hidden" name="sort_column" value="<%//=strSortColumn%>" -->
	<!-- input type="hidden" name="sort_cond" value="<%//=strSortCond%>" -->
	<!-- input type="hidden" name="TARGETCOND" value="<%//=strTarget%>" -->
	<!-- input type="hidden" name="folder" value="<%//=folder%>" -->
	
	<input type="hidden" name="inputInstanceName" value="<%=strInstanceName %>" />
	<input type="hidden" name="inputWorkName" value="<%=strWorkName %>" />
	<input type="hidden" name="workitem_start_value_handler_class" value="<%=strWorkitemStartValueHandlerClass%>" />
	<input type="hidden" name="workitem_start_date" value="<%=strWorkitemStartDate%>" />
	<input type="hidden" name="workitem_end_value_handler_class" value="<%=strWorkitemEndValueHandlerClass%>" />
	<input type="hidden" name="workitem_end_date" value="<%=strWorkitemEndDate%>" />
	<input type="hidden" name="search_user__which_is_xml_value" value="<%=search_user__which_is_xml_value%>" />
	<input type="hidden" name="search_user_display" value="<%=search_user_display%>" />
	<input type="hidden" name="search_user" value="<%=search_user%>" />
	<input type="hidden" name="processDefName" value="<%=processDefName%>" />

</form>
</body>
</html>