<html>
<HEAD>   
   <BASE href="/uengine-web/processmanager">
 </HEAD>
<LINK href="../../style/uengine.css" type=text/css rel=stylesheet>
 
<!--- JavaScript to detect if Java Web Start is installed or not --->

<SCRIPT LANGUAGE="Javascript">
   var javawsInstalled = 0;
   isIE = "false";

   if (navigator.mimeTypes && navigator.mimeTypes.length) {
      x = navigator.mimeTypes['application/x-java-jnlp-file'];
      if (x) javawsInstalled = 1;
    } else { 
      isIE = "true";
    }


	function launchFile(){
		location = "ApplicationInvoker.jnlp";
	}

</script>

<body onl oad=launchFile()>



This page will show up the application. When you complete the task, please click the 'Complete' button to submit the result.
<br>
if your browser cannot show up the document application, try clicking here: <a href="ApplicationInvoker.jnlp?defaultApplication=<%=request.getParameter("defaultApplication")%>">launch</a>




<form action="submit.jsp" method=POST>
	<input type=hidden value='<%=request.getParameter("instanceId")%>' name=instanceId>
	<input type=hidden value='<%=request.getParameter("message")%>' name=message>
	<input type=submit value=complete>
</form>

<h1>Current status:</h1>
<%@include file="../../processmanager/viewProcessFlowChart.jsp"%>


</body>
  

</html>