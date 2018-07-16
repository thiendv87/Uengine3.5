<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="org.uengine.util.dao.*, java.sql.*,javax.sql.*,javax.naming.*"%>
<%@ page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@ page import="java.util.*" %>
<%@ page import="com.defaultcompany.web.acl.AuthorityUtils" %>

<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String defId = request.getParameter("defId");
String defName = request.getParameter("defName");

AclManager acl = AclManager.getInstance(); 
HashMap<Character, Boolean> permission = acl.getPermission(Integer.parseInt(defId), loggedUserId);

String sComOption = "";
if (loggedUserIsAdmin || permission.containsKey(AclManager.PERMISSION_MANAGEMENT)) {
    AuthorityUtils au = new AuthorityUtils();
    sComOption = au.getComTableComboText(loggedUserLocale);
} else {
%>
<script type="text/javascript">
    alert("You don't have Management Authority");
    window.location.href = "../processmanager/processInstanceList.jsp"; 
</script>
<% 
} 
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../common/styleHeader.jsp"%>
<title><%=GlobalContext.getMessageForWeb("Set Authority", loggedUserLocale) %>:<%=defName %></title>
<link href="../style/default.css" rel="stylesheet" type="text/css">
<jsp:include page="../scripts/formActivity.js.jsp" flush="false">
			<jsp:param name="rmClsName" value="<%=rmClsName%>" />
</jsp:include>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/tabs.js"></script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/ajax/ajaxCommon.js"></script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/ajax/department.js"></script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/crossBrowser/elementControl.js"></script>
<%@include file="../lib/jquery/importJquery.jsp"%>
<script type="text/javascript">
var defId = "<%=defId %>";
var WEB_ROOT = "<%=GlobalContext.WEB_CONTEXT_ROOT%>";
var isIE = (document.all) ? 1: 0;

var permissionNames = new Array();
permissionNames["N"] = "<%=GlobalContext.getMessageForWeb("None", loggedUserLocale)%>";
permissionNames["V"] = "<%=GlobalContext.getMessageForWeb("View", loggedUserLocale)%>";
permissionNames["I"] = "<%=GlobalContext.getMessageForWeb("Initiate", loggedUserLocale)%>";
permissionNames["E"] = "<%=GlobalContext.getMessageForWeb("Edit", loggedUserLocale)%>";
permissionNames["M"] = "<%=GlobalContext.getMessageForWeb("Management", loggedUserLocale)%>";

//var defaultUserNames = new Array();
//defaultUserNames["A"] = "anonymous";
//defaultUserNames["M"] = "members";

$(document).ready(function() {
	getAuthorityList();
});

function getText(o) {
	var tmpValue = "";
	if (o && o.nodeValue != "null") {
		tmpValue = o.nodeValue;
	}
	else
	{
		tmpValue = " - ";
	}
	
	return decodeURIComponent(tmpValue);
}

var getAuthorityList = function() {
    var url = WEB_ROOT + "/authority?defId=" + defId;
    submitAjaxServlet(url, "Get", setAuthorityTable, null)
}

var setAuthorityTable = function(res) {
	var dom = getDom(res);
	var tableAuthority = document.getElementById("tableAuthority");
	
	formatTable(tableAuthority);

	var authoritys = dom.getElementsByTagName("authority");
	var aclIds = dom.getElementsByTagName("aclid");
	var comCodes = dom.getElementsByTagName("comcode");
	var comNames = dom.getElementsByTagName("comname");
	var partCodes = dom.getElementsByTagName("partcode");
	var partNames = dom.getElementsByTagName("partname");
	var empCodes = dom.getElementsByTagName("empcode");
	var empNames = dom.getElementsByTagName("empname");
	var roleCodes = dom.getElementsByTagName("rolecode");
	var roleNames = dom.getElementsByTagName("rolename");
	//var defaultusers = dom.getElementsByTagName("defaultuser");
	var permissions = dom.getElementsByTagName("permission");
	
	for (var listCount = 0; listCount < authoritys.length; listCount++) {
		//var defaultuser = defaultUserNames[defaultusers[listCount].childNodes[0].nodeValue];
		var permission = getText(permissions[listCount].childNodes[0]);
		var aclid = getText(aclIds[listCount].childNodes[0]);

		//if (defaultuser) {
		//	var cb = document.getElementById(defaultuser + "Permission" + permission);
		//	if (cb.fireEvent) {
		//		cb.checked = true;
		//		cb.fireEvent("onclick");
		//	} else {
		//		cb.click();
		//	}
		//} else {
			var row = appendRow(tableAuthority);
			row.style.backgroundColor = "#ffffff";

			var comName = getText(comNames[listCount].childNodes[0]);
			var empName = getText(empNames[listCount].childNodes[0]);
			var partName = getText(partNames[listCount].childNodes[0]);
			var roleName = getText(roleNames[listCount].childNodes[0]);
			
			//alert(comName + "/" + empName + "/" + partName + "/" + roleName);
			appendTextNodeWithAlign(appendCell(row), comName, "center");
			appendTextNodeWithAlign(appendCell(row), partName, "center");
			appendTextNodeWithAlign(appendCell(row), empName, "center");
			appendTextNodeWithAlign(appendCell(row), roleName, "center");
			appendTextNodeWithAlign(appendCell(row), permissionNames[permission], "center");
			
			var button = document.createElement("input");
			button.type = "button";
			button.id = aclid + "___aclId";
			button.value = "<%=GlobalContext.getMessageForWeb("Delete", loggedUserLocale) %>";
			button.onclick = function() { deleteAuthority(this); };
			
			cell = appendCell(row);
			cell.appendChild(button);
			cell.style.textAlign = "center";
			
		//}
	}
}

