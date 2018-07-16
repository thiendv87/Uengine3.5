<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<%@include file="../../../../../../common/header.jsp"%>
<%@include file="../../../../../../common/styleHeader.jsp"%>
<%@include file="../../../../../../common/getLoggedUser.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Form Template</title>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/dojo/dojo/dojo.js" djConfig="parseOnLoad: true, isDebug: false"></script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/dojo/dijit/tests/_testCommon.js"></script>
	<script type="text/javascript">
		dojo.require("dojo.data.ItemFileReadStore");
		dojo.require("dijit.Tree");
		dojo.require("dijit.ColorPalette");
		dojo.require("dijit.Menu");
		dojo.require("dojo.parser");	// scan page for widgets and instantiate them
		var global_tn = '';
	</script>
	<style type="text/css">
		@import "<%=GlobalContext.WEB_CONTEXT_ROOT %>/dojo/dojo/resources/dojo.css";
		@import "<%=GlobalContext.WEB_CONTEXT_ROOT %>/dojo/dijit/tests/css/dijitTests.css";
		body{padding:0}
	</style>
	<script type="text/javascript">
		var WEB_CONTEXT_ROOT = "<%=GlobalContext.WEB_CONTEXT_ROOT%>";
	
		function createXMLHttpRequest() {
			if (window.ActiveXObject) {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			} else if (window.XMLHttpRequest) {
				xmlHttp = new XMLHttpRequest();
			}
			return xmlHttp;
		}
	
		function getFormVersionList(defId) {
			var url = WEB_CONTEXT_ROOT + "/formList?type=defId&defId=" + defId;
			var xmlHttp = createXMLHttpRequest();
			xmlHttp.open("GET", url, true); 
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					if (xmlHttp.status == 200) {
						var result = xmlHttp.responseText;
						var formVersionList = eval('(' + result + ')');
						
						if (formVersionList != null) {

							var defVerId = formVersionList.defVerId;
							
							var selectformVersion = document.getElementsByName("selectformVersion")[0];
							while(selectformVersion.options.length != 0) {
								selectformVersion.remove(0);
							}

							//selectformVersion.size = formVersionList.forms.length;

							if (formVersionList.forms.length > 0) {
								var defVerIndex = -1;
								
								for (i=0; i<formVersionList.forms.length; i++) {
									var newOption = document.createElement('option');
									newOption.text = formVersionList.forms[i].ver;
									newOption.value = formVersionList.forms[i].defVerId;
	
									if (defVerId == formVersionList.forms[i].defVerId) {
										defVerIndex = i;
									}
									
									try {
										selectformVersion.add(newOption, i);
									} catch(ex) {
										selectformVersion.options[i] = newOption;
									}
								}
	
								selectformVersion.options.selectedIndex = defVerIndex;

								changeFormVersion(defVerId);
							}
							
						} 
						
					}
				}
			};
			xmlHttp.send(null);
		}

		function changeFormVersion(defVerId) {
			if (defVerId == null) {
				var selectformVersion = document.getElementsByName("selectformVersion")[0];
				defVerId = selectformVersion.options[selectformVersion.selectedIndex].value;
			}

			if (defVerId != -1 ) {	
				var url = WEB_CONTEXT_ROOT + "/formList?type=defVerId&defVerId=" + defVerId;
				var xmlHttp = createXMLHttpRequest();
				xmlHttp.open("GET", url, true); 
				xmlHttp.onreadystatechange = function() {
					if (xmlHttp.readyState == 4) {
						if (xmlHttp.status == 200) {
							var result = xmlHttp.responseText;
							try {
								frames["iframePreviewForm"].document.getElementById("content").innerHTML = result;
							} catch(ex) {
								document.getElementById("iframePreviewForm").contentWindow.document.getElementById("content").innerHTML = result;
							}
							var formContent = document.getElementsByName("formContent")[0];
							formContent.value = result;
						}
					}
				};
				xmlHttp.send(null);
			}
		}
		
		var CKEDITOR = window.parent.CKEDITOR;
		
		var okListener = function(ev) {
		   this._.editor.insertHtml(document.getElementsByName("formContent")[0].value);
		   CKEDITOR.dialog.getCurrent().removeListener("ok", okListener);
		};

		CKEDITOR.dialog.getCurrent().on("ok", okListener);
		
	</script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/tabs.js"></script>
</head>

<body>
<script type="text/javascript">
	//var tmp = new Array(
	//		"Form Template"
	//);
	//createTabs(tmp);
</script>

<div style=" padding:15px;">
<div id="formDefinitionTree"  style="border:1px solid #CCC; width:200px; height:400px; overflow:auto; float:left;">
	<div dojoType="dojo.data.ItemFileReadStore" jsId="continentStore" url="definition.jsp"></div>
	<div dojoType="dijit.tree.ForestStoreModel" jsId="continentModel" store="continentStore" rootId="continentRoot" rootLabel="Definitions" childrenAttrs="children"></div>
	
	<div dojoType="dijit.Tree" id="tree2" model="continentModel" showRoot="true" openOnClick="true">
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
				getFormVersionList(item.id);
			}
		</script>
	</div>
</div>


<div  style="width:530px; height:400px; float:left;  margin-left:15px;">
    <div name="formVersionDefinitionList" style="float:left; line-height:25px; height:25px;">
		<span class="sectiontitle" style="padding-top:-3px;"><b>Version</b></span>
    </div>
    <div style="float:left; padding:3px 0 0 10px; line-height:25px; height:25px;">
        <select name="selectformVersion" onclick="changeFormVersion(null)">
            <option value="-1">-</option>
        </select>
    </div>
    <div id="previewForm" style=" clear:both; border:1px solid #CCC;">
        <iframe id="iframePreviewForm" src="preview.jsp" width="100%" height="368" frameborder="0" ></iframe>
    </div>
</div>

<input type="hidden" id="formContent" name="formContent" value="" />
</div>

</body>
</html>