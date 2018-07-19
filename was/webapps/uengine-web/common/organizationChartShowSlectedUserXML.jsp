<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String selectedUsers = request.getParameter("user");	
	String[] selectedUsersSplit = selectedUsers.split(";");
%>

<%
	for(int i = 0; i < selectedUsersSplit.length; i++){			
%> 
	<%=selectedUsersSplit[i] %><br>
<% 
	}
%>