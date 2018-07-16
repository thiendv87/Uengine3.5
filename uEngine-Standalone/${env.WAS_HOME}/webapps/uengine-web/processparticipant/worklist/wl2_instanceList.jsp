<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="org.uengine.util.dao.*"%>
<%@ page import="org.uengine.persistence.dao.*"%>
<%@ page import="org.uengine.persistence.processinstance.*"%>
<%@ page import="org.uengine.ui.list.datamodel.DataMap"%>
<%@ page import="org.uengine.ui.list.datamodel.DataList"%>
<%@ page import="org.uengine.ui.list.datamodel.QueryCondition"%>
<%@ page import="org.uengine.ui.list.util.HttpUtils"%>
<%@ page import="org.uengine.ui.list.util.DAOListCursorUtil"%>
<%@ page import="org.uengine.util.dao.DefaultConnectionFactory"%>

<html>
<head>

<%@ include file="../../common/header.jsp"%>
<%@ include file="../../common/getLoggedUser.jsp"%>
<%@ include file="../../common/styleHeader.jsp"%>
<%@ include file="../../lib/jquery/importJquery.jsp"%>

<%@ taglib uri="http://www.uengine.org/taglibs/bpm" prefix="bpm" %>

<jsp:include page="../../scripts/formActivity.js.jsp" flush="false">
	<jsp:param name="rmClsName" value="<%=rmClsName%>" />
</jsp:include>
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />


<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/instanceList.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	setCalender("<%=loggedUserLocale%>", {buttonImage:"<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Icon/btn_calendar.gif"});
});

function changeView(objButton) {
	var divMainSearch = document.getElementById("divMainSearch");
	var divSubSearch = document.getElementById("divSubSearch");
	if (divSubSearch.style.display == "") {
		//divMainSearch.style.display = "";
		divSubSearch.style.display = "none";
		
		objButton.src = "<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/b_filteropen_<%=loggedUserLocale%>.gif";
		objButton.style.cursor="pointer";
	} else {
		//divMainSearch.style.display = "none";
		divSubSearch.style.display = "";
		
		objButton.src = "<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/b_filterclose_<%=loggedUserLocale%>.gif";
		objButton.style.cursor="pointer";
	}
}
		
</script>

