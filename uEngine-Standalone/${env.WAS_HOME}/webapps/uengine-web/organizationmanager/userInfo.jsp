<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.uengine.util.dao.*, java.sql.*,javax.sql.*,javax.naming.*"%>
<%@ page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<% 
	request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<%@include file="../common/header.jsp"%>
	<%@include file="../common/getLoggedUser.jsp"%>
	
	
	<%
		String empCode = request.getParameter("empCode") == null ? loggedUserId : decode(request.getParameter("empCode"));
		boolean isModification = UEngineUtil.isTrue(request.getParameter("isModification"));
	
		Connection conn 	   = null;
		PreparedStatement stmt = null;
		ResultSet rs 		   = null;
		
		String partCode  = null;
		String partName  = null;
		String empName   = null;
		String email 	 = null;
		String jikName   = null;
		String globalCom = null;
		String nateOn 	 = null;
		String msn 	 	 = null;
		String locale 	 = null;
		String mobilecmp = null;
		String mobileno  = null;
		boolean isAdmin  = false;
		String password = null;

		String sPartOption = "";
		String sComOption  = "";
		String[][] localeValueList = {
				{"ko", "Korean"},
				{"en", "English"}/*,
				{"jp", "Japanese"},
				{"zh", "Chinese"}*/
		};
		
		try {
			String sql = " SELECT * FROM EMPTABLE WHERE EMPCODE = ? ";
			conn = DefaultConnectionFactory.create().getConnection();
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, empCode);
	
			rs = stmt.executeQuery();
	
			if (rs.next()) {
				empName 	= UEngineUtil.isNotEmpty(rs.getString("empname"))	?rs.getString("empname")	:"";
				isAdmin 	= rs.getInt("isAdmin") == 1;
				jikName 	= UEngineUtil.isNotEmpty(rs.getString("jikName"))	?rs.getString("jikName")	:"";
				email 		= UEngineUtil.isNotEmpty(rs.getString("email"))  	?rs.getString("email")  	:"";
				partCode 	= UEngineUtil.isNotEmpty(rs.getString("partCode"))	?rs.getString("partCode")	:"";
				globalCom 	= UEngineUtil.isNotEmpty(rs.getString("globalCom"))	?rs.getString("globalCom")	:"";
				locale 		= UEngineUtil.isNotEmpty(rs.getString("locale"))	?rs.getString("locale")		:"";
				nateOn 		= UEngineUtil.isNotEmpty(rs.getString("nateOn")) 	?rs.getString("nateOn") 	:"";
				msn 		= UEngineUtil.isNotEmpty(rs.getString("msn")) 		?rs.getString("msn") 		:"";
				mobilecmp 	= UEngineUtil.isNotEmpty(rs.getString("mobilecmp")) ?rs.getString("mobilecmp") 	:"";
				mobileno 	= UEngineUtil.isNotEmpty(rs.getString("mobileno")) 	?rs.getString("mobileno") 	:"";
				password 	= UEngineUtil.isNotEmpty(rs.getString("password")) 	?rs.getString("password") 	:"";

				sql = " SELECT PARTCODE, PARTNAME FROM PARTTABLE WHERE ISDELETED = '0' AND GLOBALCOM = ? ";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, globalCom);
				ResultSet rsPart = stmt.executeQuery();
				
				while (rsPart.next()) {
					String sSeleted = rsPart.getString("partcode").equals(partCode) ? " selected=\"selected\" " : "";
					sPartOption += "<option value=\"" + rsPart.getString("partcode") + "\" " + sSeleted + ">" + rsPart.getString("partname") + "</option>";
				}
				
				sql = " SELECT * FROM COMTABLE WHERE ISDELETED = '0' ";
				stmt = conn.prepareStatement(sql);
				ResultSet rsCom = stmt.executeQuery();
				
				while (rsCom.next()) {
					String sSeleted = rsCom.getString("comcode").equals(globalCom) ? " selected=\"selected\" " : "";
					sComOption += "<option value=\"" + rsCom.getString("comcode") + "\" " + sSeleted + ">" + rsCom.getString("comname") + "</option>";
				}
				
				try {
					if (rsPart != null) {
						rsPart.close();
						rsCom.close();
					}
				} catch (Exception e) {}
			}
		} finally {
    		if (rs != null) {
    			try { rs.close(); } catch (Exception e) { }
    		}
    		if (stmt != null) {
    			try { stmt.close(); } catch (Exception e) { }
    		}
    		if (conn != null) {
    			try { conn.close(); } catch (Exception e) { }
    		}
		}
		
		String imgPath="/images/portrait/" + empCode + ".gif";
		java.io.File imgFile = new java.io.File(request.getRealPath(imgPath));
   		if (!imgFile.exists()) imgPath = GlobalContext.WEB_CONTEXT_ROOT + "/images/main/NoIMG.gif";
   		else imgPath = GlobalContext.WEB_CONTEXT_ROOT + imgPath;
	%>
	
	<link href="../style/default.css" rel="stylesheet" type="text/css">
	<style type="text/css">
	@import "../dojo/dojo/resources/dojo.css";
	@import "../dojo/dijit/tests/css/dijitTests.css";
	@import "../dojo/dojox/grid/_grid/soriaGrid.css";
	@import "../dojo/dijit/themes/soria/soria.css";
	
	/* NOTE: for a full screen layout, must set body size equal to the viewport. */
	body {
		height: 100%;
		width: 100%;
		margin: 15px;
		padding: 0;
        overflow:hidden; 
	}
	</style>
	
	<script type="text/javascript" src="../dojo/dojo/dojo.js" djConfig="parseOnLoad: true, isDebug: false, defaultTestTheme: 'soria'"></script>
	<script type="text/javascript" src="../dojo/dijit/tests/_testCommon.js"></script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/common.js"></script>
	<script type="text/javascript">
        dojo.require("dojo.parser");
        dojo.require("dijit.form.TextBox");
        dojo.require("dijit.form.CheckBox"); 
        dojo.require("dijit.form.Button"); 

        function updateUserActionSubmit() {
            if (isEmpty(document.addUser.empName.value)) {
                alert("Name is required.");
                return;
            }
            
            if (isEmpty(document.addUser.password.value)) {
                alert("Password is required.");
                return;
            }
            
            if (!isEmpty(document.addUser.email.value) && !isEmail(document.addUser.email.value)) {
                alert("Invalid email format.");
                return;
            }
            
            if (!isEmpty(document.addUser.nateOn.value) && !isEmail(document.addUser.nateOn.value)) {
                alert("Invalid NateOn format.");
                return;
            }
            
            if (!isEmpty(document.addUser.msn.value) && !isEmail(document.addUser.msn.value)) {
                alert("Invalid MSN format.");
                return;
            }
            
            document.addUser.submit();
        }

		function changePicture() {
			var x= "dialogWidth:300px; dialogHeight:350px; scrollbar:no; status:no; help:no;";
			var umodal = window.showModalDialog("modalUserPicture.jsp?imgPath=<%=URLEncoder.encode(imgPath, GlobalContext.ENCODING) %>", document.addUser, x);
			this.location.reload();
		}

		var req = null;
		var partCode = "<%=partCode %>";
		var WEB_ROOT = "<%=GlobalContext.WEB_CONTEXT_ROOT%>";
	</script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/ajax/ajaxCommon.js"></script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/ajax/department.js"></script>
	<title><%=empName %><%=GlobalContext.getMessageForWeb("'s Infomation", loggedUserLocale) %></title>
