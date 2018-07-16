<%@page import="org.uengine.security.AclManager"%>
<%@page import="org.uengine.kernel.GlobalContext"%>
<%
	//ProcessInstance instance = piRemote;

	//String keyword = initiationActivity.getKeyword().getText();	
	//if (!UEngineUtil.isNotEmpty(keyword)) {
	//	keyword = initiationActivity.getName().getText();
	//}
	
	//keyword = java.net.URLEncoder.encode(keyword, "UTF-8");
	java.util.Hashtable<String, String> mapPageName4Url = new java.util.Hashtable<String, String>();
	AclManager acl = AclManager.getInstance();
	//java.util.HashMap permission = acl.getPermission(Integer.parseInt(pdr.getBelongingDefinitionId()), loggedUserId);
	java.util.HashMap permission = acl.getPermission(Integer.parseInt(request.getParameter("processDefinition")), loggedUserId);
	
	mapPageName4Url.put("Workitem Page", "showFormContext.jsp");
	mapPageName4Url.put("Workitem Information", GlobalContext.WEB_CONTEXT_ROOT + "/wih/wihDefaultTemplate/showFlowChart.jsp");
	
	/*
	* 개선 관련지식 텝 삭제 관련
	* Author: CJS
	*/
	//mapPageName4Url.put("Definition Improve", GlobalContext.WEB_CONTEXT_ROOT + "/wih/wihDefaultTemplate/showImproveDefinition.jsp");
	//mapPageName4Url.put("Related Knowledge", "http://www.google.com/search?hl="+loggedUserLocale+"&q=" + keyword + "&lr=");

	String strContentPageName = request.getParameter("contentPageName");
	
	if (!UEngineUtil.isNotEmpty(strContentPageName)) {
		strContentPageName = "Workitem Page";
	}
	
	String strContentUrl = mapPageName4Url.get(strContentPageName);
%>
<script type="text/javascript">
var listStrMenuText = new Array();
</script>
<%!
private String createTabMenuItem(String strMenuId, String loggedUserLocale, String strActionUrl) {
	String strTempHtml = "";
	if (UEngineUtil.isNotEmpty(strMenuId)) {
		String strMenuText = GlobalContext.getMessageForWeb(strMenuId, loggedUserLocale);
		strTempHtml += "<li id=\"" + strMenuId + "_menuItem\">"
				+ "<a href=\"javascript:changeDisplayMenuItem('" + strActionUrl + "', '" + strMenuId + "')\">"
				+ strMenuText + "</a></li>"
				+ "<script>listStrMenuText['" + strMenuId + "'] = '" + strMenuText + "'</script>";
	}
	return strTempHtml;
}
%>
<ul class="tabs">
<%
	StringBuffer strJsAllElement = new StringBuffer();
	out.println(createTabMenuItem("Workitem Page", loggedUserLocale, mapPageName4Url.get("Workitem Page")));
	strJsAllElement.append("Workitem Page;");
	
	if (permission.containsKey(AclManager.PERMISSION_VIEW)) {
		out.println(createTabMenuItem("Workitem Information", loggedUserLocale, mapPageName4Url.get("Workitem Information")));
		strJsAllElement.append("Workitem Information;");
	}
/*
	* 개선 관련지식 텝 삭제 관련
	* Author: CJS
	
	out.println(createTabMenuItem("Definition Improve", loggedUserLocale, mapPageName4Url.get("Definition Improve")));
	strJsAllElement.append("Definition Improve;");
	
	out.println(createTabMenuItem("Related Knowledge", loggedUserLocale, mapPageName4Url.get("Related Knowledge")));
	strJsAllElement.append("Related Knowledge");
*/
%>
</ul>
<div id="topbtnline">
	<table border="0" cellpadding="0" cellspacing="0" width="100%" >
		<tr>
			<td height="27">
				&nbsp;&nbsp;
				<img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Icon/arw_gray2.gif"  align="middle"  border="0" style="padding:0 0 3px 0;">
				<%=request.getParameter("definitionName")%><span id="spanInstanceName"></span><!-- (<%--=piRemote.getName()--%>) -->
				&nbsp;&nbsp;
				<img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Icon/i_tr.gif"  align="middle"  border="0">
				&nbsp;
				<%=request.getParameter(KeyedParameter.TITLE)%>
			</td>
		</tr>
	</table>
</div>

<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/wih/wihDefaultTemplate/dis.js"></script>
<script type="text/javascript">
	var allElements = "<%=strJsAllElement.toString().trim()%>";
/*
	if (window.attachEvent) {
		window.attachEvent(
				"onload", 
				function() {
					changeDisplayMenuItem("<%=strContentUrl.trim()%>", "<%=strContentPageName.trim()%>"); 
				}
		);
	} else {
		window.addEventListener("load", 
				function() { changeDisplayMenuItem("<%=strContentUrl.trim()%>", "<%=strContentPageName.trim()%>"); }, 
				false
				);
	}
*/
	$(document).ready(function(){
		changeDisplayMenuItem("<%=strContentUrl.trim()%>", "<%=strContentPageName.trim()%>"); 
	});
</script>
