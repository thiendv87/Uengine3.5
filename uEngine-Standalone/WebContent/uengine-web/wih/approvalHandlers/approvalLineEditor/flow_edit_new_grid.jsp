<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="../../../common/header.jsp"%>
<%@include file="../../../common/getLoggedUser.jsp"%>
<%@include file="../../../common/styleHeader.jsp"%>
<%@include file="portalConst.jsp"%>
<%@ page import="org.uengine.kernel.*"%>

<%
	String multiple = request.getParameter("multiple");
	String isChangeApprovalLine = request.getParameter("isChangeApprovalLine");
    request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<HTML>
<HEAD>
	<TITLE>결재자 그리드</TITLE>
	<%@ include file="../../../common/styleHeader.jsp"%>
	<%@ include file="../../../scripts/importCommonScripts.jsp"%>
	<%@ include file="../../../lib/jquery/importJquery.jsp"%>
	<script language="javascript">

		// 개인결재선 적용 버튼을 표시
		function showPersonalButton() {
			useButton.innerHTML = personalButton.innerHTML;
		}
	
		function SelectedInfo() {
			var id			= '';
			var name		= '';
			var deptname	= '';
			var jikname		= '';
			var type		= '';
			var preConfirm	= '';
			var status		= '';
			var isMale		= '';
			var birthday	= '';
		}
		
		function getSelectedUsers() {
			var checkbox = parent.document.all.selectUser;
			var j=0;
			selectedOrganizationList = new Array();
			if(checkbox.length==undefined){
				if(checkbox!=null){				
					var user 				= new SelectedInfo();
					var bulkUserInfo 		= checkbox.value;
					var keyAndValuePairs 	= bulkUserInfo.split(";");
					var keyAndValues 		= new Array();
					
					for(k=0; k<keyAndValuePairs.length; k++){
						var keyAndValue = keyAndValuePairs[k].split("=");
						keyAndValues[keyAndValue[0]] = keyAndValue[1];
					}

					user.id 		= keyAndValues["id"];
					user.name		= keyAndValues["name"];
					user.deptname	= keyAndValues["deptname"];
					user.jikname 	= keyAndValues["jikname"];
					user.type 		= keyAndValues["type"];
					user.preConfirm	= keyAndValues["preConfirm"];
					user.status		= keyAndValues["status"];
					user.isMale		= "0";
					user.birthday	= "";
					
					selectedOrganizationList [0] = user;			
				}
			}

			for(i=0; i<checkbox.length; i++){
				if(checkbox[i].checked){
					var user 				= new SelectedInfo();
					var bulkUserInfo 		= checkbox[i].value;
					var keyAndValuePairs 	= bulkUserInfo.split(";");
					var keyAndValues 		= new Array();
	
					for(k=0; k<keyAndValuePairs.length; k++){
						var keyAndValue = keyAndValuePairs[k].split("=");
						keyAndValues[keyAndValue[0]] = keyAndValue[1];
					}

					user.id 		= keyAndValues["id"];
					user.name		= keyAndValues["name"];
					user.deptname	= keyAndValues["deptname"];
					user.jikname 	= keyAndValues["jikname"];
					user.type 		= keyAndValues["type"];
					user.preConfirm	= keyAndValues["preConfirm"];
					user.status		= keyAndValues["status"];
					user.isMale		= "0";
					user.birthday	= "";
	
					selectedOrganizationList [j++] = user;
				}
			}
			return selectedOrganizationList;
		}
	
		function view() {
			//alert(selectedOrganizationInfo.type + "," + selectedOrganizationInfo.id + "," + selectedOrganizationInfo.name + "," + selectedOrganizationInfo.loginName + "," + selectedOrganizationInfo.title);
		}
	
		var selectedOrganizationList = new Array();
		var inpuName = "";
		
		//추가오후 4:23
		function addToApprovalLine_1(){
			var approvalType = document.getElementsByName("approvalType");
			
			var selectedType = "1";
			var type = "결재";
			var preConfirm = "불가능";
			var status = "미결";
					
			for(var i=0; i<approvalType.length; i++) {
				if (approvalType[i].checked) {
					selectedType = approvalType[i].value;
					type = approvalType[i].text;
				}
			}
				
			if(selectedType == "1"){	type = "결재";	}
			if(selectedType == "21"){	type = "동의";	}
			
			var chk = "N";
				
			var selectedUsers = "";
			var searchPlug    = null;//parent.document.all.searchWord.value;

			
			if(searchPlug == null || searchPlug == ""){
				selectedUsers = parent.tree.getSelectedUsers();
			}else{
				selectedUsers = getSelectedUsers();
			}
	
			var size_list = selectedUsers.length;

			for(var i=0; i<size_list; i++) {
				var userInfo = selectedUsers[i];

				var id			= userInfo.id;
				var name		= userInfo.name;
				var deptname	= userInfo.deptname;
				//var jikname		= userInfo.title;
				var jikName		= userInfo.jikName;
				var tpye		= userInfo.tpye;
				var preConfirm	= userInfo.preConfirm;
				var isBirthday	= userInfo.status;
				var isMale		= "0";
				var birthday	= "";
				
				chk = "Y";

				//alert(id+","+name+","+deptname+","+jikName+","+type+","+preConfirm+","+status);
				insert_table_data(id,name,deptname,jikName,type,preConfirm,status);				
			}

			if(chk == "N"){ 
				return; 
			}

			// 결재나 동의가 아닌 경우를 추가하였을 경우 라디오버튼을 default로 '결재'로 세팅함
			if (selectedType!=1&&selectedType!=21) {
				approvalType[0].checked = true;
			}
		}
		
		//추가할 row폼 생성
		function insert_table_data(id,name,deptname,jikname,type,preConfirm,status){
			
			var frm			= document.insert_form;
			var tbl			= "insert_table";									
			var grp			= document.all[tbl];								
			var grpCnt		= document.all[tbl].rows.length;		
			var cnt_count	= parseInt(grpCnt);		
			
			var tdHTML		= new Array();		
			var fixedTdHTML	= new Array();											
			var tdAlign		= new Array();

			tdHTML[0]  = "<input type='radio' name='chk_data' value='"+(parseInt(cnt_count)-1)+"' style='border:none; background:none;'  >";
			tdHTML[1]  = "<span id='no' title='" + deptname + "'>" + (parseInt(cnt_count)+1) + "</span>" ;
			tdHTML[2]  = "<span id='d_name' title='" + deptname + "'>" + name + "</span><input type='hidden' name='data_code' value='" + id + "'><input type='hidden' name='data_name' value='" + name + "'>";
			tdHTML[3]  = "<span id='d_jik' title='" + deptname + "'>" + jikname + "</span><input type='hidden' name='data_jik'  value='"+jikname+"' >";
			tdHTML[4] = "<span id='d_type' title='" + deptname + "'>" + type + "</span><input type='hidden' name='data_type' value='"+type+"'>";

			fixedTdHTML[0]  = "";	
			fixedTdHTML[1]  = "<span id='no' title='" + deptname + "'>" + (parseInt(cnt_count)+1) + "</span>" ;
			fixedTdHTML[2]  = "<span id='d_name' title='" + deptname + "'>" + name + "</span>";
			fixedTdHTML[3]  = "<span id='d_jik' title='" + deptname + "'>" + jikname + "</span>";
			fixedTdHTML[4] = "<span id='d_type' title='" + deptname + "'>"+type+ "</span>";
			
			
			var strNo = "selected";
			var strYes = "";
			
			if(preConfirm == "yes") {
				strNo = "";
				strYes = "selected";
			} else {
				strNo = "selected";
				strYes = "";
			}
/*			
			for(var i=0; i<approvalType.length; i++) {
				if (appovalType(i).checked) {
					if(approvalType(i).value != "21"){
						selectHTML = "<span id='d_type1' style='display:none;'></span><select name='data_type1'><option value='no' " + strNo + ">불가능</option><option value='yes' " + strYes + ">가능</option></select>";
					}else{
						selectHTML = "<span id='d_type1' style='display:none;'></span><select name='data_type1' disabled><option value='no' " + strNo + ">불가능</option><option value='yes' " + strYes + ">가능</option></select>";
					}
				}
			}
*/
			var disableStr = disableStr = (type == "동의") ?	"disabled" : "";
			var selectHTML = "<span id='d_type1' style='display:none;'></span><select name='data_type1' " + disableStr + "><option value='no' " + strNo + ">불가능</option><option value='yes' " + strYes + ">가능</option></select>";
			
			tdHTML[5] = selectHTML;
			tdHTML[6] = "<span id='d_type2' title='" + deptname + "'>" + status + "</span><input type='hidden' name='data_type2' value='"+status+"'>";
			tdHTML[7] = "<span id='d_dept' style='display:none;'></span><input type='hidden' name='data_dept' value='"+deptname+"'>";

			fixedTdHTML[5] = selectHTML;
			fixedTdHTML[6] = "<span id='d_type2' title='" + deptname + "'>" + status + "</span>";
			fixedTdHTML[7] = "<span id='d_dept' style='display:none;'></span>";
			
			tdAlign[0]  = "center";
			tdAlign[1]  = "center";
			tdAlign[2]  = "center";
			tdAlign[3]  = "center";
			tdAlign[4]  = "center";
			tdAlign[5]  = "center";
			tdAlign[6]  = "center"; 
			tdAlign[7]  = "center";

			frm.cnt.value = cnt_count;
					
			CreateTR('insert_table', tdHTML, '', tdAlign,0); 

			var idxv = frm.chk_data.length;	
			
			for(i=0;i<idxv;i++){	
				// 무조건 값을 0부터 차례대로 대입한다.		
				frm.chk_data[i].value=i+1;				
			}
		}

		function insert_table_text(id,name,deptname,jikname,type,preConfirm,status){

			var frm			= document.insert_form;
			var tbl			= "insert_table";									
			var grp			= document.all[tbl];								
			var grpCnt		= document.all[tbl].rows.length;		
			var cnt_count	= parseInt(grpCnt);		
			
			var tdHTML		= new Array();											
			var tdAlign		= new Array();

			tdHTML[0]  = "";
			tdHTML[1]  = "<span id='no' title='" + deptname + "'>" + (parseInt(cnt_count)+1) + "</span>" ;
			tdHTML[2]  = "<span id='d_name' title='" + deptname + "'>" + name + "</span>";
			tdHTML[3]  = "<span id='d_jik' title='" + deptname + "'>" + jikname + "</span>";
			tdHTML[4] = "<span id='d_type' title='" + deptname + "'>" + type + "</span>";
			
			var strNo = "selected";
			var strYes = "";
			
			if(preConfirm == "yes"){
				strNo = "";
				strYes = "selected";
			}else{
				strNo = "selected";
				strYes = "";
			}

			//var disableStr = disableStr = (type == "동의") ?	"disabled" : "";
			var disableStr = "disabled";
			var selectHTML = "<span id='d_type1' style='display:none;'></span><select name='data_type1_temp' " + disableStr + "><option value='no' " + strNo + ">불가능</option><option value='yes' " + strYes + ">가능</option></select>";
			
			tdHTML[5] = selectHTML;
			tdHTML[6] = "<span id='d_type2' title='" + deptname + "'>" + status + "</span>";
			tdHTML[7] = "<span id='d_dept' style='display:none;'></span>";
			
			tdAlign[0]  = "center";
			tdAlign[1]  = "center";
			tdAlign[2]  = "center";
			tdAlign[3]  = "center";
			tdAlign[4]  = "center";
			tdAlign[5]  = "center";
			tdAlign[6]  = "center";
			tdAlign[7]  = "center";

			CreateTR('insert_table', tdHTML, '', tdAlign,0); 
		}
		
		//row 생성
		function CreateTR(tbl, tdHtml, tdCls, tdAlign, position) {
			var pos		= 0;
			var grp		=document.all[tbl];
			var grpCnt	= grp.rows.length;
			var obj;

			pos = (position == null)?grpCnt:position;

			grp.insertRow(pos);

			for (var i=0; i<tdHtml.length; i++) {
				grp.rows[pos].insertCell(i);
				obj = grp.rows[pos].cells[i];
				obj.align = tdAlign[i];
				obj.innerHTML = tdHtml[i];
				obj.focus();

			}
		}
		
		//삭제
		function delFromApprovalLine_1(){
			
			var frm			= document.insert_form;
			var tbl			= "insert_table";									
			var grp			= document.all[tbl];								
			var grpCnt		= document.all[tbl].rows.length;		
			var cnt_count	= parseInt(grpCnt);	
			var chk			= "N";
			
			if(cnt_count > 1){
				for (var i=0; i<cnt_count; i++) {
					if(frm.chk_data[i].checked){
						var row = frm.chk_data[i].value;
						eval("document.all.insert_table.deleteRow("+(parseInt(row)-1)+")");
						chk = "Y";
						var idxv = frm.chk_data.length;	
						
						if(idxv > 1){
							for(i=0;i<idxv;i++){
								// 무조건 값을 0부터 차례대로 대입한다.		
								frm.chk_data[i].value=i+1;						
								document.all.no[i].innerHTML = idxv - i;
							}
						}else {
							frm.chk_data.value=1;	
							document.all.no.innerHTML = 1;						
						}
						break;
					}
				}		
			}
			if(chk == "N"){ alert("삭제할 인원을 선택해주십시요"); return; }
		}

		// 위로 버튼
		function gridRowMoveUp_1() {
			var frm = document.insert_form;
			var tbl = "insert_table";									
			var grp=document.all[tbl];								
			var grpCnt = document.all[tbl].rows.length;		
			var cnt_count = parseInt(grpCnt);	
			var chk = "N";

			if(cnt_count > 1){
				for (var i=0; i<cnt_count; i++) {
					
					if(frm.chk_data[i].checked){
						
						var row = frm.chk_data[i].value;
						if( row != 1){
							
							//위,아래 함수호출
							innerRow(i,"+");
							
							chk = "Y";						
						}
						else {
							chk = "Y";
						}
					}
				}		
			}
			if(chk == "N"){ alert("위로 이동할 인원을 선택해주십시요"); return; }
		}

		// 아래로 버튼
		function gridRowMoveDown_1() {
			var frm = document.insert_form;
			var tbl = "insert_table";									
			var grp = document.all[tbl];								
			var grpCnt = document.all[tbl].rows.length;		
			var cnt_count = parseInt(grpCnt);	
			var chk = "N";

			if(cnt_count > 1){
				for (var i=0; i<cnt_count; i++) {
					
					if(frm.chk_data[i].checked){
						
						var row = frm.chk_data[i].value;
						if( row != (cnt_count - 1)){
							
							//위,아래 함수호출
							innerRow(i,"-");						
							chk = "Y";		
							break;
						}
						else {
							alert("기안자와 위치를 변경할 수 없습니다.");
							chk = "Y";
						}
					}
				}		
			}
			if(chk == "N"){ alert("아래로 이동할 인원을 선택해주십시요"); return; }
		}

		//위,아래 공통
		function innerRow(i,gubun){
			
			var frm = document.insert_form;
			var ii;
			var jj;
			if(gubun == "+" ){
				ii = i-1;
			}
			else {
				ii = i+1;
			}
			
			//상위 데이타를 받아둠
			var code_text  = frm.data_code[ii].value;
			var name_text  = frm.data_name[ii].value;
			var jik_text   = frm.data_jik[ii].value;
			var dept_text  = frm.data_dept[ii].value;
			var type_text  = frm.data_type[ii].value;
			var type1_text = frm.data_type1[ii].value;
			var type1_disp = frm.data_type1[ii].disabled;
			var type2_text = frm.data_type2[ii].value;

			//하위 데이타를 상위데이타에 넣어둠
			frm.data_code[ii].value = frm.data_code[i].value; 
			frm.data_name[ii].value = frm.data_name[i].value; 
			frm.data_jik[ii].value  = frm.data_jik[i].value;  
			frm.data_dept[ii].value = frm.data_dept[i].value; 
			frm.data_type[ii].value = frm.data_type[i].value;
			for(var j=0; j<frm.data_type1[ii].options.length;j++){
				if(frm.data_type1[ii].options[j].value == frm.data_type1[i].value){
					frm.data_type1[ii].options[j].selected = true;
				}
			}
			frm.data_type1[ii].disabled = frm.data_type1[i].disabled;
			frm.data_type2[ii].value    = frm.data_type2[i].value;
			
			frm.chk_data[ii].checked = true;
			document.all.d_name[ii].innerHTML  = frm.data_name[i].value; 
			document.all.d_jik[ii].innerHTML   = frm.data_jik[i].value;  
			document.all.d_dept[ii].innerHTML  = frm.data_dept[i].value; 
			document.all.d_type[ii].innerHTML  = frm.data_type[i].value; 
			document.all.d_type1[ii].innerHTML = frm.data_type1[i].value;
			document.all.d_type2[ii].innerHTML = frm.data_type2[i].value;
			
			//상위데이타를 하위데이타에 넣어둠
			frm.data_code[i].value = code_text;
			frm.data_name[i].value = name_text;
			frm.data_jik[i].value  = jik_text;
			frm.data_dept[i].value = dept_text;
			frm.data_type[i].value = type_text;
			for(var j=0; j<frm.data_type1[i].options.length;j++){
				if(frm.data_type1[i].options[j].value == type1_text){
					frm.data_type1[i].options[j].selected = true;
				}
			}
			frm.data_type1[i].disabled = type1_disp;
			frm.data_type2[i].value = type2_text;
			
			document.all.d_name[i].innerHTML  = name_text;
			document.all.d_jik[i].innerHTML   = jik_text;
			document.all.d_dept[i].innerHTML  = dept_text;
			document.all.d_type[i].innerHTML  = type_text;
			document.all.d_type1[i].innerHTML = type1_text;
			document.all.d_type2[i].innerHTML = type2_text;

			var idxv = frm.chk_data.length;			  
			for(i=0;i<idxv;i++){	
				// 무조건 값을 0부터 차례대로 대입한다.		
				frm.chk_data[i].value=i+1;				
			}
		}

		function init() {
			// 페이지가 로딩되기전 버튼 클릭 등을 막아놓은 변수를 true로 환원함
			// true로 바뀐후에는 페이지의 모든 링크가 정상적으로 동작함
			// by Sunny 2006.2.23
			parent.clickEnableApproval = true;
			
			initAddToApprovalLine_1();
			//window.top.opener.document.forms[0].approvalLine.option
		}
		
		function initAddToApprovalLine_1(){
			var approvalType = document.getElementsByName("approvalType");
			var selectedType 	= "1";
			var type 			= "결재";
			var preConfirm 		= "불가능";
			var status 			= "미결";

			for(var i=0; i<approvalType.length; i++) {
				if (approvalType[i].checked) {
					selectedType = approvalType[i].value;
					type = approvalType[i].text;
				}
			}
			
			if(selectedType == "1"){	type = "결재";	}
			if(selectedType == "21"){	type = "동의";	}
			
			var chk = "N";
			
			//숨겨진 select의 값
			var selectedUsers = window.top.opener.document.forms[0].elements['approvalLine'];
			var size_list = selectedUsers.length;

			for(var i=0; i<size_list; i++) {
				var userInfo    = selectedUsers[i];
				var userInfoStr = userInfo.value.split(";");

				var id			= userInfoStr[0];
				var name		= userInfoStr[1];
				var deptname	= userInfoStr[2];
				var jikname		= userInfoStr[3];
				var type		= userInfoStr[4];
				var preConfirm	= userInfoStr[5];
				status	= userInfoStr[6];
				
				chk = "Y";
				if ( status != "승인" && status != "진행중"){
					insert_table_data(id,name,deptname,jikname,type,preConfirm,status);
				} else {
					insert_table_text(id,name,deptname,jikname,type,preConfirm,status);
				}
			}

			if(chk == "N"){ 
				//alert("추가할 인원을 선택해주십시요"); 
				return; 
			}

			// 결재나 동의가 아닌 경우를 추가하였을 경우 라디오버튼을 default로 '결재'로 세팅함
			if (selectedType!=1&&selectedType!=21) {
				approvalType[0].checked = true;
			}
		}
	</script>
	<style type="text/css">
		body, html {
			margin: 0px;
		}
		
		#useButton {
			float: left;
			width: 70px;
			text-align: center;
			padding: 100px 0px;
		}
		
		#div-grid {
			float: none;
			padding: 5px;
			margin-left: 70px;
		}
		
		.hidden {
			visibility: hidden;
			display: none;
		}
		
		.topbutton {
			padding: 5px;
			height: 25px;
		}
	</style>