</head>
<body class="soria">
<form name="addUser" action="addUserAction.jsp" method="post">
<br />

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<col span="1" width="130">
	<col span="1" width="150">
	<col span="1" width="">
	<col span="1" width="150">
	<col span="1" width="">
	<tr><td class="formheadline" colspan="6"></td></tr>
	<tr height="25">
		<td rowspan="11" align="center">
			<a href="javascript: changePicture();"><img src="<%=imgPath %>" alt="변경하려면 클릭하세요." width="105" height="135" style="border:1px #CCCCCC solid;" align="middle" /></a>
		</td>
		<td class="formtitle">
			<strong><%=GlobalContext.getMessageForWeb("ID", loggedUserLocale) %></strong>
		</td>
		<td class="formcon"><input type="hidden" name="empCode" dojoType="dijit.form.TextBox" value="<%=empCode %>" /><%=empCode %>
			<font color="#F58E03">(<%=GlobalContext.getMessageForWeb("You can't change your ID", loggedUserLocale) %>)</font>
		</td>
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("Administrator", loggedUserLocale) %></strong></td>
		<td class="formcon"><input type="checkbox" dojoType="dijit.form.CheckBox" name="isAdmin" <%=isAdmin ? "checked=\"checked\" " : ""%> <%=loggedUserIsAdmin ? "" : " readonly=\"readonly\" " %> /></td>
	</tr>
    <tr><td class="formline" height="1"  colspan="5"></td></tr>
	<tr height="25">
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("Name", loggedUserLocale) %></strong></td>
		<td class="formcon">
			<input type="text" name="empName" dojoType="dijit.form.TextBox" value="<%=empName %>" />
		</td>
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("Password", loggedUserLocale) %></strong></td>
		<td class="formcon"><input type="password" name="password"  dojoType="dijit.form.TextBox" value="<%=password %>" /></td>
	</tr>
    <tr><td class="formline" height="1"  colspan="5"></td></tr>
	<tr height="25">
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("Email", loggedUserLocale) %></strong></td>
		<td class="formcon"><input type="text" name="email" dojoType="dijit.form.TextBox" value="<%=email %>"></td>
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("Staff Level", loggedUserLocale) %></strong></td>
		<td class="formcon"><input type="text" name="jikName" dojoType="dijit.form.TextBox" value="<%=jikName %>" /></td>
	</tr>
	<tr><td class="formline" height="1"  colspan="5"></td></tr>
	<tr height="25">
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("Mobile", loggedUserLocale) %></strong></td>
		<td class="formcon"><input type="text" name="mobileno" dojoType="dijit.form.TextBox" value="<%=mobileno %>" /></td>
		<td class="formtitle">
			<strong>
				<%=GlobalContext.getMessageForWeb("Company", loggedUserLocale) %>/<%=GlobalContext.getMessageForWeb("Department", loggedUserLocale) %>
			</strong>
		</td>
		<td class="formcon">
			<select name="globalCom" onChange="changCompany(this);">
				<%=sComOption %>
			</select>
			<select name="partCode" id="selectPartCode">
			<%=sPartOption %>
			</select>
		</td>
	</tr>
     <tr><td class="formline" height="1"  colspan="5"></td></tr>
	<tr height="25">
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("NateOn", loggedUserLocale) %></strong></td>
		<td class="formcon"><input type="text" name="nateOn" dojoType="dijit.form.TextBox" value="<%=nateOn %>" /></td>
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("MSN", loggedUserLocale) %></strong></td>
		<td class="formcon"><input type="text" name="msn" dojoType="dijit.form.TextBox" value="<%=msn %>" /></td>
	</tr>
	<tr><td class="formline" height="1"  colspan="5"></td></tr>
	<tr height="25">
		<td class="formtitle"><strong><%=GlobalContext.getMessageForWeb("Language", loggedUserLocale) %></strong></td>
		<td class="formcon" colspan="3"><select name="locale">
<%			
			for (int i=0; i<localeValueList.length;i++) {
				String[] localeValue = localeValueList[i];
				String sSeleted = localeValue[0].equals(locale) ? "selected=\"selected\"" : "";
%>
				<option value='<%=localeValue[0] %>' <%=sSeleted %>><%=GlobalContext.getLocalizedMessageForWeb(localeValue[1].toLowerCase(), loggedUserLocale, localeValue[1]) %></option>
<%
			}
%>
		</select></td>
		<td align="right"></td>
	</tr>
	<tr><td class="formheadline" colspan="6"></td></tr>
</table>
<br>
<table width="98%">
	<tr>
		<td align="center">
            <table>
                <tr>
                    <td class="gBtn">
                        <a onClick="updateUserActionSubmit();" >
                        <span><%=GlobalContext.getMessageForWeb("Update", loggedUserLocale)%></span></a>
                    </td>
                </tr>
            </table>
		</td>
	</tr>
</table>
<input type="hidden" name="isModification" value="true">
</form>
</body>
</html>