<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<%@page import="org.uengine.ui.processmap.ProcessMap"%>
<%
	String processMap2Col = null;
	Cookie[] cookies = request.getCookies();
	if ( cookies != null && cookies.length > 0 ) {
		for (int i=0; i<cookies.length; i++) {
			if ("cookieProcessMap2Col".equals(cookies[i].getName())) {
				processMap2Col = cookies[i].getValue();
				break;
			}
		}
	}
	
	if (!UEngineUtil.isNotEmpty(processMap2Col)) {
		processMap2Col = "5";
	}
	
	String strategyId = request.getParameter("strategyId");
%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>
<meta name="author" content="Matt Everson of Astuteo, LLC – http://astuteo.com/slickmap" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Process Map</title>
<link rel="stylesheet" type="text/css" media="screen, print" href="../style/slickmap.css" />


<script type="text/javascript">
	var strategyId = "<%=strategyId%>";
	
	function viewObjectType(id) {
		var screenWidth = screen.width;
		var screenHeight = screen.Height;
		var windowWidth = 950;
		var windowHeight = 650;
		var window_left = (screenWidth-windowWidth)/2; 
		var window_top = (screenHeight-windowHeight)/2;
			
		var option = "left=" + window_left + ", top=" + window_top + ", width=" + windowWidth + ", height=" + windowHeight + " ,scrollbars=yes,resizable=yes";
		var url = "../processparticipant/viewProcessFlowChart.jsp?processDefinition=" + id + "&strategyId=" + strategyId;
		window.open(url, "processView", option);	
	}

	function changeCol() {
		var selectCol = document.getElementsByName("selectCol")[0];		
		var valCol = selectCol.options[selectCol.selectedIndex].value;

		var cookieProcessMap2Col = document.getElementsByName("cookieProcessMap2Col")[0];
		cookieProcessMap2Col.value = valCol;
		
		document.changeProcessMap2.submit();
	}

	function init(col) {
		var selectCol = document.getElementsByName("selectCol")[0];
		for (i =0; i<selectCol.options.length; i++) {
			if (selectCol.options[i].value == col) {
				selectCol.options.selectedIndex = i;
				break;
			} 
		}		
	}
</script>
</head>

<body onLoad="init(<%=processMap2Col%>);">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="right" style="padding:0 20px 10px 0;">
            <table width="*" border="0" cellspacing="0" cellpadding="0">
                <tr height="25" valign="middle">
                    <td valign="middle"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/viewModeTitle.gif" height="25"></td>
                    <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif" valign="middle"></td>
                    <td width="5" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif"></td>
                    <td width="*" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif" style="padding-top:1px;"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/i_pm1On.gif" width="20" height="19" > <a href="viewProcessMap.jsp"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/i_pm2Off.gif" width="20" height="19"  border="0"></a></td>
                    <td width="5" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif"></td>
                    <td width="*" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif">
	                    <select name="selectCol" style="height:19px;" onChange="changeCol();">
	                        <option value="2">2 cols</option>
	                        <option value="3">3 cols</option>
	                        <option value="4">4 cols</option>
	                        <option value="5">5 cols</option>
	                    </select>
					</td>
                    <td valign="middle" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif"></td>
                    <td valign="middle"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleRight.gif"></td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<div class="sitemap">
<%
	ProcessMap pm = new ProcessMap();
	pm.setCol(Integer.parseInt(processMap2Col));
	out.print(pm.toHTML(loggedUserId));
%>
</div>

<form name="changeProcessMap2" action="setCookies.jsp" method="post" style="display: none;">
	<input name="cookieProcessMap2Col" type="text" value="" />
	<input name="strategyId" type="text" value="<%=strategyId%>" />
</form>

</body>
</html>