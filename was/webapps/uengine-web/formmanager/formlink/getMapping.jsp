<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/xml; charset=UTF-8");%>
<%@include file="../../../common/no_cache.jsp"%>
<%@include file="../../../common/commons.jsp"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="hanwha.bpm.BPMConstants"%>
<%@page import="hanwha.bpm.util.StreamUtils"%>
<%
	String savePath = request.getParameter("savePath");
	String mode = request.getParameter("mode");
	File savePathFile = new File(BPMConstants.FORM_FILE_PATH, savePath+"-"+mode+"map.xml");
	System.out.println("[savePathFile : " + savePathFile + "]");
	if ( savePathFile.exists() ) {
		String mappingXML = StreamUtils.getString(new FileInputStream(savePathFile));
		out.println(mappingXML);
	}
%>
