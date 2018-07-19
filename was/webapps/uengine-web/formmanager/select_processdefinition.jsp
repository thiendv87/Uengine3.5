<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/html; charset=UTF-8");%>
<%@include file="../../common/no_cache.jsp"%>
<%@include file="../../common/commons.jsp"%>
<%@page import="hanwha.commons.brainnet.commons.Constants"%>

<%@page import="hanwha.bpm.commons.dao.FolderDAO"%>
<%@page import="org.uengine.persistence.processdefinition.ProcessDefinitionBusinessFacade"%>

<%-- 
<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%> 
--%>

<%
	String formId = request.getParameter("formId");
%>

<%
	String deptSelect = "N";
	String multiSelect = "N";
	String companySelect = "N";
	String treeOption = "N";
	String cTreeImageDir = IMG+"/themes/common/images";

	RequestContext reqCtx = new RequestContext(request);
	//FormBusinessFacade formBF = new FormBusinessFacade(reqCtx);	
	ProcessDefinitionBusinessFacade procDefBF = new ProcessDefinitionBusinessFacade(reqCtx);
		
	//FolderDAO folderDAO = formBF.getFormMenuDAO();
	FolderDAO folderDAO = procDefBF.getProcessDefinitionRootMenuDAO();
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Process Definitions</title>
<LINK REL="stylesheet" href="<%=CSS%>/portlet.css" type="text/css"/>	
<LINK REL="stylesheet" href="<%=CSS%>/portal.css" type="text/css"/>	
<LINK REL="stylesheet" href="<%=CSS%>/groupware.css" type="text/css"/>
<LINK rel="stylesheet" href="<%=CSS%>/xtree.css" type="text/css"/>
<LINK REL="stylesheet" href="<%=CSS%>/common.css" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=CSS%>/bpm.css.jsp">

<script language="JAVASCRIPT" src="<%=JS%>/menu_tree.js"></script>

<script type="text/javascript" src="<%=JS%>/css.js"></script>
<script type="text/javascript" src="<%=JS%>/xtree.js"></script>
<script type="text/javascript" src="<%=JS%>/xmlextras.js"></script>
<script type="text/javascript" src="<%=JS%>/xloadtree.js"></script>
<SCRIPT language="JAVASCRIPT">
<!--
	/***************************************************************************
	 사원목록화면에 결과 표시
	***************************************************************************/
	function goToUserList(Id, name) {		
		selected('procDef',Id, name);
	}

	/***************************************************************************
	 부서노드 클릭시 사원목록화면에 결과 표시
	***************************************************************************/
	var isDebug;
	
	function goToDept(type,Id,name) {
		//alert(Id + ", " + name);
		isDebug = false;

		if( isFolderClick()) {
			//goToUserList(deptId);
			selected(type,Id,name);
		}
		
		if( clickedFolder.isChildDataQuery == false ) {
			var goUrl = "../processmanager/processDynamicTree.jsp?type="+type+"&Id="+Id+"&deptSelect=<%=deptSelect%>&multiSelect=<%=multiSelect%>&treeOption=<%=treeOption%>";
			startDownLoad(goUrl);
		}
	}
-->
</SCRIPT>
<script type="text/javascript">
	// 선택된 정보 클래스
	function SelectedInfo() {
		var type = '';
		var id = '';
	}
	var selectedInfo = new SelectedInfo();

	function selected(type, id, name) {
		selectedInfo.type = type;
		selectedInfo.id = id;
		if ( type == "procDef" ) {
			viewProcess(id, name);
		}
	}
</script>	
<script>
	function viewProcess(id, name){
		//alert(id + ", " + name);
		
		document.viewForm.action = "setProcessDefinition.jsp";
		document.viewForm.processDefinition.value=id;
		document.viewForm.processDefinitionName.value=name;
		document.viewForm.submit();		
	}
</script>
<script type="text/javascript">
	function clickMenu() {
		treeMenu.releaseCapture();
		treeMenu.style.display="none";
		el=event.srcElement;
		//alert(el.id);
		if (el.id=="mnuFolderAdd") {
			addFolder(selectedInfo.id);
		} else if (el.id=="mnuProcAdd") {
			addProcess(selectedInfo.id);
		} else if (el.id=="mnuDel") {
			//deleteFolder();
		}
	}
	function treeContextMenu(type, selectedId) {
		//alert(type + ", " + selectedId);
		if ( type != 'folder' ) return;
		selectedInfo.type = type;
		selectedInfo.id = selectedId;
		whichDiv=event.srcElement;
		treeMenu.style.posLeft=event.clientX;
		treeMenu.style.posTop=event.clientY;
		treeMenu.style.display="block";
		treeMenu.setCapture();
	}
	function contextHighlightRow(obj) {
	
	}
