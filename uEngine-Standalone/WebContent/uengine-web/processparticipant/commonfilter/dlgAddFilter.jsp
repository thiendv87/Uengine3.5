<%@include file="../../common/header.jsp"%>
<%@include file="../../common/styleHeader.jsp"%>

<%
	String type = request.getParameter("type");
%>
<html>
<head>
	<title><%=type%> filter</title>
	<LINK rel="stylesheet" href="../../style/portlet.css" type="text/css"/>	
	<LINK rel="stylesheet" href="../../style/portal.css" type="text/css"/>	
	<LINK rel="stylesheet" href="../../style/groupware.css" type="text/css"/>
	<LINK href="../../style/uengine.css" type=text/css rel=stylesheet>
    <script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/tabs.js"></script>
    <script type="text/javascript">
		/*function selectProcess(){
			var url = "selectProcessDefinition_frame.jsp";
			var StrOption ;
			StrOption  = "dialogWidth:500px;dialogHeight:300px;";
			StrOption += "center:on;scroll:no;status:off;resizable:no";
			var arrResult = new Array(2);
			arrResult = showModalDialog (url , window, StrOption);
			//arrResult = window.open (url , "", StrOption);
			if( arrResult != null && arrResult[0] != null ){
				var f = document.mainForm;
				f.processDefinition.value=arrResult[0];
				//f.folder.value=arrResult[1];
				document.all.processDefName.innerText = arrResult[1] + "(" + arrResult[0] + ")";
			}
		}*/
		
		function selectProcess() {
			var url = "selectProcessDefinition_frame.jsp";

			var screenWidth = screen.width;
			var screenHeight = screen.Height;
			var windowWidth = 500;
			var windowHeight = 300;
			var window_left = (screenWidth - windowWidth) / 2;
			var window_top = (screenHeight - windowHeight) / 2;

			var option = "left=" + window_left + ", top=" + window_top + ", width="
					+ windowWidth + ", height=" + windowHeight
					+ " ,scrollbars=yes,resizable=yes";

			var arrResult = window.open(url, "", option);
		}
		
		function setProcess(processDefinition, processDefName) {
			document.getElementById("processDefinition").value = processDefinition;
			document.getElementById("processDefName").value = processDefName + "(" + processDefinition + ")";
		}
	
		function selectInformation() {
			var url = "selectInformationList_frame.jsp";
			var StrOption ;
			StrOption  = "dialogWidth:500px;dialogHeight:300px;";
			StrOption += "center:on;scroll:auto;status:off;resizable:no";
	
			var Result;
			Result = showModalDialog (url , window, StrOption);
			if( Result != null){
				document.all.informationListName.innerText = Result;
			}
		}
		
    	function saveFilter() {
    		var filterName = document.getElementsByName("filterName")[0];
    		var processDefName = document.getElementsByName("processDefName")[0];
    		if (filterName.value == null || filterName.value == "" || filterName.length ==0) {
        		alert("Input Filter Name");
    		} else if (processDefName.value == null || processDefName.value == "" || processDefName.value ==0) {
    			alert("Select ProcessDefinition");
    		} else {
    			mainForm.submit();
    		}
    	}
    </script>
</head>

<body>
	<script type="text/javascript">
	var tmp = new Array(
			"<%=type%>Filter"
	);
	createTabs(tmp);
	</script>

<form name="mainForm" action=saveFilter.jsp method=POST>
<input type=hidden name="type" value="<%=type %>">




<br>
<div id="divTabItem_<%=type%>Filter" align="center">
<table width="95%">
	<tr><td colspan="5" bgcolor="#97aac6" height="2"></td></tr>
	<tr>
		<td class="formtitle">Filter Name</td>
		<td class="formcon"><input name=filterName type=text style="width:180px;" ></td>
	</tr>
    <tr bgcolor="#b9cae3"><td colspan="4" height="1"></td></tr>
	<tr>
		<td class="formtitle">Status</td>
		<td class="formcon">
			<select name=status style="width:120px;">
<%
	if (type.equals("workitem")) {
%>
				<option value=Open>Open</option>
				<option value=Completed>Completed</option>
				<option value=Cancelled>Cancelled</option>
				<option value=Reserved>Reserved</option>
<%
	} else if (type.equals("instance")) {
%>
		<option value=Running>Running</option>
		<option value=Completed>Completed</option>
		<option value=Stopped>Stopped</option>
<%
	} 
%>
			</select>
		</td>
	</tr>
    <tr bgcolor="#b9cae3"><td colspan="4" height="1"></td></tr>
	<tr>
		<td class="formtitle">Definition</td>
		<td class="formcon">	            
			<input type="text" name="processDefName" id="processDefName" style="width:180px;">
	        <img align="middle" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/Toolbar-toblock.gif" onClick="selectProcess();" >
	        <input type="hidden" name="processDefinition" id="processDefinition" />
		</td>
	</tr>
    <tr bgcolor="#b9cae3"><td colspan="4" height="1"></td></tr>
	<tr>
		<td class="formtitle">Information</td>
		<td class="formcon">
			<input type=text name=informationListName id=informationListName style="width:180px;">
			<img align=absmiddle src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/Toolbar-toblock.gif" onClick="selectInformation();" >
		</td>
	</tr>
	<tr bgcolor="#b9cae3"><td colspan="4" height="1"></td></tr>
	<tr>
		<td class="formtitle">Endpoint Type</td>
		<td class="formcon">
			<input type="radio" name="endpointType" value="self" checked="checked" /> Self &nbsp;
			<input type="radio" name="endpointType" value="allEndpoint" /> All Endpoint
		</td>
	</tr>
    <tr><td colspan="5" bgcolor="#97aac6" height="2"></td></tr>
</table>

<br>
<table>
    <tr>
		<td class="gBtn">
            <a href="javascript:saveFilter();" ><span>save</span></a>
		</td>
    </tr>
</table>

</form>
</div>
</body>
</html>