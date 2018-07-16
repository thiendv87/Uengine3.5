<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="org.uengine.persistence.dao.*"%>
<%@ page import="org.uengine.ui.list.datamodel.DataList"%>
<%@ page import="org.uengine.ui.list.util.DAOListCursorUtil"%>
<%@ page import="org.uengine.ui.list.datamodel.QueryCondition"%>
<%@ page import="org.uengine.util.dao.DefaultConnectionFactory"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/instanceList.js"></script>

<%@ include file="../common/header.jsp"%>
<%@ include file="../common/getLoggedUser.jsp"%>
<%@ include file="../common/styleHeader.jsp"%>
<%@ include file="../lib/jquery/importJquery.jsp"%>

<%@ taglib uri="http://www.uengine.org/taglibs/bpm" prefix="bpm" %>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<%
request.setCharacterEncoding(GlobalContext.ENCODING);

String folderId = request.getParameter("folderId");
String folderName = request.getParameter("folderName");

String globalcom = (String)session.getAttribute("loggedUserGlobalCom");

QueryCondition condition = new QueryCondition();
StringBuffer strAddWhere = new StringBuffer();

DataList dl = null;

int intPageCnt = 50;
int nPagesetSize = 10;
int currentPage = reqMap.getInt("CURRENTPAGE", 1);
int totalCount = 0;
int totalPageCount = 0;

String filtering = reqMap.getString("filtering", "0");
String definitionName = reqMap.getString("inputDefinitionName", "");
String definitionAlias = reqMap.getString("inputDefinitionAlias", "");
String simpleKeyWord = reqMap.getString("simpleKeyWord", "");

reqMap.put("folderId" ,new Integer(folderId));
reqMap.put("folderName" ,folderName);
reqMap.put("globalcom" ,globalcom);
reqMap.put("simpleKeyWord" ,simpleKeyWord);
reqMap.put("definitionName" ,definitionName);
reqMap.put("definitionAlias" ,definitionAlias);


condition.setMap(reqMap);
condition.setOnePageCount(intPageCnt);
condition.setPageNo(currentPage);


String concatFunctionString = "CONCAT(CONCAT('%', ?), '%')";
//String lowerCaseFunctionName = "LCASE";
String typeOfDBMS = DAOFactory.getInstance(null).getDBMSProductName().toUpperCase();
//if ("ORACLE".equals(typeOfDBMS) || "POSTGRES".equals(typeOfDBMS)) {
//    lowerCaseFunctionName = "LOWER";
//}

if ("POSTGRES".equals(typeOfDBMS)) {
	concatFunctionString = "'%'||?||'%'";
}

if (UEngineUtil.isNotEmpty(simpleKeyWord)) {

	//String simpleKeyWordLowerCase = simpleKeyWord.toLowerCase(); 
	
	strAddWhere.append(" AND ( ");
	strAddWhere.append("	")
		//.append(lowerCaseFunctionName)
		.append("(DEF.NAME) 	LIKE ").append(concatFunctionString).append(" OR ");
	strAddWhere.append("	")
		//.append(lowerCaseFunctionName)
		.append("(DEF.ALIAS) 	LIKE ").append(concatFunctionString);
	strAddWhere.append(" ) ");
	
} else {
	
	if (UEngineUtil.isNotEmpty(definitionName)) {
		strAddWhere.append(" AND DEF.NAME LIKE ").append(concatFunctionString); 
	}

	if (UEngineUtil.isNotEmpty(definitionAlias)) {
		strAddWhere.append(" AND DEF.ALIAS LIKE ").append(concatFunctionString); 
	}
}

ProcessManagerRemote pm = processManagerFactory.getProcessManager();
String pd = reqMap.getString("processDefinition", "");

ProcessDefinitionRemote pdr = null;
String pdver = null;
String processName = "";

if (!"".equals(pd)) {
	pdver = pm.getProcessDefinitionProductionVersion(pd);
	pdr = pm.getProcessDefinitionRemote(pdver);	
	processName = pdr.getName().getText();
}

