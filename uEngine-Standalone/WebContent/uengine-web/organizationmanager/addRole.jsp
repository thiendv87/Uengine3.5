<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.uengine.util.dao.*, java.sql.*,javax.sql.*,javax.naming.*" %>
<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>


<html>
<head>
	<script>
		var WEB_CONTEXT_ROOT = "<%=GlobalContext.WEB_CONTEXT_ROOT%>"; 
		function addRoleActionSubmit()
		{
			document.addRole.submit();
		}
		
        function addRoleCompany(resultString)
        {
			var arrayOfResult = eval(resultString);
			var selectRoleCompany = document.getElementById("selectRoleCompany");
			
			for (var i = 0; i < arrayOfResult.length; i++)
			{
				var result = arrayOfResult[i];

				var option = addOptionForSelect(selectRoleCompany);
				option.text = decodeURIComponent(result.name);
				option.value = result.code;
			}
        }
        
		function getCompanyList()
		{
			var url = WEB_CONTEXT_ROOT + "/organizationmanager/json/getDepartmentsWithUsersToJson.jsp";
			submitAjaxServlet(
					url,
					"Get",
					addRoleCompany,
					null
			);
		}

		function init()
		{
			getCompanyList();
		}
	</script>

	<style type="text/css">
		@import "../dojo/dojo/resources/dojo.css";
		@import "../dojo/dijit/tests/css/dijitTests.css";
		
		@import "../dojo/dojox/grid/_grid/soriaGrid.css";
        @import "../dojo/dijit/themes/soria/soria.css";
	</style>

	<script type="text/javascript" src="../dojo/dojo/dojo.js"
		djConfig="parseOnLoad: true, isDebug: false, defaultTestTheme: 'soria'"></script>
	<script type="text/javascript" src="../dojo/dijit/tests/_testCommon.js"></script>
    <style>  
        /* NOTE: for a full screen layout, must set body size equal to the viewport. */
        html, body { height: 100%; width: 100%; margin: 0; padding: 0; }
    </style>
    <script type="text/javascript">
        dojo.require("dojo.parser");
        dojo.require("dijit.form.TextBox");
        dojo.require("dijit.form.Textarea"); 
        dojo.require("dijit.form.Button");
    </script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/ajax/ajaxCommon.js"></script>
</head>
<body class="soria" onload="init();">
	<form name="addRole" action="addRoleAction.jsp" method="POST">
	<center>
	<table width="80%">
		<tr>
			<td align="right"><button dojoType="dijit.form.Button" label="Add role" onclick="addRoleActionSubmit()"></td>
		</tr>
	</table>
	<table width="80%" border="0">
		<tr height="25">
			<td align="right"><strong>Role ID:&nbsp;</strong></td><td><input type="text" name="roleCode" dojoType="dijit.form.TextBox" trim="true"></td>
			<td align="right"><strong>Role Name:&nbsp;</strong></td><td><input type="text" name="roleName" dojoType="dijit.form.TextBox" trim="true"></td>
			<td align="right"><strong>Role Company:&nbsp;</strong></td><td>
				<select name="roleCompany" id="selectRoleCompany"></select>
			</td>
		</tr>
	</table>
	</center>
	</form>
</body>

</html>