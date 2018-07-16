<%@ page contentType="text/html; charset=UTF-8" language="java"  %>
<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>
<%
	boolean isMultiple = reqMap.getBoolean("multiple", true);
	
	String inputType = null;
	String dblClickScript = null;
	if (isMultiple) {
		dblClickScript = "deleteApproval();";
	} else {
		dblClickScript = "";
	}
%>
<%@page import="org.uengine.util.UEngineUtil"%>
<html>
<head>
<title>OrganizationChart</title>
<%@include file="../../common/styleHeader.jsp"%>
<style type="text/css">
	@import "<%=GlobalContext.WEB_CONTEXT_ROOT %>/dojo/dojo/resources/dojo.css";
	@import "<%=GlobalContext.WEB_CONTEXT_ROOT %>/dojo/dijit/tests/css/dijitTests.css";
</style>
<%@include file="../../scripts/importCommonScripts.jsp" %>

<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/ajax/ajaxCommon.js"></script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/crossBrowser/elementControl.js"></script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/dojo/dojo/dojo.js" djConfig="parseOnLoad: true, isDebug: false"></script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/dojo/dijit/tests/_testCommon.js"></script>
<script type="text/javascript">
		dojo.require("dojo.data.ItemFileWriteStore");
		dojo.require("dijit.Tree");
		dojo.require("dijit.ColorPalette");
		dojo.require("dijit.Menu");
		dojo.require("dojo.parser");	// scan page for widgets and instantiate them
		var global_tn = '';
		
		var IS_MULTIPLE = <%=isMultiple%>;
		function SelectedInfo() {
				var code = '';
				var name = '';
				var description = '';
		}
		
		
		function getSelectedDepartments() {
			if (IS_MULTIPLE) {
				selectedDepartmentList = new Array();
	
				var selectList = document.mainForm.selectDepartmentList;
				var j = 0;
				for (var i=0; i<selectList.options.length; i++) {
					var info = selectList.options[i].value.split(";");
					
					var department = {code : info[0], name : info[1]};
					selectedDepartmentList[selectedDepartmentList.length] = department;
				}
			}
			
			return selectedDepartmentList;
		}
		
		function addDepartment() {
			var departmentList = document.mainForm.chkDepartment;
			
			if (departmentList) {
				if (departmentList.length) {
					for (var ii = 0; ii < departmentList.length; ii++) {
						setDepartment(departmentList[ii])
					}
				} else {
					setDepartment(departmentList)
				}
				
				if (IS_MULTIPLE) {
					getSelectedDepartments(departmentList);
				}
			}
		}

		function setDepartment(chkBoxUser)
		{
			var info = null;
			var department = null;
			
			if (chkBoxUser.checked == true) {
				info = chkBoxUser.id;
				var infos = info.split(";");
				department = { code : infos[0], name : infos[1], description : ''};

				if (IS_MULTIPLE) {
					var newOption = document.createElement("option");
					var realTargetTag = document.mainForm.selectDepartmentList;
					
					newOption.value = info;
					newOption.text = " " + infos[1];
					
					realTargetTag.options.add(newOption);
				} else {
					selectedDepartmentList[0] = department;
				}
			}
		}
		
		function deleteApproval() {
			var selectedUser = document.mainForm.selectDepartmentList;

			for (var ii = 0; ii < selectedUser.options.length; ii++) {
				var option = selectedUser.options[ii];
				if (option.selected) {
					selectedUser.options[ii] = null;
					ii--;
				}
			}

			getSelectedDepartments();
		}

		function searchDepartment() {
			var mainForm = document.mainForm;
			getDepartmentList(mainForm.column.value, mainForm.key.value, "tableUserList", IS_MULTIPLE); 
			try {
				document.getElementById("chkBoxAllUsers").checked = false;
			} catch (e) {}
		}

		function chkEnter(e) {
			var code = (window.event) ? event.keyCode : e.which;
			if (code == 13) {
				searchUser();
				if (window.event) {
					window.event.returnValue = false;
				} else {
					e.returnValue = false;
				}
			}
		}

		var appendChildNodeToTree = function(item, resultValue) {
			var resultArray = eval(resultValue);
			
			for (var i = 0; i < resultArray.length; i++)
			{
				var result = resultArray[i];
				
				if (result.discription)
				{
					result.discription = decodeURIComponent(result.discription);
				}
				
				if (result.name)
				{
					result.name = decodeURIComponent(result.name);
				}
				
				var newItem = continentStore.newItem(result, {parent : item, attribute : "children"});
				var tempChild = {code : "temp" + result.code, name : "tempChildrenForItem", type : "temp"};
				continentStore.newItem(tempChild, {parent : newItem, attribute : "children"});

				
			}
		}

		function getLabelForCheckBox(inputId, lableText)
		{
			var label = document.createElement("label");
			
			appendTextNode(label, lableText)
			label.htmlFor = inputId;
			label.style.cursor = "pointer";

			return label;
		}

		var appendChildNodeToTable = function(item, resultValue) {
			var resultArray = eval(resultValue);
			var tableUserList = document.getElementById("tableUserList");

			formatTable(tableUserList);
			
			for (var i = 0; i < resultArray.length; i++)
			{
				var result = resultArray[i];
				
				if (result.discription)
				{
					result.discription = decodeURIComponent(result.discription);
				}
				
				if (result.name)
				{
					result.name = decodeURIComponent(result.name);
				}

				var row = appendRow(tableUserList);

				var checkCell = appendCell(row);
				var input = null;

				if (document.all)
				{
					var createString = "<input name='chkDepartment' ";

					if (!IS_MULTIPLE)
					{
						createString += " onclick='addDepartment(); onOk(selectedDepartmentList, opener.inputName); window.close();' ";
					}
					createString += " />";
					input = document.createElement(createString);
				}
				else
				{
					input = document.createElement("input");
					input.type = "chkDepartment";

					if (!IS_MULTIPLE)
					{
						input.onclick = function()
						{
							addDepartment();
							onOk(selectedDepartmentList, opener.inputName); 
							window.close();
						}
					}
				}
				var inputId = result.code + ";" + result.name;
				input.type = "checkbox";
				input.id = inputId;
				checkCell.appendChild(input);
				
				var codeCell = appendCell(row);
				codeCell.appendChild(getLabelForCheckBox(inputId, result.code));
				
				var nameCell = appendCell(row);
				nameCell.appendChild(getLabelForCheckBox(inputId, result.name));
				
				var campanyCell = appendCell(row);
				campanyCell.appendChild(getLabelForCheckBox(inputId, result.globalcom));
			}
		}

		function getDepartmentListForTable(item)
		{
			var url = WEB_CONTEXT_ROOT + "/organizationmanager/json/childrenOfPartJson.jsp?";
			
			if (item.type == "company")
			{
				url += "comCode=" + item.code;
			}
			else if(item.type == "department")
			{
				url += "parentCode=" + item.code;
			}
			
			submitAjaxServlet(
					url,
					"Get",
					function (resultValue)
					{
						appendChildNodeToTable(item, resultValue);
					},
					null
			);
		}

		function getDepartmentList(item)
		{
			if (item.children)
			{
				var firstChild = item.children[0];
				
				if ("tempChildrenForItem" == firstChild.name)
				{
					continentStore.deleteItem(firstChild);
					var url = WEB_CONTEXT_ROOT + "/organizationmanager/json/childrenOfPartJson.jsp?";
					
					if (item.type == "company")
					{
						url += "comCode=" + item.code;
					}
					else if(item.type == "department")
					{
						url += "parentCode=" + item.code;
					}
					
					submitAjaxServlet(
							url,
							"Get",
							function (resultValue)
							{
								appendChildNodeToTree(item, resultValue);
							},
							null
					);
				}
			}
		}
		
		var selectedDepartmentList = new Array();
		var inpuName = "";
	</script>