var addAuthority = function () {
	var fm = 	document.formAuthority;
	var userType = userTypeName[contentPageName];
	
	var chk = false;
	$("input[name='permission']").each(function(index, chkbox) {
   		if (chkbox.checked) {
   			chk = true;
   		}
       });
	
	if (!chk) {
		alert("허가 내용을 선택하시지 않으셨습니다.");
		return;
	}
	
	if (
			(userType == "com" && fm.comCode.value != "") 
			|| (userType == "part" && fm.partCode.value != "")
			|| (userType == "emp" && fm.empCode.value != "")
			|| (userType == "role" && fm.roleCode.value != "")
	) {
		fm.userType.value = userType + "Code";
		fm.action = "authorityAction.jsp";
		fm.todo.value = "add";
		fm.submit();
	} else {
		alert("<%=GlobalContext.getMessageForWeb("Required data is not", loggedUserLocale) %>");
	}
}

var deleteAuthority = function(button) {
	var aclId = button.id.split("___aclId")[0];
	var fm = 	document.formAuthority;
	fm.aclId.value = aclId;
	fm.todo.value = "delete";
	fm.action = "authorityAction.jsp";
	fm.submit();
}

var setDefaultPermission = function() {
	var fm = 	document.formAuthority;
	fm.todo.value = "set";
	fm.action = "defaultAuthorityAction.jsp";
	fm.submit();
}

function showLayer(id) {
	document.getElementById(id).style.display = "";
}

function hideLayer(id) {
	document.getElementById(id).style.display = "none";
}

var roleInputName = "";
function searchRole(s) {
	roleInputName = s;
	var url = "../common/rolePicker.jsp";
	window.open(url,'','top=190,left=500,width=400,height=400,resizable=true,scrollbars=no');
}

function setRoleInput(a) {
	document.getElementById(roleInputName).value = a[0];
	document.getElementById(roleInputName + "_display").value = a[1];
}

function setNonePermission(o) {
	var checkboxs = document.getElementsByName(o.name);
	var isCheck = o.checked;

	for (var i = 0; i< checkboxs.length; i++) {
		var cb = checkboxs[i];
		if (cb != o) {
			cb.disabled = isCheck;
		}
	}
}
</script>
<style type="text/css">
body {
	padding:15px;
	
}
.tabs{ height:28px;}
</style>
</head>
<body>
<form name="formAuthority" method="post">
    <input type="hidden" name="defId" value="<%=defId %>" />
    <input type="hidden" name="defName" value="<%=defName %>" />
    <input type="hidden" name="todo" />
    <input type="hidden" name="userType" />
    <input type="hidden" name="aclId" />
