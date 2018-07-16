<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">
        <!--
        var variable            = null;
        var FCK                 = window.opener.FCK;
        function ok() {
                
                FCK.Focus();
                var B = FCK.EditorDocument.selection.createRange(); //only works in IE


                var ctrlName = document.getElementById("controlName").value;
                var rootGroup = document.getElementById("rootGroup").value;
                
                var html = "<table border=0 cellspacing=0 cellpadding=0><tr><td>";

				html += "<div id=\""+ctrlName+"Div\" ></div>";
                html += "<select id=\"autoCreateId"+ctrlName+"\" + ><option>선택하세요</option></select>";
                html += "<input:dubblecombo name=\"" + ctrlName + "\" id=\"" + ctrlName + "\" viewmode=0 "; 
                html += " root=\"" + rootGroup + "\" value=\"dubblecombo\" codename=\"\"></input:dubblecombo>";
				html += "";
                html += "</td></tr></table>";
                FCK.InsertHtml(html);
                
                window.close();
        }
        //-->
</script>
<title>Insert title here</title>
</head>
<body>
<table>
	<tr>
		<td> 더블콤보박스 추가</td>
	</tr>
	<tr>
		<td> Control Name <input type="text" id="controlName" /></td>
	</tr>
	<tr>
		<td> Root Group <input type="text" id="rootGroup" value="G102" /></td>
	</tr>
	<tr>
        <td height="50" align="center"> 
            <div style=" width:100; margin:0 auto; ">
                 <a href="javascript:ok()"><img src="/images/Common/b_btm_completion.gif" /></a>
                 <a href="javascript:window.close()"><img src="/images/Common/b_btm_cancel.gif" /></a>
            </div>
        </td>
    </tr>
</table>
</body>
</html>