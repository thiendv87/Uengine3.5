<%@page pageEncoding="UTF-8" language="java" contentType="text/html; charset=UTF-8"%> 
<%@page import="org.uengine.kernel.GlobalContext"%>
<html>
<head>
<title>User Picker</title> 
<script language="javascript">
        <!--
        var variable            = null;
        var FCK                 = window.opener.FCK;
        function ok() {
            
                FCK.Focus();
                if (document.all)
                {
                    var B = FCK.EditorDocument.selection.createRange(); //only works in IE
                }

                var ctrlName 		= document.getElementById("controlName").value;
                var isMultiple = document.getElementById("multiple").checked ? true : false;
                var viewMode 	=	document.getElementById("viewMode").checked ? "1" : "0";

                var html = "<table border='0' cellspacing='2' cellpadding='0' width='200'>"
                    	+ "<tr><td width=\"*\">"
                		+ "<input:finduser multiple='" + isMultiple + "' name=\""+ctrlName+"\" viewmode=\"" + viewMode + "\" value=\"finduser\" /></input:finduser>"
                		+ "</td><td width=\"10px\"><img class=\"hiddenIcon\" align=\"middle\" src=\""
                		+ "<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/Toolbar-toblock.gif\" /></td></tr></table>";

                FCK.InsertHtml(html);
                window.close();
        }
        //-->
</script>
</head>

<form>
<body leftmargin="0" topmargin="0">
<table width="100%" height="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td bgcolor="E3E3C7" height="35">
			<font size="3" color="737357" face="돋음">
				&nbsp;&nbsp;<b>User Picker</b>
				( is view mode ?<input type="checkbox" name="viewMode" id="viewMode"> )
			</font>
		</td>
	</tr>
	<tr>
		<td bgcolor="F1F1E3" align="center">
			<table cellpadding="0" cellspacing="0">
				<tr><td>
						<font size="2">ControlName </font>
						(
						<font size="2">Use Multiple </font>
						<input type="checkbox" name="multiple" id="multiple" />
						)
						<br />
						<input type="text" name="controlName" id="controlName" size="35" />
				</td></tr>
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
<iframe marginheight="0" marginwidth="0" scrolling="auto" frameborder="0"></iframe>
</body>
</form>

</html>
