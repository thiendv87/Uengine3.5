<%@page import="org.uengine.kernel.ProcessInstance"%>
<%@page import="org.uengine.contexts.ComplexType"%>

<%@page import="org.uengine.kernel.HumanActivity"%>
<%@page import="org.uengine.kernel.ParameterContext"%>
<%@page import="java.util.HashMap"%><link href="../../style/default.css" rel="stylesheet" type="text/css">
<div id="form">

<%
	if(isRacing){
		%>
<table width="100%" align="center" border="0" cellspacing="0" cellpadding="4">
	<tr height="1">
		<td align="center" bgcolor=yellow><b><%=GlobalContext.getLocalizedMessageForWeb("accept_desc", loggedUserLocale, "You need to accept this workitem since users are racing to handle this workitem.") %></b></td>
	</tr>
</table>
		
<%
	}else if(!isMine && !isViewMode){
%>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr height="1">
		<td align="center" bgcolor=lightblue><b><%=GlobalContext.getLocalizedMessageForWeb("wih.only_for_reference", loggedUserLocale, "This workitem is only for reference. So you can't complete this workitem.") %></b></td>
	</tr>
</table>

<%
	}
%>

<%@include file="showURLApplication.jsp"%>

<%
	ObjectType.addInputterPackage("org.uengine.processdesigner.inputters");
%>


<%
	String instruction =null;
	if(initiationActivity!=null)
		instruction = initiationActivity.getInstruction().getText(loggedUserLocale);
		
	if(instruction!=null){
		instruction = (instruction);
%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr height="30" >
			<td class="formtitle" width="100">
				&nbsp;<b><%=GlobalContext.getLocalizedMessageForWeb("instruction", loggedUserLocale, "Instruction") %></b>
			</td>
			<td width="*" align=left>
		<%=instruction%>
			</td>
		</tr>
		</table>
<%	}%>

<table cellspacing=1>
<%
	//ParameterContext[] parameterContexts = (ParameterContext[])piRemote.getActivityProperty(initiationProcessDefinition, tracingTag, "parameters");
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
			        if(isViewMode || ParameterContext.DIRECTION_IN.equals(parameterContext.getDirection())){
			        	htmlFromInputter = inputter.getViewerHTML(parameterContext.getVariable().getName(), fieldDescriptor, propertyValue, inputterOptions);
			        }else{
			        	htmlFromInputter = inputter.getInputterHTML(parameterContext.getVariable().getName(), fieldDescriptor, propertyValue, inputterOptions);
			        }
			    	
			   		%>  <%=htmlFromInputter%>
			   		<% if(i<columns.length-1){%>
			   		 <br>
			   		<%}
			    }
			 }else{
		 		FieldDescriptor fieldDescriptor = new FieldDescriptor("value", "value");
		 		defaultInputter.addScriptTo(scriptSet, parameterContext.getVariable().getName(), fieldDescriptor, existingValue, inputterOptions);
		 		String htmlFromInputter;
		        if(isViewMode || ParameterContext.DIRECTION_IN.equals(parameterContext.getDirection())){
		        	htmlFromInputter = defaultInputter.getViewerHTML(parameterContext.getVariable().getName(), fieldDescriptor, existingValue, inputterOptions);
		        }else{
		        	htmlFromInputter = defaultInputter.getInputterHTML(parameterContext.getVariable().getName(), fieldDescriptor, existingValue, inputterOptions);
		        }
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
<%=WebUtil.createScriptBodyFromScriptSet(scriptSet) %>

</table>

</div>

