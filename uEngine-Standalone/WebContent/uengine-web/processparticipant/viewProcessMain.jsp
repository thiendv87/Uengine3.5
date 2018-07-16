<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="org.uengine.persistence.dao.*"%>
<%@ page import="org.uengine.ui.list.datamodel.DataList"%>
<%@ page import="org.uengine.ui.list.util.DAOListCursorUtil"%>
<%@ page import="org.uengine.ui.list.datamodel.QueryCondition"%>
<%@ page import="org.uengine.util.dao.DefaultConnectionFactory"%>

<%@ include file="../common/header.jsp"%>
<%@ include file="../common/getLoggedUser.jsp"%>

<%@ taglib uri="http://www.uengine.org/taglibs/bpm" prefix="bpm" %>
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
DataList dl = null;
QueryCondition condition = new QueryCondition();

int totalCount = 0;
int intPageCnt = 50;
int currentPage = reqMap.getInt("CURRENTPAGE", 1);
int nPagesetSize = 10;
int totalPageCount = 0;

String userId = (String)session.getAttribute("loggedUserId");

String pd = reqMap.getString("processDefinition", "");
String filtering = reqMap.getString("filtering", "0");
String simpleKeyWord = reqMap.getString("simpleKeyWord", "");
String definitionName = reqMap.getString("inputDefinitionName", "");
String definitionAlias = reqMap.getString("inputDefinitionAlias", "");
String parentFolderName = reqMap.getString("inputParentFolderName", "");

reqMap.put("userId" ,userId);
reqMap.put("simpleKeyWord" ,simpleKeyWord.toLowerCase());
reqMap.put("definitionName" ,definitionName);
reqMap.put("definitionAlias" ,definitionAlias);
reqMap.put("parentFolderName" ,parentFolderName);

condition.setMap(reqMap);
condition.setOnePageCount(intPageCnt);
condition.setPageNo(currentPage);

StringBuffer strAddWhere = new StringBuffer();
StringBuffer sql = new StringBuffer();

String lowerCaseFunctionName = "LCASE";
String concatFunctionString = "CONCAT(CONCAT('%', ?), '%')";
String typeOfDBMS = "";
try{
	typeOfDBMS = DAOFactory.getInstance(null).getDBMSProductName().toUpperCase();
}catch (Exception e) {
    e.printStackTrace();
}

if ("ORACLE".equals(typeOfDBMS) || "POSTGRES".equals(typeOfDBMS)) {
    lowerCaseFunctionName = "LOWER";
}

if ("POSTGRES".equals(typeOfDBMS)) {
	concatFunctionString = "'%'||?||'%'";
}

if (UEngineUtil.isNotEmpty(simpleKeyWord)) {
     
    strAddWhere.append(" AND (");
    strAddWhere.append("     ").append(lowerCaseFunctionName).append("(PDEF.NAME) LIKE ").append(concatFunctionString).append(" OR ");
    strAddWhere.append("     ").append(lowerCaseFunctionName).append("(DEF.NAME)  LIKE ").append(concatFunctionString).append(" OR ");
    strAddWhere.append("     ").append(lowerCaseFunctionName).append("(DEF.ALIAS) LIKE ").append(concatFunctionString);
    strAddWhere.append(" )   ");
    
} else {
    if (UEngineUtil.isNotEmpty(parentFolderName)) {
    	strAddWhere.append(" AND ")
    	.append(lowerCaseFunctionName)
    	.append("(PDEF.NAME) LIKE ").append(concatFunctionString); 
    }
    
    if (UEngineUtil.isNotEmpty(definitionName)) {
    	strAddWhere.append(" AND ")
    	.append(lowerCaseFunctionName)
    	.append("(DEF.NAME) LIKE ").append(concatFunctionString);
    }

    if (UEngineUtil.isNotEmpty(definitionAlias)) {
    	strAddWhere.append(" AND ")
    	.append(lowerCaseFunctionName)
    	.append("(DEF.ALIAS) LIKE ").append(concatFunctionString);
    }
}

