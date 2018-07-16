<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.uengine.kernel.GlobalContext"%>
<%@page import="org.uengine.util.UEngineUtil"%>

<html>
<head>
	<%@include file="common/topFrame/indexHead.jsp" %>
	<%
		int iMuneNum = 0;
	%>
</head>
<body>
<div id="bc" style="width:100%; height:100%;" dojoType="dijit.layout.BorderContainer">
	<%@include file="common/topFrame/indexBodyTop.jsp" %>
	<div dojoType="dijit.layout.ContentPane" region="center" id="centerPane">
	     <iframe onresize="resizeFrame(this);" style="width: 100%; height: 100%;" src="main.jsp" name="innerworkarea" frameborder="0"></iframe>
	</div>
	<div id="footer" style="border:solid 0px white; background-color: #F0F0F0;" dojotype="dijit.layout.ContentPane" region="bottom">
        <%@include file="common/footer.jsp" %>
    </div>
</div>
</body>
</html>