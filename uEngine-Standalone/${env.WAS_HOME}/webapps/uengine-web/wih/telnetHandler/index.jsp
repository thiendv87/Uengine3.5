<%@page import="org.uengine.telnet.*"%>
<html>
<head>
<title>Telnet Workitem Handler</title>
<%@include file="../wihDefaultTemplate/header.jsp"%>
<%!
	public String getProcessVariableValue(String key, ProcessInstance instance, ProcessDefinition pd) throws Exception {
		if (key != null) {
			if (key.length() > 4) {
				if (key.startsWith("<%=") && key.endsWith(">")) {
					key = (key.substring(key.indexOf("<%=") + 3, key.lastIndexOf(">") - 1)).trim();
					if (instance != null) {
						ProcessVariable[] processVariables = instance.getProcessDefinition().getProcessVariables();
						if (processVariables != null) {
							for (int i = 0; i < processVariables.length; i++) {
								ProcessVariable processVariable = processVariables[i];
								if (processVariable.getName().equals(key)) {
									key = (String)processVariable.get(instance, "", key);
									if (key == null)
										key = "";
									break;
								}
							}
						}
					} else if (pd != null) {
						ProcessVariable[] processVariables = pd.getProcessVariables();
						if (processVariables != null) {
							for (int i = 0; i < processVariables.length; i++) {
								ProcessVariable processVariable = processVariables[i];
								if (processVariable.getName().equals(key)) {
									key = (String)processVariable.getDefaultValue();
									if (key == null)
										key = "";
									break;
								}
							}
						}
					}
				}
			}
		} else if (key == null) {
			key = "";
		}
		return key;
	}
%>
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/tabs.js"></script>
<script type="text/javascript" src="javascripts/ajaxTelnet.js" ></script>
<script type="text/javascript" src="javascripts/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="javascripts/jquery.simplemodal.js"></script>
<script type="text/javascript" src="javascripts/jquery.cluetip.js" ></script>
<script type="text/javascript" src="javascripts/jquery.hoverIntent.js" ></script>
<script type='text/javascript'>
jQuery.fn.resizehandle = function() {
      return this.each(function() {
            var me = jQuery(this);
            me.after(
                  jQuery('<div class="resize_bar"></div>')
                        .bind('mousedown', function(e) {
                              var h = me.height();
                              var y = e.clientY;
                              var movehandler = function(e) {
                                    me.height(Math.max(40, e.clientY + h - y));
                              };
                              var uphandler = function(e) {
                                    jQuery('html').unbind('mousemove',movehandler)
                                          .unbind('mouseup',uphandler);
                              };
                              jQuery('html') .bind('mousemove', movehandler)
                                    .bind('mouseup', uphandler);
                        })
            );
      });
}
$(document).ready(function(){
      $("textarea").resizehandle();
});

$(document).ready(function() {
	$('span.jt:eq(0)').cluetip({cluetipClass: 'jtip', arrows: true, dropShadow: true, hoverIntent: false});
	$('span.jt:eq(1)').cluetip({cluetipClass: 'jtip', arrows: true, dropShadow: true, hoverIntent: false});
	$('span.jt:eq(2)').cluetip({cluetipClass: 'jtip', arrows: true, dropShadow: true, hoverIntent: false});
});

</script>

<link type="text/css" rel="StyleSheet" href="css/telnet.css">
<link type="text/css" rel="stylesheet" href="../style/default.css">
<link type="text/css" rel="stylesheet" href="css/basic.css" media="screen" />
<link type="text/css" rel="stylesheet" href="css/jquery.cluetip.css"  />


</head>

<%
	//------------- declaration & initialize -------------------//
	ProcessManagerRemote pm;
	String instanceId;
	String processDefinition;
	String tracingTag;
	boolean initiate;
	boolean isViewMode;
	ProcessDefinitionRemote pdr = null;

	pm = processManagerFactory.getProcessManager();

	instanceId = decode(request.getParameter("instanceId"));
	processDefinition = decode(request.getParameter("processDefinition"));
	tracingTag = request.getParameter("tracingTag");
	initiate = "yes".equals(request.getParameter("initiate")) || "yes".equals(request.getParameter("isEventHandler"));
	isViewMode = UEngineUtil.isTrue(request.getParameter("isViewMode"));
	
	String TEMP_DIRECTORY = GlobalContext.getPropertyString(
	"filesystem.path",
	"." + File.separatorChar + "uengine" + File.separatorChar + "fileSystem" + File.separatorChar
		);
	TEMP_DIRECTORY = TEMP_DIRECTORY + "telnet" + File.separatorChar;
	File f = new File(TEMP_DIRECTORY);
	if (!f.exists()) {
		f.mkdirs();
	}
	
	ProcessInstance instance = null;
	ProcessDefinition pd = pm.getProcessDefinition(processDefinition);
	if (UEngineUtil.isNotEmpty(instanceId)) {
		instance = pm.getProcessInstance(instanceId);	
	}
	Activity act = pd.getActivity(tracingTag);
	TelnetNormalActivity telnetNorAct = (TelnetNormalActivity) act;
	TelnetConfigHost[] telnetConfigHosts = telnetNorAct.getTelnetConfigHosts();
	