sql.append("SELECT \r\n") 
.append("	DEF.DEFID, \r\n") 
.append("	DEF.PRODVER, \r\n") 
.append("	DEF.PRODVERID, \r\n") 
.append("	DEF.NAME, \r\n") 
.append("	DEF.ALIAS, \r\n") 
.append("	PDEF.NAME AS PARENTFOLDERNAME, \r\n") 
.append("	COUNT(INST.INSTID) AS INITCOUNT, \r\n") 
.append("	( \r\n") 
.append("		SELECT COUNT(*) \r\n") 
.append("		FROM BPM_PROCINST INST \r\n") 
.append("		WHERE INST.STATUS='Running' \r\n") 
.append("		AND INST.DEFVERID=DEF.PRODVERID \r\n") 
.append("		AND INST.ISSUBPROCESS='0' \r\n") 
.append("	)AS INSTCOUNT \r\n") 
.append(" FROM \r\n") 
.append("	BPM_PROCDEf DEF \r\n") 
.append("	LEFT JOIN BPM_PROCDEF PDEF ON DEF.PARENTFOLDER = PDEF.DEFID \r\n") 
.append("	,BPM_PROCINST INST \r\n") 
.append(" WHERE \r\n") 
.append("	DEF.DEFID = INST.DEFID \r\n") 
.append("	AND DEF.ISDELETED='0' \r\n") 
.append("	AND DEF.OBJTYPE='process' \r\n") 
.append("	AND INST.ISSUBPROCESS = '0' \r\n") 
.append("	AND INST.INITEP = ? \r\n") 
.append("	AND INST.STATUS='Running' \r\n")
.append(strAddWhere.toString()) //검색조건
.append(" GROUP BY DEF.DEFID, DEF.PRODVER, DEF.PRODVERID, DEF.NAME, DEF.ALIAS, PDEF.NAME ");

ProcessManagerRemote pm = null;
ProcessDefinitionRemote pdr = null;
String pdver = null;
String processName = "";

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

ListField[] listFields = null;

ListField[] defListFields = new ListField[6];
defListFields[0] = new ListField(GlobalContext.getMessageForWeb("Folder Name", loggedUserLocale), new InstanceTableListFieldType("parentfoldername"));
defListFields[1] = new ListField(GlobalContext.getMessageForWeb("Definition Name", loggedUserLocale) , new InstanceTableListFieldType("name"));
defListFields[2] = new ListField(GlobalContext.getMessageForWeb("Alias", loggedUserLocale) , new InstanceTableListFieldType("alias"));
defListFields[3] = new ListField(GlobalContext.getMessageForWeb("Version", loggedUserLocale) , new InstanceTableListFieldType("prodver"));
defListFields[4] = new ListField(GlobalContext.getMessageForWeb("Running Instance(count)", loggedUserLocale), new InstanceTableListFieldType("instcount"));
defListFields[5] = new ListField(GlobalContext.getMessageForWeb("Executed Instance(count)", loggedUserLocale), new InstanceTableListFieldType("initcount"));

listFields = defListFields;
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@ include file="../common/styleHeader.jsp"%>
<%@ include file="../lib/jquery/importJquery.jsp"%>

<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/instanceList.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	setListForm(document.refreshForm);
});
</script>
<title><%=GlobalContext.getLocalizedMessageForWeb("process_index_title", loggedUserLocale, "Frequently Executed Processes") %></title>
</head>

