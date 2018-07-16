<%@include file="header.jsp"%>
<%
	String tracingTag = request.getParameter("tracingTag");
	String processDefinition = decode(request.getParameter("processDefinition"));
	System.out.println("saveComplet");
	String realPath=pageContext.getServletContext().getRealPath("html/uengine-web/forms/");
	String urlPattern=decode(request.getParameter("urlPattern"));
	String htmlPattern = decode(request.getParameter("htmlPattern"));
	String urlPattern2=decode(request.getParameter("urlPattern2"));
	String htmlPattern2 = decode(request.getParameter("htmlPattern2"));
//	String htmlValues = decode(request.getParameter("htmlValues"));
	String fileName = "completionPattern.xml";	

	File dir = new File(realPath + "/" + processDefinition + "/" + tracingTag);
	dir.mkdirs();	
	
	FileOutputStream fos = new FileOutputStream(dir + "/" + fileName);
	
	Properties prop = new Properties();
	prop.setProperty("urlPattern", 	urlPattern);
	prop.setProperty("htmlPattern", htmlPattern);
	
	if(urlPattern2!=null){
		prop.setProperty("urlPattern2", urlPattern2);
		prop.setProperty("htmlPattern2", htmlPattern2);
	}
//	prop.setProperty("htmlValues", 	htmlValues);

	GlobalContext.serialize(prop, fos, String.class);
	
	fos.close();

%>
Completion Pattern has been successfully saved.