</HEAD>

<BODY onLoad="init();">

<div>
	<div id="useButton">
		<p>
			<input name="approvalType" type="radio" value="1"  checked="checked"  style="background:none; border:none;"> 결재
			<br />
			<input name="approvalType" type="radio" class="none" value="21" style="background:none; border:none;"> 동의
		</p>
		<p>
			<a href="javascript: addToApprovalLine_1();">
				 <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/b_addR.gif" width="25" height="25">
			</a>
			<br />
			<a href="javascript: delFromApprovalLine_1();">
				 <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/b_addL.gif" width="25" height="25">
			</a>
		</p>
	</div>
	<div id="div-grid" class="ui-widget-content ui-corner-all">
				<div class="ui-widget ui-state-default ui-corner-all" style="padding: 5px;"> Approval Line </div>
				
				<div>
					<div class="topbutton">
						<a href="javascript: gridRowMoveUp_1();">
						    <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/ico_btn/btn2_14.gif" border="0">&nbsp;
						</a>
						<a href="javascript: gridRowMoveDown_1();">
						    <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/ico_btn/btn3_03.gif" border="0">&nbsp;
						</a>
						<a href="javascript: delFromApprovalLine_1();">
						   	<img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/ico_btn/btn2_07.gif">
						</a>
					</div>
					
					<div class="ui-widget-content ui-corner-all" style=" height: 467px; overflow: auto; padding: 5px;">
										<form name="insert_form" >
										<input type="hidden" name="cnt" />
										<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
											<thead>
												<tr>
												
													<th class="ui-widget ui-state-default">&nbsp;</th>
													<th class="ui-widget ui-state-default">NO</th>
													<th class="ui-widget ui-state-default">이름</th>
													<th class="ui-widget ui-state-default">직책</th>
													<th class="ui-widget ui-state-default">결재형식</th>
													<th class="ui-widget ui-state-default">전결</th>
													<th class="ui-widget ui-state-default">상태</th>
												</tr>
											</thead>
											<tbody id='insert_table'>
