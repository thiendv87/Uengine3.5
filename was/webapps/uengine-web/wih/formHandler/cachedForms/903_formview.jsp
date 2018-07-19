<%@ page pageEncoding="UTF-8" %><%response.setContentType("text/html; charset=UTF-8");%>
<%@include file="../../../common/commons.jsp"%>

<p>
	<input:richtextarea height="300px" name="rtn" viewmode="<%=InputConstants.VIEW%>"  width="100%"></input:richtextarea></p>
<p>
	input 1 : &nbsp;
 <% 
 java.util.Hashtable input1_0 = new java.util.Hashtable(); 
 
 %> 
 <input:text name="input1" attributes="<%=input1_0%>" default="" viewMode="<%=InputConstants.VIEW%>" /></p>
<p>
	input 2 : &nbsp;
 <% 
 java.util.Hashtable input2_1 = new java.util.Hashtable(); 
 
 %> 
 <input:text name="input2" attributes="<%=input2_1%>" default="" viewMode="<%=InputConstants.VIEW%>" /></p>
