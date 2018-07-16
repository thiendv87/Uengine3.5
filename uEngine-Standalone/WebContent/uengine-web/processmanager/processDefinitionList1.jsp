<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>


<html>
<head>
    <title>Process Definitions</title>

    <style type="text/css">
		@import "../dojo/dojo/resources/dojo.css";
		@import "../dojo/dijit/tests/css/dijitTests.css";
	</style>

	<script type="text/javascript" src="../dojo/dojo/dojo.js"
		djConfig="parseOnLoad: true, isDebug: false"></script>
	<script type="text/javascript" src="../dojo/dijit/tests/_testCommon.js"></script>

	<script language="JavaScript" type="text/javascript">
		dojo.require("dojo.data.ItemFileReadStore");
		dojo.require("dijit.Tree");
		dojo.require("dijit.ColorPalette");
		dojo.require("dijit.Menu");
		dojo.require("dojo.parser");	// scan page for widgets and instantiate them
		var global_tn = '';
	</script>
	
	<script>
		function viewObjectType(objType ,id, folder){
			if(objType=="process"){
				document.viewProcessDefinition.processDefinition.value=id;
				document.viewProcessDefinition.folder.value=folder;		
				document.viewProcessDefinition.submit();
			}else if(objType=="rule"){
				document.viewRuleDefinition.objectDefinitionId.value=id;
				document.viewRuleDefinition.folder.value=folder;		
				document.viewRuleDefinition.submit();
			}else if(objType=="class"){
				document.viewClassDefinition.objectDefinitionId.value=id;
				document.viewClassDefinition.folder.value=folder;		
				document.viewClassDefinition.submit();
			}else if(objType=="form"){
				document.viewFormDefinition.objectDefinitionId.value=id;
				document.viewFormDefinition.folder.value=folder;		
				document.viewFormDefinition.submit();
			}else if(objType=="excel"){
				document.viewCalcDefinition.objectDefinitionId.value=id;
				document.viewCalcDefinition.folder.value=folder;		
				document.viewCalcDefinition.submit();
			}
		}
	</script>		

	
	<style TYPE="TEXT/CSS">
		BODY {	background:url(images/empty.gif) #ffffff }
		BODY {  
			margin: 2;
			padding: 2;
		}

	</style>
	
</head>
<body>


	<div dojoType="dojo.data.ItemFileReadStore" jsId="continentStore"
		url="../organizationmanager/organizationUserListJson.jsp"></div>
	<div dojoType="dijit.tree.ForestStoreModel" jsId="continentModel" 
		store="continentStore" query="{type:'main'}"
		rootId="continentRoot" rootLabel="Definitions" childrenAttrs="children"></div>


    
	<div dojoType="dijit.Tree" id="tree2"
		model="continentModel" showRoot="true" openOnClick="true">
		

		<script type="dojo/method" event="getIconClass" args="item, opened">
		   var ObjType="";
		   
		   if(item == this.model.root){
		   		ObjType="folder";
		   }else if(continentStore.getValue(item, "type")=="main"){
		   		ObjType="folder";
		   }else{
			    ObjType = continentStore.getValue(item, "type");
		   }
		   
		   if(ObjType =="folder"){
		   		ObjType = opened ? "customFolderOpenedIcon" : "customFolderClosedIcon";
		   }else{
		   	    ObjType += "Icon";
		   }

           return ObjType;

		</script>
		
		<script type="dojo/method" event="onClick" args="item">
			if(continentStore.getValue(item, "type")=="user"){
				var id = continentStore.getValue(item, "id");	
				var name = continentStore.getValue(item, "name");	
				var jikname= continentStore.getValue(item, "jikname");	

				adduser(id,name,jikname);
			}

		</script>
		
</div>		 
<br>
<b>SELETED USER LIST</b><br>
<hr>
<table width=100%>
	<tr>
		<td align=left>
			<select multiple name=selectUserList size=5>
				<option >---------- user List ---------</option>
			</select>
		</td>
	</tr>
</table>


</body>
</html>

<script type="text/javascript">
 
 function SelectedInfo() {
		var type = '';
		var id = '';
		var name = '';
		var title = '';
		var birthday;
		var isMale = true;
	}


function getSelectedUsers() {
	var selectList = document.all.selectUserList;
	var j=0;
	selectedOrganizationList = new Array();
	for(i=0; i<selectList.length; i++){
		
		if(selectList.options[i].selected==true){
		
			var user = new SelectedInfo();
			var userInfo = selectList.options[i].value;
			var userName = selectList.options[i].text;

			var userInfoArray = userInfo.split(';');		
			var userId = userInfoArray[0].split('=');
			var title = userInfoArray[4].split('=');
						
			user.type 		= "";
			user.name 		= userName.replace('_',' ');
			user.id 		= userId[1];
			user.title 		= title[1];
			user.isMale		= "1";
			user.birthday	= "";
			selectedOrganizationList [j++] = user;
		}
	}
	
	return selectedOrganizationList;
}

function adduser(id,name,jikname){
	
	var newOption = document.createElement("option");
	var realTargetTag = document.getElementById("selectUserList");

	newOption.value = "id="+id+";"+"name="+name+";"+"isMale=T;"+"birthday=0;"+"title="+jikname+";";
	newOption.text = name;
			
	realTargetTag.add(newOption);	
}

var selectedOrganizationList = new Array();
var inpuName = "";

</script>