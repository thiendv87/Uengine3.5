<%@ page language="java" contentType="text/html; charset=UTF-8"%> 



<html><head><title>Form Control</title> 
<script language="javascript">
        <!--
        var variable            = null;
        var FCK                 = window.opener.FCK;
        function ok() {
                
                FCK.Focus();
                var B = FCK.EditorDocument.selection.createRange(); //only works in IE

                var html = "<input:formctrl name="+document.forms[0].controlName.value +" value=formctrl>fc</input:formctrl>";
 
                FCK.InsertHtml(html);
                
                window.close();
        }
        //-->
</script>
</head>

<form>
<body leftmargin="0" topmargin="0" >
<table width=100% height=100% cellpadding=0 cellspacing=0>
	<tr>
		<td bgcolor=E3E3C7 height= 35><font size=3 color=737357 face="돋음">&nbsp;&nbsp;<b>Form Control</font></td>
	</tr>
	<tr>
		<td align=center bgcolor=F1F1E3>
			<table cellpadding=0 cellspacing=0>
				<tr><td ><font size=2 face="굴림">ControlName <br><input name="controlName" size=35></td></tr>
			</table>
		</td>
	</tr>
	<tr>
		<td bgcolor=E3E3C7 height= 35 align=right><input type=button size=20 onClick="ok();" value="      Ok      "> <input type=button size=5 onClick="javascript:window.close();" value="Cancel"></td>
	</tr>
</table>

</body>
</form>