<%@include file="header.jsp"%>
<%@include file="definition.jsp"%>
<%@include file="initialize.jsp"%>
<%
try{
%>

<%@include file="showInputForm.jsp"%>

<%
	pm.applyChanges();

}catch(Exception e){
	try{
		pm.cancelChanges();
	}catch(Exception ex){
	}
	
	throw e;
}finally{
	try{
		pm.remove();
	}catch(Exception e){
	}
}

%>