<%@ page pageEncoding="UTF-8" %><%response.setContentType("text/html; charset=UTF-8");%>
<%@include file="../../../common/commons.jsp"%>

<p>
	frm1</p>
<p>
	&nbsp;</p>
<p>
	테스트 
<%
java.util.Hashtable txtA_0 = new java.util.Hashtable();
 txtA_0.put("attrid", "TEMP_ATTR_ID"); 
%>
<input:text name="txtA" viewMode="0" attributes="<%=txtA_0%>" default="" /></p>

<script language="javascript"> 
<!-- 
function valid_check(){ 

	return true; 
} 

//--> 
</script> 