<%@ page session="true" contentType="text/html; charset=ISO-8859-1" import="java.util.*, java.io.*"%>
<%@ taglib uri="http://www.tonbeller.com/jpivot" prefix="jp" %>
<%@ taglib uri="http://www.tonbeller.com/wcf" prefix="wcf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib uri="http://www.uengine.org/favorite" prefix="fa" %>
<%
	String webRoot = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
	String changeFavoriteName = request.getParameter("changeFavoriteName");
	String linkPath = "/mondrian/testpage.jsp?query=uengine&changeFavoriteName=" + changeFavoriteName;
%>
<html>
<head>
  <title>Mondrian/JPivot ShowChart Page</title>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <link rel="stylesheet" type="text/css" href="jpivot/table/mdxtable.css">
  <link rel="stylesheet" type="text/css" href="jpivot/navi/mdxnavi.css">
  <link rel="stylesheet" type="text/css" href="wcf/form/xform.css">
  <link rel="stylesheet" type="text/css" href="wcf/table/xtable.css">
  <link rel="stylesheet" type="text/css" href="wcf/tree/xtree.css">
 
</head>
<body bgcolor=white>

<script language="javascript">
	function openWindow(path){
		window.open(path,"_blank","toolbar=no,scrollbars=yes, height=700, width = 1000");
	}
</script>

<form action="showChart.jsp" method="post">
<center>
<%-- include query and title, so this jsp may be used with different queries --%>
<wcf:include id="include01" httpParam="query" prefix="/WEB-INF/queries/" suffix=".jsp"/>
<c:if test="${query01 == null}">
  <jsp:forward page="/index.jsp"/>
</c:if>

<%-- draw chart --%>
<fa:chart id="chart02" query="#{query01}" visible="false"/>
<fa:favorite id="favor01" chartmodel="chart02" model="query01" favoriteHttpParam="favorite"/>
<!--fa:dynamicform id="favorform" xmlURL="/favorite_showChart.jsp" model="#{favor01}"/-->

<h2><c:out value="${title01}"/></h2>

<p>
<center>
<table>
<tr><td>
<a href="javascript:openWindow('<%=linkPath %>')"><img src="images/seeWhy.gif"/>See Why</a></td></tr></table>
<!-- render chart -->
<fa:render ref="chart02" xslUri="/WEB-INF/jpivot/chart/chart.xsl" xslCache="true"/>
</form>
</body>
</html>
