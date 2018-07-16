<%@include file="../common/header.jsp"%>

<LINK href="../style/uengine.css" type=text/css rel=stylesheet>

<table border=1>
		
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<%

	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	
	String instanceID = decode(request.getParameter("instanceID"));
	String tracingTag = decode(request.getParameter("tracingTag"));
			   
	Hashtable map = pm.getActivityDetails(instanceID, tracingTag);
	 
	for(Iterator iter = map.keySet().iterator(); iter.hasNext(); ){
		String key = (String)iter.next();
%>
<tr><td> <%=key%> </td><td> <%=map.get(key)%> </td></tr>
<%		
	}
%>

</table>