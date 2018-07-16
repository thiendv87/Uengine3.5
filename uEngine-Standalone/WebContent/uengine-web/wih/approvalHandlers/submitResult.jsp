<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setHeader("Cache-Control", "no-cache");
	
	String	saveOnlyStr			= request.getParameter("saveOnly");
	String	tracingTag			= request.getParameter("tracingTag");
	String	taskId				= request.getParameter("taskId");
	boolean	saveOnly			= Boolean.valueOf(saveOnlyStr);
	String 	processInstance		= request.getParameter("processInstance");
	String	nextAct 			= request.getParameter("nextAct");
	String	nextWorkerRM 		= request.getParameter("nextWorkerRM");

	String workerName = "";
	String workerId = "unknown_user";
	
	if (UEngineUtil.isNotEmpty(nextWorkerRM)) {
		String worker[] = nextWorkerRM.split("/");
		workerName = worker[0];
		workerId = worker[1];
	}
	
	if (!UEngineUtil.isNotEmpty(nextAct)) {
		nextAct = "";
	}
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BPM Message</title>
<%@include file="../wihDefaultTemplate/header.jsp"%>


<style>
#gBtn a {
	display:block;
	background:url('<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/gBtn7_bg.gif') left 0; 
	float:left; 
	font:12px 굴림 bold; 
	color:#777; 
	padding-left:6px; 
	text-decoration:none; 
	height:23px; 
	cursor:pointer; 
	margin-right:3px; 
	overflow:hidden
}
#gBtn a span {
	display:block;
	float:left; 
	background:url('<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/gBtn7_bg.gif') right 0; 
	line-height:190%; 
	padding-right:6px; 
	height:23px; 
	overflow:hidden; 
	font:bold;
}
#gBtn a:hover {
	background:url('<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/gBtn7_bg.gif') left -23px;
	text-decoration:none; 
}
#gBtn a:hover span {
	background:url('<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/gBtn7_bg.gif') right -23px; 
	color:#000
}
</style>

<script type="text/javascript">
	function sendRedirectPage() {
		//setTimeout("sendUrl()", 3000);
		//sendUrl();
	}

	function sendUrl() {
<%
		String url = GlobalContext.WEB_CONTEXT_ROOT + "/processparticipant/worklist/workitemHandler.jsp?taskId="+taskId+"&instanceId="+processInstance+"&tracingTag="+tracingTag;

%>
		var url = "<%=url%>";
		

		window.location.href = url;
	
	}
	
	function viewProcess() {
		//var option = "width=950,height=650,scrollbars=yes,resizable=no,top=0,left=0";
		var url = "<%=GlobalContext.WEB_CONTEXT_ROOT %>/processparticipant/viewProcessInformation.jsp?type=no&option=on&omitHeader=yes&instanceId=<%=processInstance%>";
		window.location.href = url;
	}
	
	function leftSetCount() {
		try {
			top.frames['left'].getCount();
		} catch(err) {}
	}
	
	leftSetCount();
	window.opener.document.location.reload();
	//setTimeout('self.close()','10000000','JavaScript'); 
</script>

</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="80%">
  <tr> 
    <td align="center"> 
      <table width="709" border="0" cellspacing="0" >
        <tr> 
          <td align="center">
          
          	<table  width="709" height="348" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="3"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/consequence_01_<%=loggedUserLocale%>.gif" width="709" height="196" alt=""></td>
                </tr>
                <tr>
                    <td><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/consequence_02.gif" width="87" height="66" alt=""></td>
                    <td width="385" height="66" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    	<col width="85" align="center">
                    	<col width="85">
                    	<col width="*">
                        <tr height="25">
                        <%
                        if(UEngineUtil.isNotEmpty(nextAct)){
	                        String imgPath="images/portrait/"+workerId+".gif";
	        				java.io.File imgFile = new java.io.File(request.getRealPath(imgPath));
	        				if (!imgFile.exists()) imgPath="images/main/NoIMG.gif";
	                        %>
	                            <td rowspan="2" align="center" valign="middle"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT+"/"+imgPath %>" 
	                            width="52" height="55" style="padding:2px; border:1px solid #CCC;"></td>
	                            <td><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/i_blue01.gif" width="5" height="7"> <%=GlobalContext.getLocalizedMessageForWeb("next_work", loggedUserLocale, "Next Work") %></td>
	                            <td>: <%=nextAct %></td>
	                        </tr>
	                        <tr height="25">
	                            <td><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/i_blue01.gif" width="5" height="7"> <%=GlobalContext.getLocalizedMessageForWeb("worker_name", loggedUserLocale, "Worker Name") %></td>
	                            <td>: <%=workerName %></td>
	                        </tr>
                        <%
                        }
                        %>
                    </table></td>
                    <td><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/consequence_04.gif" width="237" height="66" alt=""></td>
                </tr>
                <tr>
                    <td colspan="3"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/consequence_05.gif" width="709" height="86" alt=""></td>
                </tr>
            </table>
          
          </td>
        </tr>
        <tr align="center">
        	<td>
				<table cellSpacing="0" cellpadding="0" align="center" border="0">
                    <tBody>
                        <tr>
                            <td id="gBtn">
								<a href="javascript: parent.window.close();"><span><%=GlobalContext.getMessageForWeb("OK", loggedUserLocale) %></span></a>
								<a href="javascript: viewProcess();"><span><%=GlobalContext.getMessageForWeb("View Process", loggedUserLocale) %></span></a>
								<a href="javascript: sendUrl();"><span><%=GlobalContext.getMessageForWeb("View Workitem", loggedUserLocale) %></span></a>
							</td>
                        </tr>
                    </tBody>
                </table>
        	</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

<script type/text="javascript">
sendRedirectPage();
</script>