<%
	/***********************************************************************/
	/*                            Define                                   */
	/***********************************************************************/

	QueryCondition condition = new QueryCondition();
	DataList dl = null;

	// Work List BF.
	//	WorkListBusinessFacade workListBF = null;

	// 占쏙옙占쏙옙占쏙옙 占쏙옙d.
	int intPageCnt = 50; // 占쏙옙 占쏙옙占쏙옙占쏙옙占� 10占쏙옙 占쏙옙
	int nPagesetSize = 10; // 占싹댐옙 占쏙옙占쏙옙占쏙옙 占쏙옙크 1~10占쏙옙占쏙옙
	int currentPage = reqMap.getInt("CURRENTPAGE", 1);
	int totalCount = 0;
	int totalPageCount = 0;

	// 占싯삼옙 占쏙옙d.
	//String strTarget = reqMap.getString("TARGETCOND","procins.instancename");
	//String strKeyword = reqMap.getString("KEYWORDCOND", "");
	//String strDateKeyStart = reqMap.getString("INIT_START_DATE", "");
	//String strDateKeyEnd = reqMap.getString("INIT_END_DATE", "");
	//String strDefCategoryId = reqMap.getString("DEFCATEGORYID", "");
	//String strDefTypeId = reqMap.getString("DEFTYPEID", "");

	// d占쏙옙 占쏙옙d.
	//String strSortColumn = reqMap.getString("SORT_COLUMN", "");
	//String strSortCond = reqMap.getString("SORT_COND", "");
	
	//String menuItemId=reqMap.getString("MENU_ITEMID","item_bpm");
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

	/*************************************************************************/
	/*                             Get Parameter                             */
	/*************************************************************************/
	String pd = reqMap.getString("processDefinition", "");
	//	if( pd == null ){
	//		return;
	//	}
	String folder = reqMap.getString("folder", "");
	String filtering = reqMap.getString("filtering", "0");
	String dispPdNameNId = "";
	if (!"".equals(folder)) {
		dispPdNameNId += folder;
	}
	if (!"".equals(pd)) {
		dispPdNameNId += "(" + pd + ")";
	}

	String search_user = reqMap.getString("search_user", "");
	String search_user_display = reqMap.getString("search_user_display", "");
	String processDefName = reqMap.getString("processDefName", "");
	String strDefinitionName = reqMap.getString("inputDefinitionName", "");
	String strInstanceName = reqMap.getString("inputInstanceName", "");
	String strWorkName = reqMap.getString("inputWorkName", "");
	String strWorkitemStartDate = reqMap.getString("workitem_start_date", "");
	String strWorkitemEndDate = reqMap.getString("workitem_end_date", "");
	String strWorkitemStartValueHandlerClass = reqMap.getString("workitem_start_value_handler_class", "");
	String strWorkitemEndValueHandlerClass = reqMap.getString("workitem_end_value_handler_class", "");
	String search_user__which_is_xml_value = reqMap.getString("search_user__which_is_xml_value", "");
	
	String p_initep = reqMap.getString("p_initep", "");

	// Filter
	//String processDefId = reqMap.getString("processDefId", "");
	String instanceInfo = reqMap.getString("instanceInfo", "");
	String endpointType = reqMap.getString("endpointType", "self");
	
	StringBuffer strAddWhere = new StringBuffer();
	
	// SimpleSearch
	String simpleKeyWord = reqMap.getString("simpleKeyWord", "");
	if (UEngineUtil.isNotEmpty(simpleKeyWord)) {
		
		String lowerCaseFunctionName = "LCASE";
		String typeOfDBMS = DAOFactory.getInstance(null).getDBMSProductName().toUpperCase();
		if ("ORACLE".equals(typeOfDBMS) || "POSTGRES".equals(typeOfDBMS)) {
		    lowerCaseFunctionName = "LOWER";
		}
		
		String simpleKeyWordLowerCase = UEngineUtil.searchStringFilter(simpleKeyWord.toLowerCase()); 
		
		strAddWhere.append(" AND ( ");
		strAddWhere.append("	").append(lowerCaseFunctionName).append("(inst.DEFNAME) 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR ");
		strAddWhere.append("	").append(lowerCaseFunctionName).append("(inst.INFO) 		LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR "); 
		strAddWhere.append("	").append(lowerCaseFunctionName).append("(inst.NAME) 		LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR "); 
		strAddWhere.append("	").append(lowerCaseFunctionName).append("(inst.INITEP)	 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR ");
		strAddWhere.append("	").append(lowerCaseFunctionName).append("(inst.INITRSNM) 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR "); 
		strAddWhere.append("	").append(lowerCaseFunctionName).append("(inst.CURREP)	 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ").append(" OR ");
		strAddWhere.append("	").append(lowerCaseFunctionName).append("(inst.CURRRSNM) 	LIKE '%").append(simpleKeyWordLowerCase).append("%' ");
		strAddWhere.append(" ) ");
		
	} else {
		if (UEngineUtil.isNotEmpty(strDefinitionName)) {
			strAddWhere.append(" AND inst.defname LIKE '%").append(UEngineUtil.searchStringFilter(strDefinitionName)).append("%' ");
		}
	
		if (UEngineUtil.isNotEmpty(strInstanceName)) {
			strAddWhere.append(" AND inst.name LIKE '%").append(UEngineUtil.searchStringFilter(strInstanceName)).append("%' ");
		}
	
		if (UEngineUtil.isNotEmpty(strWorkitemStartDate)) {
			strAddWhere.append(" AND inst.starteddate >= '").append(UEngineUtil.searchStringFilter(strWorkitemStartDate)).append("' ");
		}
	
		if (UEngineUtil.isNotEmpty(strWorkitemEndDate)) {
			strAddWhere.append(" AND inst.starteddate <= '").append(UEngineUtil.searchStringFilter(strWorkitemEndDate)).append("' ");
		}
	
		if (UEngineUtil.isNotEmpty(search_user_display)) {
			strAddWhere.append(" AND inst.currrsnm LIKE '%").append(UEngineUtil.searchStringFilter(search_user_display)).append("%' ");
		}
	
		if (UEngineUtil.isNotEmpty(search_user)) {
			strAddWhere.append(" AND inst.currep LIKE '%").append(UEngineUtil.searchStringFilter(search_user)).append("%' ");
		}
		
		if (UEngineUtil.isNotEmpty(p_initep)) {
			strAddWhere.append(" AND inst.initep = '").append(UEngineUtil.searchStringFilter(p_initep)).append("' ");
		}
		
		
	}

	/*************************************************************************/
	/*                             Set production version                    */
	/*************************************************************************/
	ProcessDefinitionRemote pdr = null;
	//replace with production version
	String pdver = null;
	String processName = "";
	//String pageType = "instance_view";
	
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
	/*                             Set filter                                */
	/*************************************************************************/
	String[] filters = {
			GlobalContext.getMessageForWeb("Running", loggedUserLocale), "inst.status = 'Running'",
			GlobalContext.getMessageForWeb("Completed", loggedUserLocale), "inst.status = 'Completed'",
			GlobalContext.getMessageForWeb("Stopped", loggedUserLocale), "inst.status = 'Stopped'",
	//"Referencing",			"",
	};

	int filteringNo = 0;
	if (filtering != null && !"".equals(filtering) && !"undefined".equals(filtering)) {
		filteringNo = Integer.parseInt(filtering);
	}
	StringBuffer filter = new StringBuffer();
	
	if (!"".equals(filters[filteringNo * 2 + 1])) {
		filter.append(" and " + filters[filteringNo * 2 + 1]);
	}

	filter.append(" and inst.isdeleted=0");

	if (UEngineUtil.isNotEmpty(pd)) {
		filter.append(" and inst.defid=" + pd);
	}
	if (UEngineUtil.isNotEmpty(instanceInfo)) {
		filter.append(" and inst.info='" + instanceInfo + "'");
	}

	String filterName = null;
	if ("0".equals(filtering)) {
		filterName = GlobalContext.getMessageForWeb("Running Process", loggedUserLocale);
	} else if ("1".equals(filtering)) {
		filterName = GlobalContext.getMessageForWeb("Completed Process", loggedUserLocale);
	} else if ("2".equals(filtering)) {
		filterName = GlobalContext.getMessageForWeb("Stopped Process", loggedUserLocale);
	}
