<%@page import="org.uengine.persistence.dao.*"%>
<%
	String target = request.getParameter("target");
%>
    
<style type="text/css">
	BODY {
		background:url(images/empty.gif) #ffffff ;
		overflow: hidden;
		margin: 0;
		padding: 0;
	}
</style>

<div class="tundra">

<div dojoType="dojo.data.ItemFileReadStore" jsId="continentStore" url="processFolderListForParticipantJson.jsp"></div>
<div dojoType="dijit.tree.ForestStoreModel" jsId="continentModel" store="continentStore" rootId="continentRoot" rootLabel="Definitions" childrenAttrs="children">
</div>

<!-- ############################################ -->
<div dojoType="dijit.layout.LayoutContainer" style="height: 100%;">
	<div dojoType="dijit.layout.AccordionContainer" layoutAlign="client">
			<!-- First accordion : Process -->
		<div dojoType="" title="">
			<div dojoType="dijit.Tree" id="tree2" model="continentModel" showRoot="true" onClick="true">
				<script type="dojo/method" event="getIconClass" args="item, opened">
					if (item == this.model.root) {
		   				ObjType="definition";
		  			} else if (item.obj == "folder"){
		   				ObjType="folder";
		  		 	} else {
		  		 		ObjType = item.obj;
		   			}
		   
		   			if (ObjType == "folder") {
                        ObjType = opened ? "folderOpenIcon" : "folderClosedIcon";
		   			} else {
		   				ObjType += "Icon";
		   			}
           			return ObjType;
				</script>
				<script type="dojo/method" event="onClick" args="item">
					if (item.obj == "folder") {
						document.viewProcessInformation.folderId.value = item.id;
						document.viewProcessInformation.folderName.value = item.name;
						document.viewProcessInformation.submit();
					}
					if(item == this.model.root){
						document.viewProcessInformation.folderId.value = "-1";
						document.viewProcessInformation.folderName.value = "Definition";
						document.viewProcessInformation.submit();
					}
				</script>
			</div>
		</div>
	</div>
</div>

<form name="viewProcessDefinition" action="viewProcessFlowChart.jsp" method="post" target="innerworkarea">
	<input type="hidden" name="processDefinition">
	<input type="hidden" name="folder">
</form>

<form name="viewProcessInformation" action="viewProcessInfo.jsp" method="post" target="innerworkarea">
	<input type="hidden" name="folderId">
	<input type="hidden" name="folderName">
</form>

</div>