<style type="text/css">
BODY {
	background:url(images/empty.gif) #ffffff;
	margin: 0px;
	padding: 0px;
}
</style>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/tabs.js"></script>
</head>
<body>
<form name="mainForm">
   
    <table width="95%"  align="center">
        <tr>
        <td valign="top">
        
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                	<select name="column">
                        <option value="empname"><%=GlobalContext.getMessageForWeb("User Name", loggedUserLocale) %></option>
                        <option value="empcode"><%=GlobalContext.getMessageForWeb("User ID", loggedUserLocale) %></option>
                        <option value="partname"><%=GlobalContext.getMessageForWeb("Department Name", loggedUserLocale) %></option>
                        <option value="partname"><%=GlobalContext.getMessageForWeb("Department Code", loggedUserLocale) %></option>
                    </select>
                    <input type="text" name="key" onKeyPress="chkEnter(event);" style="height:19px; width:105px;" />
                    <input type="button" onClick="searchUser();" value="<%=GlobalContext.getMessageForWeb("Search", loggedUserLocale) %>" style="height:19px;"/></td>
            </tr>
            <tr>
                <td height="10"></td>
            </tr>
        </table>
        <div style="overflow: auto; height: 155px; border:1px solid #CCC;">
                	<div dojoType="dojo.data.ItemFileWriteStore" jsId="continentStore" url="<%=GlobalContext.WEB_CONTEXT_ROOT %>/organizationmanager/json/jsonConfig.json"></div>
                    
                    <div dojoType="dijit.tree.ForestStoreModel" jsId="continentModel" store="continentStore" 
					rootId="continentRoot" rootLabel="Organization" childrenAttrs="children" ></div>
                    
                    <div dojoType="dijit.Tree" id="tree2" model="continentModel" showRoot="false" openOnClick="false" >
                <script type="dojo/method" event="getIconClass" args="item, opened">
					var ObjType="";
					
					if (item == this.model.root) {
						ObjType = "folder";
					} else if (continentStore.getValue(item, "type") == "root") {
						ObjType = "folder";
					} else {
						ObjType = continentStore.getValue(item, "type");
					}
					
					if (ObjType == "folder") {
						ObjType = opened ? "customFolderOpenedIcon" : "customFolderClosedIcon";
					} else if (ObjType == "company") {
						ObjType = "comIcon";
					} else if (ObjType == "department") {
						ObjType = "deptIcon";
					}
					
					return ObjType;
				</script>
                <script type="dojo/method" event="onClick" args="item">
					if (item.type == "department" || item.type == "company")
					{
						getDepartmentListForTable(item);
						
						try {
							document.getElementById("chkBoxAllUsers").checked = false;
						} catch(e){}
					}
				</script>
				<script type="dojo/method" event="onOpen" args="item, node">
					getDepartmentList(item);
				</script>
                </div>
        </div>
        <br>
        <hr>
        <table width="100%" class="tableborder" >
            <tr>
                <td>
                	
		            <div style="width:100%; height:110px; overflow:auto;">
                	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                		<col span="1" align="center" />
                		<col span="1" align="center" />
                		<col span="1" align="center" />
                		<col span="1" align="center" />
                		
                		<thead>
                        <tr class="tabletitle" align="center" height="26">
                            <td width="30" align="center">
                           		<% if (isMultiple) { %>
                                <input type="checkbox" id="chkBoxAllDepartments" onClick="formatCheckBox('chkDepartment', this.checked);" />
                                <% } else { %>
                                &nbsp;
                                <% } %>
                            </td>
                            <td>CODE</td>
                            <td>NAME</td>
                            <td>COMPANY</td>
                        </tr>
                        </thead>
	                    <tbody id="tableUserList"></tbody>
                    </table>
		            </div>
                </td>
            </tr>            
        </table>
        </td>
        
        <% if (isMultiple) { %>
        <script type="text/javascript">
			window.resizeTo(600, 580);
		</script>
        <td width="40" align="center">
			<img src="../../images/Common/b_addR.gif" width="25" height="25" onClick="addDepartment()" style="cursor:pointer">
			<br />
			      <br />
			      <img src="../../images/Common/b_addL.gif" width="25" height="25" onClick="deleteApproval()" style="cursor:pointer">
			</td>
			<td width="200"  valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
			        <tr>
			            <td><img src="../../images/Common/I_info.gif" width="11" height="11"></td>
			            <td height="30" style="font-size:11px; letter-spacing:-1; text-align:center">double click = remove selected user</td>
			        </tr>
			        <tr>
			            <td colspan="2"><select multiple="multiple" name="selectDepartmentList" id="selectDepartmentList" size="22" style="width:100% " ondblclick="deleteApproval();" style="background:#F7F7F7"></select></td>
			        </tr>
			    </table>
		</td>
            <% } %>
        </tr>
    </table>
    <br>
    <br>
    <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
            <td  class="formheadline"></td>
        </tr>
    </table>
</form>
</body>
</html>