%>
<title><%=filterName%></title>
</head>                    
<body  alink="black" vlink="black" onLoad="setListForm(document.refreshForm);" style="margin-left:10px;">
<div id="divSubSearch" class="divSubSearchStyle" style="display: none;" title="<%=GlobalContext.getMessageForWeb("Advanced Search", loggedUserLocale) %>">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
    	<colgroup>
	        <col span="1" width="110" style="font-weight: bold; font-size: 12pt;">
	        <col span="1" width="220">
	        <col span="1" width="110">
	        <col span="1" width="*">
    	</colgroup>
        <tr>
            <td class="formtitle"><%=GlobalContext.getMessageForWeb("Instance Name", loggedUserLocale) %></td>
            <td class="formcon" colspan="3"><input type="text" id="inputInstanceName" value="<%=strInstanceName %>" size='28' /></td>
        </tr>
        <tr bgcolor="#b9cae3">
            <td colspan="4" height="1"></td>
        </tr>
        <tr>
            <td class="formtitle"><%=GlobalContext.getMessageForWeb("Period", loggedUserLocale) %></td>
            <td class="formcon" >
                <input type='text' id="workitem_start_date" value="<%=strWorkitemStartDate %>" size="9" class='j_calendar' />
                ~ <input type='text' id="workitem_end_date" value="<%=strWorkitemEndDate %>" size="9" class='j_calendar'/>
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
            <td class="formtitle" ><%=GlobalContext.getMessageForWeb("Current Participant Name", loggedUserLocale) %></td>
            <td class="formcon" >
            	<input type="text" id='search_user_display' name="search_user_display" size='24' value="<%=search_user_display %>" />
            </td>
            <td class="formtitle"><%=GlobalContext.getMessageForWeb("Current Participant Id", loggedUserLocale) %></td>
            <td class="formcon" >
            	<input type="hidden" id='search_user__which_is_xml_value' name="search_user__which_is_xml_value" value="<%=search_user__which_is_xml_value %>" />
                <input type="text" id='search_user' name="search_user" size='28' value="<%=search_user %>" />
			</td>
        </tr>
    </table>
</div>


<form name="refreshForm" method="post" action="?" />

<fieldset class='block-labels' >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
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
	                    <a href="wl2_instanceList.jsp?filtering=<%=filtering %>"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchRefresh.gif" 
	                    alt="reset" align="middle" /></a>
	                </td>
	                <td width="5" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif"></td>
	                <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif">
	                    <a href="javascript: showDetailSearch('Participation', '750', '110', '<%=GlobalContext.getMessageForWeb("Search Button", loggedUserLocale)%>', '<%=GlobalContext.getMessageForWeb("Close Button", loggedUserLocale)%>');" style="text-decoration:underline;"><%=GlobalContext.getMessageForWeb("Advanced Search", loggedUserLocale) %></a></td>
	                <td>
	                    <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleRight.gif"></td>
                </tr>
            </table>
        </td>
    </tr>
