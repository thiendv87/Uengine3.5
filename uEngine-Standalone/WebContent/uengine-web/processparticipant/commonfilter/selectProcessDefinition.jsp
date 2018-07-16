<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	String moveToDef = request.getParameter("moveToDef");
%>
<%@include file="../../common/header.jsp"%>
<%@include file="../../common/styleHeader.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Form Template</title>
	<script type="text/javascript" src="../../dojo/dojo/dojo.js" djConfig="parseOnLoad: true, isDebug: false"></script>
	<script type="text/javascript" src="../../dojo/dijit/tests/_testCommon.js"></script>
	<script type="text/javascript">
		dojo.require("dojo.data.ItemFileReadStore");
		dojo.require("dijit.Tree");
		dojo.require("dijit.ColorPalette");
		dojo.require("dijit.Menu");
		dojo.require("dojo.parser");	// scan page for widgets and instantiate them
		var global_tn = '';
	</script>
	<style type="text/css">
		@import "../../dojo/dojo/resources/dojo.css";
		@import "../../dojo/dijit/tests/css/dijitTests.css";
		body{padding:0; }
	</style>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/tabs.js"></script>
</head>

<body scroll=no>
<script type="text/javascript">
	var tmp = ["Process Definitions"];
	createTabs(tmp);
</script>

<div style="padding:15px; overflow:hidden;">
<div id="formDefinitionTree"  style="border:1px solid #CCC; width:470px; height:235px; overflow:auto;">
	<div dojoType="dojo.data.ItemFileReadStore" jsId="continentStore" url="<%=GlobalContext.WEB_CONTEXT_ROOT %>/processparticipant/processDefinitionListForParticipantJson.jsp?moveToDef=<%=moveToDef%>"></div>
	<div dojoType="dijit.tree.ForestStoreModel" jsId="continentModel" store="continentStore" rootId="continentRoot" rootLabel="Definitions" childrenAttrs="children"></div>
	
	<div dojoType="dijit.Tree" id="tree2" model="continentModel" showRoot="false" openOnClick="true">
		<script type="dojo/method" event="getIconClass"	args="item, opened">
			if(item == this.model.root) {
				ObjType = "folder";
			} else if(item.obj == "folder") {
				ObjType = "folder";
			} else{
				ObjType = item.obj;
			}

			if (ObjType == "folder") {
				ObjType = opened ? "customFolderOpenedIcon" : "customFolderClosedIcon";
			} else {
				ObjType += "Icon";
			}
			return ObjType;
		</script> 
		<script type="dojo/method" event="onClick" args="item">
			if (item.obj != "folder") {
				var isMoveToDef = <%="Y".equals(moveToDef) ? "true" : "false"%>;
				var folderId = null;
				
				if (isMoveToDef) {
					var itemId = item.id + "";
					window.top.opener.actionMoveFolder(itemId.substring(1));
				} else {
					window.top.opener.setProcess(item.id, item.name);
				}
				
				window.top.close();
			}
		</script>
	</div>
</div>
</div>


</body>
</html>