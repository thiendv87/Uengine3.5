<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Organization Chart</title>
	<%@include file="../../../common/header.jsp"%>
	<%@include file="../../../common/getLoggedUser.jsp"%>
	<%@include file="../../../common/styleHeader.jsp"%>
	
	<%
		boolean isMultiple = UEngineUtil.isTrue(request.getParameter("multiple"));
		boolean isApproval = UEngineUtil.isTrue(request.getParameter("isApproval"));
		isMultiple = true;
		//String sMultiple = request.getParameter("multiple");
		
		/*try {
		} catch (Exception e) {
			isMultiple = true;
			isApproval = false;
		}*/
	
		String inputType = null;
		String dblClickScript = null;
	
		if (isMultiple) {
			dblClickScript = "deleteApproval();";
		} else {
			dblClickScript = "";
		}
	%>
	<script type="text/javascript">
		var IS_MULTIPLE = <%=isMultiple%>;
		var IS_APPROVAL = <%=isApproval%>;
	</script>
	<%@ include file="../../../scripts/importCommonScripts.jsp"%>
	<%@ include file="../../../lib/jquery/importJquery.jsp"%>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/lib/jsTree/_lib/jquery.cookie.js"></script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/lib/jsTree/_lib/jquery.hotkeys.js"></script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/lib/jsTree/jquery.jstree.js"></script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/organization/treeView.js"></script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/ajax/userList.js"></script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/organization/util.js"></script>
	<style type="text/css">
		.intro {
			height: 20px;
		}
	</style>
</head>
<body>
<form name="mainForm" style="margin: 10px; ">
<div class="ui-widget-content" style="float: left; padding: 5px;">
	<div class="ui-widget ui-widget-header" style="padding: 5px;">Organization Chart</div>
	<div style="width: 350px; float: inherit;">
		<p class="intro">
			<select name="column">
				<option value="empname"><%=GlobalContext.getMessageForWeb("User Name", loggedUserLocale)%></option>
				<option value="empcode"><%=GlobalContext.getMessageForWeb("User ID", loggedUserLocale)%></option>
				<option value="partname"><%=GlobalContext.getMessageForWeb("Department Name", loggedUserLocale)%></option>
				<option value="partcode"><%=GlobalContext.getMessageForWeb("Department Code", loggedUserLocale)%></option>
			</select>
			<input type="text" name="key" onkeypress="chkEnter(event);" />
			<input type="button" onclick="searchUser();" value="<%=GlobalContext .getMessageForWeb("Search", loggedUserLocale)%>" />
		</p>
		<div id="divOrganizationTree" style="overflow: auto; height: 155px; border: 1px solid #CCC;"></div>
	
		<script type="text/javascript">
		//var dataURL = "/uengine-web/lib/jsTree/_docs/_json_data.json";
		var dataURL = WEB_CONTEXT_ROOT + "/organizationmanager/datas/organizationDataForJtree.jsp";
		var imagesFolder = WEB_CONTEXT_ROOT + "/processmanager/images";
		$(function () {
			$("#divOrganizationTree").jstree({
				"plugins" : [ "themes", "json_data", "ui", "types", "hotkeys" ],
				"json_data" : {
					"ajax" : {
						"url" : dataURL,
						"data" : function (n) {
				            var params = {};
				            
				            if (this._get_type(n)) {
				                switch (this._get_type(n)) {
				                    case "company":
				                        params = {
				                            comCode: n.attr("code")
				                        };
				                        break;
				                    case "department":
				                        params = {
				                            parentCode: n.attr("code")
				                        };
				                    default:
				                        break;
				                }
				            }
				            
				            return params;
						}
					}
				},
		           "types": {
		               "max_depth": -2,
		               "max_children": -2,
		               "valid_children": ["company"],
		               "types": {
		                   "company": {
		                       "icon": {
		                           "image": imagesFolder + "/obj_icon_company.gif"
		                       },
		                       "valid_children": ["department", "user"],
		                       "max_depth": -1,
		                       "hover_node": false,
		                       "select_node": function(){
		                           return true;
		                       }
		                   },
		                   "department": {
		                       "icon": {
	                           		"image": imagesFolder + "/obj_icon_quarter.gif"
		                       },
		                       "valid_children": ["department", "user"],
		                       "max_depth": -1,
		                       "hover_node": false,
		                       "select_node": function(n){
		                           getUserList("partcode", this._get_node(n).attr("code"), "tableUserList", IS_MULTIPLE, IS_APPROVAL);
		                           //							try {
		                           //								document.getElementById("chkBoxAllUsers").checked = false;
		                           //							} catch (e) {}
		                           return true;
		                       }
		                   },
		                   "user": {
		                       "icon": {
	                           		"image": imagesFolder + "/obj_icon_user.gif"
		                       },
		                       "valid_children": "none",
		                       "max_depth": -1,
		                       "hover_node": false,
		                       "select_node": function(n){
		                           //							var id = item.code;
		                           //							var name = item.name;	
		                           //							var jikname= item.jikname;	
		                           //							
		                           //							adduser(id, name, jikname);
		                           return true;
		                       }
		                   }
		               }
		           }
			});
		});
		</script> <br />
		<div class="tableborder">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<col span="1" style="width: 30px" align="center" />
				<col span="1" style="width: 30px" align="center" />
				<col span="1" align="center" />
				<col span="1" align="center" />
				<col span="1" align="center" />
				<tr class="tabletitle" align="center">
					<th>
					<%
						if (isMultiple) {
					%> <input type="checkbox" id="chkBoxAllUsers" onclick="formatCheckBox('chkUser', this.checked);" /> <%
		 	} else {
		 %> &nbsp; <%
		 	}
		 %>
					</th>
					<th>CODE</th>
					<th>NAME</th>
					<th>PART</th>
					<th>POSITION</th>
				</tr>
			</table>
			<div style="height: 180px; overflow: auto;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<col span="1" style="width: 30px;" align="center" />
				<col span="1" style="width: 30px;" align="center" />
				<col span="1" align="center" />
				<col span="1" align="center" />
				<col span="1" align="center" />
				<tbody id="tableUserList"></tbody>
			</table>
			</div>
		</div>
	</div>
<%
	if (isMultiple) {
%>
	<script type="text/javascript">
				window.resizeTo(600, 580);
	</script>
	<div style="width: 40px; float: inherit; text-align: center; padding-top: 100px;">
		<img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/b_addR.gif" width="25" height="25" onclick="addUser()" style="cursor: pointer" /><br /><br />
		<img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/b_addL.gif" width="25" height="25" onclick="deleteApproval()" style="cursor: pointer" />
	</div>
	<div style="width: 150px; float: inherit;">
		<p class="intro">
		<img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/I_info.gif" width="11" height="11" />
		Double click : Remove
		</p>
		<select multiple="multiple" name="selectUserList" id="selectUserList"
			style="background: #F7F7F7; width: 100%; height: 378px;"
			ondblclick="deleteApproval();"></select>
	</div>
<%
	}
%>
</div>
</form>
</body>
</html>