<%@ page contentType="text/xml; charset=UTF-8" language="java" import="java.util.*, java.io.*"  
%><?xml version="1.0" encoding="iso-8859-1"?>
<%
response.setContentType("text/xml; charset=UTF-8");
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>


<xform style="manual">
<table>
<tr>
	<td>
		Save New Favorite View: <textField type="string" modelReference="name" size="20" title="Name"/>
	</td>
	<td>
  	<button action="validate" label="Save" handler="com.tonbeller.wcf.form.ButtonHandler" hide="true"/>
  </td>
 </tr>
</table>
  
</xform>
