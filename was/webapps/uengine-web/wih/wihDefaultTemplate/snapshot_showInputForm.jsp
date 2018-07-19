<%@include file="header.jsp"%>

<%@page import="org.uengine.kernel.ProcessInstance"%>
<%@page import="org.uengine.contexts.ComplexType"%>

<%@page import="org.uengine.kernel.HumanActivity"%>
<%@page import="org.uengine.kernel.ParameterContext"%>
<%@page import="java.util.HashMap"%>
<%

/************************************************************
#0. Define Variables  
************************************************************/
ProcessManagerRemote pm = null;
ProcessDefinitionRemote pdr = null;
ProcessInstance piRemote = null;
Activity currentActivity = null;

String processDefinition = null;
String instanceId = null;
String tracingTag = null;

Properties scriptSet = new Properties();

/************************************************************
#1. Gathering Request Attributes  
************************************************************/
Object instanceForSnapshot = request.getAttribute("instanceForSnapshot");
Object currActivityForSnapshot = request.getAttribute("currActivityForSnapshot");

if(instanceForSnapshot != null && currActivityForSnapshot != null){
	
	/************************************************************
	#2. Variables assignment
	************************************************************/
	piRemote = (ProcessInstance) instanceForSnapshot;
	currentActivity =  (HumanActivity) currActivityForSnapshot;
	
	pm = piRemote.getProcessTransactionContext().getProcessManager();
	instanceId = piRemote.getInstanceId();
	processDefinition = piRemote.getProcessDefinition().getId();
	tracingTag = currentActivity.getTracingTag();
	pdr = pm.getProcessDefinitionRemote(processDefinition);
	
	
	/************************************************************
	#3. Render HTML _ metaworks
	************************************************************/
	%>
	<link href="../../style/default.css" rel="stylesheet" type="text/css">
	<div id="form">
	<%@include file="showURLApplication.jsp"%>
	<!--
	Multiple annotations found at this line:
		- Class is a raw type. References to generic type Class<T> should be parameterized
		- Type safety: The method put(Object, Object) belongs to the raw type HashMap. 
		 	References to generic type HashMap<K,V> should be parameterized
		- Duplicate local variable url
		- Duplicate local variable isActiveXBrowser
	 -->
	<%
		ObjectType.addInputterPackage("org.uengine.processdesigner.inputters");
	
	%><table cellspacing=1><%
	
		ParameterContext[] parameterContexts = ((HumanActivity) currentActivity).getParameters();
		
		HashMap inputterOptions = new HashMap();
		inputterOptions.put("instanceId", instanceId);
			
		if(piRemote !=null)
			inputterOptions.put("instance", piRemote);
		
		inputterOptions.put("defVerId", processDefinition);
		inputterOptions.put("definitionRemote", pdr);
		inputterOptions.put("processManager", pm);
		
		if(parameterContexts !=null){
			for(int j=0; j<parameterContexts.length; j++){	
			       
				ParameterContext parameterContext = parameterContexts[j];
		
			
		        %>	
		        <tr>
		         <td align=right>
		          <b><%=(parameterContext.getArgument()!=null ? parameterContext.getArgument().getText(loggedUserLocale):parameterContext.getVariable().getDisplayName().getText(loggedUserLocale))%> : </b>
		         </td>
		         <td>
		        <%
		
				Object existingValue = (piRemote!=null ? parameterContext.getVariable().get(piRemote, "") : parameterContext.getVariable().getDefaultValue());	
				
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
				
				if(defaultInputter==null){
					
					Class objType = parameterContext.getVariable().getType();
					if(objType == ComplexType.class){
						objType = ((ComplexType)existingValue).getTypeClass(pm);
					}
					
					ObjectType outputClsTable = new ObjectType(objType);
					FieldDescriptor[] arrayFieldDescriptors = outputClsTable.getFieldDescriptors();
						
					String[] columns = new String[arrayFieldDescriptors.length];	
					for(int i=0; i<arrayFieldDescriptors.length; i++){
						columns[i] = arrayFieldDescriptors[i].getName();
					}
					
					for(int i=0; i<columns.length; i++){
				    	FieldDescriptor fieldDescriptor = outputClsTable.getFieldDescriptor(columns[i]);
				        %>	<%=(fieldDescriptor.getDisplayName().equals("-") ? "":fieldDescriptor.getDisplayName()+":")%>
				        <%
				    	
				    	WebInputter inputter = fieldDescriptor.getWebInputter();
				        inputter.addScriptTo(scriptSet, parameterContext.getVariable().getName(), fieldDescriptor, existingValue, inputterOptions);
				        
				        Object propertyValue = null;
				        try{
				        	propertyValue = objType.getMethod("get" + columns[i], new Class[]{}).invoke(existingValue, new Object[]{});
				        }catch(Exception e){
				        }
				        
				        String htmlFromInputter;
			        	htmlFromInputter = inputter.getViewerHTML(parameterContext.getVariable().getName(), fieldDescriptor, propertyValue, inputterOptions);
				    	
				   		%>  <%=htmlFromInputter%>
				   		<% if(i<columns.length-1){%>
				   		 <br>
				   		<%}
				    }
				 }else{
			 		FieldDescriptor fieldDescriptor = new FieldDescriptor("value", "value");
			 		defaultInputter.addScriptTo(scriptSet, parameterContext.getVariable().getName(), fieldDescriptor, existingValue, inputterOptions);
			 		String htmlFromInputter;
		        	htmlFromInputter = defaultInputter.getViewerHTML(parameterContext.getVariable().getName(), fieldDescriptor, existingValue, inputterOptions);
			        %>
			    	<%=htmlFromInputter%>	    	 
			    	<%
				 }
		%>
				</td></tr>
		<%
			}//end for
		}//if(parameterContexts !=null)
		else{
			%><tr><td>&nbsp;</td></tr><%
		}
		%>
		<%=WebUtil.createScriptBodyFromScriptSet(scriptSet)%>
</table>
</div>
<%}%>