//------------- pass values to submit.jsp -------------------//
%>
<body onscroll="loadingDivScroll();">

<script type="text/javascript">
	var tmp = new Array(
			<%
			if (telnetConfigHosts.length != 0) {
				for (int i=0; i<telnetConfigHosts.length; i++) {
					out.print("\"Host"+(i+1)+"\"");
					if (i != telnetConfigHosts.length-1)
						out.print(",");
				}
			}
			%>
	);
	createTabs(tmp);
</script>

<iframe id="iframeViewTotalResult" src="" scrolling="auto" frameborder="1" width="100%" height="460" style="display: none;"></iframe>

<form name="rootForm" action="submit.jsp" method="post">
<div id="loading">loading...</div>

<input type="hidden" value="<%=decode(request.getParameter("instanceId"))%>" name="instanceId" />
<input type="hidden" value="<%=request.getParameter("message")%>" name="message" />
<input type="hidden" value="<%=decode(request.getParameter("processDefinition"))%>" name="processDefinition" />
<input type="hidden" value="<%=request.getParameter("tracingTag")%>" name="tracingTag" />
<input type="hidden" value="<%=request.getParameter("taskId")%>" name="taskId" />
<input type="hidden" value="<%=request.getParameter("initiate")%>" name="initiate" />

<%	if (isViewMode) { %>
<br />
<div>
<table width="100%">
	<tr><td align="center" bgcolor="YELLOW"><h6><b>Complete Work</b></h6></td></tr>
</table>
</div>
<br />
<%	} %>

