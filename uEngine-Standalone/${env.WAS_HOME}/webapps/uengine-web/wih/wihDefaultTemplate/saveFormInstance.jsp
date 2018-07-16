<%
	RequestDispatcher dis = application.getRequestDispatcher((wasIsJBoss ? GlobalContext.WEB_CONTEXT_ROOT : "") + "/wih/wihDefaultTemplate/standalone_showInputForm.jsp?instanceId=" + processInstance + "&processDefinition=" + processDefinition + "&tracingTag=" + tracingTag + "&isViewMode=yes");
	final StringWriter sw = new StringWriter();
	dis.include(request, new HttpServletResponseWrapper(response){
		public PrintWriter getWriter() throws IOException {	
			return new PrintWriter(sw);
		}
	});
	
	String html = sw.toString();
	
	String realPath=application.getRealPath((wasIsJBoss ? GlobalContext.WEB_CONTEXT_ROOT : "") + "/formInstances/");
	String fileName = "index.html";
	
	File dir = new File(realPath + "/" + processInstance + "/" + tracingTag);
	dir.mkdirs();

	FileWriter fw = new FileWriter(dir + "/" + fileName);
	fw.write(html);
	fw.close();

%>
