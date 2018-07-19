<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/html; charset=UTF-8");%>
<%@include file="../../common/no_cache.jsp"%>
<%@include file="../../common/commons.jsp"%>
<%@page import="hanwha.bpm.commons.dao.FolderDAO"%>
<%@page import="hanwha.bpm.form.business.FormBusinessFacade"%>
<%
	String deptSelect = "N";
	String multiSelect = "N";
	String companySelect = "N";
	String treeOption = "N";
	String cTreeImageDir = IMG+"/themes/common/images";

	RequestContext reqCtx = new RequestContext(request);
	FormBusinessFacade formBF = new FormBusinessFacade(reqCtx);	
		
	FolderDAO folderDAO = formBF.getFormRootMenuDAO();
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="<%=CSS%>/admin.css.jsp">	
<link rel="STYLESHEET" type="text/css" href="<%=CSS%>/left.css.jsp">

<script language="javascript" src="<%=JS%>/themes/common/js/left.js" type="text/javascript"></script>
<script language="JAVASCRIPT" src="<%=JS%>/menu_tree.js"></script>
<script type="text/javascript" src="<%=JS%>/css.js"></script>
<style type="text/css">
body{overflow:auto;}
.s1 {position:absolute; font-size:10pt; color:#BFD0EF; visibility:hidden}
</style>
<SCRIPT language="JAVASCRIPT">
<!--
	/***************************************************************************
	 사원목록화면에 결과 표시
	***************************************************************************/
	function goToUserList(Id) {		
		selected('form',Id);
	}

	/***************************************************************************
	 부서노드 클릭시 사원목록화면에 결과 표시
	***************************************************************************/
	var isDebug;
	
	function goToDept(type,Id) {
		isDebug = false;

		if( isFolderClick()) {
			//goToUserList(deptId);
			selected(type,Id);
		}
		
		if( clickedFolder.isChildDataQuery == false ) {
			var goUrl = "./formDynamicTree.jsp?type="+type+"&Id="+Id+"&deptSelect=<%=deptSelect%>&multiSelect=<%=multiSelect%>&treeOption=<%=treeOption%>";
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

	function selected(type, id) {
		selectedInfo.type = type;
		selectedInfo.id = id;
		if ( type == "form" ) {
			viewRole();
		}else{
			return;
		}
	}
	
	function viewRole() {
  		document.roleMenuForm.target = "right";
  		document.roleMenuForm.formId.value = selectedInfo.id;
  		document.roleMenuForm.action = "edit.jsp?action=view";
  		document.roleMenuForm.submit();		
	}
	
	function view() {
		alert(selectedInfo.type + "," + selectedInfo.id);
	}
	
	function addFolder() {
		var url = "folder_update_frame.jsp?action=add&ownCompany=<%=loggedUserCompanyId%>&parentGroupId="+selectedInfo.id;
	    var StrOption ;
	    StrOption  = "dialogWidth:420px;dialogHeight:230px;";
	    StrOption += "center:on;scroll:auto;status:off;resizable:off";	
	    showModalDialog (url , window, StrOption);
	}

	function updateFolder() {
		var url = "folder_update_frame.jsp?action=update&ownCompany=<%=loggedUserCompanyId%>&parentGroupId="+selectedInfo.id;
	    var StrOption ;
	    StrOption  = "dialogWidth:420px;dialogHeight:230px;";
	    StrOption += "center:on;scroll:auto;status:off;resizable:off";	
	    showModalDialog (url , window, StrOption);
	}

	function deleteFolder() {
		var truthBeTold = window.confirm("삭제 하시겠습니까?");
		if (truthBeTold) {
			var url = "folder_delete.jsp?parentGroupId="+selectedInfo.id;
			//alert(url);
		    var StrOption ;
		    StrOption  = "dialogWidth:370px;dialogHeight:150px;";
		    StrOption += "center:on;scroll:auto;status:off;resizable:off";	
		    showModalDialog (url , window, StrOption);
		}
	}	

	function deleteForm(formId) {	
		var deleteAlert = "현재 폼을 삭제하시겠습니까?";	
		var actionType = "del_form";
		
		if(!confirm(deleteAlert)){
			return;
		}
		
		document.delForm.target = "right";
		document.delForm.actionType.value = actionType;
		document.delForm.formId.value=formId;
		document.delForm.action = "form_delete.jsp";
		document.delForm.submit();
	}

	function moveProcess(folderId){
		document.moveProcessForm.process_id.value = folderId;
		document.moveProcessForm.type.value = "moveProc";
		document.moveProcessForm.click.value = "moveProc";
		//show();
	}

	function moveFolder(folderId){
		document.moveProcessForm.process_id.value = folderId;
		document.moveProcessForm.type.value = "moveGroup";
		document.moveProcessForm.click.value = "moveGroup";
		//show();
	}

	function pasteProcess(folderId){
		if (document.moveProcessForm.type.value == "moveProc"){
			document.moveProcessForm.target = "hiddenFrame";
			document.moveProcessForm.folder.value = folderId;
			document.moveProcessForm.submit();
		}else{
			document.moveProcessForm.type.value = "";
			document.moveProcessForm.folder.value = "";
			document.moveProcessForm.process_id.value = "";
		}
	}

	function pasteFolder(folderId){
		if (document.moveProcessForm.type.value == "moveGroup"){
			document.moveProcessForm.target = "hiddenFrame";
			document.moveProcessForm.folder.value = folderId;
			document.moveProcessForm.submit();
		}else{
			document.moveProcessForm.type.value = "";
			document.moveProcessForm.folder.value = "";
			document.moveProcessForm.process_id.value = "";
		}
	}
</script>
<script type="text/javascript">
	function setCursor(){
		if(document.moveProcessForm.click.value == "moveProc" || document.moveProcessForm.click.value == "moveGroup"){
			document.moveProcessForm.click.value = "";
			show();
		}else if(document.moveProcessForm.type.value == "moveProc" || document.moveProcessForm.type.value == "moveGroup"){
			document.moveProcessForm.click.value = "";
			document.moveProcessForm.type.value = "";
			document.moveProcessForm.folder.value = "";
			document.moveProcessForm.process_id.value = "";
			show();
		}else{
			document.moveProcessForm.click.value = "";
			document.moveProcessForm.type.value = "";
			document.moveProcessForm.folder.value = "";
			document.moveProcessForm.process_id.value = "";
			show();
		}
	}

	function clickMenu() {
		treeMenu.releaseCapture();
		treeMenu.style.display="none";
		el=event.srcElement;
		//alert(el.id);
		if (el.id=="mnuAdd") {
			addFolder();
		} else if (el.id=="mnuMod") {
			updateFolder();
		} else if (el.id=="mnuDel") {
			deleteFolder();
		} else if (el.id=="mnuFolderCopy") {
			moveFolder(selectedInfo.id);
		}
	}

	function clickMenu2() {
		treeMenu2.releaseCapture();
		treeMenu2.style.display="none";
		el=event.srcElement;
		//alert(el.id);
		if (el.id=="mnuAdd") {
			addFolder();
		} else if (el.id=="mnuMod") {
			updateFolder();
		} else if (el.id=="mnuDel") {
			deleteFolder();
		} else if (el.id=="mnuDefPaste") {
			pasteProcess(selectedInfo.id);
		}
	}

	function clickMenu3() {
		treeMenu2.releaseCapture();
		treeMenu2.style.display="none";
		el=event.srcElement;
		//alert(el.id);
		if (el.id=="mnuAdd") {
			addFolder();
		} else if (el.id=="mnuMod") {
			updateFolder();
		} else if (el.id=="mnuDel") {
			deleteFolder();
		} else if (el.id=="mnuFolderPaste") {
			pasteFolder(selectedInfo.id);
		}
	}

	function clickMenuDef() {
		treeMenuDef.releaseCapture();
		treeMenuDef.style.display="none";
		el=event.srcElement;
		//alert(el.id);
		if (el.id=="mnuDefCopy") {
			moveProcess(selectedInfo.id);
		} else if (el.id=="mnuDel") {
			deleteForm(selectedInfo.id);
		} 
	}
	
	function treeContextMenu(type, selectedId) {
		if ( type == 'folder' && document.moveProcessForm.type.value == "moveProc") {
			selectedInfo.type = type;
			selectedInfo.id = selectedId;
			whichDiv=event.srcElement;
			treeMenu2.style.posLeft=event.clientX;
			treeMenu2.style.posTop=event.clientY;
			treeMenu2.style.display="block";
			treeMenu2.setCapture();
		} else if ( type == 'folder' && document.moveProcessForm.type.value == "moveGroup") {
			selectedInfo.type = type;
			selectedInfo.id = selectedId;
			whichDiv=event.srcElement;
			treeMenu3.style.posLeft=event.clientX;
			treeMenu3.style.posTop=event.clientY;
			treeMenu3.style.display="block";
			treeMenu3.setCapture();
		} else if ( type == 'folder' ) {
			selectedInfo.type = type;
			selectedInfo.id = selectedId;
			whichDiv=event.srcElement;
			treeMenu.style.posLeft=event.clientX;
			treeMenu.style.posTop=event.clientY;
			treeMenu.style.display="block";
			treeMenu.setCapture();
		} else {
			selectedInfo.type = type;
			selectedInfo.id = selectedId;
			whichDiv=event.srcElement;
			treeMenuDef.style.posLeft=event.clientX;
			treeMenuDef.style.posTop=event.clientY;
			treeMenuDef.style.display="block";
			treeMenuDef.setCapture();
		}
	}
	function contextHighlightRow(obj) {
	
	}
</script>
<style type="text/css">
div.scroll {	
	height:100%; width:240px;	
	overflow: auto;	border: 0px solid #666;	padding: 1px;}
</style>
</head>
<body topmargin="11" leftmargin="10" bottommargin="0" onclick="javascript:setCursor();" oncontextmenu="return false">

<script language="javascript">
var nav = (document.layers);
var tmr = null;
var spd = 50;
var x = 0;
var x_offset = 5;
var y = 0;
var y_offset = 15;
var flag = 6;
var i = 0;

function show(){
	if(nav) document.captureEvents(Event.MOUSEMOVE);

	if(document.moveProcessForm.type.value == "moveProc" || document.moveProcessForm.type.value == "moveGroup"){
		flag = 0;
	}else{
		flag = 6;
	}

	document.onmousemove = get_mouse;
}

function get_mouse(e)
{ 
x = (nav) ? e.pageX : event.clientX+document.body.scrollLeft;
y = (nav) ? e.pageY : event.clientY+document.body.scrollTop;
x += x_offset;
y += y_offset;
beam(flag); 
}

function beam(n)
{
	if(n<5)
	{
		if(nav)
		{ 
			eval("document.div"+n+".top="+y);
			eval("document.div"+n+".left="+x);
			eval("document.div"+n+".visibility='visible'");
		} 
		else
		{
			eval("div"+n+".style.top="+y);
			eval("div"+n+".style.left="+x);
			eval("div"+n+".style.visibility='visible'");
		}
		n++;
		tmr=setTimeout("beam("+n+")",spd);
	}
	else if(n == 6)
	{
		i = 0;
		
		div0.style.visibility = "hidden";
		div1.style.visibility = "hidden";
		div2.style.visibility = "hidden";
		div3.style.visibility = "hidden";
		div4.style.visibility = "hidden";

		if(i<5) {
			if(nav)
			{ 
				eval("document.div"+i+".top="+y);
				eval("document.div"+i+".left="+x);
				eval("document.div"+i+".visibility='hidden'");
			} 
			else
			{
				eval("div"+i+".style.top="+y);
				eval("div"+i+".style.left="+x);
				eval("div"+i+".style.visibility='hidden'");
			}
			i++;
		}
	}
	else
	{
		clearTimeout(tmr);
		fade(4);
	} 
} 

function fade(n)
{
	if(n>0) 
	{
		if(nav)eval("document.div"+n+".visibility='hidden'");
		else eval("div"+n+".style.visibility='hidden'"); 
		n--;
		tmr=setTimeout("fade("+n+")",spd);
	}
	else clearTimeout(tmr);
} 

function refresh() {
	document.location.reload();
}

// -->

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

<div id="div0" class="s1"><img src="<%=IMG%>/tree/xp/file.png" border="0"></div>
<div id="div1" class="s1"><img src="<%=IMG%>/tree/xp/file.png" border="0"></div>
<div id="div2" class="s1"><img src="<%=IMG%>/tree/xp/file.png" border="0"></div>
<div id="div3" class="s1"><img src="<%=IMG%>/tree/xp/file.png" border="0"></div>
<div id="div4" class="s1"><img src="<%=IMG%>/tree/xp/file.png" border="0"></div>

<div class="scroll">

<table border="0" cellspacing="0" cellpadding="0" class="Lwidth" style="width:231">
  <tr id="menuPane0">
    <td colspan="3" height="9">
      <table border="0" cellspacing="0" cellpadding="0" class="Lmenu_box_tbl">
        <tr>
          <td class="Lmenu_box_tdleft"><img src="<%=IMG%>/themes/common/images/admin/LeftBox_top_right.gif" border="0" align="absmiddle"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td class="Lmenu_box_tdcetner" id="menuPane1"><img src="<%=IMG%>/themes/common/images/admin/LeftBox_center_left.gif" border="0" align="absmiddle"></td>
    <td valign="top" id="menuPane2">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <img src="<%=IMG%>/themes/common/images/admin/leftmenu_tit_bpm_fa.gif" border="0"><br><br>
          </td>
        </tr>
        <tr>
          <td class="Lmenu_box_tdcont"></td>
        </tr>
        <tr>
	      <td>
			<table border="0" cellspacing="0" cellpadding="0" width="100%">
				<tr>
					<td class="bold" style="padding-left:5">
						<img src="<%=IMG%>/bull-tri-orange2.gif" border=0 align="absmiddle" style="margin-bottom:3"> 
						폼 리스트 <a href="#"><img onclick="javascript:refresh()" src="<%=IMG%>/but-refresh.gif" border=0 align="absmiddle"></a>
					</td>
				</tr>
			</table>
			<br style="line-height:5px">
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

								nodeId = nType+"_"+nid;						
								String pId = Integer.toString(folderDAO.getParentFolderId().intValue());

								//가상의 최상위 노드를 생성한다.
								if( "-1".equals(pId) ) {
									nodeId = "folder_root";
%>
									<%=nodeId%> = gFld('<%=folderName%>',"","<%=folderOpenSrc%>","<%=folderCloseSrc%>",true, '', '<%=nid%>', '<%=nType%>')
									foldersTree = <%=nodeId%>;
									curFolder   = <%=nodeId%>;
									curFolder.isChildDataQuery = true;

									parentNodeId = "folder_root";
<%
								}else {
									parentNodeId = "folder_"+pId;

									if(nType.equals("form")){
										folderOpenSrc = "form-big.gif";
										folderCloseSrc = "form-big.gif";
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
									
									<%=nodeId%> = insFld(parentFolder, gFld('<%=folderName%>', "goToDept(\"<%=nType%>\",\"<%=nid%>\")","<%=folderOpenSrc%>","<%=folderCloseSrc%>",<%=isDynamicTree%>, '',"<%=nid%>",'<%=nType%>'))
									<%=nodeId%>.isChildDataQuery = false
									<%=nodeId%>.isLastNode = 0									
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
			
	      
	      </td>
        </tr>
      </table>
    </td>
    <td width="6" background="<%=IMG%>/themes/common/images/admin/LeftBox_center_right.gif">
		<table border="0" cellspacing="0" cellpadding="0">
	        <tr><td><a href="javascript:closeMenu();"><img src="<%=IMG%>/themes/common/images/admin/frame_locator_l.gif" border="0" width="12" height="30" align="center"/></a></td></tr>
	        <tr><td style="height:1px;"></td></tr>
	        <tr><td><a href="javascript:openMenu();"><img src="<%=IMG%>/themes/common/images/admin/frame_locator_r.gif" border="0" width="12" height="30" align="center"/></a></td></tr>
      	</table>    	
    </td>
  </tr>
			<form name="roleMenuForm" method="POST">
			<input type="hidden" name="formId">
			<input type="hidden" name="ownCompany" value="<%=loggedUserCompanyId%>">
			</form>
			<form name=moveProcessForm action="moveProcess.jsp" method="POST">
				<input type="hidden" name="folder">
				<input type="hidden" name="process_id">
				<input type="hidden" name="type">
				<input type="hidden" name="click">
			</form>
			<form name=delForm action="form_delete.jsp" method="POST">
				<input type="hidden" name="actionType">
				<input type="hidden" name="formId">
			</form>  
</table>

</div>

<script>
	function closeMenu() {
		menuPane0.style.display = "none";
		menuPane1.style.display = "none";
		menuPane2.style.display = "none";
		window.parent.mainFrameSet.cols="21,*";
	}
	
	function openMenu() {
		menuPane0.style.display = "block";
		menuPane1.style.display = "block";
		menuPane2.style.display = "block";
		window.parent.mainFrameSet.cols="255,*";
	}
	
	openMenu();
</script>

<div id=treeMenu onclick="clickMenu()" style="position:absolute;display:none;background-color: #6699cc;border:1px solid #99ccff;">
	<div id="mnuAdd" NOWRAP="true" STYLE="text-align:center; font-size:11px; width:110px height:20px; color:white; background-color:#6699cc; border-top:1px solid #6699cc;  border-bottom:1px solid #6699cc; padding-top: 2px; padding-bottom:2px; padding-left: 6px; padding-right: 8px; cursor: hand; border-left: 1px solid #ffffff; border-top: 1px solid #ffffff; border-bottom: 0px solid #ffffff; border-right: 1px solid #ffffff;">
	추가
	</div>
	<div id="mnuMod" NOWRAP="true" STYLE="text-align:center; font-size:11px; width:110px height:20px; color:white; background-color:#6699cc; border-top:1px solid #6699cc;  border-bottom:1px solid #6699cc; padding-top: 2px; padding-bottom:2px; padding-left: 6px; padding-right: 8px; cursor: hand; border-left: 1px solid #ffffff; border-top: 1px solid #ffffff; border-bottom: 0px solid #ffffff; border-right: 1px solid #ffffff;">
	수정
	</div>
	<div id="mnuDel" NOWRAP="true" STYLE="text-align:center; font-size:11px; width:110px height:20px; color:white; background-color:#6699cc; border-top:1px solid #6699cc;  border-bottom:1px solid #6699cc; padding-top: 2px; padding-bottom:2px; padding-left: 6px; padding-right: 8px; cursor: hand; border-left: 1px solid #ffffff; border-top: 1px solid #ffffff; border-bottom: 0px solid #ffffff; border-right: 1px solid #ffffff;">
	삭제
	</div>
	<div id="mnuFolderCopy" NOWRAP="true" STYLE="text-align:center; font-size:11px; width:110px height:20px; color:white; background-color:#6699cc; border-top:1px solid #6699cc;  border-bottom:1px solid #6699cc; padding-top: 2px; padding-bottom:2px; padding-left: 6px; padding-right: 8px; cursor: hand; border-left: 1px solid #ffffff; border-top: 1px solid #ffffff; border-bottom: 1px solid #ffffff; border-right: 1px solid #ffffff;">
	Folder 잘라내기
	</div>
</div>

<div id=treeMenu2 onclick="clickMenu2()" style="position:absolute;display:none;background-color: #6699cc;border:1px solid #99ccff;">
	<div id="mnuAdd" NOWRAP="true" STYLE="text-align:center; font-size:11px; width:110px height:20px; color:white; background-color:#6699cc; border-top:1px solid #6699cc;  border-bottom:1px solid #6699cc; padding-top: 2px; padding-bottom:2px; padding-left: 6px; padding-right: 8px; cursor: hand; border-left: 1px solid #ffffff; border-top: 1px solid #ffffff; border-bottom: 0px solid #ffffff; border-right: 1px solid #ffffff;">
	추가
	</div>
	<div id="mnuMod" NOWRAP="true" STYLE="text-align:center; font-size:11px; width:110px height:20px; color:white; background-color:#6699cc; border-top:1px solid #6699cc;  border-bottom:1px solid #6699cc; padding-top: 2px; padding-bottom:2px; padding-left: 6px; padding-right: 8px; cursor: hand; border-left: 1px solid #ffffff; border-top: 1px solid #ffffff; border-bottom: 0px solid #ffffff; border-right: 1px solid #ffffff;">
	수정
	</div>
	<div id="mnuDel" NOWRAP="true" STYLE="text-align:center; font-size:11px; width:110px height:20px; color:white; background-color:#6699cc; border-top:1px solid #6699cc;  border-bottom:1px solid #6699cc; padding-top: 2px; padding-bottom:2px; padding-left: 6px; padding-right: 8px; cursor: hand; border-left: 1px solid #ffffff; border-top: 1px solid #ffffff; border-bottom: 0px solid #ffffff; border-right: 1px solid #ffffff;">
	삭제
	</div>
	<div id="mnuDefPaste" NOWRAP="true" STYLE="text-align:center; font-size:11px; width:110px height:20px; color:white; background-color:#6699cc; border-top:1px solid #6699cc;  border-bottom:1px solid #6699cc; padding-top: 2px; padding-bottom:2px; padding-left: 6px; padding-right: 8px; cursor: hand; border-left: 1px solid #ffffff; border-top: 1px solid #ffffff; border-bottom: 1px solid #ffffff; border-right: 1px solid #ffffff;">
	Process 붙여넣기
	</div>
</div>

<div id=treeMenu3 onclick="clickMenu3()" style="position:absolute;display:none;background-color: #6699cc;border:1px solid #99ccff;">
	<div id="mnuAdd" NOWRAP="true" STYLE="text-align:center; font-size:11px; width:110px height:20px; color:white; background-color:#6699cc; border-top:1px solid #6699cc;  border-bottom:1px solid #6699cc; padding-top: 2px; padding-bottom:2px; padding-left: 6px; padding-right: 8px; cursor: hand; border-left: 1px solid #ffffff; border-top: 1px solid #ffffff; border-bottom: 0px solid #ffffff; border-right: 1px solid #ffffff;">
	추가
	</div>
	<div id="mnuMod" NOWRAP="true" STYLE="text-align:center; font-size:11px; width:110px height:20px; color:white; background-color:#6699cc; border-top:1px solid #6699cc;  border-bottom:1px solid #6699cc; padding-top: 2px; padding-bottom:2px; padding-left: 6px; padding-right: 8px; cursor: hand; border-left: 1px solid #ffffff; border-top: 1px solid #ffffff; border-bottom: 0px solid #ffffff; border-right: 1px solid #ffffff;">
	수정
	</div>
	<div id="mnuDel" NOWRAP="true" STYLE="text-align:center; font-size:11px; width:110px height:20px; color:white; background-color:#6699cc; border-top:1px solid #6699cc;  border-bottom:1px solid #6699cc; padding-top: 2px; padding-bottom:2px; padding-left: 6px; padding-right: 8px; cursor: hand; border-left: 1px solid #ffffff; border-top: 1px solid #ffffff; border-bottom: 0px solid #ffffff; border-right: 1px solid #ffffff;">
	삭제
	</div>
	<div id="mnuFolderPaste" NOWRAP="true" STYLE="text-align:center; font-size:11px; width:110px height:20px; color:white; background-color:#6699cc; border-top:1px solid #6699cc;  border-bottom:1px solid #6699cc; padding-top: 2px; padding-bottom:2px; padding-left: 6px; padding-right: 8px; cursor: hand; border-left: 1px solid #ffffff; border-top: 1px solid #ffffff; border-bottom: 1px solid #ffffff; border-right: 1px solid #ffffff;">
	Folder 붙여넣기
	</div>
</div>

<div id=treeMenuDef onclick="clickMenuDef()" style="position:absolute;display:none;background-color: #6699cc;border:1px solid #99ccff;">
	<div id="mnuDel" NOWRAP="true" STYLE="text-align:center; font-size:11px; width:110px; height:20px; color:white; background-color:#6699cc; border-top:1px solid #6699cc;  border-bottom:1px solid #6699cc; padding-top: 2px; padding-bottom:2px; padding-left: 6px; padding-right: 8px; cursor: hand; border-left: 1px solid #ffffff; border-top: 1px solid #ffffff; border-bottom: 0px solid #ffffff; border-right: 1px solid #ffffff;">
	삭제
	</div>
	<div id="mnuDefCopy" NOWRAP="true" STYLE="text-align:center; font-size:11px; width:110px; height:20px; color:white; background-color:#6699cc; border-top:1px solid #6699cc;  border-bottom:1px solid #6699cc; padding-top: 2px; padding-bottom:2px; padding-left: 6px; padding-right: 8px; cursor: hand; border-left: 1px solid #ffffff; border-top: 1px solid #ffffff; border-bottom: 1px solid #ffffff; border-right: 1px solid #ffffff;">
	Process 잘라내기
	</div>
</div>

<iframe name="hiddenFrame" style="display:none"></iframe>

</body>
</html>


