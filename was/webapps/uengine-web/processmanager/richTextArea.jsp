<%@ page pageEncoding="UTF-8" language="java" contentType="text/html; charset=UTF-8"%> 
<HTML>
<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Rich TextArea</title> 
	<script language="javascript">
		String.prototype.trim = function() {
			return this.replace(/(^\s*)|(\s*$)|($\s*)/g, "");
		}
	
		var variable		= null;
		var FCK 			= window.opener.FCK;
		function ok() {
	
				FCK.Focus();
				var B = null;
				if (window.all) {
					B = FCK.EditorDocument.selection.createRange(); //only works in IE
				}
				var ctrlName		= 	document.formRichOptions.controlName.value.trim();
				var editorWidth 	= 	document.formRichOptions.editorWidth.value;
				var editorHeight 	= 	document.formRichOptions.editorHeight.value;
				var viewMode 	=	document.formRichOptions.viewMode.checked ? "1" : "0";
				
				if(!editorWidth) {
					editorWidth = "100%";
				}
				
				var html = "<div style='width:" + editorWidth + ";height:" + editorHeight + ";border:1px solid #d0d0d0;margin:0px;padding:0px;'>" 
							+ "<div class='hiddenIcon' align='center'>Rich Text Area</div>" 
	            			+ "<input:richtextarea id='" + ctrlName + "' name='" + ctrlName + "' viewmode='" + viewMode + "' "
	            			+ " width='100%' height='" + editorHeight + "' />"
							+ "</div>";
	
				FCK.InsertHtml(html);
				window.close();
		}
	</script>
	<style type="text/css">
		body {
			margin : 0;
		}
	</style>
</HEAD>
<BODY>
<form name="formRichOptions">
<table width="100%" height="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td bgcolor="E3E3C7" height="35">
			<font size="3" color="#737357">&nbsp;&nbsp;<STRONG>Rich TextArea</STRONG></font>
		</td>
		<td bgcolor="E3E3C7" height="35" align="right">
			<font size="3" color="#737357">
			( isViewMode ?<input type="checkbox" name="viewMode" id="viewMode"> )</font>
		</td>
	</tr>
	<tr>
		<td align="center" bgcolor="#F1F1E3" colspan="2">
			<table cellpadding="0" cellspacing="0">
				<tr><td>
					<font size="2" color="#737357" >ControlName <br>
					<input name="controlName" size="35" value=""></font>
				</td></tr><tr><td>
					&nbsp;
				</td></tr><tr><td>
					<font size="2">Editor width</font> <br>
					<input type="text" name="editorWidth" size="35" value="100%" />
				</td></tr><tr><td>
					<font size="2">Editor Height</font> <br>
					<input type="text" name="editorHeight" size="35" value="150px" />
				</td></tr>
			</table>
		</td>
	</tr>
	<tr>
		<td bgcolor="#E3E3C7" height="35" align="right" colspan="2">
			<input type="button" style="width:100px;" onClick="ok();" value="예">
			<input type="button" style="width:100px;" onClick="javascript:window.close();" value="아니오">
		</td>
	</tr>
</table>
</form>
</BODY>
</HTML>