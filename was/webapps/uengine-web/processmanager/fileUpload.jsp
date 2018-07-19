<%@include file="../common/header.jsp"%>
	
<html>
<head>
<title>File Upload</title> 
<script language="javascript">
        <!--
        var variable            = null;
        var FCK                 = window.opener.FCK;
        function ok() {
                
        FCK.Focus();
               //var B = FCK.EditorDocument.selection.createRange(); //only works in IE
                var ctrlName = document.forms[0].controlName.value;
                var ctrlClass = document.forms[0].fileClass.value;
                var isMultiple = (document.forms[0].multiple.checked ? 1 : 0);
                var isMemo = document.forms[0].memo.value;

                var html = "<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"200\"><tr><td width=\"*\">";
             	html += "<input:fileupload name=\""+ctrlName +"\" fileclass=\"" + ctrlClass + "\" viewmode=0 value=fileupload multiple=\"" + isMultiple + "\" memo=\"" + isMemo + "\"  /></input:fileupload>";
             	html += "</td><td width=\"10\">";
                html += "<div id=ctrlIconDiv ><img class=\"hiddenIcon\" src='<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/fileUpload.gif' /></div>";
  				html += "</td></tr></table>";
                FCK.InsertHtml(html);
                
                window.close();
        }
        //-->
</script>
</head>

<form>
<body leftmargin="0" topmargin="0" >
<table width="100%" height="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td bgcolor="E3E3C7" height="35"><font size="3" color="737357 "face="돋음">&nbsp;&nbsp;<strong>File Upload</strong></font></td>
	</tr>
	<tr>
		<td align="center" bgcolor="F1F1E3">
			<table cellpadding="0" cellspacing="0">
				<tr><td>
					<font size=2 face="굴림">ControlName</font>
					(
						<font size="2">Use Multiple </font>
						<input type="checkbox" name="multiple" id="multiple" />
						<font size="2">Memo </font>
						<select name="memo" id="memo">
							<option value="0">none</option>
							<option value="1">left</option>
							<option value="2">right</option>
							<option value="3">under</option>
						</select>
					)
					<br><input name="controlName" size="35" />
				</td></tr>
				<tr><td>
					<font size=2 face="굴림">Class</font> 
					<br><select name="fileClass">
						<option value="general">General</option>
						<option value="image">Image</option>
					</select>
				</td></tr>
			</table>
		</td>
	</tr>
	<tr>
		<td bgcolor="E3E3C7" height="35" align="right"><input type="button" size="20" onClick="ok();" value="      OK      "> <input type="button" size="5" onClick="javascript:window.close();" value="CANCEL"></td>
	</tr>
</table>

</body>
</form>