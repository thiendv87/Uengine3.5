<%@page pageEncoding="KSC5601"%>
<%@page import="hanwha.commons.Constants"%>
<%response.setContentType("text/html; charset="+Constants.ENCODING+"\"");%>
<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Process Definitions</title>
<LINK REL="stylesheet" href="../css/portlet.css" type="text/css"/>	
<LINK REL="stylesheet" href="../css/portal.css" type="text/css"/>	
<LINK REL="stylesheet" href="../css/groupware.css" type="text/css"/>
<LINK rel="stylesheet" href="../css/xtree.css" type="text/css"/>
<LINK REL="stylesheet" href="../css/common.css" type="text/css">
<script type="text/javascript" src="../script/xtree.js"></script>
<script type="text/javascript" src="../script/xmlextras.js"></script>
<script type="text/javascript" src="../script/xloadtree.js"></script>
<script type="text/javascript">
	// 선택된 정보 클래스
	function SelectedInfo() {
		var type = '';
		var id = '';
		var name = '';
		var key = '';
		var desc = '';
	}
	var selectedInfo = new SelectedInfo();

	function selected(type, id) {
		if ( type == 'version' ) view(id, "");
	}
</script>	
<script>
	function view(name, folder){
		document.viewForm.processDefinition.value=name;
		document.viewForm.folder.value=folder;		
		document.viewForm.submit();
	}
	
	function addFolder(parent){
		var folderName = prompt("Enter new folder name :");	
		if ( folderName != null && folderName != 'undefined' && folderName.length > 0 ) {
			document.addFolderForm.target = "hiddenFrame";
			document.addFolderForm.folderName.value=folderName;
			document.addFolderForm.parentFolder.value=parent;		
			document.addFolderForm.submit();
		}
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
			document.addProcessForm.target = "hiddenFrame";
			document.addProcessForm.folder.value = selectedInfo.id;
			document.addProcessForm.submit();
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
</head>
<body>

<form name=viewForm action="viewProcessFlowChart.jsp" method="POST" target=innerworkarea>
	<input type=hidden name="processDefinition">
	<input type=hidden name="folder">
</form>
<form name=addFolderForm action="addFolder.jsp" method="POST">
 	<input type=hidden name="folderName">
	<input type=hidden name="parentFolder">
</form>
<form name=addProcessForm action="ProcessDesigner.jnlp" method="POST">
	<input type="hidden" name="folder">
</form>	

<body text="black" link="blue" vlink="purple" alink="red" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table border="0" cellpadding="0" cellspacing="0" width="100%" class="color_gw_menu_bg">
	<tr>
		<td background="../images/back_g.gif">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tb_write">						
				<tr>
					<td height="57" background="../images/menu_img_admin.gif">
						<table border="0" cellpadding="0" cellspacing="0" width="100%">	
							<tr>
								<td width="52"></td>
								<td>
									<table border="0" cellpadding="0" cellspacing="0" width="100%">	
										<tr>
											<td><b><font size="3">업무 정의</font></b></td>
										</tr>
										<tr>
											<td><font size="2">Process Definition</font></td>
										</tr>
									</table>									
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="border_menu_child" id="chld_read" style="padding-left:3px;"></td>
				</tr>
				<tr>
					<td class="border_menu_child" id="chld_read" style="padding-left:3px;"></td>
				</tr>
				<tr>
					<td class="border_menu_child" id="chld_mailbox" style="padding-left:3px;" background="../images/back_g.gif">
						<table border="0" cellpadding="0" cellspacing="0" id="tb_1" style="margin:0px;" xmlns>
							<tr>
								<td height="10" style="padding-left:3px;"></td>
							</tr>
							<tr style="display:block;">
								<td>
								<div id="processLine" overflow:scroll; style="display:block" width="182" cellspacing="0" cellpadding="0">

<font size=-1 face='Tahoma'><b>업무 리스트</b> [
<a href="javascript:document.location.reload()"><img src="../images/refresh.gif" alt="새로고침" border=0></a>
]</font><br>
<script type="text/javascript">
webFXTreeConfig.rootIcon		= "../images/xp/folder.png";
webFXTreeConfig.openRootIcon	= "../images/xp/folder.png";
webFXTreeConfig.folderIcon		= "../images/xp/folder.png";
webFXTreeConfig.openFolderIcon	= "../images/xp/openfolder.png";
webFXTreeConfig.fileIcon		= "../images/xp/folder.png";
webFXTreeConfig.lMinusIcon		= "../images/xp/Lminus.png";
webFXTreeConfig.lPlusIcon		= "../images/xp/Lplus.png";
webFXTreeConfig.tMinusIcon		= "../images/xp/Tminus.png";
webFXTreeConfig.tPlusIcon		= "../images/xp/Tplus.png";
webFXTreeConfig.iIcon			= "../images/xp/I.png";
webFXTreeConfig.lIcon			= "../images/xp/L.png";
webFXTreeConfig.tIcon			= "../images/xp/T.png";
webFXTreeConfig.blankIcon       = "../images/xp/blank.png";

webFXTreeConfig.usePersistence  = true;
webFXTreeConfig.useContextMenu  = true;

var tree = new WebFXLoadTree("<%=hanwha.bpm.util.SessionUtil.getCompName(request)%>", "processDefinitionAllListXML.jsp", "javascript:selected('folder', -1);");
tree.setBehavior("classic");
document.write(tree);
tree.expand();
</script>								
								</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>						
		</td>
	</tr>
	<tr>
		<td height="600" background="../images/back_g.gif">
	</tr>
</table>

<div id=treeMenu onclick="clickMenu()" style="position:absolute;display:none;background-color: #6699cc;border:1px solid #99ccff;">
	<div id="mnuFolderAdd" NOWRAP="true" STYLE="text-align:center; font-size:11px; width:80px; height:20px; color:white; background-color:#6699cc; border-top:1px solid #6699cc;  border-bottom:1px solid #6699cc; padding-top: 2px; padding-bottom:2px; padding-left: 6px; padding-right: 8px; cursor: hand; border-left: 1px solid #ffffff; border-top: 1px solid #ffffff; border-bottom: 0px solid #ffffff; border-right: 1px solid #ffffff;">
	Add Folder
	</div>
	<div id="mnuProcAdd" NOWRAP="true" STYLE="text-align:center; font-size:11px; width:80px; height:20px; color:white; background-color:#6699cc; border-top:1px solid #6699cc;  border-bottom:1px solid #6699cc; padding-top: 2px; padding-bottom:2px; padding-left: 6px; padding-right: 8px; cursor: hand; border-left: 1px solid #ffffff; border-top: 1px solid #ffffff; border-bottom: 1px solid #ffffff; border-right: 1px solid #ffffff;">
	Add Process
	</div>
	<!--
	<div id="mnuDel" NOWRAP="true" STYLE="text-align:center; font-size:11px; width:80px; height:20px; color:white; background-color:#6699cc; border-top:1px solid #6699cc;  border-bottom:1px solid #6699cc; padding-top: 2px; padding-bottom:2px; padding-left: 6px; padding-right: 8px; cursor: hand; border-left: 1px solid #ffffff; border-top: 1px solid #ffffff; border-bottom: 1px solid #ffffff; border-right: 1px solid #ffffff;">
	삭제
	</div>
	-->
</div>

<iframe name="hiddenFrame" style="display:none"></iframe>

</body>
</html>


