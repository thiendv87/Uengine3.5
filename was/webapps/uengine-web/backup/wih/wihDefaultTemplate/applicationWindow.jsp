<%@include file="header.jsp"%>
<%@include file="initialize.jsp"%>
<%@page import="java.net.*" %>
<%


	String url = request.getParameter("url");
	if(!url.startsWith("http://")){
		String serverUrl = request.getRequestURL().toString();
		String codebase = serverUrl.substring( 0, url.lastIndexOf( "/" ) );
		URL urlURL = new java.net.URL(codebase);
		String host = urlURL.getHost();
		int port = urlURL.getPort();

		url = "http://" + host + (port != 80 ? ":"+port : "") + url;
	}

%>

<script>
 function onApplicationLoaded(){
 	var applicationFrame = document.frames["applicationFrame"];
 	opener.onApplicationLoaded(""+ applicationFrame.location);
 }
 	function go(){
		Browser.go("<%=url%>")
	}
 
</script>


<form action=submit.jsp method=POST>


<%@include file="passValues.jsp"%>
<%@include file="showFlowChart.jsp"%>
<%@include file="returnIfNotRunning.jsp"%>
<%@include file="showRoleBindingForm.jsp"%>

</form>

<SCRIPT for="Browser" event="DocumentComplete(pDisp, URL)" language="javascript">
	//opener.onApplicationLoaded(URL);
	document.all.urlPattern.value = URL;
		var element;
		element = pDisp.document.body
		while (element.parentElement != null) {
			element = element.parentElement;
		}
		document.all.htmlPattern.value = element.outerHTML.substring(0, 1000);

</SCRIPT>




<body onload="go()">

<form action="saveCompletionPattern.jsp">
<table>
<tr><td>Pattern of URL :</td><td><input size=100 name="urlPattern"></td></tr>
<tr><td>Pattern of result HTML :</td><td> <textarea name="htmlPattern" cols=80 rows=5></textarea></td></tr>
</table>

<br>
<input type=submit value="Save Compeletion Pattern">
</form>

<!-- iframe name="applicationFrame" onload="onApplicationLoaded()" frameborder=0 width=100% height=100% src="<%=request.getParameter("url")%>"></iframe-->

<OBJECT ID="Browser" CLASSID="CLSID:7665E723-3C49-4FAB-966F-A306A996C59B" width=100% height=800></OBJECT>

