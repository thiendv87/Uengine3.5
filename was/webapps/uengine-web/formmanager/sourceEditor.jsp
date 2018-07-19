<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/html; charset=UTF-8");%>
<%--
  - Author(s): Sungsoo Park ( ghbpark@hanwha.co.kr )
  - Copyright Notice:
	Copyright 2001-2005 by HANWHA S&C Corp.,
	All rights reserved.

	This software is the confidential and proprietary information
	of HANWHA S&C Corp. ("Confidential Information").  You
	shall not disclose such Confidential Information and shall use
	it only in accordance with the terms of the license agreement
	you entered into with HANWHA S&C Corp.
  - @(#)
  - Description:
--%>
<%
	String onLoadAction = "openContentEditor()";
	String actionType = request.getParameter("action");
	if ( actionType != null && actionType.equals("submit") ) onLoadAction = "editSubmitAction()";
%>
<html>
<head>
<title>иб? иб???</title>
<script type="text/javascript">
	function openContentEditor() {
		document.hiddenForm.sourceEditor.editContent();
	}
	function editSubmitAction() {
		alert("editSubmitAction!!");
		document.hiddenForm.sourceEditor.editSubmitAction();
	}	
	function changeDocument(contents) {
		parent.document.Wec.Value = contents;
	}	
	function saveSubmitActionContents(contents) {
		//alert("this");
		parent.document.editForm.submitActionContents.value = contents;
		//alert(parent.document.editForm.submitActionContents.value);
	}	
</script>
<body onload="<%=onLoadAction%>">
<form name="hiddenForm" method="post">
<OBJECT 
    ID="sourceEditor" 
    classid = "clsid:8AD9C840-044E-11D1-B3E9-00805F499D93"
    codebase = "http://java.sun.com/update/1.4.2/jinstall-1_4-windows-i586.cab#Version=1,4,0,0"
    WIDTH = "0" HEIGHT = "0" ALIGN = "baseline" >
    <PARAM NAME = CODE VALUE = "org.jext.Jext.class" >
    <PARAM NAME = CODEBASE VALUE = "lib" >
    <PARAM NAME = ARCHIVE VALUE = "dawn-1.1.1.jar,looks-1.2.2.jar,jext-5.0.jar,jython-2.1.jar,tinylaf_.jar" >
    <PARAM NAME = "type" VALUE = "application/x-java-applet;version=1.4">
    <PARAM NAME = "scriptable" VALUE = "false">
    <PARAM NAME = "model" VALUE="models/HyaluronicAcid.xyz">

    <COMMENT>
	<EMBED 
            type = "application/x-java-applet;version=1.4" \
            CODE = "org.jext.Jext.class" \
            JAVA_CODEBASE = "lib" \
            ARCHIVE = "dawn-1.1.1.jar,looks-1.2.2.jar,jext-5.0.jar,jython-2.1.jar,tinylaf_.jar" \
            WIDTH = "0" \
            HEIGHT = "0" \
            ALIGN = "baseline" \
            model ="models/HyaluronicAcid.xyz" \
	    scriptable = false \
	    pluginspage = "http://java.sun.com/products/plugin/index.html#download">
	    <NOEMBED>
            
            </NOEMBED>
	</EMBED>
    </COMMENT>
</OBJECT>	
</form>
</body>
</html>