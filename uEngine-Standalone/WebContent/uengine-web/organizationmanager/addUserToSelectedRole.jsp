<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<html>

<%
	String mappedUser = request.getParameter("mappedUser");
	String roleCode = request.getParameter("selectedRole");
	String roles = request.getParameter("roles");
	String comCode = request.getParameter("comCode");
	String anotherRoles[];
	String mappedUserId[] = mappedUser.split(",");
	if(roles.indexOf(",") > 0){
		anotherRoles = roles.split("'");
	}
%>
<title>Add User</title>
<head>
<%@include file="../common/styleHeader.jsp"%>

<style type="text/css">
    /* NOTE: for a full screen layout, must set body size equal to the viewport. */
    html, body {
    	height: 100%;
    	width: 100%;
    	margin: 0px;
    	padding: 0px; 
    }
    .scrollDiv {
    	overflow: auto;
    	height: 200px;
    }
</style>

<%@ include file="../scripts/importCommonScripts.jsp"%>
<%@ include file="../common/importOrganizationTree.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
    IS_MULTIPLE = true;
    var organizationTree = new OrganizationTree("divOrganizationTree", false);
    getRleUserList();
    
    $("#chkBoxAllUsers").click(function() {
        if ($(this).is(":checked")) {
            $("[name=chkUser]").attr("checked", "checked");
        } else {
            $("[name=chkUser]").attr("checked", "");
        }
    });
});

function updateRole(roleCode) {
	var chkSelectedUser = document.getElementsByName("chkUser");
    var tableRoleUserList = document.getElementById("tableRoleUserList");
    
    var userList = "";
    
    $("[name=chkUser]").each(function() {
        if ($(this).is(":checked")) {
            var chkUserId = $(this).attr("id");
            
            for(var i = 0; i < tableRoleUserList.rows.length; i++) {
                var rowUserCode = tableRoleUserList.rows[i].id;
                
                if(chkUserId == rowUserCode) {
                    isUseable = false;
                    break;
                }
            }
            
            if (userList != "") {
                userList += ",";
            }
            
            userList += chkUserId;
        }
    });
    
    if (userList != "") {
        var url = "addUserToSelectedRoleAction.jsp";
        var param = "selectedUsers=" + userList
            + "&roleCode=" + roleCode
            + "&comCode=<%=comCode%>";
        
        submitAjaxServlet(
                url,
                "POST",
                function (responseText) {
                    alert(responseText.trim());
                    getRleUserList();
                },
                param
        );
    }
}

function searchUser() {
	var mainForm = document.mainForm;
	getUserList(mainForm.column.value, mainForm.key.value, "tableUserList", true); 
	document.getElementById("chkBoxAllUsers").checked = false;
}


function appendChildNodeToTable(resultString) {
	var arrayOfResult = new Array();
	arrayOfResult = eval(resultString);
	
	var tbodyUsers = document.getElementById("tableRoleUserList");
	formatTable(tbodyUsers);
	
	for (var i = 0; i < arrayOfResult.length; i++) {
		var result = arrayOfResult[i];
		var row = appendRow(tbodyUsers);
		
		var rowId = "role_" + result.usercode;
		row.id = rowId;
		
		appendTextNode(appendCell(row), result.usercode.decodeURI());
		appendTextNode(appendCell(row), result.name.decodeURI());
		appendTextNode(appendCell(row), result.partname.decodeURI());
		appendTextNode(appendCell(row), result.globalcom.decodeURI());
		appendTextNode(appendCell(row), result.jikname.decodeURI());
		appendTextNode(appendCell(row), result.email.decodeURI());

		var rowClass = getCrossClassName(i, "portlet-section-body", "portlet-section-alternate");
		var rowOverClass = rowClass + "-hover";
		
		addEventWithFunctionString(row, "mouseover", "document.getElementById('" + rowId + "').className = '" + rowOverClass + "'");
		addEventWithFunctionString(row, "mouseout", "document.getElementById('" + rowId + "').className = '" + rowClass + "'");
		row.className = rowClass;
	}
}

