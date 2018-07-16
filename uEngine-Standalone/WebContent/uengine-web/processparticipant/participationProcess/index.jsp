<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.uengine.util.UEngineUtil"%>

<html>

<head>

	<%@include file="../../common/topFrame/indexHead.jsp" %>
	<%
		int iMuneNum = 2;
		String type = request.getParameter("type");
		String filtering = request.getParameter("filtering");
		String src;
		if ("worklist".equals(type)) {
			src = GlobalContext.WEB_CONTEXT_ROOT + "/processparticipant/worklist/wl2_instanceList.jsp?filtering=" + filtering + "&currentPage=1";
		} else if ("instancelist".equals(type)) {
			src = GlobalContext.WEB_CONTEXT_ROOT + "/processparticipant/worklist/wl2_instanceList.jsp?filtering=" + filtering + "&currentPage=1";
		} else {
			src = GlobalContext.WEB_CONTEXT_ROOT + "/processparticipant/worklist/wl2_instanceList.jsp?filtering=0&currentPage=1";
		}
	%>
</head>
<body>
<div id="bc" style="width:100%; height:100%;" dojoType="dijit.layout.BorderContainer">
	<%@include file="../../common/topFrame/indexBodyTop.jsp" %>
	<div dojoType="dojox.layout.ExpandoPane" 
					splitter="true" 
					duration="125"
					region="left" 
					title="<%=GlobalContext.getMessageForWeb("title.participation", loggedUserLocale)%>" 
					id="leftPane" 
					maxWidth="275" 
					style="width: 250px; background: #fafafa;">
		<%@include file="wl2_menu.jsp" %>
	</div>
	<div dojoType="dijit.layout.ContentPane" region="center" id="centerPane" style="overflow: hidden;">
		<%@include file="../../common/topFrame/titleBar.jsp" %>
	    <iframe onresize="resizeFrame(this);" onload="changeTitle(this);" style="width: 100%; height: 100%; padding-bottom: 30px;" src="<%=src %>" name="innerworkarea" frameborder="0"></iframe>
	</div>
	<div id="footer" style="border:solid 0px white; background-color: #F0F0F0;" dojotype="dijit.layout.ContentPane" region="bottom">
        <%@include file="../../common/footer.jsp" %>
    </div>
</div>
</body>
</html>