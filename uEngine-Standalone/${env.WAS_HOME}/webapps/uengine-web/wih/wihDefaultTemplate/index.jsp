<%@ page pageEncoding="UTF-8" language="java" contentType="text/html; charset=UTF-8"%>

<html>
<head>
	<%@include file="header.jsp"%>
	<%@include file="definition.jsp"%>
	<%--@include file="initialize.jsp"--%>
	<link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/formdefault.css" />
</head>
<body style="overflow:hidden;">
	<%
		try{
	%>
	<table height="100%" width="100%" border="0" cellspacing="0" cellpadding="0">
		<thead>
		<tr>
			<td width="100%" height="70"><div id="divTabMenus">
				<%@include file="showTabs.jsp"%>
			</div></td>
		</tr>
		</thead>
		<tbody>
			<tr><td height="*" width="100%" valign="top" align="center">
			
				<div id="divMassageBackGroundArea"
				style="position: absolute; display:none; width:100%; background-color: #F7F7F7; z-index: 1"
				><iframe  style="width: 100%" height="100%" frameborder="0" scrolling="no" id="iframeMassageBackGround"
				></iframe></div>
				<div id="divMassageArea" align="center"
				style="position: absolute; display:none; width:100%; background-color: #F7F7F7; z-index: 2"
				></div>
				<div id="divMassageButton" align="center" onclick="showMassge();" 
				style="position: absolute; display: none; bottom: 20px; right: 20px; color: #FFFFFF; background-color: maroon; 
				cursor: pointer; z-index: 2; width: 100px;"
				><strong>메시지열기</strong> </div>
				
				<iframe width="100%" height="100%" name="iframeWihContent" id="iframeWihContent"
					scrolling="auto" marginheight="0" marginwidth="0" frameborder="0" src="about:blank">
				</iframe>
				
			</td></tr>
		</tbody>
	</table>
	
	<form name="formIndexPassValues" method="POST"  target="iframeWihContent">
		<%@include file="../wihDefaultTemplate/passValues.jsp"%>
		<%@include file="../wihDefaultTemplate/addIndexPassValues.jsp"%>
	</form>
	<%
		} catch(Exception e){
			throw e;
		} finally {
			try {pm.cancelChanges();} catch(Exception ex) { }
			try {pm.remove();} catch(Exception ex) { }
		}
	%>
</body>
</html>