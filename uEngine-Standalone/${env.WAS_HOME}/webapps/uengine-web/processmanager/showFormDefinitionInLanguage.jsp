<%@page contentType="text/xml; charset=UTF-8" 
	    import="java.lang.reflect.Method,
	            java.io.*,
	            java.util.*,
	            org.uengine.kernel.*,
	            org.uengine.processmanager.*,
                au.id.jericho.lib.html.*"%>
<%
	response.setContentType("text/xml; charset=UTF-8");
	response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%! 
	private Source readForm(String id, ProcessManagerRemote pm) throws Exception {
		String prodVerId = pm.getProcessDefinitionProductionVersion(id);
		String html = pm.getResource(prodVerId);
		
		Source source = new Source(html);
		source.setLogWriter(new OutputStreamWriter(System.err)); // send log messages to stderr
		return source;
    }
%><jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<%
	//load up the formfield
	String formDefId = request.getParameter("formDefId");
	//System.out.println("formDefId =["+formDefId+"]");
	
	ProcessManagerRemote pm = null;
	try{
		pm = processManagerFactory.getProcessManagerForReadOnly();
		Source source = readForm(formDefId, pm);
		FormFields formFields = source.findFormFields();
	
		//System.out.println("The document contains "+formFields.size()+" form fields:\n");
		
		ArrayList array = new ArrayList();
		for (Iterator i=formFields.iterator(); i.hasNext();) {
			FormField formField=(FormField)i.next();
			if(formField.getName()!=null)
				array.add(formField.getName());
		}
		
		List tagLibTags = source.findAllStartTags("input:");
		for (int i=0; i<tagLibTags.size(); i++) {
			au.id.jericho.lib.html.Tag tag=(au.id.jericho.lib.html.Tag)tagLibTags.get(i);
			if(tag.getElement().getAttributeValue("name")!=null)
			   array.add(tag.getElement().getAttributeValue("name"));
		}		
		out.println(GlobalContext.serialize(array,ArrayList.class));
		
	}finally{
		if(pm != null) try{ pm.remove(); } catch(Exception e){}
	}
%>