%>
<title><%=GlobalContext.getMessageForWeb("Process", loggedUserLocale) %> - <%=folderName%></title>
</head>
<body alink="black" vlink="black" onLoad="setListForm(document.refreshForm);">
<div id="divSubSearch" style="display: none;" title="<%=GlobalContext.getMessageForWeb("Advanced Search", loggedUserLocale) %>">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <colgroup>
	        <col span="1" width="150" style="font-weight: bold; font-size: 12pt;">
	        <col span="1" width="*">
        </colgroup>
        <tr>
            <td class="formtitle"><%=GlobalContext.getMessageForWeb("Definition Name", loggedUserLocale) %></td>
            <td class="formcon"><input type="text" id="inputDefinitionName" value="<%=definitionName%>" size='25' /></td>
        </tr>
        <tr bgcolor="#b9cae3">
            <td colspan="4" height="1"></td>
        </tr>
        <tr>
            <td class="formtitle"><%=GlobalContext.getMessageForWeb("Alias", loggedUserLocale) %></td>
            <td class="formcon"><input type="text" id="inputDefinitionAlias" value="<%=definitionAlias%>" size='25' /></td>
        </tr>
    </table>
</div>
<form name="refreshForm" method="post" action="viewProcessInfo.jsp">
    <input type="hidden" id="folderId" name="folderId" value="<%=folderId %>"/>
    <input type="hidden" id="folderName" name="folderName" value="<%=folderName %>"/>
    <table border='0' width='98%' align="center" cellpadding='0' cellspacing='0'>
        <tr>
            <td valign='top'>
            	<fieldset class='block-labels' >
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                	<tr>
                    	<td>
			            <%if (!"".equals(pd)) {%>
			            	<h3><%=processName%></h3>
			            <%}%>
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
                                        <a href="viewProcessInfo.jsp?filtering=<%=filtering %>&folderId=<%=folderId%>&folderName=<%=folderName %>"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchRefresh.gif" 
                                        alt="reset" align="middle" /></a>
                                    </td>
                                    <td width="5" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif"></td>
                                    <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif">
                                        <a href="javascript: showDetailSearch('ProcessMenuTreeList', '350', '70', '<%=GlobalContext.getMessageForWeb("Search Button", loggedUserLocale)%>', '<%=GlobalContext.getMessageForWeb("Close Button", loggedUserLocale)%>');" style="text-decoration:underline;"><%=GlobalContext.getMessageForWeb("Advanced Search", loggedUserLocale) %></a></td>
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
					
					// Default fields.
					ListField[] defListFields = new ListField[4];
					defListFields[0] = new ListField(GlobalContext.getMessageForWeb("Definition Name", loggedUserLocale) , new InstanceTableListFieldType("name"));
					defListFields[1] = new ListField(GlobalContext.getMessageForWeb("Alias", loggedUserLocale) , new InstanceTableListFieldType("alias"));
					defListFields[2] = new ListField(GlobalContext.getMessageForWeb("Version", loggedUserLocale) , new InstanceTableListFieldType("prodver"));
					defListFields[3] = new ListField(GlobalContext.getMessageForWeb("Running Instance(count)", loggedUserLocale), new InstanceTableListFieldType("instcount"));
				
					listFields = defListFields;
					sql = "	SELECT DEF.DEFID, DEF.PRODVER, DEF.PRODVERID, DEF.NAME, DEF.ALIAS, " + 
						  "		(SELECT COUNT(*) FROM BPM_PROCINST INST WHERE INST.STATUS='Running' AND INST.DEFVERID=DEF.PRODVERID AND INST.ISSUBPROCESS='0') AS INSTCOUNT" + 
						  " FROM BPM_PROCDEf DEF " +
						  " WHERE DEF.PARENTFOLDER=?" +
						  "		AND DEF.ISDELETED='0' AND DEF.OBJTYPE='process' AND DEF.COMCODE=?";
					
					sql += strAddWhere + " ORDER BY DEF.DEFID DESC";	//검색시 조건문 추가
				%>
				<table width="100%">
                    <tr>
                        <td><table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder" style="border-bottom:1px solid #C5D2E3;">
                        <colgroup>
                                <col width="250px" height="27px">
			                    <col width="2px">
			                    <col width="250px">
			                    <col width="2px">
			                    <col width="50px" align="left">
			                    <col width="2px">
			                    <col width="200px" align="left">
                        </colgroup>
                                <tr class="tabletitle" align="center">
                                <%
								// Make Header.
								boolean isGray = false;
								if (listFields != null){
									for (int i = 0; i < listFields.length; i++) {
								%>
	                                <th nowrap="nowrap" class="col-<%=i%>" align="center"> <%=listFields[i].getDisplayName().getText(loggedUserLocale)%> </th>
	                                <th width="1"><img src="../images/Common/tabletitleline.gif" width="2" height="27" align="center"></th>
	                            <%	}%>
                                </tr>
                               <%
									java.sql.Connection con = DefaultConnectionFactory.create().getConnection();
									
                              		ArrayList pstmtValues = new ArrayList();
                               		
                              		pstmtValues.add(0, "folderId");
                               		pstmtValues.add(1, "globalcom");
                               		
                               		if(UEngineUtil.isNotEmpty(simpleKeyWord)){
	                               	 	pstmtValues.add(2, "simpleKeyWord");
	                               	 	pstmtValues.add(3, "simpleKeyWord");
                               		}else{
                               			if(UEngineUtil.isNotEmpty(definitionName)){
		                               	 	pstmtValues.add(2, "definitionName");
                               			}else if(UEngineUtil.isNotEmpty(definitionAlias)){
		                               	 	pstmtValues.add(2, "definitionAlias");
                               			}else{}
                               		}
                               		
                               		try {
										dl = DAOListCursorUtil.executeList(sql, condition, pstmtValues, con);
										totalCount = (int)dl.getTotalCount();
										totalPageCount = dl.getTotalPageNo();
									} catch(Exception e) {
										throw e;
									} finally {
										if ( con != null ){con.close();}
									}
								
									//while(wl.next()){
									if(totalCount > 0) {
									    AclManager acl = AclManager.getInstance();
									    HashMap permission = null;
										for ( int i=0; i<dl.size(); i++ ) {
											DataMap tmpMap = (DataMap)dl.get(i);
											String defId = tmpMap.getString("defid", "-");
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
									        
											if (loggedUserIsAdmin) {
					                            permission = new HashMap();
												permission.put(AclManager.PERMISSION_MANAGEMENT, true);
											} else {
											    permission = acl.getPermission(Integer.parseInt(defId), loggedUserId);
											}
											
											if (permission.containsKey(AclManager.PERMISSION_MANAGEMENT) 
											        || permission.containsKey(AclManager.PERMISSION_EDIT)
											        || permission.containsKey(AclManager.PERMISSION_VIEW)
											        || permission.containsKey(AclManager.PERMISSION_INITIATE)) {
								%>
								<tr <%=bgcolor%> style="cursor: pointer;" onclick="viewObjectType('<%=defId%>')" >
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
													//add end 
%>
                                    <td colspan="2" align="center"><%=bold%><font color="<%= (j==4) && (delay == true) ? "red" : "" %>"><%=(fieldValue == null) ? "-" : fieldValue%></font></td>
<%	
												} // td for loop
%>
                                </tr>
<%
											} // permission check
										}	// for( int i=0; i<dl.size(); i++ ){
									}	// if(totalCount > 0) {
								}	// if( listFields != null ){
%>
                            </table></td>
                    </tr>
                    <tr>
                        <td align="center"><% if (totalCount > 0) { %>
                            <!--	#####	paging start		#####	-->
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
	<input type="hidden" name="processDefinition" value="<%=pd%>" />
	<input type="hidden" name="inputDefinitionName" value="<%=definitionName%>" />
	<input type="hidden" name="inputDefinitionAlias" value="<%=definitionAlias%>" />
	
</form>
</body>
</html>