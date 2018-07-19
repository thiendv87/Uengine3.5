<%@ page import="org.uengine.util.*"%>
<%@ page import="org.uengine.processpublisher.graph.GraphActivity"%>

<%
	ProcessDefinition tempProcessDefinition = piRemote.getProcessDefinition();
	String tempInstanceId = piRemote.getInstanceId();
	
    final HumanActivity currentTempActivity = initiationActivity;
	final org.uengine.kernel.Role currentRoleMapping = currentTempActivity.getRole();
	final ProcessInstance pi = piRemote;
	final Vector backableActivity = new Vector();
	final Vector completedActivity = new Vector();	
	
	ActivityForLoop findBackableActivities = new ActivityForLoop(){
		public void logic(Activity activity) {
			if(activity != null){
	    		try{
		       		if(activity instanceof HumanActivity && 
		       		   activity.STATUS_COMPLETED.equals(activity.getStatus(pi))&&
		       		   ((HumanActivity)activity).getRole().getMapping(pi).getEndpoint().equals(currentRoleMapping.getMapping(pi).getEndpoint())){
		       		   
		        		backableActivity.add(activity);
		       		}
		       		
		       		if(activity instanceof HumanActivity && 
		       		   activity.STATUS_COMPLETED.equals(activity.getStatus(pi))){
		       		   
		        		completedActivity.add(activity);
		       		}
		       		
	       		}catch(Exception e){}
			}
	      }
	     
	  };	    
	  findBackableActivities.run(tempProcessDefinition);
%>