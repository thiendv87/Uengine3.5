package org.uengine.kernel;

import java.io.Serializable;
import java.util.*;

import org.uengine.kernel.GlobalContext;


/**
 * @author Jinyoung Jang
 */

public class LoopActivity extends ComplexActivity{
	private static final long serialVersionUID = org.uengine.kernel.GlobalContext.SERIALIZATION_UID;
	private static final String PROP_LOOPCOUNT = "_loopCnt";

	Condition loopingCondition;
		public Condition getLoopingCondition() {
			return loopingCondition;
		}
		public void setLoopingCondition(Condition value) {
			loopingCondition = value;
		}
		
	boolean worklistHistoryManagement;		
		public boolean isWorklistHistoryManagement() {
			return worklistHistoryManagement;
		}
		public void setWorklistHistoryManagement(boolean worklistHistoryManagement) {
			this.worklistHistoryManagement = worklistHistoryManagement;
		}
		
	public void setLoopingCount(ProcessInstance instance, int val) throws Exception{
		instance.setProperty(getTracingTag(), PROP_LOOPCOUNT, new Integer(val));
	}
	public int getLoopingCount(ProcessInstance instance) throws Exception{
		 Serializable value = instance.getProperty(getTracingTag(), PROP_LOOPCOUNT);
		 
		 if(value == null) return 0;
		 if(!(value instanceof Integer)) throw new UEngineException("Internal Error:Property value should be Integer");
		 return ((Integer)value).intValue();
	}
		
	public LoopActivity(){
		super();
		setName("loop");
		setWorklistHistoryManagement(true);
	}	
		
	protected void executeActivity(ProcessInstance instance) throws Exception{
		boolean returned = false;
		
		int currStep = getCurrentStep(instance);
		if( currStep >= getChildActivities().size()){
			if(loopingCondition==null)
				throw new UEngineException("Condition is not specified.");
				
			if(loopingCondition.isMet(instance, "")){
				
				//Lets each child activity reset instance
				Vector childActivities = getChildActivities();	 			
				for(Enumeration enumeration = childActivities.elements(); enumeration.hasMoreElements(); ){
					Activity child = (Activity)enumeration.nextElement();

					if(child instanceof HumanActivity){
						if(isWorklistHistoryManagement()){
							child.reset(instance);
						}else{
							if(isSuspendable(child.getStatus(instance))){
								child.reset(instance);
							}
						}
						
						child.setStatus(instance, STATUS_READY);
					}else{
						child.reset(instance);
					}
					
				}
				
//				instance.setStatus(getTracingTag(), STATUS_READY);
				
				currStep = 0;
				setCurrentStep(instance, currStep);
				
				setLoopingCount(instance, getLoopingCount(instance) + 1);
				
				returned = true;
				
			}else{	
				fireComplete(instance);
				
				return;
			}
		}
//System.out.println("execute in loop: " +currStep);
		
		Activity childActivity = (Activity)getChildActivities().elementAt(currStep);
		queueActivity(childActivity, instance);
		
		if(returned){
			fireEventToActivityFilters(instance, "loop-returned", this);
		}
	}
	
	public static void main(String[] args) throws Exception{
		ProcessDefinition processDefinition = new ProcessDefinition();
		
		processDefinition.setProcessVariables(new ProcessVariable[]{
			new ProcessVariable(new Object[]{
				"name", "var1",
				"type", String.class
			})
		});
				
		LoopActivity loopActivity = new LoopActivity();
		
		Condition condition = new Evaluate("var1", "val");
		
		AssignActivity assignActivity = new AssignActivity(){
			public void executeActivity(ProcessInstance instance) throws Exception{
			    	String strin = getNewStringFromConsole();
			    	
			    	setVal(strin);
			    				    	
				super.executeActivity(instance);
			}
		};
			    	String strin = getNewStringFromConsole();
			
		assignActivity.setVariable(processDefinition.getProcessVariable("var1"));
		assignActivity.setVal("val");
		
		loopActivity.setLoopingCondition(condition);
		loopActivity.addChildActivity(assignActivity);
					
		processDefinition.addChildActivity(loopActivity);
		
		ProcessInstance.USE_CLASS = DefaultProcessInstance.class;
		ProcessInstance instance = processDefinition.createInstance();
		instance.execute();
	}
	
	private static String getNewStringFromConsole(){
		try{
			java.io.DataInputStream bis = new java.io.DataInputStream(new java.io.BufferedInputStream(System.in));
			String temp = bis.readLine();
			return temp;
			
		}catch(Exception e){
			return null;
		}		
	}

	public ValidationContext validate(Map options) {
		ValidationContext vc = super.validate(options);
		
		try{
			Condition condition = getLoopingCondition();
			
			if(condition==null)
				vc.add("Condition should be specified.");
			
			HashMap map = new HashMap(1);
			map.put("activity", this);				
			vc.addAll(condition.validate(map));			
		}catch(Exception e){}
		 		
		return vc;
	}

}