<body>
<div id="divSubSearch" style="display: none; height:100%;" title="<%=GlobalContext.getMessageForWeb("Advanced Search", loggedUserLocale) %>">
    <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
        <colgroup>
	        <col span="1" width="150" style="font-weight: bold; font-size: 12pt;">
	        <col span="1" width="*">
        </colgroup>
        <tr>
            <td class="formtitle"><%=GlobalContext.getMessageForWeb("Folder Name", loggedUserLocale) %></td>
            <td class="formcon"><input type="text" id="inputParentFolderName" value="<%=parentFolderName %>" size='25' /></td>
        </tr>
        <tr bgcolor="#b9cae3">
            <td colspan="4" height="1"></td>
        </tr>
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
<form name="refreshForm" method="post" action="viewProcessMain.jsp?userId=<%=userId%>">
    <table border='0' width='98%' align="center" cellpadding='0' cellspacing='0'>
        <tr>
            <td valign='top'>
            	<fieldset class='block-labels' >
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                	<tr>
                    	<td>
			            <%if (UEngineUtil.isNotEmpty(pd)) {%>
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
                                        <a href="viewProcessMain.jsp?filtering=<%=filtering %>"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchRefresh.gif" 
                                        alt="reset" align="middle" /></a>
                                    </td>
                                    <td width="5" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif"></td>
                                    <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif">
                                        <a href="javascript: showDetailSearch('Process', '400', 100, '<%=GlobalContext.getMessageForWeb("Search Button", loggedUserLocale)%>', '<%=GlobalContext.getMessageForWeb("Close Button", loggedUserLocale)%>');" style="text-decoration:underline;"><%=GlobalContext.getMessageForWeb("Advanced Search", loggedUserLocale) %></a></td>
                                    <td>
                                        <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleRight.gif"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                </fieldset>
				<table width="100%">
                    <tr>
                        <td>
                        	<table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder" style="border-bottom:1px solid #C5D2E3;">
                            <colgroup>
                            	<col width="150px" height="27px">
			                    <col width="2px">
			                    <col width="*px">
			                    <col width="2px">
			                    <col width="200px" align="left">
			                    <col width="2px">
			                    <col width="80px" align="left">
			                    <col width="2px">
			                    <col width="180px">
			                    <col width="2px">
			                    <col width="180px">
                            </colgroup>
                                <tr class="tabletitle" align="center">
                                <%
								// Make Header.
								boolean isGray = false;
								if (listFields != null){
									for (int i = 0; i < listFields.length; i++) {
								%>
	                                <th nowrap="nowrap" class="col-<%=i%>" align="center"> <%=listFields[i].getDisplayName().getText(loggedUserLocale)%> </th>
	                                <th width="2"><img src="../images/Common/tabletitleline.gif" width="2" height="27"></th>
	                            <%	}%>
                                </tr>
                               <%
									java.sql.Connection con = DefaultConnectionFactory.create().getConnection();
                               		
                               		ArrayList pstmtValues = new ArrayList();
                               	 	pstmtValues.add(0, "userId");
                               	 	
                               	 	if(UEngineUtil.isNotEmpty(simpleKeyWord)){
	                               	 	pstmtValues.add("simpleKeyWord");
	                               	 	pstmtValues.add("simpleKeyWord");
	                               	 	pstmtValues.add("simpleKeyWord");
                               	 	}else{
                               	 		if(UEngineUtil.isNotEmpty(parentFolderName)){
		                               	 	pstmtValues.add("parentFolderName");
                               	 		}
                               	 		if(UEngineUtil.isNotEmpty(definitionName)){
		                               	 	pstmtValues.add("definitionName");
                               	 		}
                               	 		if(UEngineUtil.isNotEmpty(definitionAlias)){
		                               	 	pstmtValues.add("definitionAlias");
                               	 		}
                               	 	}
                               	 	
                               	 	try {
										dl = DAOListCursorUtil.executeList(sql.toString(), condition, pstmtValues, con);
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
								%>
								<tr <%=bgcolor%> style="cursor: pointer;" onClick="viewObjectType('<%=defId%>')" >
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
                                    <td colspan="2" align="center"><%=bold%><font color="<%= (delay == true) ? "red" : "" %>"><%=(fieldValue == null) ? "-" : fieldValue%></font></td>
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
                            <!--    #####    paging start    #####    -->
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
	<input type="hidden" name="inputParentFolderName" value="<%=parentFolderName%>" />
</form>
</body>
</html>