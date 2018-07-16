<%@include file="../common/header.jsp"%>
<%

	String realPath=pageContext.getServletContext().getRealPath("html/uengine-web/forms/");
	String source = decode(request.getParameter("FCKeditor1"));
	String fileName = "index.jsp";
	
	String tracingTag = request.getParameter("tracingTag");
    String processDefinition = decode(request.getParameter("processDefinition"));
    
	File dir = new File(realPath + "/" + processDefinition + "/" + tracingTag);
	dir.mkdirs();
	boolean isRequestToRestore = "yes".equals(request.getParameter("restore"));
	
	if(isRequestToRestore){
		File sourceFile = new File(dir, fileName+ ".source");
		sourceFile.delete();
	
		File translatedFile = new File(dir, fileName);
		translatedFile.delete();
		%>Form has been restored as default.<%
		return;
	}
	
	FileWriter fw = new FileWriter(dir + "/" + fileName + ".source");
	fw.write(source);
	fw.close();
    System.out.println("source : "+source);
    
	//save translated one
	StringBuffer translatedOne = new StringBuffer();

	translatedOne.append("<"+"%@page pageEncoding=\"KSC5601\" import=\"java.util.*\"%"+">\n<"+"%! public Object inputter(HttpServletRequest request, String varName){return ((Map)request.getAttribute(\"inputterBag\")).get(varName);} %"+">");
			
	String[] processVariableMappingsAndHtml = source.split("processvariablemapping");
	if(processVariableMappingsAndHtml.length == 1){
		translatedOne.append(source);
	}else
	for(int i=0; i < processVariableMappingsAndHtml.length; i++){
		String htmlPart = processVariableMappingsAndHtml[i];
		
		
		int lastStartingTagPos;
		
		if(i==0){
			lastStartingTagPos = htmlPart.lastIndexOf("<");
			if(lastStartingTagPos < 0) lastStartingTagPos = htmlPart.length();

			translatedOne.append(htmlPart.substring(0, lastStartingTagPos));
			i++;
		}
		
		String attributePart;
		String nextHtmlPart;

		nextHtmlPart = processVariableMappingsAndHtml[i];
		int endTagPos = nextHtmlPart.indexOf(">");
		attributePart = nextHtmlPart.substring(0, endTagPos);
		
		lastStartingTagPos = nextHtmlPart.lastIndexOf("<");
		if(lastStartingTagPos < 0 || processVariableMappingsAndHtml.length == (i+1)) lastStartingTagPos = nextHtmlPart.length();
		nextHtmlPart = nextHtmlPart.substring(endTagPos + 1, lastStartingTagPos);
			
		String nameAndValue[] = attributePart.split("name=\"");
		if(nameAndValue.length > 0){
			String processVariableName = nameAndValue[1].split("\"")[0];
			translatedOne.append("<"+"%=inputter(request, \"" + processVariableName +"\")%"+">");
		}else{
			translatedOne.append("-");
		}
		
		translatedOne.append(nextHtmlPart);
	}
	
	fw = new FileWriter(dir + "/" + fileName);
	fw.write(translatedOne.toString());
	fw.close();
%>
	
	Form is saved like below:

<%=source%><p>
