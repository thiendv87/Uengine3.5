<%@ page isErrorPage="true" %>

<%=exception.getMessage()%>
<%exception.printStackTrace();%>
<p>
<a href="javascript:history.back()">back</a>