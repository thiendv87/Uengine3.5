<%@ page import="java.io.*" isErrorPage="true" %>

<%
	exception.printStackTrace();

	if(exception instanceof java.rmi.RemoteException){
		exception = ((java.rmi.RemoteException)exception).detail;
	
		if(exception instanceof java.lang.NullPointerException){
		%> The process instance seems to be removed. Please delete this workitem or contact to system administrator.<%
		
		}
	}else{%>


An error has been occured. Please send me following error log at pongsor2@hotmail.com.

<table cellpadding="2" cellspacing="0" border="0"><tr><td bgcolor="#000000">
	<table cellpadding="0" cellspacing="0" border="0"><tr><td bgcolor="#eeeeff">
	<%
	ByteArrayOutputStream bao = new ByteArrayOutputStream();
	exception.printStackTrace(new PrintStream(bao));
	%>
	<%=bao.toString()%>
	</td></tr></table>
</td></tr></table>

<%}%>

<p>
<a href="javascript:history.back()">back</a>
</p>