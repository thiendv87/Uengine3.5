<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.uengine.util.dao.*, java.sql.*,javax.sql.*,javax.naming.*" %>

<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<%
	String partCode = null;
	String partName = null;
	String comCode = request.getParameter("comCode");
	String comName = request.getParameter("comName");
	String type = request.getParameter("type");
	String parent = request.getParameter("parent");
	
	String strTitle = "";
	if ("company".equals(type)) {
		strTitle = "Add Department In " + comName + "(" + type + ")";
	} else if ("department".equals(type)) {
		strTitle = "Add Department In " + parent + "(" + type + ")";
	} else {
		strTitle = "Add Company";
	}
%>
<script>
	function addGroupActionSubmit(){
		document.addGroup.submit();
	}
</script>

	<style type="text/css">
		@import "../dojo/dojo/resources/dojo.css";
		@import "../dojo/dijit/tests/css/dijitTests.css";
		
		@import "../dojo/dojox/grid/_grid/soriaGrid.css";
        @import "..dojo/dijit/themes/soria/soria.css";
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
     
<body class="soria">
<form name="addGroup" action="addGroupAction.jsp" method="post">
<input type="hidden" name="type" value="<%=type %>" />
<input type="hidden" name="parent" value="<%=parent %>" />
<input type="hidden" name="comCode" value="<%=comCode %>" />
<center>
<table width="80%">
	<tr>
		<td>
			<strong><%=strTitle %></strong>
		</td>
		<td align="right"><button dojoType="dijit.form.Button" label="Add Group" onclick="addGroupActionSubmit()"></td>
	</tr>
</table>
<table width="80%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="right"><strong>Group ID:&nbsp;</strong></td>
		<td><input type="text" name="groupCode" dojoType="dijit.form.TextBox" trim="true" /></td>
		<td align="right"><strong>Group name:&nbsp;</strong></td>
		<td><input type="text" name="groupName" dojoType="dijit.form.TextBox" trim="true" /></td>	
	</tr>
	<tr>
		<td align="right"><strong>Group description:&nbsp;</strong></td>
		<td colspan="3">
			<textarea name="description" style="width: 100%; height: 200px;"></textarea>
		</td>
	</tr>
</table>
</center>
</form>
</body>