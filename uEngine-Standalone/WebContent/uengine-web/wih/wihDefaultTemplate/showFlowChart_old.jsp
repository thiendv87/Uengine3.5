<html>
<head>
<style type="text/css">
body {
	overflow: auto;
}
</style>
<link href="../../style/default.css" rel="stylesheet" type="text/css">
<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>
<%@page import="org.uengine.util.*"%>
<script type="text/javascript">
var initiate = "<%=request.getParameter("initiate")%>";

function setParentIframeHeight() {
	try {
		var parentTemp = window.parent;
		parentTemp.setFrameHeight(parentTemp.window.document.getElementById("iframeFlowchart"));
	} catch (e) {}
}

function displayProcessRow(nm, url) {
	var iframe = document.getElementById(nm);
	var row = document.getElementById("row_" + nm);
	var src = iframe.src;
	
	if (src == "") {
		iframe.src = url;
	}

	if (row.style.display == "none") {
		row.style.display = "";
	} else {
		row.style.display = "none"
	}

	setParentIframeHeight();
}

function swapView(folder, pi, pd, viewOption, tracingTag) {
	var divSubProcess = parent.document.getElementById("viewSubProcess");

	var frameName = "";
	var url = WEB_CONTEXT_ROOT + "/wih/wihDefaultTemplate/showFlowChart.jsp?initiate=" + initiate;
	
	if (pi != "") {
		frameName += "_" + pi;
		url += "&instanceId=" + pi;
	} else if (pd != "") {
		frameName = "_" + pd;
		url += "&definitionVersionId=" + pd;
	}

	window.parent.window.location.href = url;
}
</script>
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
</head>
<body>
<%

String pd = request.getParameter("processDefinition");
String pi = request.getParameter("instanceId");
String pdver = request.getParameter("definitionVersionId");
String viewOption = request.getParameter("viewOption");
String viewFrame = request.getParameter("viewFrame");
String lastInstance = request.getParameter("lastInstance");
String initiate = request.getParameter("initiate");
ProcessManagerRemote pm = processManagerFactory.getProcessManagerForReadOnly();

