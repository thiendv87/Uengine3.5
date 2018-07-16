<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");
%>

<%@include file="../wihDefaultTemplate/header.jsp"%>
<%@page import="org.uengine.contexts.HtmlFormContext" %>
<%@page import="org.uengine.contexts.MappingContext" %>

<%@page import="au.id.jericho.lib.html.FormFields"%>
<%@page import="au.id.jericho.lib.html.FormField"%>
<%@page import="au.id.jericho.lib.html.OutputDocument"%>
<%@page import="au.id.jericho.lib.html.Source"%>


<script type="text/javascript" src="../../scripts/formActivity.js"></script>
<script type="text/javascript">

	function commentPopup(instid, trctag){
		var url = "../../comment/commentInfo.jsp?instid=" + instid + "&trctag=" + trctag +  "&partype=G";
		window.open(url,'_comment','top=10,left=10,width=650,height=450,resizable=true,scrollbars=no');	
	}

</script>

<body>
<form action=submit.jsp method=POST>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
//------------- declaration & initialize -------------------//
	ProcessManagerRemote pm = null;
	String instanceId;
	String processDefinition;
	String tracingTag;
	boolean initiate;
	boolean isMine;
	ProcessDefinitionRemote pdr = null;
try{
	pm = processManagerFactory.getProcessManagerForReadOnly();

	instanceId = decode(request.getParameter("instanceId"));
	processDefinition = decode(request.getParameter("processDefinition"));
	tracingTag = request.getParameter("tracingTag");
	initiate = "yes".equals(request.getParameter("initiate")) || "yes".equals(request.getParameter("isEventHandler"));
	isMine = initiate || "yes".equals(request.getParameter("isMine"));
	
	ProcessInstance instance = null;
	if(!initiate)
		instance = pm.getProcessInstance(instanceId);

	ProcessDefinition procDef = (ProcessDefinition)pm.getProcessDefinition(processDefinition);
	FormActivity formActivity = (FormActivity)procDef.getActivity(tracingTag);
	
	HtmlFormContext formContext = initiate ? (HtmlFormContext)(formActivity.getVariableForHtmlFormContext().getDefaultValue()) : (HtmlFormContext)(formActivity.getVariableForHtmlFormContext().get(instance, ""));
	String formDefId = formContext.getFormDefId();
	String formInstanceFilePath = formContext.getFilePath();
	System.out.println("formInstanceFilePath : " + formInstanceFilePath );
	
//------------- pass values to submit.jsp -------------------//

%>	
	<input type=hidden value='<%=decode(request.getParameter("instanceId"))%>' name=instanceId>
	<input type=hidden value='<%=request.getParameter("message")%>' name=message>
	<input type=hidden value='<%=decode(request.getParameter("processDefinition"))%>' name=processDefinition>
	<input type=hidden value='<%=request.getParameter("tracingTag")%>' name=tracingTag>
	<input type=hidden value='<%=request.getParameter("taskId")%>' name=taskId>
	<input type=hidden value='<%=request.getParameter("initiate")%>' name=initiate>
<%
//------------- show flow chart -------------------//


	Hashtable options = new Hashtable();
	options.put("decorated", "yes");
	options.put("nowrap", "yes");
	options.put("locale", loggedUserLocale);
	options.put("imagePathRoot", "../../processmanager/");
	
	String chart;

	if(initiate)
		chart = pm.viewProcessDefinitionFlowChart(processDefinition, options);	
	else
		chart = pm.viewProcessInstanceFlowChart(instanceId, options);	
%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="tit_c1"></td>
					<td class="tit_c2">
						<!--Title-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="11" height="34">&nbsp;</td>
								<td width="18"><img src="/bul_tit.gif" width="11" height="15"></td>
								<td class="tit1"><span class="linemap">Process Information </span></td>
								<td align="right" class="linemap">&gt; Process Information </td>
								<td width="20">&nbsp;</td>
							</tr>
						</table>
						<!--/Title-->
					</td>
				</tr>
			</table>		
		</td>
	</tr>	
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr>
		<td style="padding: 0px 0px 0px 20px;" >
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" height="2" class="line_blue"></td>
				</tr>
				<tr>
					<td align="center" height="2" class="line_gray"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr>
		<td style="padding: 0px 0px 0px 20px;" >
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr height="20" >
					<td width="110" class="prs1"><b>Process</b></td>
					<td width="10"></td>
					<td width="*" align=left>
		
						<div id="processLine1" style="display : ''">
						<%=chart %>
						</div>
					</td>		
				</tr>
				<tr height="1">
					<td align="center" colspan="3" height="1" class="line_gray"></td>
				</tr>	
			</table>
		</td>
	</tr>
</table>
<br>

<p>

<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr>
		<td style="padding: 0px 0px 0px 20px;" >
	<!-- ....Form Dispatch Part.... -->
<%
	String[] defIdAndVersionId = formDefId.split("@");
	String formPath = defIdAndVersionId[1] + ".html";
	out.flush();
	System.out.println("formPath : " + formPath);
	
//	File contextDir = new File(request.getRealPath(XONEConstants.FORM_CONTEXT_PATH));
//	FormUtil.copyToContext(contextDir, formPath);
/*	
	RequestDispatcher rdIncludeAction = request.getRequestDispatcher(formJSP);
	rdIncludeAction.include(request, response);
	out.flush();
*/
	FileInputStream htmlFIS = null;
	Reader HtmlReader = null;
	Source source =  null;
	try {
		htmlFIS = new FileInputStream(ProcessDefinitionFactory.DEFINITION_ROOT + "/" + formPath);
		HtmlReader = new InputStreamReader(htmlFIS, "UTF-8");
		source = new Source(HtmlReader);
		out.println(source.toString());
		out.flush();
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		if(HtmlReader != null) HtmlReader.close();
		if(htmlFIS != null) htmlFIS.close();
	}
%>

<!-- .... Binding with ProcessVariable to FormField Part.... -->
<%
		HashMap valueMap = new HashMap();
		FileInputStream fis = null;
		if(formInstanceFilePath != null) { // 임시저장된 폼인스턴스가 있을때
			try {
				fis = new FileInputStream(formInstanceFilePath);
				valueMap = (HashMap)GlobalContext.deserialize(fis, HashMap.class);

				FormFields formFields = source.findFormFields();
				String script = "";
				String formName = null;
				String formValue = null;
				for (Iterator i=formFields.iterator(); i.hasNext();) {
					FormField formField=(FormField)i.next();
					formName = formField.getFormControl().getName();
					if(valueMap.containsKey(formName)) {
						formValue = (String)valueMap.get(formName);
						formValue = formValue.replaceAll("\r\n", "@xonebpm@");
						script = script + "bindingFormValue('"+  formName +"','"+ formValue +"');\n";
					}
				}
				out.println("<script>");
				out.println("function init(){");
				out.println(script);
				out.println("}");
				out.println("init();");
				out.println("</script>");
			} catch(Exception e) {

			} finally {
				if(fis != null) fis.close();
			}
		} else { // 임시저장된적이 없을때  1.이전 액티비티의  폼 변수들 값 세팅 후   2.매핑정보에 의한 프로세스 변수 값 세팅 해야함!
			String script = new String("");
		
			// 1.
			
			
			if(!initiate){
				Vector beforeActivities = null;
				beforeActivities = formActivity.getPreviousActivities();
				String beforeFormInstanceFilePath = null;
				if(beforeActivities!=null){
					for(int i=0;i<beforeActivities.size();i++){
						if(beforeActivities.get(i) instanceof FormActivity){
							FormActivity beforeFormActivity = (FormActivity)beforeActivities.get(i);
							HtmlFormContext beforeFormContext = (HtmlFormContext)(beforeFormActivity.getVariableForHtmlFormContext().get(instance, ""));
							//String beforeFormDefId = beforeFormContext.getFormDefId();
							beforeFormInstanceFilePath = beforeFormContext.getFilePath();
							System.out.println("beforeFormInstanceFilePath : " + beforeFormInstanceFilePath );
						}
					}
				}
				
				
				if(beforeFormInstanceFilePath!=null){
					try {
						fis = new FileInputStream(beforeFormInstanceFilePath);
						valueMap = (HashMap)GlobalContext.deserialize(fis, HashMap.class);
	
						FormFields formFields = source.findFormFields();
						
						String formName = null;
						String formValue = null;
						for (Iterator i=formFields.iterator(); i.hasNext();) {
							FormField formField=(FormField)i.next();
							formName = formField.getFormControl().getName();
							if(valueMap.containsKey(formName)) {
								formValue = (String)valueMap.get(formName);
								formValue = formValue.replaceAll("\r\n", "@xonebpm@");
								script = script + "bindingFormValue('"+  formName +"','"+ formValue +"');\n";
							}
						}
						//out.println("<script>");
						//out.println("function init(){");
						//out.println(script);
						//out.println("}");
						//out.println("init();");
						//out.println("</script>");
					} catch(Exception e) {
	
					} finally {
						if(fis != null) fis.close();
					}
				}
			}
			
			
			// 2.
			MappingContext mappingContext = (MappingContext)pm.getActivityProperty(processDefinition, tracingTag, "mappingContext");
			
			
			ParameterContext[] params = mappingContext.getMappingElements();//getVariableBindings();
			if(params!=null && !initiate){
				//String script = "";
				String objName = null;
				String objValue = null;
				for (int i = 0; i < params.length; i++) {
					ParameterContext param = params[i];

					String sourceProcessVariable = param.getVariable().getName();
					String targetFormField = param.getArgument().getText();
		System.out.println("sourceProcessVariable = " +sourceProcessVariable);
		System.out.println("targetFormField = " +targetFormField);
					
					targetFormField = targetFormField.replace('.','@');
					String [] targetFormFieldName = targetFormField.split("@");
					
					if(formActivity.getVariableForHtmlFormContext().getName().equals(targetFormFieldName[0])){
					
						objName = targetFormFieldName[1];
						objValue =  (String)pm.getProcessVariable(instanceId,"",sourceProcessVariable);
						objValue = objValue.replaceAll("\r\n", "@xonebpm@");
						script = script + "bindingFormValue('"+  objName +"','"+ objValue +"');\n";
					}
				}
				out.println("<script>");
				out.println("function init(){");
				out.println(script);
				out.println("}");
				out.println("init();");
				out.println("</script>");
			}
		}
%>


		</td>
	</tr>
</table>

<br>

<%
	if(!initiate){
		String status = pm.getActivityStatus(instanceId, tracingTag);
		
		if(status!=null && !status.equals("Running") && !status.equals("Timeout")){%>
			
			<table width="100%" border="0" cellspacing="0" cellpadding="4">
				<tr>
					<td style="padding: 0px 0px 0px 20px;" >
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr height="20" >
								<td>
									The workitem has been closed (<%=status%>)<p>									
									<!-- You can see the data you've submitted by this <a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/wih/formHandler/viewFormInstances.jsp?instanceId=<%=instanceId%>&tracingTag=<%=tracingTag%>&processDefinition=<%=processDefinition%>&taskId=<%=request.getParameter("taskId")%>" >Link</a> -->
								</td>
							</tr>	
						</table>
					</td>
				</tr>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="10"></td>
				</tr>
			</table>
			<%
			return;
		}
	}
%>

<% if(!initiate) {%>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr>
		<td style="padding: 0px 0px 0px 20px;" >
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr height="20" >
					<td>
						<input type=submit class="btn" value="Complete">
						<input type=submit class="btn" value="Save" onclick="saveWorkitem()">
					</td>		
				</tr>	
			</table>
		</td>
	</tr>
</table>
<% }else{ 
System.out.println("----------------------------------------sdfasdf");
%>

sd
afsadlfkjsdalfjasldkfjlaksdjflk

<input type=submit class="btn" value="Complete">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr>
		<td style="padding: 0px 0px 0px 20px;" >
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr height="20" >
					<td>
						
					</td>		
				</tr>	
			</table>
		</td>
	</tr>
</table>

<% }
}finally{
	if(pm!=null) pm.remove();
}
%>
<script>
function saveWorkitem(){
	document.forms[0].saveOnly.value="yes";
	document.forms[0].submit();
}
</script>
<input type=hidden name="saveOnly">
</form>
</body>