<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.uengine.kernel.*"%>
<%@ page import="com.woorifis.srms.util.web.WebMenuInfo" %>

<% 
	request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");
    
	WebMenuInfo wmi = new WebMenuInfo();
	String instanceAlias = request.getParameter("instanceAlias");
	String userLocale = request.getParameter("userLocale");
	String userDefinitionName = request.getParameter("userDefinitionName");
	String keyedParameterTiTile = request.getParameter("keyedParameterTiTile");
	
	String[] listTabMenu = wmi.getListTabMenus(instanceAlias);
	String strMenuHtml = "";
	
	String contentPageName = request.getParameter("contentPageName");
	if (contentPageName == null || "".equals(contentPageName)) {
		contentPageName = listTabMenu[0];
	}
%>

<HTML>
<HEAD>

</HEAD>

<script type="text/javascript">
	var allElements = "<%=wmi.getStrTabMenus(instanceAlias)%>";
	var strHeadActionBtns = "<%=wmi.getStrHeadActionMenus(contentPageName)%>";
	window.attachEvent("onload", function() { });
</script>
<script src="dis.js" type="text/javascript"></script>

<BODY onload="setDisplay("<%=contentPageName%>", "", "active");">
<div id="navcontainer">
	<ul class="navlist">
<%
	
	String[] listActionUrl = wmi.getListActionUrls(contentPageName);
	
	if ("yes".equals(request.getParameter("initiate"))) {
		String strMenu = listTabMenu[0].trim();
		strMenuHtml += "<li id=\"" + strMenu + "_menuItem\">";
		strMenuHtml += "<a href=\"javascript:changeDisplayMenuItem('" + listActionUrl[0] + "', '" + strMenu + "')\">";
		strMenuHtml += GlobalContext.getLocalizedMessageForWeb(strMenu, userLocale, strMenu);
		strMenuHtml += "</a>";
		strMenuHtml += "</li>";
	} else {
		for (int i = 0; i < listTabMenu.length; i++) {
			String strMenu = listTabMenu[i].trim();
			if (!"".equals(strMenu) || strMenu != null) {
				strMenuHtml += "<li id=\"" + strMenu + "_menuItem\">";
				strMenuHtml += "<a href=\"javascript:changeDisplayMenuItem('" + listActionUrl[i] + "', '" + strMenu + "')\">";
				strMenuHtml += GlobalContext.getLocalizedMessageForWeb(strMenu, userLocale, strMenu);
				strMenuHtml += "</a>";
				strMenuHtml += "</li>";
			}
		}
	}
	
	out.println(strMenuHtml);
%>
	</ul>
</div>

<div id="topbtnline">
	<table border="0" cellpadding="0" cellspacing="0" width="100%" >
		<tr>
			<td height="28">
				&nbsp;&nbsp;<img src="/images/Icon/arw_gray2.gif"  align="absmiddle"  border="0" style="padding:0 0 3px 0;">
				<%=userDefinitionName%>&nbsp;&nbsp;<img src="/images/Icon/i_tr.gif"  align="absmiddle"  border="0">&nbsp;<%=keyedParameterTiTile%>
			</td>
			<td>
				<div class="topbtn" style="margin:8px 25px;">
					<%
					String[] listHeadActionMenus = wmi.getListHeadActionMenus(contentPageName);
					for (int i = 0; i < listHeadActionMenus.length; i++) {
						String strHeadActionMenu = listHeadActionMenus[i];
					%>
					<span id="<%=strHeadActionMenu%>_span">
						<% if (!"tempsave".equals(strHeadActionMenu)) {	%>
						<img src="/images/Common/b_<%=strHeadActionMenu%>.gif" alt="<%=strHeadActionMenu%>">
						<% } else { %>
						<a href="javascript:saveWorkitem();"><img src="/images/Common/B_<%=strHeadActionMenu%>.gif" alt="save"></a>
						<% } %>
					</span>
					<% } %>
				</div>
			</td>
		</tr>
	</table>
</div>
<input type=hidden value="<%=contentPageName%>" name="contentPageName" />
<input type=hidden value="<%=instanceAlias%>" name="instanceAlias" />
<input type=hidden value="<%=keyedParameterTiTile%>" name="keyedParameterTiTile" />
<input type=hidden value="<%=userLocale%>" name="userLocale" />
<input type=hidden value="<%=userDefinitionName%>" name="userDefinitionName" />
<input type=hidden value="<%=reqcd %>" name="reqcd" />
<input type=hidden value="<%=request.getParameter("indexUrlPath") %>" name="indexUrlPath" />

<input type=hidden value="<%=request.getParameter("isViewMode") %>" name="isViewMode" />
<input type=hidden value="<%=request.getParameter("isMine") %>" name="isMine" />
</body>
</HTML>