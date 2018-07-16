<%
	ProcessManagerRemote pm = null;
	String instanceId = null;
	ProcessInstance piRemote = null;
	ProcessInstance initiationPiRemote = null;
	String processDefinition = null;
	String tracingTag = null;
	String initiationProcessDefinition = null;
	boolean initiate;
	boolean isViewMode;
	String dispatchingOption = null;
	boolean isRacing;	
	ProcessDefinitionRemote pdr = null;
	Properties scriptSet = new Properties();
	HumanActivity initiationActivity=null;
	String pdver=null;
	
	ProcessDefinition currentProcessDefinition = null;
	Activity currentActivity = null;
%>