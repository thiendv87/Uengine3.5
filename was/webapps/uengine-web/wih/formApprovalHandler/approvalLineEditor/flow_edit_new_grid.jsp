<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="../../../common/header.jsp"%>
<%@include file="../../../common/getLoggedUser.jsp"%>
<%@include file="../../../common/styleHeader.jsp"%>
<%@include file="portalConst.jsp"%>
<%@ page import="org.uengine.kernel.*"%>
<%@ page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@ page import="java.sql.*"%>


<%
	String multiple = request.getParameter("multiple");
	String isChangeApprovalLine = request.getParameter("isChangeApprovalLine");
    request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<HTML>
<HEAD>
	<TITLE>결재자 그리드</TITLE>
	<link rel="stylesheet" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/global.css" type="text/css">
	<link href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/basic.css" rel="stylesheet" type="text/css">
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

			if(checkbox.length==null){
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
	
	
		var selectedOrganizationList = new Array();
		var inpuName = "";
		
		//추가오후 4:23
		function addToApprovalLine_1(){
			var approvalType = document.getElementsByName("approvalType");
			
			var selectedType = "1";
			var type = "결재";
			var preConfirm = "불가능";
			var status = "미결";
			
			/*
			for(var i=0; i<approvalType.length; i++) {
				if (approvalType[i].checked) {
					selectedType = approvalType[i].value;
					type = approvalType[i].text;
				}
			}
				
			if(selectedType == "1"){	type = "결재";	}
			if(selectedType == "21"){	type = "동의";	}
			*/
			
			
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
				var jikname		= userInfo.title;
				var jikName		= userInfo.jikName;
				var tpye		= userInfo.tpye;
				var preConfirm	= userInfo.preConfirm;
				var isBirthday	= userInfo.status;
				var isMale		= "0";
				var birthday	= "";
				
				chk = "Y";

				if(userInfo.id != null)
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
		
		function dTypeChg(row){
			var data_type  = document.all.data_type;
			var data_type1 = document.all.data_type1;
			if(data_type.length>1){
				if(data_type[row].value == "1"){
					data_type1[row].disabled = false;
				}else if(data_type[row].value == "21"){
					data_type1[row].disabled = true;
				}
			}else if(data_type.length==1){
				if(data_type.value == "1"){
					data_type1.disabled = false;
				}else if(data_type.value == "21"){
					data_type1.disabled = true;
				}
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
			tdHTML[1]  = "<input type='hidden' name='activityStatus' value='Ready'><td width=1 height='22' ></td>" ;		
			tdHTML[2]  = "<span id='no' title='" + deptname + "'>" + (parseInt(cnt_count)+1) + "</span>" ;
			tdHTML[3]  = "<td width=1 ></td>" ;
			tdHTML[4]  = "<span id='d_name' title='" + deptname + "'>" + name + 
						 "</span><input type='hidden' name='data_code' value='"+id+
						 "'><input type='hidden' name='data_name' value='" + name + "'>";
			tdHTML[5]  = "<td width=1 ></td>" ;
			tdHTML[6]  = "<span id='d_jik' title='" + deptname + "'>" + jikname + 
						 "</span><input type='hidden' name='data_jik'  value='"+jikname+"' >";	
			tdHTML[7]  = "<td width=1 ></td>" ;
			//tdHTML[8]  = "<span id='d_type' title='" + deptname + "'>"+type+
			//			 "</span><input type='hidden' name='data_type' value='"+type+"'>";	
			tdHTML[8]  = "<span id='d_type' style='display:none;'></span><select name='data_type' onchange='dTypeChg("+cnt_count+")'><option value='1'>결재</option><option value='21'>동의</option></select>";
			tdHTML[9]  = "<td width=1 ></td>" ;

			fixedTdHTML[0]  = "";
			fixedTdHTML[1]  = "<td width=1 height='22' ></td>" ;		
			fixedTdHTML[2]  = "<span id='no' title='" + deptname + "'>" + (parseInt(cnt_count)+1) + "</span>" ;
			fixedTdHTML[3]  = "<td width=1 ></td>" ;
			fixedTdHTML[4]  = "<span id='d_name' title='" + deptname + "'>" + name + "</span>";
			fixedTdHTML[5]  = "<td width=1 ></td>" ;
			fixedTdHTML[6]  = "<span id='d_jik' title='" + deptname + "'>" + jikname + "</span>";	
			fixedTdHTML[7]  = "<td width=1 ></td>" ;
			
			fixedTdHTML[8]  = "<span id='d_type' style='display:none;'></span><select name='data_type'><option value='1' " + strNo + ">결재</option><option value='21' " + strYes + ">동의</option></select>";
			//fixedTdHTML[8] = "<span id='d_type' title='" + deptname + "'>"+type+ "</span>";	
			fixedTdHTML[9] = "<td width=1 ></td>" ;
			
			
			var strNo = "selected";
			var strYes = "";
			
			if(preConfirm == "yes"){
				strNo = "";
				strYes = "selected";
			}else{
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
			//var disableStr = disableStr = (type == "동의") ?	"disabled" : "";
			//var selectHTML = "<span id='d_type1' style='display:none;'></span><select name='data_type1' " + disableStr + "><option value='no' " + strNo + ">불가능</option><option value='yes' " + strYes + ">가능</option></select>";
			var selectHTML = "<span id='d_type1' style='display:none;'></span><select name='data_type1'><option value='no' " + strNo + ">불가능</option><option value='yes' " + strYes + ">가능</option></select>";
			
			tdHTML[10] = selectHTML;
			tdHTML[11] = "<td width=1 ></td>" ;
			tdHTML[12] = "<span id='d_type2' title='" + deptname + "'>"+status+
						 "</span><input type='hidden' name='data_type2' value='"+status+"'>";
			tdHTML[13] = "<td width=1 ></td>" ;
			tdHTML[14] = "<span id='d_dept' style='display:none;'></span><input type='hidden' name='data_dept' value='"+deptname+"'>";

			fixedTdHTML[10] = selectHTML;
			fixedTdHTML[11] = "<td width=1 ></td>" ;
			fixedTdHTML[12] = "<span id='d_type2' title='" + deptname + "'>" + status + "</span>";
			fixedTdHTML[13] = "<td width=1 ></td>" ;
			fixedTdHTML[14] = "<span id='d_dept' style='display:none;'></span>";
			
			tdAlign[0]  = "center";
			tdAlign[1]  = "center";
			tdAlign[2]  = "center";
			tdAlign[3]  = "center";
			tdAlign[4]  = "center";
			tdAlign[5]  = "center";
			tdAlign[6]  = "center"; 
			tdAlign[7]  = "center"; 
			tdAlign[8]  = "center";
			tdAlign[9]  = "center";
			tdAlign[10] = "center";
			tdAlign[11] = "center";
			tdAlign[12] = "center";
			tdAlign[13] = "center"; 
			tdAlign[14] = "center"; 

			frm.cnt.value = cnt_count;        
					
			CreateTR('insert_table', tdHTML, '', tdAlign, null); 

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
			tdHTML[1]  = "<td width=1 height='22' ></td>" ;		
			tdHTML[2]  = "<span id='no' title='" + deptname + "'>" + (parseInt(cnt_count)+1) + "</span>" ;
			tdHTML[3]  = "<td width=1 ></td>" ;
			tdHTML[4]  = "<span id='d_name' title='" + deptname + "'>" + name + 
						"</span>";
			tdHTML[5]  = "<td width=1 ></td>" ;
			tdHTML[6]  = "<span id='d_jik' title='" + deptname + "'>" + jikname + 
						"</span>";	
			tdHTML[7]  = "<td width=1 ></td>" ;
			tdHTML[8] = "<span id='d_type' title='" + deptname + "'>"+type+
						"</span>";	
			tdHTML[9] = "<td width=1 ></td>" ;
			
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
			
			tdHTML[10] = selectHTML;
			tdHTML[11] = "<td width=1 ></td>" ;
			tdHTML[12] = "<span id='d_type2' title='" + deptname + "'>"+status+
						 "</span>";
			tdHTML[13] = "<td width=1 ></td>" ;
			tdHTML[14] = "<span id='d_dept' style='display:none;'></span>";
			
			tdAlign[0]  = "center";
			tdAlign[1]  = "center";
			tdAlign[2]  = "center";
			tdAlign[3]  = "center";
			tdAlign[4]  = "center";
			tdAlign[5]  = "center";
			tdAlign[6]  = "center"; 
			tdAlign[7]  = "center"; 
			tdAlign[8]  = "center";
			tdAlign[9]  = "center";
			tdAlign[10] = "center";
			tdAlign[11] = "center";
			tdAlign[12] = "center";
			tdAlign[13] = "center"; 
			tdAlign[14] = "center"; 

			CreateTR('insert_table', tdHTML, '', tdAlign, null); 
		}
		
		//row 생성
		function CreateTR(tbl, tdHtml, tdCls, tdAlign, position) {
			var pos		= 0;
			var grp		= document.all[tbl];
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
								//document.all.no[i].innerHTML = idxv - i;
								document.all.no[i].innerHTML = i+1;
							}
						}else {
							frm.chk_data.value = 1;	
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
						if( row > 2){
							
							//위,아래 함수호출
							innerRow(i,"+");
							
							chk = "Y";						
						} else if(row == 2) {
							alert("기안자와 위치를 변경할 수 없습니다.");
							chk = "Y";
						} else{
							
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
						
						/*
						var row = frm.chk_data[i].value;
						if( row != (cnt_count - 1)){
							
							//위,아래 함수호출
							innerRow(i,"-");						
							chk = "Y";		
							break;
							
						} else {
							alert("기안자와 위치를 변경할 수 없습니다.");
							chk = "Y";
						}
						*/
						if(i==cnt_count-1){alert("이동할 수 없습니다."); chk = "Y"; break;}
						innerRow(i,"-");						
						chk = "Y";		
						break;
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
				if(frm.chk_data[ii].value == ""){
					alert("이동할 수  없습니다.");
					return;
				}
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
		
		// 결재선 버튼을 표시
		function showApprovalButton() {		
			useButton.innerHTML = approvalButton.innerHTML;		
		}

		function init() {		
			showApprovalButton();
			// 페이지가 로딩되기전 버튼 클릭 등을 막아놓은 변수를 true로 환원함
			// true로 바뀐후에는 페이지의 모든 링크가 정상적으로 동작함
			// by Sunny 2006.2.23
			parent.clickEnableApproval = true;
		}
		

	</script>
</HEAD>

<BODY leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="init();">

<div id="flow" style="display:">
	<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<TD width="14%" valign="top">
				<!--중앙 라디오버튼(결재, 동의, 선임계리사, 준법감시담당) -->
				<div id="useButton"></div>
			</td>
			<TD width="350">
			<!-- RIGHT TABLE START -->
				<TABLE width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<TD>
							<TABLE cellpadding="0" cellspacing="0" border="0" width="100%">
								<TR>
									<TD><span class="sectiontitle">결재선</span></TD>
									<TD width="3" align="right">
                                    	<TABLE cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <TD class="space_left_right2">
                                                    <a href="javascript: gridRowMoveUp_1();">
                                                        <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/ico_btn/btn2_14.gif" border="0">&nbsp;
                                                    </a>
                                                </td>
                                                <TD class="space_left_right2">
                                                    <a href="javascript: gridRowMoveDown_1();">
                                                        <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/ico_btn/btn3_03.gif" border="0">&nbsp;
                                                    </a>
                                                </td>
                                                <TD width="10%"></TD>
                                                <!-- 
                                                <TD class="space_left_right2">
                                                	<a href="javascript: delAllFromApprovalLine();">
                                                    	<img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/ico_btn/btn2_07.gif">
                                                    </a>
                                                </TD>
                                                 -->
                                                <TD class="space_left_right2">
                                                </TD>
                                            </tr>
                                        </table>
                                    </TD>
								</TR>
							</TABLE>
						</TD>	
					</tr>
					
					<TR>
						<TD>
							<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="tableborder" style="height:324px;">
								<tr height="1">
									<td valign="top">
										<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
											<tr class="tabletitle" align="center" height="26">
												<td width="20" align="center" class="pop_list_t">&nbsp;</td>
												<td class="pop_list_t2"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/pop_line.gif" width="1" height="22"></td>
												<td width="25" align="center" class="pop_list_t">NO</td>
												<td class="pop_list_t2"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/pop_line.gif" width="1" height="22"></td>
												<td width="50" align="center" class="pop_list_t">이름</td>
												<td class="pop_list_t2"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/pop_line.gif" width="1" height="22"></td>
												<td width="40" align="center" class="pop_list_t">직책</td>
												<!--
												<td class="pop_list_t2"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/pop_line.gif" width="1" height="12"></td>
												<td width="50" align="center" class="pop_list_t">부서</td>
												-->
												<td class="pop_list_t2"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/pop_line.gif" width="1" height="22"></td>
												<td width="60" align="center" class="pop_list_t">결재형식</td>
												<td class="pop_list_t2"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/pop_line.gif" width="1" height="22"></td>
												<td width="49" align="center" class="pop_list_t">전결</td>
												<td class="pop_list_t2"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/pop_line.gif" width="1" height="22"></td>
												<td width="40" align="center" class="pop_list_t">상태</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>								
									<td valign="top">
										<form name="insert_form" >
										<input type="hidden" name="cnt" >
										<input type="hidden" name="initype" value='<%=request.getParameter("initype") %>'>
										<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id='insert_table'  >
											<col width='20'>
											<col width='1'>
											<col width='25'>
											<col width='1'>
											<col width='50'>
											<col width='1'>
											<col width='40'>
											<col width='1'>
											<col width='60'>
											<col width='1'>
											<col width='49'>
											<col width='1'>
											<col width='40'>
<%
	
		String empno          = request.getParameter("empno");
		String activityStatus = request.getParameter("activityStatus");
		String type           = request.getParameter("appvtype");
		String status  = "hold";
		String d_type  = "";
		String d_type1 = "";
		String d_type2 = "";
		java.sql.Connection con = null;
		PreparedStatement prepStmt = null;
		ResultSet rs = null;
		
		try {
			if(empno != null && !"".equals(empno)){
				String[] empnoList          = empno.split(";");
				String[] activityStatusList = activityStatus.split(";");
				String[] typeList           = type.split(";");
			
				con = DefaultConnectionFactory.create().getConnection();
			
				for(int i=0; i<empnoList.length; i++){
				
					prepStmt = con.prepareStatement("SELECT * FROM EMPTABLE WHERE EMPCODE = ?");
					prepStmt.setString(1, empnoList[i]);
					rs = prepStmt.executeQuery();
					
					if((Activity.STATUS_COMPLETED).equals(activityStatusList[i])){
						status = "unhold";
						d_type2 = (i==0)?"완료":"승인";
					}else if((Activity.STATUS_RUNNING).equals(activityStatusList[i])|| (Activity.STATUS_TIMEOUT).equals(activityStatusList[i])){
						status = "unhold";
						d_type2 = "진행중";
					}else if((FormApprovalActivity.SIGN_DRAFT).equals(activityStatusList[i])){
						status = "unhold";
					}else if((FormApprovalActivity.SIGN_APPROVED).equals(activityStatusList[i])){
						status = "unhold";
					}else if((FormApprovalActivity.SIGN_ARBITRARY_APPROVED).equals(activityStatusList[i])){
						status = "unhold";
					}else if((FormApprovalActivity.SIGN_REJECT).equals(activityStatusList[i])){
						status = "unhold";
						d_type2 = "반려";
					}else {
						status = "hold";
						d_type2 = (i==0)?"상신":"미결";
		     		}
					
					while(rs.next()){
					%>
											<tr title="<%=rs.getString("PARTCODE")%>">
												<input type="hidden" name="activityStatus" value="<%=activityStatusList[i] %>">
											<% if(i==0){ %>
												<td height="25" align="center"><input name="chk_data" type="hidden" value='no' ></td>
												<td width="1" align="center"></td>
												<td align="center"><span id="no" ><%=i+1 %></span></td>
												<td width="1" align="center"></td>
												<td align="center">
													<input type="hidden" name="data_code"  value="<%=rs.getString("EMPCODE")%>" >
													<input type="hidden" name="data_name"  value="<%=rs.getString("EMPNAME")%>" >
													<span id='d_name'><%=rs.getString("EMPNAME")%></span>
												</td>
												<td width="1" align="center"></td>
												<td align="center">
													<input type="hidden" name="data_jik"   value="<%=rs.getString("JIKNAME")%>" >
													<input type="hidden" name="data_dept"  value="<%=rs.getString("PARTCODE")%>" >
													<span id='d_jik'><%=rs.getString("JIKNAME")%></span>
													<span id='d_dept'><%=rs.getString("PARTCODE")%></span>
												</td>
												<td width="1" align="center"></td>
												<td align="center">
													<input type="hidden" name="data_type"  value="기안" ><span id='d_type'>기안</span>
												</td>
												<td width="1" align="center"></td>
												<td align="center">
													<input type="hidden" name="data_type1"  value="불가능" ><span id='d_type1'>불가능</span>
												</td>
												<td width="1" align="center"></td>
												<td align="center">
													<input type="hidden" name="data_type2"  value="<%=d_type2 %>" ><span id='d_type2'><%=d_type2 %></span>
												</td>
												
											<%}else{ %>
												<%
												if("hold".equals(status)){
												%>
												<td height="25" align="center"><input type='radio' name='chk_data' value='<%=i+1 %>' style='border:none; background:none;'  ></td>
												<td width="1" align="center"></td>
												<td align="center"><span id="no" ><%=i+1 %></span></td>
												<td width="1" align="center"></td>
												<td align="center">
													<input type="hidden" name="data_code"  value="<%=rs.getString("EMPCODE")%>" >
													<input type="hidden" name="data_name"  value="<%=rs.getString("EMPNAME")%>" >
													<span id='d_name'><%=rs.getString("EMPNAME")%></span>
												</td>
												<td width="1" align="center"></td>
												<td align="center">
													<input type="hidden" name="data_jik"   value="<%=rs.getString("JIKNAME")%>" >
													<input type="hidden" name="data_dept"  value="<%=rs.getString("PARTCODE")%>" >
													<span id='d_jik'><%=rs.getString("JIKNAME")%></span>
													<span id='d_dept'><%=rs.getString("PARTCODE")%></span>
												</td>
												<td width="1" align="center"></td>
												<td align="center">
													<span id='d_type' style='display:none;'></span>
													<select name='data_type' onchange='dTypeChg(<%=i %>)'>
														<option value='1'  <% if("1".equals(typeList[i]))out.print("selected"); %>>결재</option>
														<option value='21' <% if("21".equals(typeList[i]))out.print("selected"); %>>동의</option>
													</select>
												</td>
												<td width="1" align="center"></td>
												<td align="center">
													<span id='d_type1' style='display:none;'></span>
													<select name='data_type1' <% if("21".equals(typeList[i]))out.print("disabled"); %>>
														<option value='no'>불가능</option>
														<option value='yes'>가능</option>
													</select>
												</td>
												<td width="1" align="center"></td>
												<td align="center">
													<input type="hidden" name="data_type2"  value="<%=d_type2 %>" ><span id='d_type2'><%=d_type2 %></span>
												</td>
														 
												<%} else { %>
												<td height="25" align="center"><input name="chk_data" type="hidden" value="no" ></td>
												<td width="1" align="center"></td>
												<td align="center"><span id="no" ><%=i+1 %></span></td>
												<td width="1" align="center"></td>
												<td align="center">
													<input type="hidden" name="data_code"  value="<%=rs.getString("EMPCODE")%>" >
													<input type="hidden" name="data_name"  value="<%=rs.getString("EMPNAME")%>" >
													<span id='d_name'><%=rs.getString("EMPNAME")%></span>
												</td>
												<td width="1" align="center"></td>
												<td align="center">
													<input type="hidden" name="data_jik"   value="<%=rs.getString("JIKNAME")%>" >
													<input type="hidden" name="data_dept"  value="<%=rs.getString("PARTCODE")%>" >
													<span id='d_jik'><%=rs.getString("JIKNAME")%></span>
													<span id='d_dept'><%=rs.getString("PARTCODE")%></span>
												</td>
												<td width="1" align="center"></td>
												<td align="center">
													<input type="hidden" name='data_type' value="<%=typeList[i] %>"><span id='d_type'><%if("1".equals(typeList[i]))out.print("결재");else out.print("동의"); %></span>
												</td>
												<td width="1" align="center"></td>
												<td align="center">
													<input type="hidden" name='data_type1' value="no"><span id='d_type1'>불가능</span>
												</td>
												<td width="1" align="center"></td>
												<td align="center">
													<input type="hidden" name="data_type2"  value="<%=d_type2 %>" ><span id='d_type2'><%=d_type2 %></span>
												</td>	
												<%} %>
											<%} %>
											</tr>
					<%}

        		} 
			}
		}catch (Exception e) {
			throw e;
		}finally{
			if (rs != null) rs.close();
			if (prepStmt != null) prepStmt.close();
			if (con != null) con.close();	
		}
%>										
										</table>
										</form>
									</td>
								</tr>
							</table>
							<p style='margin-top: 8px; '/>
						</td>
					</tr>
				</table>
				<!--/결재자 그리드 -->
			</td>
		</TR>
	</table>
</div>
<iframe id="personalLine" name="personalLine" style="display: none;"></iframe>

</BODY>
</HTML>

<div id="approvalButton" style="visibility: hidden;">
	<TABLE width="80" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td height="110"></td>
		</tr>
		<tr>
			<TD height="30"></TD>
		</tr>
		<tr>
			<td align="center">
				<a href="javascript: addToApprovalLine_1();">
					 <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/b_addR.gif" width="25" height="25">
				</a>
			</td>
		</tr>
		<tr>
			<TD height="5"></TD>
		</tr>
		<TR>
			<TD align="center">
				<a href="javascript: delFromApprovalLine_1();">
					 <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/b_addL.gif" width="25" height="25">
				</a>
			</TD>
		</TR>
	</table>
</div>

<div id="personalButton" style="visibility: hidden;">
	<table border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td><a href="javascript: addPersonalApprovalLine();"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/pop_bt_apply.gif" width="99" height="23" border="0"></a></td>
		</tr>
	</table>
</div>

