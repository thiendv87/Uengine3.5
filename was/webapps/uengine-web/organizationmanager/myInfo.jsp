<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.uengine.util.dao.*, java.sql.*,javax.sql.*,javax.naming.*"%>
<%@ page import="org.uengine.util.dao.DefaultConnectionFactory"%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<%@include file="../common/header.jsp"%>
	<%@include file="../common/getLoggedUser.jsp"%>
	
	<%
		String[][] localeValueList = {
				{"ko", "Korean"},
				{"en", "English"},
				{"jp", "Japanese"},
				{"zh", "Chinese"}
		};
	%>
	
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
	<title>Insert title here</title>
</head>
<body class="soria">
<form name="addUser" action="addUserAction.jsp" method="POST">
<center>
<br><br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="formheadline" colspan="5"></td>
	</tr>
	<tr height="25">
		<td class="formtitle"><strong><%=GlobalContext.getLocalizedMessageForWeb("name", loggedUserLocale, "Name") %>:&nbsp;</strong></td>
		<td class="formcon">
			<input type="hidden" name="empName" dojoType="dijit.form.TextBox" value="<%=loggedUserFullName %>" />
			<%=loggedUserFullName %>
			<font color="#ff0000">(<%=GlobalContext.getLocalizedMessageForWeb("you_can't_change_your_name", loggedUserLocale, "You can't change your name.") %>)</font>
		</td>
		<td class="formtitle"><strong><%=GlobalContext.getLocalizedMessageForWeb("administrator", loggedUserLocale, "Administrator") %>:&nbsp;</strong></td>
		<td class="formcon"><input type="checkbox" dojoType="dijit.form.CheckBox" name="isAdmin" <%=loggedUserIsAdmin ? "checked=\"checked\"" : "" %> /></td>
	</tr>
    <tr><td class="formline" height="1"  colspan="5"></td></tr>
	<tr height="25">
		<td class="formtitle"><strong><%=GlobalContext.getLocalizedMessageForWeb("id", loggedUserLocale, "ID") %>:&nbsp;</strong></td>
		<td class="formcon">
			<input type="hidden" name="empCode" dojoType="dijit.form.TextBox" value="<%=loggedUserId %>" />
			<%=loggedUserId %>
			<font color="#ff0000">(<%=GlobalContext.getLocalizedMessageForWeb("you_can't_change_your_id", loggedUserLocale, "You can't change your ID.") %>)</font>
		</td>
		<td class="formtitle"><strong><%=GlobalContext.getLocalizedMessageForWeb("password", loggedUserLocale, "Password") %>:&nbsp;</strong></td>
		<td class="formcon"><input type="text" name="password"  dojoType="dijit.form.TextBox" value="" /></td>
	</tr>
    <tr><td class="formline" height="1"  colspan="5"></td></tr>
	<tr height="25">
		<td class="formtitle"><strong><%=GlobalContext.getLocalizedMessageForWeb("email", loggedUserLocale, "E-mail") %>:&nbsp;</strong></td>
		<td class="formcon"><input type="text" name="email" dojoType="dijit.form.TextBox" value="<%=loggedUserEmail %>"></td>
		<td class="formtitle"><strong><%=GlobalContext.getLocalizedMessageForWeb("staff_level", loggedUserLocale, "Staff level") %>:&nbsp;</strong></td>
		<td class="formcon"><input type="text" name="jikName" dojoType="dijit.form.TextBox" value="<%=loggedUserJikName %>" /></td>
	</tr>
     <tr><td class="formline" height="1"  colspan="5"></td></tr>
	<tr height="25">
		<td class="formtitle"><strong><%=GlobalContext.getLocalizedMessageForWeb("nateOn_id", loggedUserLocale, "NateOn ID") %>:&nbsp;</strong></td>
		<td class="formcon"><input type="text" name="nateOn" dojoType="dijit.form.TextBox" value="<%=loggedUserNateonId %>" /></td>
		<td class="formtitle"><strong><%=GlobalContext.getLocalizedMessageForWeb("msn_id", loggedUserLocale, "MSN ID") %>:&nbsp;</strong></td>
		<td class="formcon"><input type="text" name="msn" dojoType="dijit.form.TextBox" value="<%=loggedUserMsnId %>" /></td>
	</tr>
     <tr><td class="formline" height="1"  colspan="5"></td></tr>
	<tr height="25">
		<td class="formtitle"><strong><%=GlobalContext.getLocalizedMessageForWeb("department", loggedUserLocale, "Department") %>:&nbsp;</strong></td>
		<td class="formcon"><input type="text" dojoType="dijit.form.TextBox" name="partCode" value="<%=loggedUserPartCode %>" /></td>
		<td align="right"></td>
	</tr>
    <tr><td class="formline" height="1"  colspan="5"></td></tr>
	<tr height="25">
		<td class="formtitle"><strong><%=GlobalContext.getLocalizedMessageForWeb("language", loggedUserLocale, "Language") %></strong></td>
		<td class="formcon"><select name="locale">
<%			
			for (int i=0; i<localeValueList.length;i++) {
				String[] localeValue = localeValueList[i];
%>
				<option value='<%=localeValue[0] %>' <%=localeValue[0].equals(loggedUserLocale) ? "selected=\"selected\"" : "" %>><%=GlobalContext.getLocalizedMessageForWeb(localeValue[1].toLowerCase(), loggedUserLocale, localeValue[1]) %></option>
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
		label="<%=GlobalContext.getLocalizedMessageForWeb("update", loggedUserLocale, "Update")%>" /></td>
	</tr>
</table>
</center>
<input type="hidden" name="isModification" value="true">
</form>
</body>
</html>