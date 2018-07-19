<%@ page pageEncoding="UTF-8" %><%response.setContentType("text/html; charset=UTF-8");%>
<%@include file="../../../common/commons.jsp"%>

<p>
	<input:richtextarea height="300px" name="rtn" viewmode="0" width="100%"></input:richtextarea></p>
<p>
	input 1 : &nbsp;
<%
java.util.Hashtable input1_0 = new java.util.Hashtable();
 input1_0.put("attrid", "TEMP_ATTR_ID"); 
%>
<input:text name="input1" viewMode="0" attributes="<%=input1_0%>" default="" /></p>
<p>
	input 2 : &nbsp;
<%
java.util.Hashtable input2_1 = new java.util.Hashtable();
 input2_1.put("attrid", "TEMP_ATTR_ID"); 
%>
<input:text name="input2" viewMode="0" attributes="<%=input2_1%>" default="" /></p>

<script language="javascript"> 
<!-- 
function valid_check(){ 

	return true; 
} 

//--> 
</script> 