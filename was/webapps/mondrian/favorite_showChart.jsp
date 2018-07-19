<%@ page contentType="text/xml; charset=UTF-8" language="java" import="java.util.*, java.io.*, org.uengine.kernel.ProcessDefinitionFactory"  
%><?xml version="1.0" encoding="iso-8859-1"?>
<%
response.setContentType("text/xml; charset=UTF-8");
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>


<%@page import="org.uengine.kernel.ProcessDefinitionFactory;"%>
<xform style="manual">

<table>
<tr>	
	<td>
		Give A Name: <listBox1 type="string" modelReference="changeFavoriteName">
<%
		String favoritePath = ProcessDefinitionFactory.DEFINITION_ROOT + "analysis/";
		File[] files = (new File(favoritePath)).listFiles();
		for(int i=0; i<files.length; i++){		
			if(files[i].getName()!=null && files[i].getName().startsWith("favorite_")){
				%><listItem value="<%=files[i].getName()%>" label="<%=files[i].getName().substring(9)%>"/><%
			}
		}
%>
		</listBox1>
	</td>	
	<td>		
  	Give A Name: <textField type="string" modelReference="name" size="4" title="Name"/>
  </td>
  <td>
    <button action="validate" label="OK" handler="com.tonbeller.wcf.form.ButtonHandler" hide="true"/>
    <button action="revert" label="Cancel" handler="com.tonbeller.wcf.form.ButtonHandler" hide="true"/>
  </td>
</tr>
</table>


</xform>