</table>


</fieldset>
<%
	if (UEngineUtil.isNotEmpty(pd)) {
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
	defListFields[0] = new ListField(GlobalContext.getMessageForWeb(
			"Instance Name", loggedUserLocale),
			new InstanceTableListFieldType("name")
	);
	defListFields[1] = new ListField(GlobalContext.getMessageForWeb(
			"Definition Name", loggedUserLocale),
			new InstanceTableListFieldType("defname")
	);
	defListFields[2] = new ListField(GlobalContext.getMessageForWeb(
			"Current Participant", loggedUserLocale),
			new InstanceTableListFieldType("currrsnm")
	);
	defListFields[3] = new ListField(GlobalContext.getMessageForWeb(
			"Start Date", loggedUserLocale),
			new InstanceTableListFieldType("startedDate")
	);
	defListFields[4] = new ListField(GlobalContext.getMessageForWeb(
			"Due Date", loggedUserLocale),
			new InstanceTableListFieldType("dueDate")
	);
	defListFields[5] = new ListField(GlobalContext.getMessageForWeb(
			"End Date", loggedUserLocale),
			new InstanceTableListFieldType("finisheddate")
	);
	defListFields[6] = new ListField(GlobalContext.getMessageForWeb(
			"Information", loggedUserLocale),
			new InstanceTableListFieldType("info")
	);
	
/*
	if (pdver != null) {
		ProcessDefinition pdObj = pm.getProcessDefinition(pdver);
		if (pdObj.getInstanceListFields() != null && pdObj.getInstanceListFields().length > 0) {
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
			selectItems.add("inst.currrsnm");
			for (int i = 0; i < listFields.length; i++) {
				ListFieldType listFieldType = listFields[i].getListFieldType();
				if (listFieldType instanceof VariablePointingListFieldType) {
					ProcessVariable pv = ((VariablePointingListFieldType) listFieldType).getVariable();
					org.uengine.contexts.DatabaseSynchronizationOption dso = pv.getDatabaseSynchronizationOption();

					String tableAlias;
					if (!joiningTables.containsKey(dso.getTableName().toUpperCase())) {
						tableAlias = "t" + (++tableCnt);
						joiningTables.put(dso.getTableName().toUpperCase(), tableAlias);
						fromClause.append(
								" LEFT OUTER JOIN "
								+ dso.getTableName().toUpperCase()
								+ " " + tableAlias
						);
						fromClause.append(
								" ON inst."
								+ dso.getCorrelatedFieldName() + "="
								+ tableAlias + "."
								+ dso.getCorrelationFieldName()
						);
					} else {
						tableAlias = (String) joiningTables.get(dso.getTableName().toUpperCase());
					}

					selectItems.add(tableAlias + "." + dso.getFieldName());
				} else if (listFieldType instanceof InstanceTableListFieldType) {
					String strFieldName = ((InstanceTableListFieldType) listFieldType).getFieldName();
					if (!"startedDate".equalsIgnoreCase(strFieldName)) {
						selectItems.add("inst." + strFieldName);
					}
				}
			}
			whereClauses.add("inst.defid=" + pdObj.getBelongingDefinitionId());
			whereClauses.add(filter);

			String sep = "";
			for (int i = 0; i < selectItems.size(); i++) {
				selectClause.append(sep + selectItems.get(i));
				sep = ", ";
			}

			sep = "";
			for (int i = 0; i < whereClauses.size(); i++) {
				whereClause.append(sep + whereClauses.get(i));
				sep = " and ";
			}

			sql = "select " + selectClause + " from bpm_procinst inst " + fromClause + " where " + whereClause;
		} else {
			listFields = defListFields;
			sql = "select * from bpm_procinst inst "
					+ " where inst.defid="
					+ pdObj.getBelongingDefinitionId() + " and "
					+ filter;
		}
	} else {
		*/
		listFields = defListFields;
		sql = "SELECT DISTINCT(inst.instid), inst.* FROM bpm_procinst inst INNER JOIN bpm_rolemapping role ON role.rootinstid=inst.instid ";
		if ("self".equals(endpointType)) {
			sql += " AND role.endpoint='" + loggedUserId + "' ";
		}
		sql += filter;
		
//	}

	sql += strAddWhere + " ORDER BY starteddate desc";
%>
<table width=100% >
    <tr>
        <td ><table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder" style="border-bottom:1px solid #C5D2E3;">
                <tr class="tabletitle">
                <%
                // Make Header.
                if (listFields != null) {
                	for (int i = 0; i < listFields.length; i++) {
                %>
                    	<th nowrap="nowrap" class="col-<%=i%>" align="center"> <%=listFields[i].getDisplayName().getText(loggedUserLocale)%></th>
                    	<th width="1"><img src="../../images/Common/tabletitleline.gif" width="2" height="27"></th>
                <%
                	}
                %>
                </tr>
                <%
                	boolean isGray = false;
                		java.sql.Connection con = DefaultConnectionFactory.create().getConnection();
                		
                		try {
                			dl = DAOListCursorUtil.executeList(sql, condition, new ArrayList(), con);
                			totalCount = (int) dl.getTotalCount();
                			totalPageCount = dl.getTotalPageNo();
                		} catch (Exception e) {
                			throw e;
                		} finally {
                			if (con != null) {
                				con.close();
                			}
                		}

                		if (totalCount > 0) {
                			for (int i = 0; i < dl.size(); i++) {
                				DataMap tmpMap = (DataMap) dl.get(i);
                				//				Long instId = piDAO.getInstId();
                				String instId = tmpMap.getString("INSTID", "-");
                				//				String bold = ( "NEW".equals(piDAO.getStatus()) ? "<b>":"");
                				String bold = ("NEW".equals(tmpMap.getString("STATUS", "-")) ? "<b>" : "");
                				String bgcolor = (
                						isGray
                						? "class=\"portlet-section-body\""
                								+ " onmouseover=\"this.className = 'portlet-section-body-hover';\""
                								+ " onmouseout=\"this.className = 'portlet-section-body';\""
                						: "class=\"portlet-section-alternate\""
                								+ " onmouseover=\"this.className = 'portlet-section-alternate-hover';\""
                								+ " onmouseout=\"this.className = 'portlet-section-alternate';\""
                				);
                				isGray = !isGray;
                %>
                <tr <%=bgcolor%> onClick="viewProcInfo('<%=instId%>')" style="cursor:hand;">
                    <%
                    	for (int j = 0; j < listFields.length; j++) {
                    					//					Object fieldValue = listFields[j].getFieldValue(piDAO, null);
                    					String fieldValue = tmpMap.getString(listFields[j].getListFieldType().getFieldName(), "-");
                    					if ("currrsnm".equals(listFields[j].getListFieldType().getFieldName())) {
                    						if (fieldValue.indexOf(";") != -1) {
                    							fieldValue = fieldValue.replace(";", ", ");
                    							fieldValue = fieldValue.trim();
                    							if (fieldValue.endsWith(",")) {
                    								fieldValue = fieldValue.substring(0, fieldValue.length() - 1);
                    							}
                    						}
                    					} else if (j >= 3 && j <= 5) {
                    						if (fieldValue.length() > 10) {
                    							fieldValue = fieldValue.substring(0,16);
                    						}
                    					}
                    %>
                    <td colspan="2" align="center"><%=bold%><%=fieldValue == null ? "-" : fieldValue%></td>
                    <%
                    	}
                    %>
                </tr>
            <%
            		} // for( int j=0; j<dl.size(); j++ ){
            	} // if(totalCount > 0) {
            } // if( listFields != null ){
            %>
            </table></td>
    </tr>
    <tr>
        <td align="center"><%
        	if (totalCount > 0) {
        %>
            <!--	#####	占쌓븝옙占쏙옙抉占� start		#####	-->
            <br style="line-height:15px;">
            <bpm:page link="" totalcount="<%=totalCount%>" pagecount="<%=intPageCnt%>" pagelimit="<%=nPagesetSize%>" currentpage="<%=currentPage%>" locale="<%=loggedUserLocale%>"/>
            <br>
            <%
            	}
            %></td>
    </tr>
</table>
<%
	//	}
%>
<!-- Paging -->
	<input type="hidden" name="currentPage" value="<%=currentPage%>" />
	<input type="hidden" name="listURL" value="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/instancelist.jsp" />
	<input type="hidden" name="processDefinition" value="<%=pd%>" />
	<input type="hidden" name="folder" value="<%=folder%>" />
	<input type="hidden" name="filtering" value="<%=filtering%>" />
	<input type="hidden" name="endpointType" value="<%=endpointType %>" />
	<input type="hidden" nanme="p_initep" value="<%=p_initep %>" />
	
	<!-- input type="hidden" name="sort_column" value="<%//=strSortColumn%>" -->
	<!-- input type="hidden" name="sort_cond" value="<%//=strSortCond%>" -->
	<!-- input type="hidden" name="TARGETCOND" value="<%//=strTarget%>" -->
	
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