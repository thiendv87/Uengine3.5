<%@page pageEncoding="KSC5601"%>
<%@include file="../../common/commons.jsp"%>
<%@page import="hanwha.bpm.commons.dao.FolderDAO"%>
<%@page import="hanwha.bpm.form.business.FormBusinessFacade"%>

<%
System.err.println("~~~~~~~~~~~~~~~`` START!");
	RequestContext reqCtx = new RequestContext(request);
	FormBusinessFacade formBF = new FormBusinessFacade(reqCtx);	
	
	String type = request.getParameter("type");
	String Id = request.getParameter("Id");
	
	boolean isDynamicTree = true;
	String deptSelect = request.getParameter("deptSelect");
	String multiSelect = request.getParameter("multiSelect");
	String treeOption = request.getParameter("treeOption");
	
	String cTreeImageDir = IMG+"/themes/common/images";

	///////////////////////////////////////////////////////////////////////////
	 //Get FormVersion List.
	FolderDAO folderDAO = formBF.getFormMenuDAO(Id);
	int menuSize = folderDAO.size();
	///////////////////////////////////////////////////////////////////////////

	while(folderDAO.size()>0 && folderDAO.next()) {
		String nid = Integer.toString(folderDAO.getFolderId().intValue());
		String folderName = folderDAO.getFolderName();
		String nType = folderDAO.getType();
		String nodeId = nType+"_"+nid;						
		String pId = Integer.toString(folderDAO.getParentFolderId().intValue());
		
		String folderOpenSrc = "tree-fold-open.gif";
		String folderCloseSrc = "tree-fold-close.gif";
		
		String parentNodeId = "folder_"+pId;
		
		if(nType.equals("form")){
			folderOpenSrc = "form-big.gif";
			folderCloseSrc = "form-big.gif";
		}else{
			folderOpenSrc = "tree-fold-open.gif";
			folderCloseSrc = "tree-fold-close.gif";
		}
		
		int childMenuCnt = 1;
%>
		try{
			parentFolder = <%=parentNodeId%>;
		}catch(Exception) {
			parentFolder = foldersTree;
		}
		
		<%=nodeId%> = insFld(parentFolder, gFld('<%=folderName%>', "goToDept(\"<%=nType%>\",\"<%=nid%>\")","<%=folderOpenSrc%>","<%=folderCloseSrc%>",<%=isDynamicTree%>, '',"<%=nid%>",'<%=nType%>'))
<%
      if ( childMenuCnt == 0 ) {
%>
          <%=nodeId%>.isChildDataQuery = true
<%
      }

    out.flush();
  }   
%>
