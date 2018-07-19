<?xml version="1.0" encoding="UTF-8"?>
<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/xml; charset=UTF-8");%>
<%@include file="../../common/no_cache.jsp"%>
<%@include file="../../common/commons.jsp"%>
<%@page import="java.io.StringWriter"%>
<%@page import="hanwha.commons.xml.brainnet.commons.xml.XMLString"%>
<%@page import="hanwha.bpm.commons.dao.FolderDAO"%>
<%@page import="hanwha.bpm.form.business.FormBusinessFacade"%>
<%
	RequestContext reqCtx = new RequestContext(request);
	FormBusinessFacade formBF = new FormBusinessFacade(reqCtx);	
		
	FolderDAO folderDAO = formBF.getFormFolderDAO();
	
	int curLevel = -1;
	
	XMLString.Element _ROOT = XMLString.createElement("tree");
	Map treeMap = new HashMap();
	

	while (folderDAO.next()) {
		XMLString.Element _CURRENT = XMLString.createElement("tree");

		XMLString.Element _TEXT = XMLString.createElement("text");
		_TEXT.appendCDATAText(folderDAO.getFolderName());
		_CURRENT.appendChild(_TEXT);
		_CURRENT.addAttribute("action", "javascript:selected('folder',"+folderDAO.getFolderId().longValue()+")");
		_CURRENT.addAttribute("src", "getFormXML.jsp?id="+folderDAO.getFolderId());
		_CURRENT.addAttribute("icon", IMG+"/tree/xp/folder.png");
		_CURRENT.addAttribute("openIcon", IMG+"/tree/xp/openfolder.png");
		_CURRENT.addAttribute("id", folderDAO.getFolderId()+"");
		_CURRENT.addAttribute("contextAction", "javascript:treeContextMenu('folder',"+folderDAO.getFolderId()+")");
		
		curLevel = folderDAO.getLevel().intValue();
		
		if ( curLevel==1 ) {
			_ROOT.appendChild(_CURRENT);
			treeMap.put(folderDAO.getFolderId(), _CURRENT);
		} else {
			XMLString.Element _PARENT = (XMLString.Element)treeMap.get(folderDAO.getParentFolderId()); 
			_PARENT.appendChild(_CURRENT);
			treeMap.put(folderDAO.getFolderId(), _CURRENT);
		}		
	}

	StringWriter sw = new StringWriter();
	_ROOT.write(sw);

    System.out.println(sw.toString());	//TODO : delete
	out.println(sw.toString());	
%>