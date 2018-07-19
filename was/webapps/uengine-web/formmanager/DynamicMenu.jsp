<%@ page pageEncoding = "KSC5601" %>
<%@ page import="hanwha.framework.*"%>
<%@ page import="hanwha.common.util.*"%>
<%@ page import="hanwha.gw.org.dao.bo.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%@page import="java.io.StringWriter"%>
<%@page import="hanwha.commons.xml.brainnet.commons.xml.XMLString"%>
<%@page import="hanwha.bpm.dao.FolderDAO"%>
<%@page import="hanwha.bpm.form.business.FormBusinessFacade"%>

<script language="javascript">
	alert("test");
</script>

<%
	boolean isDynamicTree = true;
	int compId = 0;
    int deptId = 0;
    String deptSelect = "N";
    String multiSelect = "N";

	RequestContext reqCtx = new RequestContext(request);
	FormBusinessFacade formBF = new FormBusinessFacade(reqCtx);	
		
	FolderDAO folderDAO = formBF.getFormFolderDAO();

	int groupSize = folderDAO.size();
%>

<%	
	//조건에 맞는 폴더이미지 셋팅
	String folderOpenSrc = "/tree/openfolder.gif";
	String folderCloseSrc = "/tree/folder.gif";

	while (folderDAO.next()) {
		String nid = Integer.toString(folderDAO.getFormId().intValue());
		String folderName = folderDAO.getFormName();

  		nodeId = "folder_"+nid;					
		String pId = Integer.toString(folderDAO.getFolderId().intValue());
%>
		try{
			parentFolder = folder_<%=pId%>;
		}catch(Exception) {
			parentFolder = clickedFolder;
		}
		folder_<%=nid%> = insFld(parentFolder, gFld('<%=folderName%>', "goToDept(\"<%=nid%>\")","<%=folderOpenSrc%>","<%=folderCloseSrc%>",<%=isDynamicTree%>))

	  if( "<%=deptSelect%>" == "Y" ) {
		 folder_<%=nid%>.setCheckboxValue("<%=multiSelect%>","<%=compId%><%="\14"%><%=nid%><%="\14"%><%=folderName%><%="\14"%><%=deptVO.getCompanyName()%>")
	  }
<%
    out.flush();
  }   
%>        