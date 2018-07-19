<%@ page pageEncoding="UTF-8" %><%response.setContentType("text/html; charset=UTF-8");%>
<%@include file="../../../common/commons.jsp"%>

<p>
	frm2</p>
<p>
	&nbsp;</p>
<p>
	테스트 2 
<%
java.util.Hashtable txtB_0 = new java.util.Hashtable();
 txtB_0.put("attrid", "TEMP_ATTR_ID"); 
%>
<input:text name="txtB" viewMode="0" attributes="<%=txtB_0%>" default="" /></p>

<script language="javascript"> 
<!-- 
function valid_check(){ 

	return true; 
} 

//--> 
</script> 