</script>
<script language="javascript">

function right_click(id) {
	var click = event.button;
	var this_id = "";
	var this_type = "";

	if(click == "2"){
		this_id = eval("document.all.deptId_"+id).value;
		this_type = eval("document.all.type_"+id).value;
	
		treeContextMenu(this_type,this_id);
		return false;
	}
}

</script>
</head>
<body>

<form name=viewForm method="POST">
	<input type=hidden name="processDefinition">
	<input type=hidden name="processDefinitionName">
	<input type=hidden name="formId" value="<%=formId%>">
</form>

<body text="black" link="blue" vlink="purple" alink="red" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table border="0" cellpadding="0" cellspacing="0" width="100%" class="color_gw_menu_bg">
	<tr>
		<td background="<%=IMG%>/back_g.gif">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tb_write">						
				<tr>
					<td class="border_menu_child" id="chld_mailbox" style="padding-left:3px;" background="../images/back_g.gif">
						<table border="0" cellpadding="0" cellspacing="0" id="tb_1" style="margin:0px;" xmlns>
							<tr>
								<td height="5"></td>
							</tr>
							<tr align="center">
								<td class="color_gw_menu_bg" style="CURSOR: hand">
									<p align=center> 
									</p>
								</td>
							</tr>
						</table>
						<table border="0" cellpadding="0" cellspacing="0" id="tb_1" style="margin:0px;" xmlns>
							<tr>
								<td height="10" style="padding-left:3px;"></td>
							</tr>
							<tr style="display:block;">
								<td>
<%
			//String curNodeId = request.getParameter("select_dept");
			String curNodeId = "";
			String nodeId = "";
			String parentNodeId = "";
			String dummyRootName = "";
			boolean isNeedDummyRoot = true;
			boolean initFolderOpen = true;
			boolean isDynamicTree = true;
			boolean isTopNodeHidden = false;  //최상위 노드 표시여부
%>	
<!-- Tree Part start -->
									<table border="0" cellpadding="2" cellspacing="1" width="100%">
										<tr>
											<td width="10"></td>
											<td>
												<script language="JavaScript" type="text/javascript">
													var parentFolder = null;
													setWebAppConfig("<%=cTreeImageDir%>","_self"); //imagePath, linkTarget
<%	
													//조건에 맞는 폴더이미지 셋팅
							String folderOpenSrc = "tree-fold-open.gif";
							String folderCloseSrc = "tree-fold-close.gif";

													while (folderDAO.next()) {
														String nid = Integer.toString(folderDAO.getFolderId().intValue());
														String folderName = folderDAO.getFolderName();
														String nType = folderDAO.getType();

														String level = Integer.toString(folderDAO.getLevel().intValue());

														nodeId = nType+"_"+nid;					
														String pId = Integer.toString(folderDAO.getParentFolderId().intValue());

														//가상의 최상위 노드를 생성한다.
														if( "-1".equals(pId) ) {
															nodeId = "folder_root";
%>
															<%=nodeId%> = gFld('<%=folderName%>',"","<%=folderOpenSrc%>","<%=folderCloseSrc%>",true, '', '', '<%=nType%>')
															foldersTree = <%=nodeId%>;
															curFolder   = <%=nodeId%>;
															curFolder.isChildDataQuery = true;

															parentNodeId = "folder_root";
<%
														}else {
															parentNodeId = "folder_"+pId;

															if(nType.equals("procDef")){
																folderOpenSrc = "/tree/form-big.gif";
																folderCloseSrc = "/tree/form-big.gif";
															}else{
																folderOpenSrc = "tree-fold-open.gif";
																folderCloseSrc = "tree-fold-close.gif";
															}
%>
															try{
																parentFolder = <%=parentNodeId%>;
															}catch(Exception) {
																parentFolder = foldersTree;
															}
														
															<%=nodeId%> = insFld(parentFolder, gFld('<%=folderName%>', "goToDept(\"<%=nType%>\",\"<%=nid%>\",\"<%=folderName%>\")","<%=folderOpenSrc%>","<%=folderCloseSrc%>",<%=isDynamicTree%>, '',"<%=nid%>",'<%=nType%>'))
<%
														}

														// 현재 선택되어질 폴더 찾기
														if(nodeId.equals(curNodeId)){
%>
															curFolder = <%=nodeId%>
<% 
														}
													} //while-end
