<script type="text/javascript">
function changeDisplay(objName,hiddenObjName){

    var objTemp= document.getElementById(objName);
	objTemp.style.display='';

    var hiddenObjNames = hiddenObjName.split(';');
    for(i=0 ; i < hiddenObjNames.length ; i++){
        var objTemp= document.getElementById(hiddenObjNames[i]);
		objTemp.style.display='NONE';
    }

}
</script>

<ul class="tabs">
	<li id="tab0">
		<a href="javascript:changeDisplay('flowchart','performance;roles;work_history;variables;possible_actions;improve')">
			<%=GlobalContext.getMessageForWeb("Flowchart", loggedUserLocale) %>
		</a>
	</li>
	<li id="tab1">
		<a href="javascript:changeDisplay('performance','flowchart;roles;work_history;variables;possible_actions;improve')">
			<%=GlobalContext.getMessageForWeb("Instance Performance", loggedUserLocale) %>
		</a>
	</li>
	<li id="tab2">
		<a href="javascript:changeDisplay('possible_actions','flowchart;performance;roles;work_history;variables;improve')">
			<%=GlobalContext.getMessageForWeb("Possible Actions", loggedUserLocale) %>
		</a>
	</li>
	<li id="tab3">
		<a href="javascript:changeDisplay('roles','flowchart;performance;possible_actions;work_history;variables;improve')">
			<%=GlobalContext.getMessageForWeb("Roles", loggedUserLocale) %>
		</a>
	</li>
	<li id="tab4">
		<a href="javascript:changeDisplay('work_history','flowchart;performance;possible_actions;roles;variables;improve')">
			<%=GlobalContext.getMessageForWeb("Work History", loggedUserLocale) %>
		</a>
	</li>
	<li id="tab5">
		<a href="javascript:changeDisplay('variables','flowchart;performance;possible_actions;roles;work_history;improve')">
			<%=GlobalContext.getMessageForWeb("Variables", loggedUserLocale) %>
		</a>
	</li>
	<li id="tab6">
		<a href="javascript:changeDisplay('improve','flowchart;performance;possible_actions;roles;work_history;variables')">
			<%=GlobalContext.getLocalizedMessageForWeb("definition_improve", loggedUserLocale, "Improve") %> 
		</a>
	</li>
</ul>