try {
	
	
	if (!UEngineUtil.isNotEmpty(pd)) pd = "";
	if (!UEngineUtil.isNotEmpty(pdver)) pdver = "";
	if (!UEngineUtil.isNotEmpty(pi)) pi = "";
	
//	ProcessDefinitionRemote pdr;
	
//	if (UEngineUtil.isNotEmpty(pd))
//		pdver = pm.getProcessDefinitionProductionVersion(pd);
	
	Vector<String> v =new Vector<String>();
	Vector<String> vTitle =new Vector<String>();
	boolean isInstance = false;
	
	if (UEngineUtil.isNotEmpty(pi)) {
		isInstance = true;
	} else if (UEngineUtil.isNotEmpty(lastInstance)) {
		isInstance = false;
		pi = lastInstance;
	}
	
	ProcessDefinitionRemote pdr;
	if (!"".equals(pi)) {
		pdr = pm.getProcessDefinitionRemoteWithInstanceId(pi);
	} else if (!"".equals(pdver)) {
		pdr = pm.getProcessDefinitionRemote(pdver);
	} else if (!"".equals(pd)) {
		pdver = pm.getProcessDefinitionProductionVersion(pd);
		pdr = pm.getProcessDefinitionRemote(pdver);
	} else {
		return;
	}

	if (!UEngineUtil.isNotEmpty(viewOption)) {
		if (pdr.getRoles().length > 1)
			viewOption = "swimlane";
		else
			viewOption = "vertical";
	}
	
	if (UEngineUtil.isNotEmpty(pi)) {
		vTitle.add(pm.getProcessDefinitionRemoteWithInstanceId(pi).getName().toString());
		v.add(pi);
		
		while(true){
			ProcessInstance instance = pm.getProcessInstance(pi);
			String mainPi = instance.getMainProcessInstanceId();
			if (UEngineUtil.isNotEmpty(mainPi)) {
				v.add(mainPi);
				vTitle.add(instance.getName());
				pi = mainPi;
			} else {
				break;
			}
		}
	}


%>
<form id="myform">
    <br>
    <center>
        <table width="95%" align="center">
            <tr>
                <td><%
	
	String frameName = "";
	for(int i = v.size() - 1; i >= 0 ; i-- ) {
		String withTemp = "";
		if (i == 0 && isInstance) {
			withTemp = " width='100%' ";
		}
%>
                    <table border="0" cellspacing="0" cellpadding="0" <%=withTemp%>>
                        <tr>
                            <td width="8" height="7"><img src="imges/Common/fc_mo01.gif" width="8" height="7" /></td>
                            <td background="imges/Common/fc_lineBG_top.gif"></td>
                            <td width="8"><img src="imges/Common/fc_mo02.gif" width="8" height="7" /></td>
                        </tr>
                        <%
	String[] listStrInstanceId = v.get(i).split(";");
	String title =  vTitle.get(i);
	
	for (int instanceCount = 0; instanceCount < listStrInstanceId.length; instanceCount++) {
		String strInstanceId = listStrInstanceId[instanceCount];
		frameName = "_" + strInstanceId;
		
		if (i == 0 && isInstance) {
			String url = org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT
			+ "/processparticipant/viewProcessFlowChart_Simple.jsp?instanceId=" + strInstanceId
			+ "&viewFrame=" + frameName + "&viewOption=" + viewOption;
%>
                        <tr onClick="displayProcessRow('<%=frameName%>', '<%=url%>')" style="cursor: pointer;">
                            <td background="imges/Common/fc_lineBG_left.gif"></td>
                            <td id="cellTitle_<%=frameName%>"><span class="flowcharttitle2"><%=title %></span></td>
                            <td background="imges/Common/fc_lineBG_right.gif"></td>
                        </tr>
                        <tr id="row_<%=frameName%>">
                            <td background="imges/Common/fc_lineBG_left.gif"></td>
                            <td height="80" align="center"><iframe id="<%=frameName%>" width="100%" style="width=100%;" frameborder="0" src="<%=url%>" style="margin:0px;" scrolling="no">
                                </iframe>
                                <INPUT TYPE="hidden" id="frameName" name="frameName" value="<%=frameName%>"></td>
                            <td background="imges/Common/fc_lineBG_right.gif"></td>
                        </tr>
                        <%
		} else {
			String url = "showFlowChart.jsp?instanceId=" + strInstanceId + "&viewOption=" + viewOption ;
%>
                        <tr onClick="location.href='<%=url %>';" style="cursor: pointer;">
                            <td background="imges/Common/fc_lineBG_left.gif"></td>
                            <td id="cellTitle_<%=frameName%>"><span class="flowcharttitle"><%=title %></span></td>
                            <td background="imges/Common/fc_lineBG_right.gif"></td>
                        </tr>
                        <%
		}
%>
                        <tr>
                            <td height="7"><img src="imges/Common/fc_mo04.gif" width="8" height="7" /></td>
                            <td background="imges/Common/fc_lineBG_bottom.gif"></td>
                            <td><img src="imges/Common/fc_mo03.gif" width="8" height="7" /></td>
                        </tr>
                        <%
	}
%>
                    </table>
                    <%
		if (i != 0 || (i == 0 && !isInstance)) {
%>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td rowspan="2" width="50" valign="top"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/fc_line.gif"></td>
                            <td height="15"></td>
                        </tr>
                        <tr>
                            <td><%
		}

	}
	
	if (!isInstance) {
		StringBuffer url = new StringBuffer();
		url.append(
				GlobalContext.WEB_CONTEXT_ROOT + "/processparticipant/viewProcessFlowChart_Simple.jsp?lastInstance=" + lastInstance 
				+ "&viewOption=" + viewOption
				+ "&initiate=" + initiate
		);
		
		if (UEngineUtil.isNotEmpty(pdver)) {
			url.append("&definitionVersionId=" + pdver);
			frameName = "__" + pdver;
		} else if (UEngineUtil.isNotEmpty(pd)) {
			url.append("&processDefinition=" + pd);
			frameName = "___" + pd;
		}
	
		url.append("&viewFrame=" + frameName);
%>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="8" height="7"><img src="imges/Common/fc_mo01.gif" width="8" height="7" /></td>
                                    <td background="imges/Common/fc_lineBG_top.gif"></td>
                                    <td width="8"><img src="imges/Common/fc_mo02.gif" width="8" height="7" /></td>
                                </tr>
                                <tr onClick="displayProcessRow('<%=frameName%>', '<%=url%>')" style="cursor: pointer;">
                                    <td background="imges/Common/fc_lineBG_left.gif"></td>
                                    <td id="cellTitle_<%=frameName%>"><span class="flowcharttitle2"><%=pdr.getName() %></span></td>
                                    <td background="imges/Common/fc_lineBG_right.gif"></td>
                                </tr>
                                <tr id="row_<%=frameName%>">
                                    <td background="imges/Common/fc_lineBG_left.gif"></td>
                                    <td height="80" align="center"><iframe id="<%=frameName%>" width="100%" style="width=100%;" frameborder="0" src="<%=url%>" style="margin:0px; overflow:hidden;"  scrolling="no">
                                        </iframe>
                                        <INPUT TYPE="hidden" id="frameName" name="frameName" value="<%=frameName%>"></td>
                                    <td background="imges/Common/fc_lineBG_right.gif"></td>
                                </tr>
                                <tr>
                                    <td height="7"><img src="imges/Common/fc_mo04.gif" width="8" height="7" /></td>
                                    <td background="imges/Common/fc_lineBG_bottom.gif"></td>
                                    <td><img src="imges/Common/fc_mo03.gif" width="8" height="7" /></td>
                                </tr>
                            </table></td>
                    </tr>
                </table>
                <%
	}
%></td>
            </tr>
        </table>
    </center>
</form>
<%


} finally {
	try{pm.remove();} catch(Exception e){}
}
%>
</body>
</html>