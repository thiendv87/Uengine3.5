<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../../common/header.jsp"%>
<%@ page import="com.defaultcompany.web.acl.AuthorityUtils" %>
<html>
<head>
<%@include file="../../../common/getLoggedUser.jsp"%>
<%
AuthorityUtils au = new AuthorityUtils();
String sComOption = au.getComTableComboText(loggedUserLocale);
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Monitor Filter</title>
<%@include file="../../../common/styleHeader.jsp"%>
<%@include file="../../../lib/jquery/importJquery.jsp" %>
<link rel="stylesheet" href="<%=GlobalContext.WEB_CONTEXT_ROOT %>/style/portlet.css" type="text/css" > 
<link rel="stylesheet" href="<%=GlobalContext.WEB_CONTEXT_ROOT %>/style/portal.css" type="text/css" >  
<link rel="stylesheet" href="<%=GlobalContext.WEB_CONTEXT_ROOT %>/style/groupware.css" type="text/css" >
<link rel="stylesheet" href="<%=GlobalContext.WEB_CONTEXT_ROOT %>/style/uengine.css" type="text/css" >
<style>
    .ui-autocomplete-loading { background: white url('<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/ui-anim_basic_16x16.gif') right center no-repeat; }
</style>

<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/tabs.js"></script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/ajax/ajaxCommon.js"></script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/ajax/department.js"></script>
<script type="text/javascript">
var WEB_ROOT = "<%=GlobalContext.WEB_CONTEXT_ROOT %>";

$(document).ready(function() {
    $("#tagText")
        .bind( "keydown", function( event ) {
            if ( event.keyCode === $.ui.keyCode.ENTER &&
                    $( this ).data( "autocomplete" ).menu.active ) {
                event.preventDefault();
            }
        })
        .autocomplete({
            source: function( request, response ) {
                var tag = $("#tagText").val();
                if (tag != "" && tag.lastIndexOf(";") > -1 && tag.length != null) {
                    if (tag == ";") {
                        $("#tagText").val("");
                        return;
                        //tag = "";
                    } else {
                        tag = tag.substring(tag.lastIndexOf(";")+1, tag.length);
                    }
                }
                
                if (tag == "") {
                    return;
                }

                $.ajax({
                    url:"<%=GlobalContext.WEB_CONTEXT_ROOT%>/tagService",
                    data: {"tag" : tag, "type" : "String"},
                    //data : "tag="+$("#tagText").val(),
                    type : "post",
                    //contentType: "application/json; charset=utf-8",
                    success: function( data ) {
                        // delegate back to autocomplete, but extract the last term
                        response( $.ui.autocomplete.filter( eval(data), extractLast( request.term ) ) );
                    }
                });
            },
            minLength: 0,
            focus: function() {
                // prevent value inserted on focus
                return false;
            },
            select: function( event, ui ) {
                var terms = split( this.value );
                // remove the current input
                terms.pop();
                // add the selected item
                terms.push( ui.item.value );
                // add placeholder to get the comma-and-space at the end
                terms.push( "" );
                this.value = terms.join( ";" );
                return false;
            }
        });
});

function selectProcess() {
    var url = "../selectProcessDefinition_frame.jsp";

    var screenWidth = screen.width;
    var screenHeight = screen.Height;
    var windowWidth = 500;
    var windowHeight = 300;
    var window_left = (screenWidth - windowWidth) / 2;
    var window_top = (screenHeight - windowHeight) / 2;

    var option = "left=" + window_left + ", top=" + window_top + ", width="
            + windowWidth + ", height=" + windowHeight
            + " ,scrollbars=no,resizable=yes";

    var arrResult = window.open(url, "", option);
}

function setProcess(processDefinition, processDefName) {
    $("#processDefinition").val(processDefinition);
    $("#processDefName").val(processDefName + "(" + processDefinition + ")");
}

function actionMoveFolder(a) {
}

var roleInputName = "";
function searchRole(s) {
    roleInputName = s;
    var url = WEB_ROOT + "/common/rolePicker.jsp";
    window.open(url,'','top=190,left=500,width=400,height=400,resizable=true,scrollbars=no');
}

function setRoleInput(role) {
    $("#"+roleInputName).val(role[0]);
    $("#"+roleInputName + "_display").val(role[1]);
    
    if (role[1] == "") {
        $("#selectCompany").css("display", "inline");
        $("#selectPartCode").css("display", "inline");
    } else {
        $("#selectCompany").css("display", "none");
        $("#selectPartCode").css("display", "none");
    }
}

