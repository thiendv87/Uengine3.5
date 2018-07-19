<%	
	boolean isActiveXBrowser = false;
	String url = null;
/*
	System.out.println("========================================");
	System.out.println("piRemote: " + piRemote);
	System.out.println("tracingTag: " + tracingTag);
	System.out.println("getProcessDefinition: " + piRemote.getProcessDefinition());
	System.out.println("getActivity: " + piRemote.getProcessDefinition().getActivity(tracingTag));
	System.out.println("========================================");
*/
	if (currentActivity instanceof org.uengine.kernel.URLActivity) {
		org.uengine.kernel.URLActivity urlActivity = (org.uengine.kernel.URLActivity) currentActivity;
		url = (String)urlActivity.createParameter(piRemote).get("url");
	}

	//url = request.getParameter("url");
	
	if(UEngineUtil.isNotEmpty(url)){

		if(isActiveXBrowser && !url.startsWith("http://")){
			String serverUrl = request.getRequestURL().toString();
			String codebase = serverUrl.substring( 0, serverUrl.lastIndexOf( "/" ) );
			URL urlURL = new java.net.URL(codebase);
			String host = urlURL.getHost();
			int port = urlURL.getPort();
		
			url = "http://" + host + (port != 80 ? ":"+port : "") + url;
		}
		
		String realPath=pageContext.getServletContext().getRealPath("/html/uengine-web/forms/");
		String fileName = "completionPattern.xml";
		String urlPattern = null;
		String htmlPattern = null;
		String urlPattern2 = null;
		String htmlPattern2 = null;
		try{
			File dir = new File(realPath + "/" + processDefinition + "/" + tracingTag);
	
			FileInputStream fis = new FileInputStream(dir + "/" + fileName);
	
			Properties prop = (Properties)GlobalContext.deserialize(fis, String.class);
	
			urlPattern = prop.getProperty("urlPattern");
			htmlPattern = prop.getProperty("htmlPattern");
			
			if(htmlPattern!=null){
				htmlPattern = htmlPattern.replace('\n', ' ');
				htmlPattern = htmlPattern.replace('\r', ' ');
			}
System.out.println("htmlPattern is ["+htmlPattern+"]");
			urlPattern2 = prop.getProperty("urlPattern2");
			htmlPattern2 = prop.getProperty("htmlPattern2");

			if(UEngineUtil.isNotEmpty(htmlPattern2)){
				htmlPattern2 = htmlPattern2.replace('\n', ' ');
				htmlPattern2 = htmlPattern2.replace('\r', ' ');
			}else{
				urlPattern2 = null;
				htmlPattern2 = null;
			}
			
			fis.close();
		}catch(Exception e){
			
		}
%>


<%@page import="org.uengine.kernel.ProcessDefinition"%>
<%@page import="org.uengine.kernel.Activity"%><script>
	function recordCompletionPattern(){
		document.forms[0].action = "../wihDefaultTemplate/recordCompletionPattern.jsp";
		document.forms[0].submit();
	}

	<%if(isActiveXBrowser){%>
	function urlApplicationGo(){
		//drawLoopLines();
		document.all.Browser.go("<%=url%>");
	}
	
	onload = urlApplicationGo;
	<%}%>
	
</script>

<%if(isActiveXBrowser){%>
<SCRIPT for="Browser" event="DocumentComplete(pDisp, URL)" language="javascript">
	document.forms[0].url_of_application_result.value = URL;
	
	var element;
	try{
		element = pDisp.Document.body
	}catch(e){
	}
	
	if(element!=null){
	
		while (element.parentElement != null) {
			element = element.parentElement;
		}
	
		var html = element.outerHTML;
		document.forms[0].html_of_application_result.value = html;
		
		html = html.replace('\n', ' ');
		html = html.replace('\r', ' ');
		
	<%
		if(urlPattern!=null){
			
	%>
		if(URL.indexOf("<%=urlPattern%>") > -1 <%if(htmlPattern!=null){%>&& html.indexOf("<%=htmlPattern%>") > -1<%}%>){
			document.forms[0].submit();
		}	
	<%
		}
	%>

</SCRIPT>
<%
}else{
%>

<SCRIPT language="javascript">

function onApplicationLoaded(){
 	var applicationFrame = document.frames["applicationFrame"];
 	
 	var URL = ""+ applicationFrame.window.location;
 	//alert(URL);
 	
	document.forms[0].url_of_application_result.value = URL;
	
	var element;
//	try{
		element = applicationFrame.document.documentElement.innerHTML;
//	}catch(e){
//	}
	
	if(element!=null){
//	alert(element);
	
		var html = element;
		document.forms[0].html_of_application_result.value = html;
		
		html = html.replace('\n', ' ');
		html = html.replace('\r', ' ');
		
	<%
		if(urlPattern!=null){
			
	%>
		if(URL.indexOf("<%=urlPattern%>") > -1 <%if(htmlPattern!=null){%>&& html.indexOf("<%=htmlPattern%>") > -1<%}%>){
			document.forms[0].submit();
		}	
	<%
		}
	%>
	}
	
}
</SCRIPT>

<%
}
%>

<input type=hidden name="url" value="<%=url%>">
<input type=hidden name="url_of_application_result">
<input type=hidden name="html_of_application_result">

<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr height="1">
		<td align="center" height="1" class="bgcolor_head_upperline"></td>
	</tr>
	<tr height="5">
		<td align="center" height="5" class="bgcolor_head"></td>
	</tr>
	<tr height="1">
		<td align="center" height="1" class="bgcolor_head_underline"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>			
	<tr height="30" >
		<!--td width="150" align=left bgcolor="f4f4f4">
			&nbsp;<b>Application</b>
		</td-->
		<td colspan=2 width="*" align=left>
			<!--iframe name="applicationFrame" onload="onApplicationLoaded();" frameborder=0 width=100% height=500 src="<%=url%>"></iframe-->
			<!-- input type=button value="Launch the application" onclick="launchApplication()"-->
						
			<!-- iframe name="applicationFrame" onload="onApplicationLoaded()" frameborder=0 width=100% height=100% src="<%=request.getParameter("url")%>"></iframe-->
			
			<%
			if(isActiveXBrowser){
			%>
			<OBJECT ID="Browser" CLASSID="CLSID:7665E723-3C49-4FAB-966F-A306A996C59B" width=100% height=700></OBJECT>
			<%
			}else{
			%>
			<iframe name="applicationFrame" onload="onApplicationLoaded();" frameborder=0 width=100% height=500 src="<%=url%>"></iframe>
			<%
			}
			%>
			
			<%if(true || loggedUserIsAdmin){ %>
			<a href="javascript:recordCompletionPattern()">record completion pattern</a>
			<%} %>
							
		</td>
	</tr>
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>
</table>




<%	}%>

