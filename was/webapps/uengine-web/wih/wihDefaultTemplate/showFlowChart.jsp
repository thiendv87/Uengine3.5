
<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>

<html>
<head>
<%@include file="../../processmanager/flowchart/flowchartHeader.jsp" %>
</head>

<body>
	<div id="canvasForLoopLines" style="position:absolute;left:0px;top:0px;z-index: -1"></div>
	<br>
	<div align="center" id="divFlowchartArea"></div>
	<script type="text/javascript">
		init();
	</script>
</body>
</html>

