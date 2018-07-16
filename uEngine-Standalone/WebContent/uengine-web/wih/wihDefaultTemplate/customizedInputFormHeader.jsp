<%!
	HashMap parameterContextMap = null;

//	ProcessManagerRemote pm;
//	String instanceId;
//	String processDefinition;
//	String tracingTag;
	
	Properties scriptSet = new Properties();
	
	public String inputter(String varName) throws Exception{
		if(parameterContextMap == null){
			parameterContextMap = new HashMap();
			ParameterContext[] parameterContexts = (ParameterContext[])pm.getActivityProperty(initiationProcessDefinition, tracingTag, "parameters");
			if(parameterContexts !=null)
			for(int j=0; j<parameterContexts.length; j++){
				ParameterContext parameterContext = parameterContexts[j];
				parameterContextMap.put(parameterContext.getVariable().getName(), parameterContext);	
			}
		}
		
		ParameterContext parameterContext = (ParameterContext)parameterContextMap.get(varName);
		StringBuffer inputterHtml = new StringBuffer();
		
		Object existingValue = (org.uengine.util.UEngineUtil.isNotEmpty(instanceId) ? parameterContext.getVariable().get(piRemote, "") : null);	
		
		WebInputter defaultInputter = (WebInputter)parameterContext.getVariable().getInputter();
		if(defaultInputter==null){
			try{
				defaultInputter = (WebInputter)ObjectType.getDefaultInputter(parameterContext.getVariable().getType());
			}catch(Exception e){
			}
		}
		if(defaultInputter==null){
			ObjectType outputClsTable = new ObjectType(parameterContext.getVariable().getType());
			FieldDescriptor[] arrayFieldDescriptors = outputClsTable.getFieldDescriptors();
				
			String[] columns = new String[arrayFieldDescriptors.length];	
			for(int i=0; i<arrayFieldDescriptors.length; i++){
				columns[i] = arrayFieldDescriptors[i].getName();
			}
			
			for(int i=0; i<columns.length; i++){
		    	FieldDescriptor fieldDescriptor = outputClsTable.getFieldDescriptor(columns[i]);
		        inputterHtml.append(fieldDescriptor.getDisplayName().equals("-") ? "":fieldDescriptor.getDisplayName()+":");
		        
		    	WebInputter inputter = fieldDescriptor.getWebInputter();
		        inputter.addScriptTo(scriptSet, parameterContext.getVariable().getName(), fieldDescriptor, existingValue, null);
		        
		        String htmlFromInputter;
		        if(isViewMode || ParameterContext.DIRECTION_IN.equals(parameterContext.getDirection())){
		        	htmlFromInputter = inputter.getViewerHTML(parameterContext.getVariable().getName(), fieldDescriptor, existingValue, null);
		        }else{
		        	htmlFromInputter = inputter.getInputterHTML(parameterContext.getVariable().getName(), fieldDescriptor, existingValue, null);
		        }
		    	
		   		inputterHtml.append(htmlFromInputter);
		   		if(i<columns.length-1){
		   			inputterHtml.append("<br>");
		   		}
		    }
		 }else{
		 	FieldDescriptor fieldDescriptor = new FieldDescriptor("value", "value");
	 		defaultInputter.addScriptTo(scriptSet, parameterContext.getVariable().getName(), fieldDescriptor, existingValue, null);
	 		String htmlFromInputter;
	        if(isViewMode || ParameterContext.DIRECTION_IN.equals(parameterContext.getDirection())){
	        	htmlFromInputter = defaultInputter.getViewerHTML(parameterContext.getVariable().getName(), fieldDescriptor, existingValue, null);
	        }else{
	        	htmlFromInputter = defaultInputter.getInputterHTML(parameterContext.getVariable().getName(), fieldDescriptor, existingValue, null);
	        }
	        inputterHtml.append(htmlFromInputter);
		 }
		
		return inputterHtml.toString();
	}

%>