<!-- 
    <table width="100%">
        <tr>
            <td><span class="sectiontitle"><b><%=GlobalContext.getMessageForWeb("Default Setting", loggedUserLocale) %></b></span></td>
            <td align="right">
                <table>
                    <tr>
                        <td class="gBtn">
                            <a onClick="setDefaultPermission();" > <span><%=GlobalContext.getMessageForWeb("Update", loggedUserLocale) %></span></a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table width="100%" cellpadding="0" cellspacing="0">
        <col span="1" width="20%" />
        <col span="1" width="*" />
        <tr>
            <td colspan="2" class="formheadline"></td>
        </tr>
        <tr>
            <td class="formtitle"><%=GlobalContext.getMessageForWeb("For Loggin User", loggedUserLocale) %> : </td>
            <td class="formcon">
                <input type="checkbox" name="membersPermission" value="V" id="membersPermissionV" title="View" alt="View" />
                <label for="membersPermissionV"><%=GlobalContext.getMessageForWeb("View", loggedUserLocale) %></label>
                <input type="checkbox" name="membersPermission" value="I" id="membersPermissionI"  title="Implement" alt="Implement" />
                <label for="membersPermissionI"><%=GlobalContext.getMessageForWeb("Initiate", loggedUserLocale) %></label>
                <input type="checkbox" name="membersPermission" value="E" id="membersPermissionE" title="Edit" alt="Edit" />
                <label for="membersPermissionE"><%=GlobalContext.getMessageForWeb("Edit", loggedUserLocale) %></label></td>
        </tr>
        <tr>
            <td colspan="2" class="formheadline"></td>
        </tr>
    </table>
    <br />
    <br />
 -->
    <table width="100%">
        <tr>
            <!-- td><span class="sectiontitle"><b><%=GlobalContext.getMessageForWeb("Set Authority", loggedUserLocale) %> : <%=defName %></b></span></td-->
            <td align="right">
                <table>
                    <tr>
                        <td class="gBtn">
                            <a onclick="showLayer('divAddAuthority');" > <span><%=GlobalContext.getMessageForWeb("Add", loggedUserLocale) %></span></a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2"  height="4"></td>
        </tr>
    </table>
    <br />
    <table width="100%" cellpadding="0" cellspacing="0"class="tableborder">
        <col span="1" width="15%">
        <col span="1" width="15%">
        <col span="1" width="15%">
        <col span="1" width="15%">
        <col span="1" width="20%">
        <col span="1" width="20%">
        <thead>
        <tr class="tabletitle">
            <th><%=GlobalContext.getMessageForWeb("Company", loggedUserLocale) %></th>
            <th><%=GlobalContext.getMessageForWeb("Department", loggedUserLocale) %></th>
            <th><%=GlobalContext.getMessageForWeb("User", loggedUserLocale) %></th>
            <th><%=GlobalContext.getMessageForWeb("Role", loggedUserLocale) %></th>
            <th><%=GlobalContext.getMessageForWeb("Permission", loggedUserLocale) %></th>
            <th><%=GlobalContext.getMessageForWeb("Delete", loggedUserLocale) %></th>
        </tr>
        </thead>
        <tbody id="tableAuthority"></tbody>
    </table>
    <br />
    <div id="divAddAuthority" style="display:none;position:absolute; top:168px; right:15px; width:500px; _height:130px; min-height:130px; background: #fff; border:#666 solid 1px; padding: 15px">
        <script type="text/javascript">
			var tabMenus = [
					"<%=GlobalContext.getMessageForWeb("Company", loggedUserLocale) %>",
					"<%=GlobalContext.getMessageForWeb("Department", loggedUserLocale) %>",
					"<%=GlobalContext.getMessageForWeb("User", loggedUserLocale) %>",
					"<%=GlobalContext.getMessageForWeb("Role", loggedUserLocale) %>"
			];
			var userTypeName = new Array();
			userTypeName["<%=GlobalContext.getMessageForWeb("Company", loggedUserLocale) %>"] = "com",
			userTypeName["<%=GlobalContext.getMessageForWeb("Department", loggedUserLocale) %>"] = "part",
			userTypeName["<%=GlobalContext.getMessageForWeb("User", loggedUserLocale) %>"] = "emp",
			userTypeName["<%=GlobalContext.getMessageForWeb("Role", loggedUserLocale) %>"] = "role";
			
			createTabs(tabMenus);
		</script>
        <div id="divTabItem_<%=GlobalContext.getMessageForWeb("Company", loggedUserLocale) %>">
            <table width="100%" cellpadding="0" cellspacing="0">
                <col span="1" width="170" />
                <col span="1" width="*" />
                <tr>
                    <td colspan="2"  height="10"></td>
                </tr> 
                <tr>
                    <td colspan="2"  height="1" bgcolor="#b9cae3"></td>
                </tr>                               
                <tr>
                    <td class="formtitle"><%=GlobalContext.getMessageForWeb("Set as Company", loggedUserLocale) %></td>
                    <td class="formcon"><select name="comCode">
                            <%=sComOption %>
                        </select></td>
                </tr>
                <tr>
                    <td colspan="2"  height="1" bgcolor="#b9cae3"></td>
                </tr>
            </table>
        </div>
        <div id="divTabItem_<%=GlobalContext.getMessageForWeb("Department", loggedUserLocale) %>" style="display: none;">
            <table width="100%" cellpadding="0" cellspacing="0">
                <col span="1" width="170" />
                <col span="1" width="*" />
                <tr>
                    <td colspan="2"  height="10"></td>
                </tr> 
                <tr>
                    <td colspan="2"  height="1" bgcolor="#b9cae3"></td>
                </tr>                 
                <tr>
                    <td class="formtitle"><%=GlobalContext.getMessageForWeb("Set as Department", loggedUserLocale) %></td>
                    <td class="formcon"><select onChange="changCompany(this);">
                            <%=sComOption %>
                        </select>
                        <select name="partCode" id="selectPartCode">
                        </select></td>
                </tr>
                <tr>
                    <td colspan="2"  height="1" bgcolor="#b9cae3"></td>
                </tr>
            </table>
        </div>
        <div id="divTabItem_<%=GlobalContext.getMessageForWeb("User", loggedUserLocale) %>" style="display: none;">
            <table width="100%" cellpadding="0" cellspacing="0">
                <col span="1" width="170" />
                <col span="1" width="*" />
                <tr>
                    <td colspan="2"  height="10"></td>
                </tr> 
                <tr>
                    <td colspan="2"  height="1" bgcolor="#b9cae3"></td>
                </tr>                 
                <tr>
                    <td class="formtitle"><%=GlobalContext.getMessageForWeb("Set as User", loggedUserLocale) %></td>
                    <td class="formcon">
                        <input type="hidden" name='empCode__which_is_xml_value' id="empCode__which_is_xml_value" value="" size="1" />
                        <input type="hidden" name="empCode" id="empCode" />
                        <input type="text" name='empCode_display' id="empCode_display" readonly="readonly" />
                        <img name="empCode" align="middle" onclick="searchPeopleObj(this, true);" style="cursor: pointer;" src='<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/Toolbar-toblock.gif' alt="emp code search" title="Employee code search"/>
        		    </td>
                </tr>
                <tr>
                    <td colspan="2"  height="1" bgcolor="#b9cae3"></td>
                </tr>
            </table>
        </div>
        <div id="divTabItem_<%=GlobalContext.getMessageForWeb("Role", loggedUserLocale) %>" style="display: none;">
            <table width="100%" cellpadding="0" cellspacing="0">
                <col span="1" width="170" />
                <col span="1" width="*" />
                <tr>
                    <td colspan="2"  height="10"></td>
                </tr> 
                <tr>
                    <td colspan="2"  height="1" bgcolor="#b9cae3"></td>
                </tr>                 
                <tr>
                    <td class="formtitle"><%=GlobalContext.getMessageForWeb("Set as Role", loggedUserLocale) %></td>
                    <td class="formcon">
                        <input type="hidden" name="roleCode" id="roleCode" />
                        <input type="text" name="roleCode_display" id="roleCode_display" readonly="readonly" onClick="searchRole('roleCode');" />
                        <img align="middle" onclick="searchRole('roleCode');" style="cursor: pointer;" src='<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/Toolbar-toblock.gif' alt="role search" title="Role search"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"  height="1" bgcolor="#b9cae3"></td>
                </tr>
            </table>
        </div>
        <table width="100%" cellpadding="0" cellspacing="0">
            <col span="1" width="170" />
            <col span="1" width="*" />
            <tr>
                <td class="formtitle"><%=GlobalContext.getMessageForWeb("Permission", loggedUserLocale) %></td>
                <td class="formcon">
                    <input type="checkbox" name="permission" value="V" id="permissionV" readonly="readonly" title="View" alt="View" />
                    <label for="permissionV"><%=GlobalContext.getMessageForWeb("View", loggedUserLocale) %></label>
                    <input type="checkbox" name="permission" value="I" id="permissionI" title="Implement" alt="Implement" />
                    <label for="permissionI"><%=GlobalContext.getMessageForWeb("Initiate", loggedUserLocale) %></label>
                    <input type="checkbox" name="permission" value="E" id="permissionE" title="Edit" alt="Edit" />
                    <label for="permissionE"><%=GlobalContext.getMessageForWeb("Edit", loggedUserLocale) %></label>
            </tr>
            <tr>
                <td colspan="2"  height="1" bgcolor="#b9cae3"></td>
            </tr>
            <tr>
                <td colspan="2"  height="15"></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                	<table>
                        <tr>
                            <td class="gBtn">
                            	<a onclick="addAuthority();" > <span><%=GlobalContext.getMessageForWeb("Register", loggedUserLocale) %></span></a>
                            	<a onclick="hideLayer('divAddAuthority');" > <span><%=GlobalContext.getMessageForWeb("Cancel", loggedUserLocale) %></span></a>
                            </td>
                        </tr>
                    </table></td>
            </tr>
        </table>
    </div>
</form>
<br /><br />
</body>
</html>