function partChagnge(part) {
    return;
    
    if (part == "") {
        $("#roleCode_display").css("display", "inline");
        $("#imgRole").css("display", "inline");
    } else {
        $("#roleCode_display").css("display", "none");
        $("#imgRole").css("display", "none");
    }
}

function saveFilter() {
    if ($("#filterName").val() == null || $("#filterName").val() == "") {
        alert("Input Filter Name");
    //} else if ($("#processDefName").val() == null || $("#processDefName").val() == "") {
    //    alert("Select ProcessDefinition");
    } else {
    	if ( ($("#processDefName").val() == null || $("#processDefName").val() == "")
    		    && ($("#selectPartCode").val() == null || $("#selectPartCode").val() == "")
    		    && ($("#status").val() == null || $("#status").val() == "")
    		    && ($("#tagText").val() == null || $("#tagText").val() == "")
    	    ) {
    		
    		alert("Please Enter one or more conditions.");
    	}
    	
        mainForm.submit();
    }
}

function split( val ) {
    return val.split( /;\s*/ );
}

function extractLast( term ) {
    return split( term ).pop();
}

function addTag(tag) {
	if ($("#tagText").val().indexOf(tag) > -1) {
        alert("이미 등록된 Tag 입니다.");
        return;
    }
	
	var addText = $("#tagText").val() + tag+";";
	
	$("#tagText").val(addText);
}
</script>
</head>
<body>
<script type="text/javascript">
var tmp = new Array("monitorFilter");
createTabs(tmp);
</script>
<form name="mainForm" action=saveMonitorFilter.jsp method="post">
    <br/>
    <div id="divTabItem_MonitorFilter" align="center">
        <table width="95%">
            <tr>
                <td colspan="5" bgcolor="#97aac6" height="2"></td>
            </tr>
            <tr>
                <td class="formtitle">Filter Name</td>
                <td class="formcon"><input name="filterName" id="filterName" type=text style="width:250px;" ></td>
            </tr>
            <tr bgcolor="#b9cae3"><td colspan="4" height="1"></td></tr>
            <tr>
                <td class="formtitle">Status</td>
                <td class="formcon">
                    <select name="status" id="status" style="width:120px;">
                        <option value="Running">Running</option>
                        <option value="Completed">Completed</option>
                        <option value="Stopped">Stopped</option>
                    </select>
                </td>
            </tr>
            <tr bgcolor="#b9cae3"><td colspan="4" height="1"></td></tr>
            <tr>
                <td class="formtitle">Definition</td>
                <td class="formcon">                
                    <input type="text" name="processDefName" id="processDefName" style="width:180px;"/>
                    <img align="middle" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/Toolbar-toblock.gif" onclick="selectProcess();" style="cursor:pointer;" />
                    <input type="hidden" name="processDefinition" id="processDefinition" />
                </td>
            </tr>
            <tr bgcolor="#b9cae3"><td colspan="4" height="1"></td></tr>
            <tr>
                <td class="formtitle">Resource Group</td>
                <td class="formcon">                
                    <select onchange="changCompany(this);" id="selectCompany">
                        <%=sComOption %>
                    </select>
                    <select name="selectPartCode" id="selectPartCode" onchange="partChagnge(this.value);"></select>
                    <!-- Role 
                    <input type="hidden" name="roleCode" id="roleCode" />
                    <input type="text" name="roleCode_display" id="roleCode_display" readonly="readonly" onclick="searchRole('roleCode');" />
                    <img id="imgRole" align="middle" onclick="searchRole('roleCode');" style="cursor:pointer;" src='<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/Toolbar-toblock.gif' alt="role search" title="Role search"/>
                     -->
                </td>
            </tr>
            <tr bgcolor="#b9cae3"><td colspan="4" height="1"></td></tr>
            <tr>
                <td class="formtitle">Tag</td>
                <td class="formcon">
                    <input type="text" name="tagText" id="tagText" style="width:250px;"/>
                </td>
            </tr>
            <tr>
                <td colspan="5" bgcolor="#97aac6" height="2"></td>
            </tr>
        </table>
        
        <br/>
    
        <table>
            <tr>
                <td class="gBtn">
                    <a href="javascript:saveFilter();" ><span>save</span></a>
                </td>
            </tr>
        </table>
        
        <br/>
        
        <!-- ###### tag list iframe ###### -->
        <iframe style="width: 100%; height: 270px; padding-bottom: 30px;padding-left:15px;" src="tagList.jsp" name="innerworkarea" frameborder="0"></iframe>
    </div>
</form>
</body>
</html>