%>	

													//Tree 생성
													initializeDocument(<%=isTopNodeHidden%>);

													//현재선택된 폴더펼치기
													folderOpen(curFolder);
												</script>
											</td>
										</tr>
									</table>
<!-- Tree Part end -->

<!--	#####	tree menu end		#####	-->

									<!-- <form name="roleMenuForm" method="POST">
										<input type="hidden" name="procDefId">
										<input type="hidden" name="ownCompany" value="<%=loggedUserCompanyId%>">
									</form>
									<form name=moveProcessForm action="moveProcess.jsp" method="POST">
										<input type="hidden" name="folder">
										<input type="hidden" name="process_id">
										<input type="hidden" name="type">
										<input type="hidden" name="click">
									</form>	

									<form name=delProc action="proc_delete.jsp" method="POST">
										<input type="hidden" name="actionType">
										<input type="hidden" name="procDefId">
									</form> -->
															
								</td>
							</tr>
						</table>
								<!-- <div id="processLine" overflow:scroll; style="display:block" width="182" cellspacing="0" cellpadding="0">

<script type="text/javascript">
webFXTreeConfig.rootIcon		= "<%=IMG%>/tree/xp/folder.png";
webFXTreeConfig.openRootIcon	= "<%=IMG%>/tree/xp/folder.png";
webFXTreeConfig.usePersistence  = true;
webFXTreeConfig.useContextMenu  = true;


webFXTreeConfig.folderIcon		= "<%=IMG%>/tree/xp/folder.png";
webFXTreeConfig.openFolderIcon	= "<%=IMG%>/tree/xp/openfolder.png";
webFXTreeConfig.fileIcon		= "<%=IMG%>/tree/xp/openfolder.png";
webFXTreeConfig.lMinusIcon		= "<%=IMG%>/tree/xp/Lminus.png";
webFXTreeConfig.lPlusIcon		= "<%=IMG%>/tree/xp/Lplus.png";
webFXTreeConfig.tMinusIcon		= "<%=IMG%>/tree/xp/Tminus.png";
webFXTreeConfig.tPlusIcon		= "<%=IMG%>/tree/xp/Tplus.png";
webFXTreeConfig.iIcon			= "<%=IMG%>/tree/xp/I.png";
webFXTreeConfig.lIcon			= "<%=IMG%>/tree/xp/L.png";
webFXTreeConfig.tIcon			= "<%=IMG%>/tree/xp/T.png";
webFXTreeConfig.blankIcon       = "<%=IMG%>/tree/xp/blank.png";

<%--
var tree = new WebFXLoadTree("<%=hanwha.bpm.util.SessionUtil.getCompName(request)%>", "../processmanager/processDefinitionAllListXML.jsp", "javascript:selected('folder', -1);", "", webFXTreeConfig.rootIcon, webFXTreeConfig.openRootIcon, "javascript:treeContextMenu('folder', '-1')");
--%>
var tree = new WebFXLoadTree("none", "../processmanager/getProcessDefinitionGroupXML.jsp?ownCompany=<%=loggedUserCompanyId%>"); 
tree.setBehavior("classic");
document.write(tree);
tree.expand();
</script>								
								</div> -->
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>						
		</td>
	</tr>
	<tr>
		<td height="600" background="<%=IMG%>/back_g.gif">
	</tr>
</table>

<div id=treeMenu onclick="clickMenu()" style="position:absolute;display:none;background-color: #6699cc;border:1px solid #99ccff;">
	<div id="mnuFolderAdd" NOWRAP="true" STYLE="text-align:center; font-size:11px; width:80px; height:20px; color:white; background-color:#6699cc; border-top:1px solid #6699cc;  border-bottom:1px solid #6699cc; padding-top: 2px; padding-bottom:2px; padding-left: 6px; padding-right: 8px; cursor: hand; border-left: 1px solid #ffffff; border-top: 1px solid #ffffff; border-bottom: 0px solid #ffffff; border-right: 1px solid #ffffff;">
	Add Folder
	</div>
	<div id="mnuProcAdd" NOWRAP="true" STYLE="text-align:center; font-size:11px; width:80px; height:20px; color:white; background-color:#6699cc; border-top:1px solid #6699cc;  border-bottom:1px solid #6699cc; padding-top: 2px; padding-bottom:2px; padding-left: 6px; padding-right: 8px; cursor: hand; border-left: 1px solid #ffffff; border-top: 1px solid #ffffff; border-bottom: 1px solid #ffffff; border-right: 1px solid #ffffff;">
	Add Process
	</div>
</div>

<iframe name="hiddenFrame" style="display:none"></iframe>

</body>
</html>