function getDepartmentList(item)
{
	var firstChild = item.children[0];
	if ("tempChildrenForItem" == firstChild.name)
	{
		continentStore.deleteItem(firstChild);
		var url = WEB_CONTEXT_ROOT + "/organizationmanager/json/childrenOfPartJson.jsp";
		var param = "";
		
		if(item.type == "department")
		{
			param = "parentCode=" + item.code;
		}
		else
		{
			param = "comCode=<%=comCode%>";
		}
		
		submitAjaxServlet(
				url,
				"POST",
				function (responseText) {
					appendChildNodeToTree(responseText, item);
				},
				param
		);
	}
}

function getRleUserList() {
	var url = WEB_CONTEXT_ROOT + "/organizationmanager/json/roleUsersToJson.jsp";
	var param = "roleCode=<%=roleCode%>";
	
	submitAjaxServlet(
			url,
			"POST",
			appendChildNodeToTable,
			param
	);
}
</script>
</head>

<body>

<div style="margin: 10px 15px;">
<form name="mainForm">
	<div class="ui-widget ui-widget-header ui-corner-all" style="padding: 5px;">Choose Role Users</div>
        <div style="text-align: right; padding: 10px;">
        	<select name="column">
                <option value="empname"><%=GlobalContext.getMessageForWeb("User Name", loggedUserLocale) %></option>
                <option value="empcode"><%=GlobalContext.getMessageForWeb("User ID", loggedUserLocale) %></option>
                <option value="partname"><%=GlobalContext.getMessageForWeb("Department Name", loggedUserLocale) %></option>
                <option value="partcode"><%=GlobalContext.getMessageForWeb("Department Code", loggedUserLocale) %></option>
            </select>
            <input type="text" name="key" onkeydown="if(event.keyCode == 13){searchUser(); return false;}" style="width:105px;" />
            <input type="button" onclick="searchUser();" value="<%=GlobalContext.getMessageForWeb("Search", loggedUserLocale) %>" style="height:19px;"/>
        </div>
        
        <div>
        	<div id="divOrganizationTree" class="scrollDiv ui-widget-content ui-corner-all" style="float: left; width: 400px;"></div>
        	<div class="scrollDiv ui-widget-content ui-corner-all" style="float: none; margin-left: 0px;">
        		<div style="margin: 5px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" >
						<thead>
					    <tr class="ui-widget">
					    	<th class="ui-state-default"><input type="checkbox" id="chkBoxAllUsers" onclick="formatCheckBox('chkUser', this.checked);" /></th>
							<th class="ui-state-default">CODE</th>
							<th class="ui-state-default">NAME</th>
							<th class="ui-state-default">PART</th>
							<th class="ui-state-default">POSITION</th>
		                </tr>
		                </thead>
		                <tbody id="tableUserList" align="center"></tbody>    
					</table>
        		</div>
        	</div>
        </div>
	    <div style="text-align: center; margin: 10px;">
		    <input type="button" value="▼▼ Click To Update ▼▼" onclick="updateRole('<%=roleCode %>')" style="cursor: pointer;" />
	    </div>
    
</form>

<div class="ui-widget ui-widget-header ui-corner-all" style="padding: 5px;">Current Role Users</div>
<div class="scrollDiv ui-widget-content ui-corner-all" style="margin-top: 5px;">
	<div style="margin: 5px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
		<thead>
	    	<tr class="ui-widget" style="height: 20px;">
	    		<th class="ui-state-default">CODE</th>
	    		<th class="ui-state-default">NAME</th>
	    		<th class="ui-state-default">PART</th>
	    		<th class="ui-state-default">COMPANY</th>
	    		<th class="ui-state-default">POSITION</th>
	    		<th class="ui-state-default">EMAIL</th>
		   </tr>
		   </thead>
		<tbody id="tableRoleUserList" align="center"></tbody>    
	</table>
	</div>
</div>

<form name="addUserToRoleAction" action="addUserToSelectedRoleAction.jsp" method="post" target="innerworkarea" style="hidden">
	<input type="hidden" name="selectedUser" />
	<input type="hidden" name="roleCode" />
	<input type="hidden" name="comCode" value="<%=comCode %>" />
</form>
</div>
</body>

</html>