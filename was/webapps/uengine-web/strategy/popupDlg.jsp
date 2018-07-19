<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.uengine.kernel.GlobalContext"%>
<%@page import="org.uengine.util.UEngineUtil"%>

<%@page import="org.uengine.kernel.GlobalContext"%>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<%@page import="org.uengine.util.dao.*"%>
<%@page import="com.defaultcompany.web.strategy.*"%>

<html>
<head>
<%@include file="../common/styleHeader.jsp"%>
<%@include file="../common/topFrame/indexHead.jsp" %>
<%
	int iMuneNum = 2;
	String strategyId = ServletRequestUtils.getStringParameter(request, "strategyId", "");
	
	String strategyName = "";
	
%>
<!-- Common -->
<script type="text/javascript">
	var WEB_CONTEXT_ROOT = "<%=GlobalContext.WEB_CONTEXT_ROOT%>";
	var currentNodeId = "<%=strategyId%>";
	function iframeLoader(){
		document.all.iframeGanttChart.src="../monitor/ganttChart.jsp?strategyId=<%=strategyId%>";
	}
</script>

<!-- CSS Files -->
<link type="text/css" href="Jit/Examples/css/base.css" rel="stylesheet" />
<link type="text/css" href="Jit/Examples/css/Spacetree.css" rel="stylesheet" />

<!--[if IE]><script language="javascript" type="text/javascript" src="Jit/Extras/excanvas.js"></script><![endif]-->

<!-- JIT Library File -->
<script language="javascript" type="text/javascript" src="Jit/jit.js"></script>
<script type="text/javascript" src="strategy.js"></script>

<!-- jQuery Simple Modal -->
<script language="javascript" type="text/javascript" src="../lib/jquery/jquery-1.3.2.min.js"></script>
<script language="javascript" type="text/javascript" src="jquery.simplemodal-1.3.3.min.js"></script>
<script language="javascript" type="text/javascript" src="jquery.contextMenu.js"></script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/popupTooltip.js"></script>
<LINK type="text/css" rel="stylesheet" href="<%=GlobalContext.WEB_CONTEXT_ROOT %>/style/popupTooltip.css">

<style type="text/css">
body {
	height: 100%;
	width: 100%;

	
}
#simplemodal-container a.modalCloseImg {
	background:url(x.png) no-repeat; /* adjust url as required */
	width:25px;
	height:29px;
	display:inline;
	z-index:3200;
	position:absolute;
	top:-15px;
	right:-18px;
	cursor:pointer;

}
.formdiv input {background:none; border:none; }
</style>
<link type="text/css" href="jquery.contextMenu.css" rel="stylesheet" />

</head>

<body>

<div id="bc" style="width:100%; height:100%;" dojoType="dijit.layout.BorderContainer">
    <iframe id="iframeTopNotice" width="100%" height="0" overflow="hidden" frameborder="0" src=" about:blank"></iframe>
    <%@include file="strategyOnly.jsp" %>
</div>
</body>
</html>