<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>

<link href="../style/uengine.css" type=text/css rel=stylesheet>

<script>
	insertingRole='';
 	function openMapper(role){
		window.open('urb','mapper','width=500,height=400,scrollbars=yes');
		insertingRole = role;
	}

	function setMapping(name, endpoint){
		eval('document.initiateform.' + insertingRole + '_name.value = name');
//		eval('document.initiateform.' + insertingRole + '_email.value = email');
		eval('document.initiateform.' + insertingRole + '_endpoint.value = endpoint');
	}
	
	selectedUser="";
	
	function setSelectedUser(address){
		selectedUser = address;
	}
	
</script>


<% String pdname = request.getParameter("processDefinition");%>
			
<h1>New Approval</h1>

<br>

<%
	InitialContext context = new InitialContext();
	ProcessManagerHomeRemote pmh = (ProcessManagerHomeRemote)context.lookup("ProcessManagerHomeRemote");
	UserManagerHomeRemote umh = (UserManagerHomeRemote)context.lookup("UserManagerHomeRemote");
	
	ProcessManagerRemote pm = pmh.create();
	UserManagerRemote um = umh.create();
	
	ProcessDefinitionRemote pd = pm.getProcessDefinitionRemote(pdname);

	String defaultInstanceId = request.getParameter("defaultInstanceId");
	if(defaultInstanceId==null){
		Calendar now = Calendar.getInstance();
		int y = now.get(Calendar.YEAR);
		int m = now.get(Calendar.MONTH) + 1;
		int d = now.get(Calendar.DATE);
		int h = now.get(Calendar.HOUR);
		int mi = now.get(Calendar.MINUTE);
		int s = now.get(Calendar.SECOND);
			
		defaultInstanceId = pd.getName().replace(' ', '_') + "-" + y + (m<10?"0"+m:""+m) + (d<10?"0"+d:""+d) + (h<10?"0"+h:""+h) + (mi<10?"0"+mi:""+mi) + (s<10?"0"+s:""+s);
	}
%>

<form action='initiate.jsp' name=initiateform>
Please name this instance: 
<input size=90 name="instanceId" value="<%=defaultInstanceId%>"><br> *leave if you want to auto-generate<p>
Please fill out following approval line:

<table>
<tr>
<td>


<table b order=1>
		
		        
<tr><th bgcolor=#bbbbbb>Role</th><th bgcolor=#bbbbbb>name</th><th bgcolor=#bbbbbb>email or endpoint</th><td></td></tr>
			     	

		
<input type=hidden name='Worklist_Service_endpoint' value='http://localhost:8082/axis/services/WorklistServer' size=30>
<input type=hidden name='mailServer_endpoint' value='http://localhost:8082/axis/services/EMailServer' size=30>
<input type=hidden name='messengerServer_endpoint' value='http://localhost:8082/axis/services/MSNMessengerService' size=30>
		
        	<tr><td b gcolor=#bbbbbb> <b> Proposer : </b></td>
        	<td> <input name='_proposer_name' size=10 value='<%=loggedUserFullName%>'> </td>
        	<td> <input name='_proposer_endpoint' size=30 value='<%=loggedUserId%>'> </td>
        	<td> <input value="<-" type=button onclick="document.initiateform.approver5_endpoint.value=selectedUser">

        	<!--<input value="search" type=button onclick="openMapper('approver5')">--> </td>
        	</tr>
        	
        	<tr><td b gcolor=#bbbbbb> <b> approver1 : </b></td>
        	<td> <input name='approver1_name' size=10> </td>
        	<td> <input name='approver1_endpoint' size=30> </td>

        	<td> <input value="<-" type=button onclick="document.initiateform.approver1_endpoint.value=selectedUser">
        	<!--<input value="search" type=button onclick="openMapper('approver1')">--> </td>
        	</tr>

		
        	<tr><td b gcolor=#bbbbbb> <b> approver2 : </b></td>
        	<td> <input name='approver2_name' size=10> </td>

        	<td> <input name='approver2_endpoint' size=30> </td>
        	<td> <input value="<-" type=button onclick="document.initiateform.approver2_endpoint.value=selectedUser">
        	<!--<input value="search" type=button onclick="openMapper('approver2')">--> </td>
        	</tr>

		
        	<tr><td b gcolor=#bbbbbb> <b> approver3 : </b></td>

        	<td> <input name='approver3_name' size=10> </td>
        	<td> <input name='approver3_endpoint' size=30> </td>
        	<td> <input value="<-" type=button onclick="document.initiateform.approver3_endpoint.value=selectedUser">
        	<!--<input value="search" type=button onclick="openMapper('approver3')">--> </td>
        	</tr>

		
        	<tr><td b gcolor=#bbbbbb> <b> approver4 : </b></td>
        	<td> <input name='approver4_name' size=10> </td>
        	<td> <input name='approver4_endpoint' size=30> </td>
        	<td> <input value="<-" type=button onclick="document.initiateform.approver4_endpoint.value=selectedUser">
        	<!--<input value="search" type=button onclick="openMapper('approver4')">--> </td>

        	</tr>

		
        	<tr><td b gcolor=#bbbbbb> <b> approver5 : </b></td>
        	<td> <input name='approver5_name' size=10> </td>
        	<td> <input name='approver5_endpoint' size=30> </td>
        	<td> <input value="<-" type=button onclick="document.initiateform.approver5_endpoint.value=selectedUser">

        	<!--<input value="search" type=button onclick="openMapper('approver5')">--> </td>
        	</tr>



</table> 


</td>
<td>

<select name=users size="10" onChange="setSelectedUser(this.value)">
	<option value=""><b>People</b><br>
<%
	User[] users = (User[])CompanyLocalManagerUtil.getUsers("liferay.com").toArray(new User[0]);
	
	for(int i=0; i<users.length; i++){
	%>
		<option value="<%= users[i].getEmailAddress() %>"> + <%= users[i].getFullName() %> (<%=um.getWorkload(users[i].getEmailAddress())%> %) <br>
	<%
	
	}
%>
	<option value=""><br>
	
</select>

</td>
</tr>
</table>

<p>
Please select template document file location:

<table>
<tr><th bgcolor=#bbbbbb>name</th><th bgcolor=#bbbbbb>value</th></tr>

		<tr><td>TemplateDocumentURL</td><td><input name="_TemplateDocumentURL_value"></td></tr>
		
</table>

<input type="hidden" name="processDefinition" value="Generic Approval">



<p><input type='submit' value='initiate'> 

</form>
<p>
<font color=red>(* This form is customized from the default initiate form)</font>