<%
	if (telnetConfigHosts != null && telnetConfigHosts.length != 0) {
		for (int i = 0; i < telnetConfigHosts.length; i++) {
			TelnetConfigCommand[] telnetConfigCommands = telnetConfigHosts[i].getTelnetConfigCommand();
	
			String hostName = telnetConfigHosts[i].getHostName();
			int port = telnetConfigHosts[i].getPort();
			//String userId = telnetConfigHosts[i].getUserId();

			if (telnetConfigCommands != null && telnetConfigCommands.length != 0) {
				String divStyle = "";
				if (i != 0) {
					divStyle = "style=\"display: none;\"";
				}
%>

<div id="divTabItem_Host<%=(i+1) %>" <%=divStyle %>>

<div class="secleft">
	<span class="secright">
		<b> hostName :</b> <%=hostName%>&nbsp;&nbsp;<b> port : </b><%=port%>
	</span>
</div>

<div id="telnetHost_<%=i %>" class="bigbox">
	<input type="hidden" name="hostName" value="<%=hostName%>" />
	<input type="hidden" name="port" value="<%=port%>" />
	<br />
<%
				for (int j = 0; j < telnetConfigCommands.length; j++) {
					TelnetConfigCommand telnetConfigCommand = telnetConfigCommands[j];

					int sessionTimeOut = telnetConfigCommand.getSessionTimeout();
					String description = telnetConfigCommand.getDescription();
					String serverType = telnetConfigCommand.getServerType();
					
					ProcessVariable totalResultProcessVariable = telnetConfigCommand.getTotalResult();
					String totalResultProcessVariableName = "";
					if (totalResultProcessVariable != null)
						totalResultProcessVariableName = totalResultProcessVariable.getName();

					TelnetCommand[] telnetCommands = telnetConfigCommand.getTelnetCommands();
					if (telnetCommands != null && telnetCommands.length != 0) {
%>
    <div id="telnet_<%=j%>">
<%
						String filePath = TEMP_DIRECTORY + File.separatorChar;
						String fileName = instanceId + "." + tracingTag + "." + "telnetHost_" + i + ".telnet_" + j + ".totalResult.log";
						File file = new File(filePath + fileName);
						
						String Str = "";
						String totalStr = "";
						/*
						if (file.exists()) {
							BufferedReader br = new BufferedReader(new FileReader(file));
							while ((Str = br.readLine()) != null) {
								totalStr += Str + "\r\n";
							}
							br.close();
							if (totalStr.indexOf("\r\n") != -1)
								totalStr = totalStr.substring(0, totalStr.lastIndexOf("\r\n"));
						}
						*/
%>
		<table style="display: none;">
			<tr>
				<td>
	        		<textarea name="totalResult" rows="10" cols="80" style="display: none;"><%//=totalStr%></textarea>
	        	</td>
	        </tr>
        </table>
        
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="130">
                	<table cellSpacing="0" cellpadding="0" align="left" >
                        <tBody>
                            <tr>
                                <td class="gBtn">
                                	<a href="#"  onClick="viewTotalResult('<%=fileName.substring(fileName.indexOf(".") + 1, fileName.length())%>');"><span>viewTotalResult</span></a>
                                	<input type="hidden" name="totalResultProcessVariableName" value="<%=totalResultProcessVariableName%>" />
				                    <input type="hidden" name="totalResultFileName" value="<%=fileName %>" />
                                </td>
                            </tr>
                        </tBody>
                    </table>
				</td>
                <td>
                	<table cellSpacing="0" cellpadding="0" align="right" >
                        <tBody>
                            <tr>
                                <td class="gBtn">
									<%	if (!isViewMode) { %>
                                	<a href="#"  onClick="runTelnetSevlet('telnetHost_<%=i %>','telnet_<%=j%>','<%=loggedUserId%>');" ><span>Run</span></a>
                                	<%	} %>
                                </td>
                            </tr>
                        </tBody>
                    </table>
				</td>
                <td width="230" align="right">
                	processingTime : <input type="text" name="processingTime" value="" />
				</td>
            </tr>
        </table>
        
        <br/>
        
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
        	<tr>
                <td colspan="2" class="formheadline" ></td>
            </tr>
            <tr>
                <td class="formtitle"  width="110">description </td>
                <td class="padding7px"><%=description%></td>
            </tr>
            <tr>
                <td colspan="2"class="formline" height="1"></td>
            </tr>
            <tr>
                <td class="formtitle">sessionTimeOut </td>
                <td class="padding7px"><input type="text" name="sessionTimeOut" value="<%=sessionTimeOut%>" /></td>
            </tr>
			<tr>
                <td colspan="2"class="formline" height="1"></td>
            </tr>
			<tr>
            	<td class="formtitle">serverType </td>
            	<td class="padding7px">
            		<input type="radio" name="serverType_<%=j%>" value="option1" <%="option1".equals(serverType) || !UEngineUtil.isNotEmpty(serverType) ? "checked=\"checked\"" : "" %> class="radio" />
            		<span class="jt" href="option1.html" rel="option1.html" title="Option 1">option1</span>
            		&nbsp;&nbsp; <input type="radio" name="serverType_<%=j%>" value="option2" <%="option2".equals(serverType) ? "checked=\"checked\"" : "" %> class="radio" />
            		<span class="jt" href="option2.html" rel="option2.html" title="Option 2">option2</span>
            		&nbsp;&nbsp; <input type="radio" name="serverType_<%=j%>" value="option3" <%="option3".equals(serverType) ? "checked=\"checked\"" : "" %> class="radio" />
            		<span class="jt" href="option3.html" rel="option3.html" title="Option 3">option3</span>
            	</td>
            </tr>
			<tr>
                <td colspan="2"class="formline" height="1"></td>
            </tr>
        </table>
        
        <br />
        
        <table border="0"  cellpadding="0" cellspacing="0" width="100%" class="tableborder" >
        	<tr class="tabletitle" align="center">
                <td colspan="2">waitFor</td>
                <td class="tabletitleborder" width="1"></td>                
                <td colspan="2">command</td>
                <td class="tabletitleborder"></td>       
                <td>result</td>
            </tr>            
<%
						for (int k = 0; k < telnetCommands.length; k++) {
							TelnetCommand telnetCommand = telnetCommands[k];

							String waitFor = telnetCommand.getWaitFor();
							String command = telnetCommand.getCommand();
							long timeout = telnetCommand.getTimeout();
							
							TelnetParameter[] telnetParameters = telnetCommand.getTelnetParameter();
							
							String style = "";
							if (telnetCommand.isVisible() == false) {
								style = "style=\"display: none;\"";
							}
%>			
			<tr <%=style%>>
                <td colspan="7" class="formheadline" ></td>
            </tr>
            <tr <%=style%>>
                <td class="formtitle">waitFor </td>
                <td class="padding7px"><input type="text" name="waitFor" value="<%=waitFor%>" /></td>
                <td width="1" bgcolor="#CCCCCC"></td>
                <td class="formtitle">command </td>
                <td class="padding7px"><input type="text" name="command" value="<%=command%>" /></td>
                <td width="1" bgcolor="#CCCCCC"></td>
                <td rowspan="3" class="padding7px">
                	<table>
<%                            
							ProcessVariable resultProcessVariable = telnetCommand.getResultCommand();
							String regularExpression = telnetCommand.getRegularExpression();
%>
                        <tr <%=style%>>
                        	<td>
                            <%
							if (resultProcessVariable != null) {
								String resultProcessVariableName = resultProcessVariable.getName();
%>
								<input type="hidden" name="resultProcessVariableName" value="<%=resultProcessVariableName%>" />
<%
							} else {
%>
								<input type="hidden" name="resultProcessVariableName" value="" />
<%
							}
%>
								<input type="hidden" name="regularExpression" value="<%=UEngineUtil.isNotEmpty(regularExpression) ? regularExpression : ""%>" />
							</td>
                        </tr>
                        <tr <%=style%>>
                            <%
							filePath = TEMP_DIRECTORY + File.separatorChar;
							fileName = instanceId+"."+tracingTag+"."+"telnetHost_"+i+".telnet_"+j+"."+k +"."+ URLEncoder.encode(telnetCommands[k].getWaitFor(), "UTF-8")+".log";
							file = new File(filePath + fileName);

							Str = "";
							totalStr = "";
							if (file.exists()) {
								BufferedReader br = new BufferedReader(new FileReader(file));
								while ((Str = br.readLine()) != null) {
									totalStr += Str + "\r\n";
								}
								br.close();
								if (totalStr.indexOf("\r\n") != -1)
									totalStr = totalStr.substring(0, totalStr.lastIndexOf("\r\n"));
							}
%>
                            <td colspan="2">
                            	<textarea name="result" class="textarea02" style="width: 450px;"><%=totalStr%></textarea>
                                <input type="hidden" name="resultFileName" value="<%=fileName %>" />
							</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr <%=style%>>
                <td colspan="6"class="formline" height="1"></td>
            </tr>
            <tr <%=style%>>
                <td height="60" class="formtitle">timeout </td>
              	<td height="60" class="padding7px"><input type="text" name="timeout" value="<%=timeout%>" /></td>
                <td width="1" height="60" bgcolor="#CCCCCC"></td>
                <td height="60" class="formtitle">Parameters</td>
                <td height="60" class="padding7px" <%=style%>>
<%
							if (telnetParameters != null) {
%>
                    <table>
<%
								for (int u = 0; u < telnetParameters.length; u++) {
									TelnetParameter telnetParameter = telnetParameters[u];
									String parameter = getProcessVariableValue(telnetParameter.getParameter(), instance, pd);
									String parameterFieldStyle = "";
									if (telnetParameter.isEditable() == false)
										parameterFieldStyle = "readonly=\"readonly\"";
%>
                        <tr>
                            <td><input type="text" name="parameter<%=k %>" value="<%=parameter%>" <%=parameterFieldStyle %>  class="textarea01"/></td>
                        </tr>
                        <%
								}
%>
                    </table>
<%
							}
%>
				</td>
				<td width="1" bgcolor="#CCCCCC"></td>
			</tr>
			<tr <%=style%>>
				<td colspan="7" class="formheadline" ></td>
			</tr>
			<tr <%=style%>>
				<td colspan="7" height="10" ></td>
			</tr>
<%
						} // for
%>
        </table>
	</div>
<%        
				} else { // if
%>
<table>
    <tr>
        <td>Can't Find Telnet Commands</td>
    </tr>
</table>
<%
				}
			} // for
%>
</div>
<%
		} else { // if
%>
<table>
    <tr>
        <td>Can't Find Telnet Config Commands</td>
    </tr>
</table>
<%
			}
%>
</div>
<%
		} // for
	} else { // if
%>
<table>
    <tr>
        <td>Can't Find Telnet Config Hosts</td>
    </tr>
</table>
<%		
	}
%>
<br />

<%	if (!isViewMode) { %>
<table cellSpacing="0" cellpadding="0" align="center" >
    <tBody>
        <tr>
            <td class="gBtn"><a href="#"  onClick="completeWorkHandler();"><span>Complete</span></a></td>
        </tr>
    </tBody>
</table>
</form>
<%	} %>

<br />
<br />
</body>
</html>