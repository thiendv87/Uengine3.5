<%@include file="../common/header.jsp"%>
<%@include file="../common/dojoHeader.jsp"%>
<%@include file="../common/styleHeader.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<%@include file="../common/flowchartSliderHeader.jsp"%>

<%@page import="org.uengine.util.*"%>



<%@page import="org.uengine.kernel.viewer.ViewerOptions"%><jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<form id="myform">
<div id="viewSubProcess">
<%
ProcessManagerRemote pm = processManagerFactory.getProcessManagerForReadOnly();

try {
	
	String pd = request.getParameter("processDefinition");
	String pi = request.getParameter("instanceId");
	String pdver = request.getParameter("definitionVersionId");
	String viewOption = request.getParameter("viewOption");
	String viewFrame = request.getParameter("viewFrame");
	
	if ( pd == null ) pd = "";
	if ( pi == null ) pi = "";
	if ( viewOption == null ) 
		viewOption = "horizontal";
		//viewOption = "vertical";
		//viewOption = "swimlane";
		//viewOption = "ganttchart";
	
	String chart ="no chart is available";
	ProcessDefinitionRemote pdr;
	
//	if(!"".equals(pd))
//		pdver = pm.getProcessDefinitionProductionVersion(pd);
	
	if(!"".equals(pi))
		pdr = pm.getProcessDefinitionRemoteWithInstanceId(pi);
	else
		pdr = pm.getProcessDefinitionRemote(pdver);
	
	ViewerOptions options = new ViewerOptions();
	options.put("decorated", new Boolean(true));
	options.put("nowrap", new Boolean(true));
	options.put("imagePathRoot", GlobalContext.WEB_CONTEXT_ROOT+"/processmanager/");
	options.put("locale", loggedUserLocale);
	options.put("subProcessDrillingDown_By_PopingUp", new Boolean(true));
    options.put("showSubProcessOutline", new Boolean(true));
  	if("swimlane".equals(viewOption))
  		options.put("swimlane", new Boolean(true));
  	else if("vertical".equals(viewOption))
  		options.put("vertical", new Boolean(true));
	else if("ganttchart".equals(viewOption))
  		options.put("ganttchart", new Boolean(true));
	options.put("align", "center");
	Vector v =new Vector();
	if(!"".equals(pi)){	
		
		v.add(pi);
		while(true){
			ProcessInstance instance = pm.getProcessInstance(pi);
			String mainPi = instance.getMainProcessInstanceId();
			if (UEngineUtil.isNotEmpty(mainPi)) {
				v.add(mainPi);
				pi = mainPi;
			} else
				break;
		}

	} 
	
	String frameName = "";
	for(int i = v.size()-1 ; i >= 0  ; i -- ) {
		frameName += "_" + v.get(i).toString();

		String url = org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT +
		"/processparticipant/viewProcessFlowChart_Simple.jsp?instanceId="+v.get(i).toString()+"&viewFrame="+frameName;
%>
		<INPUT TYPE="hidden" id="frameName" name="frameName" value="<%=frameName%>">
		<table width="900" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="8" height="7"><img src="imges/Common/fc_mo01.gif" width="8" height="7" /></td>
                <td background="imges/Common/fc_lineBG_top.gif"></td>
                <td width="8"><img src="imges/Common/fc_mo02.gif" width="8" height="7" /></td>
            </tr>
            <tr>
                <td background="imges/Common/fc_lineBG_left.gif"></td>
                <td height="80" align="center"><iframe id="<%=frameName%>" style="width=900" frameborder="0" src="<%=url%>"></iframe></td>
                <td background="imges/Common/fc_lineBG_right.gif"></td>
            </tr>
            <tr>
                <td height="7"><img src="imges/Common/fc_mo04.gif" width="8" height="7" /></td>
                <td background="imges/Common/fc_lineBG_bottom.gif"></td>
                <td><img src="imges/Common/fc_mo03.gif" width="8" height="7" /></td>
            </tr>
        </table>
<%
		if (i != 0) {
%>
		<table width="900" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="46"><img src="imges/Common/sub_p_shdow_L.gif" width="46" height="45" /></td>
                <td background="imges/Common/sub_p_shdow_C.gif">&nbsp;</td>
                <td width="46"><img src="imges/Common/sub_p_shdow_R.gif" width="46" height="45" /></td>
            </tr>
        </table>
<%
		}
	}

%>
<br>
<%= v%>

<%
	} finally {
		try{pm.remove();} catch(Exception e){}
	}
%>
</form>
</div>
</body>

<script>
	var opennedSubProc = new Array();
	var opennedSubProcType = new Array();

	addOpennedSubProc();
	

	function addOpennedSubProc() {
		var frameName = document.forms[0].all["frameName"];
		
		if (frameName != null){
			frameName = myform.frameName;
			var count = opennedSubProc.length;
		
			opennedSubProc[count] = frameName.value;
			opennedSubProcType[count] = "instance";
			//alert(opennedSubProc[count]+" | "+opennedSubProcType[count]);
		} 

		for (i=0; i<frameName.length; i++) {
			opennedSubProc[i] = frameName[i].value;
			opennedSubProcType[i] = "instance";
			//alert(opennedSubProc[i]+" | "+opennedSubProcType[i]);
		}

	}
</script>

<% //@include file="../scripts/hong.js.jsp"%>