<?xml version="1.0" encoding="UTF-8"?>
<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/xml; charset=UTF-8");%>
<%@include file="../../common/no_cache.jsp"%>
<%@include file="../../common/commons.jsp"%>
<%@page import="java.io.StringWriter"%>
<%@page import="hanwha.commons.xml.brainnet.commons.xml.XMLString"%>
<%@page import="hanwha.bpm.form.dao.FormDAO"%>
<%@page import="hanwha.bpm.form.business.FormBusinessFacade"%>
<%
	long folderId = Long.parseLong(request.getParameter("id"));

	RequestContext reqCtx = new RequestContext(request);
	FormBusinessFacade formBF = new FormBusinessFacade(reqCtx);
	FormDAO formDAO = formBF.getFormList(folderId);
	
	XMLString.Element _ROOT = XMLString.createElement("tree");
	
	for (int i=0; formDAO.next(); i++) {
		XMLString.Element _CURRENT = XMLString.createElement("tree");

		XMLString.Element _TEXT = XMLString.createElement("text");
		_TEXT.appendCDATAText(formDAO.getFormName());
		_CURRENT.appendChild(_TEXT);		
		_CURRENT.addAttribute("action", "javascript:selected('form',"+formDAO.getFormId()+")");
		_CURRENT.addAttribute("icon", IMG+"/tree/xp/file.png");
		_CURRENT.addAttribute("openIcon", IMG+"/tree/xp/file.png");
		_CURRENT.addAttribute("id", formDAO.getFormId()+"");
		_CURRENT.addAttribute("contextAction", "javascript:treeContextMenu('form',"+formDAO.getFormId()+")");
		
		_ROOT.appendChild(_CURRENT);
	}
	
	if ( formDAO.size() == 0 ) _ROOT = XMLString.createElement("tree");
	
	StringWriter sw = new StringWriter();
	_ROOT.write(sw);
	
	out.println(sw.toString());
%>