<%
	if (!"Y".equals(isChangeApprovalLine)){
%>
												<tr title="<%=loggedUserPartCode%>">
													<td height="25" align="center"><input name="chk_data" type="hidden"  ></td>
													<td align="center"><span id="no" >1</span></td>
													<td align="center">
														<input type="hidden" name="data_code"  value="<%=loggedUserId%>" >
														<input type="hidden" name="data_name"  value="<%=loggedUserFullName%>" >
														<span id='d_name'><%=loggedUserFullName%></span>
													</td>
													<td align="center">
														<input type="hidden" name="data_jik"   value="<%=loggedUserJikName%>" ><%=loggedUserJikName%>
														<input type="hidden" name="data_dept"  value="<%=loggedUserPartCode%>" >
													</td>
													<td align="center">
														<input type="hidden" name="data_type"  value="기안" >기안
													</td>
													<td align="center">불가능
														<input type="hidden" name="data_type1"  value="불가능" >
													</td>
													<td align="center">
														<input type="hidden" name="data_type2"  value="상신" >상신
													</td>
												</tr>
	<%
		}
	%>
											</tbody>
										</table>
										
										</form>
					</div>
					
				</div>
	</div>
</div>
<iframe id="personalLine" name="personalLine" class="hidden"></iframe>

<div id="personalButton" class="hidden">
	<table border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td><a href="javascript: addPersonalApprovalLine();"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/pop_bt_apply.gif" width="99" height="23" border="0"></a></td>
		</tr>
	</table>
</div>

</BODY>
</HTML>



<script language="javascript">
	// 팝업을 띄운 상태에 따라 필요한 버튼만 보이게끔 제어하는 스크립트
	var showTypeStr = "[0][1][2][4][21][22][23][24][25][26][27]";
/*
	if (showTypeStr.indexOf("[22]")!=-1) {
		showType22.style.display = "";
		approvalType(2).checked = true;
	}
	if (showTypeStr.indexOf("[21]")!=-1) {
		showType21.style.display = "";
		approvalType(1).checked = true;
	}
	
	if (showTypeStr.indexOf("[1]")!=-1) {
		showType1.style.display = "";
		approvalType(0).checked = true;
	}
*/
</script>