<%@page contentType="text/html; charset=UTF-8" import="javax.naming.InitialContext,javax.rmi.PortableRemoteObject,javax.naming.Context,javax.naming.NamingException,org.uengine.processmanager.*,org.uengine.kernel.*"%>

<LINK href="../style/uengine.css" type=text/css rel=stylesheet>

		
<b>Process Archives</b>
 [ 
<a href="javascript:document.location.reload()"><img src="../images/refresh.gif" ALT="Refresh" border=0></a>
 ]

<br>

		
<%
	InitialContext context = new InitialContext();
	ProcessManagerHomeRemote pmh = (ProcessManagerHomeRemote)context.lookup("ProcessManagerHomeRemote");
	
	ProcessManagerRemote pm = pmh.create();
	
		ProcessInstanceRemote[] pirs = pm.listProcessArchiveRemotes();
	
		if(pirs!=null && pirs.length > 0){
			for(int i=0; i < pirs.length; i++){
				String pid = pirs[i].getId();
				//String status = pirs[i].getStatus();
	
		%>
	        		<li> 
	        		<a href="javascript:view('<%=pid%>')"> <%=pirs[i].getName()%> </a>
	        		[<a href="javascript:remove('<%=pid%>')">remove</a>]
	        	
		<%	}
		}		        
%>

<script>
	function view(instanceId){
		document.actionForm.action = "viewProcessInformation.jsp";
		document.actionForm.instanceId.value = instanceId;		
		document.actionForm.submit();
	}
	function remove(instanceId){
		document.actionForm.action = "removeProcessArchive.jsp";
		document.actionForm.instanceId.value = instanceId;		
		document.actionForm.submit();
	}
</script>

<form method=POST name=actionForm target=innerworkarea>
	<input type=hidden name="instanceId">
</form>

