<%@page import="org.uengine.contexts.ComplexType"%>

<%
	if(!isEventHandler && processDefinition!=null && tracingTag!=null){
		result = new Vector();

		ParameterContext[] parameterContexts = (ParameterContext[])pm.getActivityPropertyFromInstance(processInstance, tracingTag, "parameters");
		
		if(parameterContexts!=null)
		for(int j=0; j<parameterContexts.length; j++){		
			ParameterContext parameterContext = parameterContexts[j];			

			if(ParameterContext.DIRECTION_IN.equals(parameterContext.getDirection())) continue;

	        %>	<tr><td bgcolor="#aaaaaa" colspan="2"> <%=(parameterContext.getArgument()!=null ? parameterContext.getArgument().getText(loggedUserLocale):parameterContext.getVariable().getDisplayName().getText())%> </td></tr><%
			
			
			WebInputter defaultInputter = (WebInputter)parameterContext.getVariable().getInputter();
			if(defaultInputter==null){
				try{
					defaultInputter = (WebInputter)ObjectType.getDefaultInputter(parameterContext.getVariable().getType());
				}catch(Exception e){
				}
			}
			
			if(defaultInputter==null){
				try{
					defaultInputter = (WebInputter)FieldDescriptor.getDefaultInputter(FieldDescriptor.getMappingTypeOfClass(parameterContext.getVariable().getType()));
				}catch(Exception e){}
			}

			if(defaultInputter==null){	//generates inputter on the fly
				Class outputCls = parameterContexts[j].getVariable().getType(); //org.uengine.kernel.GlobalContext.getComponentClass(clsName);	
				
				if(parameterContexts[j].getVariable().getDefaultValue() instanceof ComplexType){
					outputCls = ((ComplexType)parameterContexts[j].getVariable().getDefaultValue()).getTypeClass(pm);
				}

				ObjectType outputClsTable = new ObjectType(outputCls);
				HashMap validationResult = null;
				
				ObjectInstance rec = (ObjectInstance)WebUtil.createInstance(outputClsTable, parameterMap, parameterContext.getVariable().getName(), validationResult);
				Object value = rec.getObject();
				
				//show submitted result again
				FieldDescriptor[] arrayFieldDescriptors = outputClsTable.getFieldDescriptors();
				for(int i=0; i<arrayFieldDescriptors.length; i++){
			    	FieldDescriptor fieldDescriptor = arrayFieldDescriptors[i];
			        %>
			        <tr>
			        	<td bgcolor="#ffffff"> <%=fieldDescriptor.getDisplayName()%> </td> 
			   			<td bgcolor="#ffffff"> <%=rec.getFieldValue(fieldDescriptor.getName())%>
			   		<%
			   		if(validationResult!=null && validationResult.containsKey(fieldDescriptor.getName())){
			   			%><font color="#ff0000">(<%=validationResult.get(fieldDescriptor.getName())%>)</font><%
			   		}		   			
			   		%>	
			   			</td>
			   		</tr>
			   		<%
			    }
		    
				if (validationResult == null)
					result.add(new KeyedParameter(parameterContext.getVariable().getName(), value));
				else 
					isValid = false;
			}else{	//use the specified one
				Object oldValue = (UEngineUtil.isNotEmpty(processInstance) ? parameterContext.getVariable().get(instance, "") : null);
				Object value = defaultInputter.createValueFromHTTPRequest(parameterMap, parameterContext.getVariable().getName(), "value", oldValue);
				result.add(new KeyedParameter(parameterContext.getVariable().getName(), (java.io.Serializable)value));
				%>
			        <tr>
			   			<td bgcolor="#ffffff" colspan="2"> <%=value%>	</td>
			   		</tr>
			   	<%
			}
		}
	}	
	
%>