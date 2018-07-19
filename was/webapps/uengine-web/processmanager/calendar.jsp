<%@ page pageEncoding="UTF-8" language="java" contentType="text/html; charset=UTF-8"%> 
<%@page import="org.uengine.kernel.GlobalContext"%>
<html>
<head>
<title>Calendar</title> 
<script language="javascript">
        <!--
        var variable            = null;
        var FCK                 = window.opener.FCK;
        function ok() {
                FCK.Focus();
                if (document.all){
                    var B = FCK.EditorDocument.selection.createRange(); //only works in IE
                }
                
                var ctrlName = document.forms[0].controlName.value;
                var obejctType = document.forms[0].ObjectType;
				for (i=0;i<obejctType.length ;i++ ) {
					if (obejctType[i].checked) {
						obejctType = obejctType[i].value;
						break;
					}
				}
				
                var html = "<table border=\"0\" cellspacing=\"2px\" cellpadding=\"0\" width=\"200\">"
            			+ "<tr><td width=\"*\">"
        				+ "<input:calendartag name="+ctrlName +" viewmode=\"0\" value=\"calendartag\" objecttype=\""+obejctType +"\"></input:calendartag>"
        				+ "</td><td width=\"10px\"><img class=\"hiddenIcon\" align=\"middle\" class=\"hiddenIcon\" "
        				+ " src=\"<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Icon/btn_calendar.gif\" /></td></tr></table>";
                
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
		<td bgcolor="#E3E3C7" height="35"><font size="3" color="#737357" face="돋음">&nbsp;&nbsp;<strong>Calendar</strong></font></td>
	</tr>
	<tr>
		<td align="center" bgcolor="#F1F1E3">
			<table cellpadding="0" cellspacing="0">
				<tr><td ><font size="2" face="굴림">ControlName <br><input name="controlName" size="35"></td></tr>
			</table>
		</td>
	</tr>
		<tr>
		<td align="center" bgcolor="#F1F1E3">
			<table cellpadding="0" cellspacing="0">
				<tr><td ><font size="2" face="굴림">ObjectType <br><input type=radio name="ObjectType" value="string" checked="checked">Text <input type=radio name="ObjectType" value="calendar">Calendar</td></tr>
			</table>
		</td>
	</tr>
	<tr>
		<td bgcolor="#E3E3C7" height="35" align="right">
			<input type="button" style="width: 60px;" onclick="javascript:ok();" value="Ok" />
			<input type="button" style="width: 60px;" onclick="javascript:window.close();" value="Cancel" />
		</td>
	</tr>
</table>
 
</form>
</body>
</html>