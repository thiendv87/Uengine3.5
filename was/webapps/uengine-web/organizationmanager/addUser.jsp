<%//@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.uengine.util.dao.*, java.sql.*,javax.sql.*,javax.naming.*" %>
<%@page import="com.defaultcompany.organization.web.chartpicker.*"%>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@page import="javax.sql.DataSource"%>
<html>
<head>
<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<%
	String[][] localeValueList = {
			{"ko", "Korean"},
			{"en", "English"},
			{"jp", "Japanese"},
			{"zh", "Chinese"}
	};
	
	String groupCode = reqMap.getString("groupCode", "");
	String groupName = reqMap.getString("groupName", "");
	String comCode = reqMap.getString("comCode", "");
	
	DataSource dataSource = DefaultConnectionFactory.create().getDataSource();
	CompanyDAO companyDAO = new CompanyDAO(dataSource);
	List<Company> companies = null;
	
	if (loggedUserIsMaster) {
		companies = companyDAO.getCompany();
	} else {
		companies = companyDAO.getCompany(loggedUserGlobalCom);
	}
	
	String comName = reqMap.getString("comName", "");
	int companySize = companies.size();
	for (Company company : companies) {
		comName = company.getName();
	}
	
	
%>
	<title>Add User</title>
	<link href="../style/default.css" rel="stylesheet" type="text/css">
	<style type="text/css">
		@import "../dojo/dojo/resources/dojo.css";
		@import "../dojo/dijit/tests/css/dijitTests.css";
		@import "../dojo/dojox/grid/_grid/soriaGrid.css";
        @import "..dojo/dijit/themes/soria/soria.css";
        
        /* NOTE: for a full screen layout, must set body size equal to the viewport. */
        body { 
        	height: 100%; 
        	width: 100%; 
        	margin: 15px; 
        	padding: 0; 
        	overflow:hidden; 
        }
    </style>
    
	<script type="text/javascript" src="../dojo/dojo/dojo.js"
	djConfig="parseOnLoad: true, isDebug: false, defaultTestTheme: 'soria'"></script>
	<script type="text/javascript" src="../dojo/dijit/tests/_testCommon.js"></script>
    <script type="text/javascript">
        dojo.require("dojo.parser");
        dojo.require("dijit.form.TextBox");
        dojo.require("dijit.form.CheckBox"); 
        dojo.require("dijit.form.Button"); 

        String.prototype.trim = function() {
        	 return this.replace(/(^\s*)|(\s*$)/gi, "");
        }
        
        function updateUserActionSubmit(){
			var pw = addUser.password.value.trim();
			if (pw.length > 0) {
				document.addUser.submit();
			} else {
				alert(" Password is first! \n Check your password");
			}
		}
	</script>
</head>
<body class="soria">
<form name="addUser" action="addUserAction.jsp" method="post">
<br />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td class="formheadline" colspan="5"></td></tr>
	<tr height="25">
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("Name", loggedUserLocale) %>:&nbsp;</strong></td>
		<td class="formcon"><input type="text" name="empName" dojoType="dijit.form.TextBox"/></td>
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("Administrator", loggedUserLocale) %>:&nbsp;</strong></td>
		<td class="formcon"><input type="checkbox" dojoType="dijit.form.CheckBox" name="isAdmin" /></td>
	</tr>
    <tr><td class="formline" height="1"  colspan="5"></td></tr>
	<tr height="25">	
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("ID", loggedUserLocale) %>:&nbsp;</strong></td>
		<td class="formcon"><input type="text" name="empCode" dojoType="dijit.form.TextBox" /></td>
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("Password", loggedUserLocale) %>:&nbsp;</strong></td>
		<td class="formcon"><input type="password" name="password"  dojoType="dijit.form.TextBox" /></td>
	</tr>
    <tr><td class="formline" height="1"  colspan="5"></td></tr>
	<tr height="25">
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("Email", loggedUserLocale) %>:&nbsp;</strong></td>
		<td class="formcon"><input type="text" name="email" dojoType="dijit.form.TextBox" /></td>
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("Staff Level", loggedUserLocale) %>:&nbsp;</strong></td>
		<td class="formcon"><input type="text" name="jikName" dojoType="dijit.form.TextBox" /></td>
	</tr>
     <tr><td class="formline" height="1"  colspan="5"></td></tr>
	<tr height="25">
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("NateOn", loggedUserLocale) %>:&nbsp;</strong></td>
		<td class="formcon"><input type="text" name="nateOn" dojoType="dijit.form.TextBox" /></td>
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("MSN", loggedUserLocale) %>:&nbsp;</strong></td>
		<td class="formcon"><input type="text" name="msn" dojoType="dijit.form.TextBox" /></td>
	</tr>
     <tr><td class="formline" height="1"  colspan="5"></td></tr>
	<tr height="25">
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("Department", loggedUserLocale) %>:&nbsp;</strong></td>
		<td class="formcon"><input type="hidden" name="partCode" value="<%=groupCode %>" /><%=groupName %></td>
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("Company", loggedUserLocale) %>:&nbsp;</strong></td>
		<td class="formcon"><input type="hidden" name="globalCom" value="<%=comCode %>" /><%=comName %></td>
	</tr>
    <tr><td class="formline" height="1"  colspan="5"></td></tr>
	<tr height="25">
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("Language", loggedUserLocale) %></strong></td>
		<td class="formcon"><select name="locale">
<%			
			for (int i=0; i<localeValueList.length;i++) {
				String[] localeValue = localeValueList[i];
%>
				<option value='<%=localeValue[0] %>' <%=localeValue[0].equals(loggedUserLocale) ? "selected=\"selected\"" : "" %>><%=GlobalContext.getMessageForWeb(localeValue[1], loggedUserLocale) %></option>
<%
			}
%>
		</select></td>
		<td ></td><td></td>
	</tr>
    <tr><td class="formheadline" colspan="5"></td></tr>
</table>
<br>
<table width="98%">
	<tr>
		<td align="center"><button dojoType="dijit.form.Button" onclick="updateUserActionSubmit();" 
		label="<%=GlobalContext.getMessageForWeb("Insert", loggedUserLocale)%>" /></td>
	</tr>
</table>
	<input type="hidden" name="isModification" value="false">
</form>
</body>
</html>