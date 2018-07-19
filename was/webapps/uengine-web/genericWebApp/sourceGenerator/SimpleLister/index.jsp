<h1>Generate Simple Lister: <font color=green>1.Enter Parameters</font> > 2.Customize JSP > 3.Deploy </h1>

<form action="generate.jsp">
	Class Name : <input name="_daoClassName" value="dao.<%=request.getParameter("_tableName")%>"><br>
	Table Name : <input name="_tableName" value="<%=request.getParameter("_tableName")%>"><p>
	<input type=submit value="Generate">
</form>
