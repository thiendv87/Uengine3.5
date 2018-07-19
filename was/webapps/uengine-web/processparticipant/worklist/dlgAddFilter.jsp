<%@include file="../../common/header.jsp"%>
<%@include file="../../common/styleHeader.jsp"%>

<%
	String  type = request.getParameter("type");
%>
<center><h1><%=type%> filter </h1></center>
<form name="mainForm" action=saveFilter.jsp method=POST>
<table>
	<tr>
		<td>Filter Name:</td>
		<td><input name=filterName type=text></td>
	</tr>
	<tr>
		<td>Status:</td>
		<td>
			<select name=status>
				<option value=Open>Open</option>
				<option value=Completed>Completed</option>
				<option value=Cancelled>Cancelled</option>
				<option value=Reserved>Reserved</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>Definition:</td>
		<td>	            
			<input type=text name=processDefName id=processDefName >
	        <img align=absmiddle src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/Toolbar-toblock.gif" onclick="selectProcess();" >
	        <input type=hidden name=processDefinition >
		</td>
	</tr>
	<tr>
		<td>Information:</td>
		<td><input name=information type=text></td>
	</tr>
</table>

<br>
<input type=submit value=ok>

<script>
		function selectProcess(){
			var url = "selectProcessDefinition_frame.jsp";
			var StrOption ;
			StrOption  = "dialogWidth:500px;dialogHeight:300px;";
			StrOption += "center:on;scroll:auto;status:off;resizable:no";
			var arrResult = new Array(2);
			arrResult = showModalDialog (url , window, StrOption);
			//arrResult = window.open (url , "", StrOption);
			if( arrResult != null && arrResult[0] != null ){
				var f = document.mainForm;
				f.processDefinition.value=arrResult[0];
				//f.folder.value=arrResult[1];
				document.all.processDefName.innerText = arrResult[1] + "(" + arrResult[0] + ")";
			}
		}
</script>
</form>