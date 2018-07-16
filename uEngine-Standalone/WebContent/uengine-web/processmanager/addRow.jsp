<%@page language="java" contentType="text/html; charset=UTF-8" import="java.util.*,org.uengine.kernel.*,org.uengine.kernel.descriptor.*,org.uengine.processmanager.*,org.uengine.util.dao.* "%>

<%
String locale = GlobalContext.getPropertyString("default.locale", "en");

String strAddRowText = GlobalContext.getLocalizedMessageForWeb("buttonText_rowAdd", locale, "Add");
String strRemoveRowText = GlobalContext.getLocalizedMessageForWeb("buttonText_rowRemove", locale, "Del");
%>

<html><head><title>Add Row Button</title> 
<script language="javascript">
        <!--
        var variable            = null;
        var FCK                 = window.opener.FCK;
        
        FCK.Focus();
        
        var B = FCK.EditorDocument.selection.createRange(); //only works in IE
        var ctrlName = document.forms[0].controlName.value;
        
        String strAddRowText = GlobalContext.getLocalizedMessageForWeb("buttonText_rowAdd", locale, "Add");
    	String strRemoveRowText = GlobalContext.getLocalizedMessageForWeb("buttonText_rowRemove", locale, "Del");
 		
        var strHTML = "<input type='button' name='nameBtnAddRow' onclick='addRow(this)' value='<%=strAddRowText%>' />"
				+ "<input type='button' onclick='removeRow(this)' value='<%=strRemoveRowText%>' />";
     
        FCK.InsertHtml(strHTML);
        
        window.close();
       
        //-->
</script>
</head>
<body></body>
</html>