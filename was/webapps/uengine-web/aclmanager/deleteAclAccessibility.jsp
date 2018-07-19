<%@include file="../common/header.jsp"%>
<%@page import="org.uengine.util.dao.*"%>

<form action=executeQuery.jsp method=POST name=actionForm>

<%
	String DEFID= request.getParameter("DEFID");
	String ACCESSIBILITY= request.getParameter("ACCESSIBILITY");
	String GROUPID= request.getParameter("GROUPID");
	String ROLEID= request.getParameter("ROLEID");
	String USERID= request.getParameter("USERID");
	
	String sql ="delete from BPM_EX_ACL ";
	sql+="where DEFID=?DEFID and ACCESSIBILITY=?ACCESSIBILITY and GROUPID=?GROUPID and ROLEID=?ROLEID and USERID=?USERID";
		
	IDAO dao = GenericDAO.createDAOImpl( 
		DefaultConnectionFactory.create(),			
	       sql,
		IDAO.class
	);
			
	dao.set("DEFID", DEFID);
	dao.set("ACCESSIBILITY", ACCESSIBILITY);
	dao.set("GROUPID", GROUPID);
	dao.set("ROLEID", ROLEID);
	dao.set("USERID", USERID);
	dao.update(); 
	
%>

<html>
<head>
<script type/text="javascript">
	function sendRedirectPage() {
		setTimeout("sendUrl()", 2000);
	}

	function sendUrl() {
		window.close();
 		opener.location.reload()		
	}
</script>
</head>
<body>
<div id="center">
	<div class="boxtext">
	Object has been successfully saved ...
	</div>
</div>
</body>
</html>

<script type/text="javascript">
sendRedirectPage();
</script>