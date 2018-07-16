<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<%
	String type = reqMap.getString("type", "");
	String code = reqMap.getString("code", "");
	String itemName = reqMap.getString("itemName", "");
%>
<html>
<head>
	<%@include file="../common/styleHeader.jsp"%>
	<style type="text/css">
	/* NOTE: for a full screen layout, must set body size equal to the viewport. */
	body {
		height: 100%;
		width: 100%;
		margin: 0;
		padding: 15px;
		overflow: auto;
	}
	</style>
    <LINK rel="stylesheet" href="../style/form.css" type="text/css"/>
    <link rel='stylesheet' type='text/css' href='<%=GlobalContext.WEB_CONTEXT_ROOT%>/lib/jquery/css/cupertino/jquery-ui-1.8.7.custom.css' />
	<title><%=GlobalContext.getMessageForWeb("Role List", loggedUserLocale) %></title>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/ajax/ajaxCommon.js"></script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/crossBrowser/elementControl.js"></script>
	<script type='text/javascript' src='<%=GlobalContext.WEB_CONTEXT_ROOT%>/lib/jquery/jquery-1.4.4.js'></script>
	<script type='text/javascript' src='<%=GlobalContext.WEB_CONTEXT_ROOT%>/lib/jquery/jquery-ui-1.8.7.custom.min.js'></script>
	<script type='text/javascript' src='<%=GlobalContext.WEB_CONTEXT_ROOT%>/lib/jquery/jcalendar.js'></script>
	<script type="text/javascript">
		var WEB_CONTEXT_ROOT = "<%=GlobalContext.WEB_CONTEXT_ROOT%>";
		var tbodyUsers, tbodyGroups;
		
     	function viewUserInfo(keyString)
     	{
     		window.location.href = "userInfo.jsp?empCode=" + keyString;
     	}

     	function getUserList(item)
     	{
     		var url = WEB_CONTEXT_ROOT + "/organizationmanager/json/getDepartmentsWithUsersToJson.jsp";
     	}
     	
		var appendChildNodeToTable = function(resultString)
		{
			var arrayOfResult = new Array();
			arrayOfResult = eval(resultString);
			
			for (var i = 0; i < arrayOfResult.length; i++)
			{
				var result = arrayOfResult[i];
				var row = null;
				var rowId = "idRow_" + result.code;
				
				if (result.type == "user")
				{
					row = appendRow(tbodyUsers);
					row.style.cursor = "pointer";
					//addEventWithFunctionString(row, "click", "viewUserInfo('" + result.usercode + "')");
					
					var chkCell = appendCell(row);
					chkCell.innerHTML = "<input type='checkbox' name='del_chk' id='del_chk'><input type='hidden' name='empcode' value='"+result.usercode+"'>"
					
					var nameCell = appendCell(row);
					addEventWithFunctionString(nameCell, "click", "viewUserInfo('" + result.usercode + "')");
					nameCell.innerHTML = decodeURIComponent(result.name);

					var departmentCell = appendCell(row);
					addEventWithFunctionString(departmentCell, "click", "viewUserInfo('" + result.usercode + "')");
					departmentCell.innerHTML = (decodeURIComponent(result.partname)).encodeHtml();

					var companyCell = appendCell(row);
					addEventWithFunctionString(companyCell, "click", "viewUserInfo('" + result.usercode + "')");
					companyCell.innerHTML = decodeURIComponent(result.globalcom);

					var emailCell = appendCell(row);
					addEventWithFunctionString(emailCell, "click", "viewUserInfo('" + result.usercode + "')");
					emailCell.innerHTML = decodeURIComponent(result.email);
				}
				else
				{
					row = appendRow(tbodyGroups);
					row.style.cursor = "pointer";
					var itemType = decodeURIComponent(result.type);
					var itemName = decodeURIComponent(result.name);
					var itemCode = decodeURIComponent(result.code);
					
					addEventWithFunctionString(row, "click", "getRoleList('" + itemType + "', '" + result.code + "', '" + itemName + "')");

					var typeCell = appendCell(row);
					typeCell.innerHTML = itemType;

					var nameCell = appendCell(row);
					nameCell.innerHTML = itemName;

					var codeCell = appendCell(row);
					codeCell.innerHTML = itemCode;
				}

				row.id = rowId;

				var rowClass = getCrossClassName(i, "portlet-section-body", "portlet-section-alternate");
				var rowOverClass = rowClass + "-hover";
				
				addEventWithFunctionString(row, "mouseover", "document.getElementById('" + rowId + "').className = '" + rowOverClass + "'");
				addEventWithFunctionString(row, "mouseout", "document.getElementById('" + rowId + "').className = '" + rowClass + "'");
				row.className = rowClass;
			}
		}

		function getRoleList(type, code, itemname)
		{
			var url = WEB_CONTEXT_ROOT + "/organizationmanager/json/roleUsersToJson.jsp?";

			if (type == "company")
			{
				formatTable(tbodyGroups);
				document.getElementById("groupsTitle").innerHTML = "Children roles of " + itemname;
				url += "comCode=" + code;
			}
			else if (type == "role")
			{
				formatTable(tbodyUsers);
				document.getElementById("usersTitle").innerHTML = "Children users of " + itemname;
				url += "roleCode=" + code;
			}
			
			
			submitAjaxServlet(
					url,
					"Get",
					appendChildNodeToTable,
					null
			);
		}
		
		function init()
		{
			tbodyUsers = document.getElementById("tbodyUsers");
			tbodyGroups = document.getElementById("tbodyGroups");
			
			getRoleList("<%=type%>", "<%=code%>", "<%=itemName%>");
		}
		
		function chkall(){
			$("input[name=del_chk]").attr('checked',$("input[name=del_chk_all]").attr('checked'));
		}
		
		function del_role(){
			var url = WEB_CONTEXT_ROOT + "/organizationmanager/json/deleteUsersRole.jsp";
			
			var empcodeList = $("input[name=empcode]"); 
			var empcode = "";

			i=0;
			jQuery.each($("input[name=del_chk]"), function() {
				if($(this).attr('checked')){
					empcode += empcodeList[i].value + ";"
				}
				i++;
			});
			
			if(empcode == ""){
				alert("<%=GlobalContext.getMessageForWeb("delete_no_choice", loggedUserLocale)%>");
				return;
			}
			
			if(confirm('<%=GlobalContext.getMessageForWeb("delete_confirm", loggedUserLocale)%>')){
				var param = "rolecode=" + $("input[name=rolecode]").val()
		                  + "&empcode=" + empcode;

				submitAjaxServlet(
						url,
						"Post",
						deluserrole,
						param
				);
			}
		}
		
		var deluserrole = function(resultString){
			eval(resultString);
			
			var url = WEB_CONTEXT_ROOT + "/organizationmanager/json/roleUsersToJson.jsp?";
			formatTable(tbodyUsers);
			url += "roleCode=" + $("input[name=rolecode]").val();
			
			submitAjaxServlet(
					url,
					"Get",
					appendChildNodeToTable,
					null
			);
		}
	</script>
	<link href="../style/default.css" rel="stylesheet" type="text/css">
</head>
<body class="soria" onLoad="init();" style="padding: 15px;">
	<span class="sectiontitle" id="groupsTitle">Children roles of <%=itemName %></span>
	<table border="0" cellpadding="0" cellspacing="0" width="100%"  class="tableborder">    
		<col span="1" width="33%" align="center" />
		<col span="1" width="33%" align="center" />
		<col span="1" width="33%" align="center" />
		<thead  class="tabletitle">
			<tr height="25">
				<th><%=GlobalContext.getMessageForWeb("Type", loggedUserLocale)%></th>
				<th><%=GlobalContext.getMessageForWeb("Name", loggedUserLocale)%></th>
				<th><%=GlobalContext.getMessageForWeb("Code", loggedUserLocale)%></th>
			</tr>
		</thead>
		<tbody id="tbodyGroups"></tbody>
	</table>
	
	<br />
	
	<span class="sectiontitle" id="usersTitle">Children users of <%=itemName %></span>
	<span style=""><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/i_delete.gif" onclick="del_role()" /></span>
	<input type="hidden" name="rolecode" value="<%=code %>" />
	<table border="0" cellpadding="0" cellspacing="0" width="100%"  class="tableborder">
		<col span="1" width="5%" align="center" />
		<col span="1" width="20%" align="center" />
		<col span="1" width="25%" align="center" />
		<col span="1" width="25%" align="center" />
		<col span="1" width="25%" align="center" />
		<thead  class="tabletitle">
			<tr height="25">
				<th><input type="checkbox" name="del_chk_all" onclick="chkall()"></th>
				<th><%=GlobalContext.getMessageForWeb("Name", loggedUserLocale)%></th>
				<th><%=GlobalContext.getMessageForWeb("Department", loggedUserLocale)%></th>
				<th><%=GlobalContext.getMessageForWeb("Company", loggedUserLocale)%></th>
				<th><%=GlobalContext.getMessageForWeb("Email", loggedUserLocale)%></th>
			</tr>
		</thead>
		<tbody id="tbodyUsers"></tbody>
	</table>
</body>
</html>
