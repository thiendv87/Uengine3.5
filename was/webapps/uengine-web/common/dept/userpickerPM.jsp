<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="_rdm" type="com.woorifis.srms.core.result.ResultDataManager" scope="request"/>
<jsp:useBean id="_sm" type="com.woorifis.srms.util.SessionManager" scope="request" /> 
<%@page import="com.woorifis.srms.common.bean.DeptBean"%>
<%@page import="com.woorifis.srms.common.bean.CodeBean"%>
<%@page import="java.util.List"%>
<%@page import="com.woorifis.srms.util.StringUtil"%>
<%@page import="com.woorifis.srms.util.EncodeUtil"%>
<%@page import="com.woorifis.srms.util.DateUtil"%>
<%
List<DeptBean> dept1LvList = (List<DeptBean>) _rdm.getData("DeptLv1");
%>
<head>
<title>SRMS 결재선</title>

<link rel="stylesheet" href="/bpm/scripts/windowfiles/dhtmlwindow.css" type="text/css" />
<link rel="stylesheet" href="/bpm/scripts/modalfiles/modal.css" type="text/css" />
<script type="text/javascript" src="/bpm/scripts/windowfiles/dhtmlwindow.js"></script>
<script type="text/javascript" src="/bpm/scripts/modalfiles/modal.js"></script>

<link rel="stylesheet" href="/style/formdefault.css" />
<link rel="stylesheet" href="/style/_expando.css" />
<link rel="stylesheet" href="/style/popup.css" />
<script type="text/javascript" src="/dojo/dojo/dojo.js" djConfig="isDebug:false, parseOnLoad: true"></script>
<script type="text/javascript" src="/dojo/dijit/tests/_testCommon.js"></script>
<script type="text/javascript">
		dojo.require("dojo.data.ItemFileReadStore");
		dojo.require("dijit.Tree");
		dojo.require("dijit.form.ComboBox");
		dojo.require("dijit.layout.TabContainer");
		dojo.require("dijit.layout.ContentPane");
		dojo.require("dojo.parser");

//dojo Event
   function viewApv(event){
       
       console.debug("dentro de funcion");
       
       contenedor = dojo.byId('userApv');
       var pos = dojo.coords(contenedor, true);
       var x = event.pageX - pos.x;
       var y = event.pageY - pot.y;
       alert(x);
       alert(y);
   }	
</script> 
<script type="text/javascript">
	
function Approval_MoveRow(vi) {
	var f = document.all;
	_tbl = eval("document.all.tbapproval");
	totalrow=eval(_tbl.rows.length);
	//alert(totalrow);
  objs = eval("document.all.mov_ck");
  objRow = eval("document.all.rowId");
  //alert(objs);
  var mrIndex = 0;
  var ud = 0;
  var bck = false;
  var dv=0;
  for(i=0;i<objs.length;i++) {
  	if(objs[i].value==1){
  		dv++;
  	}
    if(objs[i].checked){
    	mrIndex = i;
    	bck = true;
    }
  }
 	//alert(mrIndex);
  if(!bck){
  	alert("Select a approval line you want to move.");
  	return;
  }
  
  if(vi == 1){
  	ud = mrIndex+1;
  }else{
  	ud = mrIndex-1;
  }
	//alert(ud);
  if(ud < dv || totalrow == ud){
  	//alert("Farst and Last !");
  	return;  	
  }
  
	tbapproval.moveRow(mrIndex,ud);
	//alert("================");
  rowColor();
 		
	objs[ud].checked = true;

	
	document.recalc();
}

function rowColor2(_tbl){
	
   if(_tbl == null || _tbl =='' || _tbl=='undefind' )return;
   
   
   rowi = _tbl.length;
  for(i=0;i<rowi;i++) {
		//alert(i%2);
		if(i%2==0){
			_tbl[i].style.background ="";
			//
		}else{
			_tbl[i].style.background ="#F5F5F5";
		}
 	}	 	
}

function rowColor(_tbl){
	
   if(_tbl == null || _tbl =='' || _tbl=='undefind' )return;
   
   
   rowi = _tbl.length;
  for(i=0;i<rowi;i++) {
		//alert(i%2);
		if(i%2==0){
			_tbl[i].style.background ="";
			//
		}else{
			_tbl[i].style.background ="#F0F0F0";
		}
 	}	 	
}

function Approval_fAddRow() {
 	//alert(document.frames["searchUserList"].tbapprovalUser);
	var f = document.all;
	_tblUser = eval(document.frames["searchUserList"].tbapprovalUser);
	
	ckObjs 			= document.frames["searchUserList"].checkbox;
	userName 		= document.frames["searchUserList"].USER_NAME;
	potion 			= document.frames["searchUserList"].POSTION;
	dept 				= document.frames["searchUserList"].DEPT;
	y_empno 		= document.frames["searchUserList"].Y_EMPNO;
    
	if(ckObjs!=null && ckObjs != ''&&ckObjs !='undfined')
	ckObs2 			= document.frames["searchUserList"].checkbox.length;
	else
	ckObs2 = 0;
	
	grpCd 			= document.frames["searchUserList"].GRP_CD;
	deptCds 		= document.frames["searchUserList"].DEPT_CD;
	posiCds 			= document.frames["searchUserList"].POSTION_CD;
	deptLv1Cd 		= document.frames["searchUserList"].DEPTLV1_CD;
	deptLv1Nm 	= document.frames["searchUserList"].DEPTLV1_NM;
	telNo 			= document.frames["searchUserList"].TEL_NO;
	idx 				= document.frames["searchUserList"].tbapprovalUser.rows.length
	bck 				= false;

	var uName;
	var uPotion;
	var uDept;
	var uEmpno;
	var ugrpCd;
	var udeptCds;
	var uposiCds;
	var uDeptLv1Cd;
	var uDeptLv1Nm;
	var uTelNo;
	
	var fLength = idx; 


	var j=0;

	if(idx > 1  || (idx == 1 && userName[0] != null&&ckObjs !=null)){
		u=0;
		ckval=0;
		var ckArry = new Array();
		var aidx=0;
		for(;u<fLength;u++){
		    if(ckObjs[u].checked){
		    	ckArry[aidx++] = u;
		    	bck = true; 
		 	}
		}
		
		for(k=0;k<ckArry.length;k++){
			uName		= userName[ckArry[k]].value;
			uPotion		= potion[ckArry[k]].value;
			uDept		= dept[ckArry[k]].value;
			uEmpno		= y_empno[ckArry[k]].value;
			ugrpCd 		= grpCd[ckArry[k]].value;
			udeptCds 	= deptCds[ckArry[k]].value;
			uposiCds 	= posiCds[ckArry[k]].value;
			uDeptCds	= deptLv1Cd[ckArry[k]].value;
			uDeptNms	= deptLv1Nm[ckArry[k]].value;
			uTelNo		= telNo[ckArry[k]].value;
			addRow(uName,uPotion,uDept,uEmpno,ugrpCd,udeptCds,uposiCds,uDeptCds,uDeptNms,uTelNo);
		}
		
		didx=0;
		//alert(didx);
		for(; didx <= ckArry.length ; didx++){
			if(ckArry[(ckArry.length-didx)] != null){
				_tblUser.deleteRow(ckArry[(ckArry.length-didx)]);
			}
		}
		
	}else if(idx=1){
		if(ckObjs!=null&&ckObjs.checked){
		uName 		= userName.value;
		uPotion 		= potion.value;
		uDept 		= dept.value;
		uEmpno 	= y_empno.value;
		ugrpCd 		= grpCd.value;
		udeptCds 	= deptCds.value;
		uposiCds 	= posiCds.value;
		uDeptNms	= deptLv1Cd.value;
		uDeptNms	= deptLv1Nm.value;
		uTelNo		= telNo.value;
		bck           = true;
		_tblUser.deleteRow(0);
		addRow(
				uName,
				uPotion,
				uDept,
				uEmpno,
				ugrpCd,
				udeptCds,
				uposiCds, 
				uDeptNms,
				uDeptNms,
				uTelNo
		);
		}
	}
	
  if(!bck){
  	alert("결재자를 선택하세요.");
  	return;
  }
}

function addRow(
		userName,
		potion,
		dept,
		y_empno,
		grpCd,
		deptCds,
		posiCds,
		deptLv1Cd,
		deptLv1Nm,
		telNo,
		statuss,
		type,
		preconfirm) {
	if(statuss == null || statuss == ''){
		statuss = '대기';
	}
	_tbl = eval("document.all.tbapproval");
	
	totalrow=_tbl.rows.length;
	var irow;
	objs = eval("document.all.mov_ck");
	irow=totalrow;
	
	addrow = _tbl.insertRow(irow);
                       
	addrow.className="rowOff";
	addrow.onmouseover=function(){tbapproval.clickedRowIndex=this.rowIndex};
	addrow.id="rowId";
	
	cel1       = addrow.insertCell();
	cel2       = addrow.insertCell();
	cel3       = addrow.insertCell();
	cel4       = addrow.insertCell();
	cel5       = addrow.insertCell();
	cel6       = addrow.insertCell();
	cel7       = addrow.insertCell();
	cel8       = addrow.insertCell();
	cel9       = addrow.insertCell();
	cel10     = addrow.insertCell();
	cel11 	= addrow.insertCell();
		
	cel1.align 	= "center";
	cel3.align 	= "center";
	cel5.align 	= "center";
	cel7.align 	= "center";	
	cel9.align 	= "center";
	cel11.align 	= "center";	
				
	cel1.width = '8%';
	cel3.width = '17%';
	cel5.width = '21%';
	cel7.width = '12%';
	cel9.width = '12%';
	cel11.width = '30%';
	
	cel1.className 	= "tbllistcon";

	cel3.className 	= "tbllistcon";

	cel5.className 	= "tbllistcon";

	cel7.className 	= "tbllistcon";

	cel9.className 	= "tbllistcon";

	cel11.className 	= "tbllistcon";
	if(statuss == '대기' && preconfirm != 'CompletedNotification'){
	cel1.innerHTML  	= '<input name="mov_ck" value="0" type="radio">';
	}else{
	cel1.innerHTML  	= '<input name="mov_ck" value="1" type="radio" disabled="disabled">';
	}
	var tmpTag = "";
		tmpTag  = '<input type="hidden" name="empno" value="'			+ y_empno + '" />';			// 사번
		tmpTag  += '<input type="hidden" name="koreanname" value="'	+ userName + '" />';		// 이름
		tmpTag  += '<input type="hidden" name="deptfullname" value="'	+ dept + '" />';				// 부서명
		//tmpTag  += '<input type="hidden" name="type" value="Y" />';
		tmpTag  += '<input type="hidden" name="remark" value="'			+ potion + '" />';			// 직급
		tmpTag  += '<input type="hidden" name="preconfirm" value="' 	+ preconfirm + '" />';								//
		tmpTag  += '<input type="hidden" name="status" value="'+statuss+'" />';			
		tmpTag  += '<input type="hidden" name="grpCd" value="'			+ grpCd + '" />';			// 그룹코드
		tmpTag  += '<input type="hidden" name="gseqs" value="'			+ grpCd + '" />';			//
		tmpTag  += '<input type="hidden" name="apvNms" value="'			+ userName + '" />';
		tmpTag  += '<input type="hidden" name="posiNms" value="'		+ potion + '" />';			// 직급
		tmpTag  += '<input type="hidden" name="deptCds" value="'			+ deptCds + '" />';
		tmpTag  += '<input type="hidden" name="deptNms" value="'		+ dept + '" />';
		tmpTag  += '<input type="hidden" name="posiCds" value="'			+ posiCds + '" />';
		tmpTag  += '<input type="hidden" name="apvIds" value="'			+ y_empno + '" />';
		tmpTag  += '<input type="hidden" name="deptLv1CD" value="'		+ deptLv1Cd + '" />';		// 최사코드
		tmpTag  += '<input type="hidden" name="deptLv1Nm" value="'	+ deptLv1Nm + '" />';		// 회사명
		tmpTag  += '<input type="hidden" name="telNo" value="'				+ telNo + '" />';				// 연락처
		tmpTag  += '<input type="hidden" name="userIds" value="<%= _sm.get("userId") %>" />';
	cel2.innerHTML = tmpTag;

  	cel3.innerHTML  	= userName;
  	cel4.innerHTML  	= '';
  	cel5.innerHTML  	= potion;
  	cel6.innerHTML  	= '';
	cel7.innerHTML  	= statuss;
  	cel8.innerHTML  	= '';
  	var tmptype;
  	if(type=='결재'){
  		tmptype='<label><select name="type" id="type"><option value="결재" selected>결재</option><option value="후결">후결</option></select></label>';
  	}else if(type=='후결'){
  		tmptype='<label><select name="type" id="type"><option value="결재">결재</option><option value="후결" selected>후결</option></select></label>';
  	}else{
  		tmptype='<label><select name="type" id="type"><option value="결재">결재</option><option value="후결" >후결</option></select></label>';
  	}
  	cel9.innerHTML  	= tmptype;
  	cel10.innerHTML	= '';
	cel11.innerHTML	= dept;
	
	objRow = eval("document.all.rowId");
	rowColor(objRow);
	document.recalc();
}


function addRowResult(rowid){

	
	obj = document.frames["searchUserList"];
	_tbl = eval("document.all.tbapproval");
	
	var empno = document.approvalLineForm.empno;
	var userNm = document.approvalLineForm.koreanname;
	var postion = document.approvalLineForm.posiNms;
	var postion_cd = document.approvalLineForm.posiCds;
	var dept = document.approvalLineForm.deptfullname;
	var grp_cd = document.approvalLineForm.grpCd;
	var dept_cd = document.approvalLineForm.deptCds;
	var deptlv1_cd = document.approvalLineForm.deptLv1CD;
	var deptlv1_nm = document.approvalLineForm.deptLv1Nm;
	var tel_no  = document.approvalLineForm.telNo;
	
	_tbl = eval("document.all.tbapproval");
	var totcnt = _tbl.rows.length;
	var mrIndex = 0;
	var rCk=false;
    objs = eval("document.all.mov_ck");
	var tempVar;
	var tempVar3;
	var tempVar4;
	var tempVar5;
	var tempVar6;
    if (totcnt > 1 || (totcnt == 1 && document.all.mov_ck[0] != null)){
    	
		tempVar = '<input type="hidden" name="Y_EMPNO" value="'+empno[rowid].value+'">';
		tempVar += '<input type="hidden" name="USER_NAME" value="'+userNm[rowid].value+'">';
		tempVar += '<input type="hidden" name="POSTION" value="'+postion[rowid].value+'">';
		tempVar += '<input type="hidden" name="POSTION_CD" value="'+postion_cd[rowid].value+'">';
		tempVar += '<input type="hidden" name="DEPT" value="'+dept[rowid].value+'">';
		tempVar	+= '<input type="hidden" name="GRP_CD" value="'+grp_cd[rowid].value+'">';
		tempVar	+= '<input type="hidden" name="DEPT_CD" value="'+dept_cd[rowid].value+'">';
		tempVar += '<input type="hidden" name="DEPTLV1_CD" value="'+deptlv1_cd[rowid].value+'">';
		tempVar += '<input type="hidden" name="DEPTLV1_NM" value="'+deptlv1_nm[rowid].value+'">';
		tempVar += '<input type="hidden" name="TEL_NO" value="'+tel_no[rowid].value+'">';
		tempVar3 = userNm[rowid].value;
	
	   if (postion[rowid].value.length > 7){
			tempVar4 = postion[rowid].value.substring(0,7) + "\n" + postion[rowid].value.substring(7);
	   }else{
		    tempVar4 = postion[rowid].value;
	   }
	   if (dept[rowid].value.length > 7){
			tempVar5 = dept[rowid].value.substring(0,7) + "\n" + dept[rowid].value.substring(7);
	   }else{
		    tempVar5 = dept[rowid].value;
	   }
	   if (deptlv1_nm[rowid].value.length > 7){
			tempVar6 = deptlv1_nm[rowid].value.substring(0,7) + "\n" + deptlv1_nm[rowid].value.substring(7);
	   }else{
		    tempVar6 = deptlv1_nm[rowid].value;
	   }
	   
//		tempVar4 = postion[rowid].value;
//		tempVar5 = dept[rowid].value;
//		tempVar6 = deptlv1_nm[rowid].value;
	 
	 
	 
	 }else if (totcnt == 1){
		tempVar = '<input type="hidden" name="Y_EMPNO" value="'+empno.value+'">';
		tempVar += '<input type="hidden" name="USER_NAME" value="'+userNm.value+'">';
		tempVar += '<input type="hidden" name="POSTION" value="'+postion.value+'">';
		tempVar += '<input type="hidden" name="POSTION_CD" value="'+postion_cd.value+'">';
		tempVar += '<input type="hidden" name="DEPT" value="'+dept.value+'">';
		tempVar	+= '<input type="hidden" name="GRP_CD" value="'+grp_cd.value+'">';
		tempVar	+= '<input type="hidden" name="DEPT_CD" value="'+dept_cd.value+'">';
		tempVar += '<input type="hidden" name="DEPTLV1_CD" value="'+deptlv1_cd.value+'">';
		tempVar += '<input type="hidden" name="DEPTLV1_NM" value="'+deptlv1_nm.value+'">';
		tempVar += '<input type="hidden" name="TEL_NO" value="'+tel_no.value+'">';
		tempVar3 = userNm.value;
	   if (postion.value.length > 7){
	   	tempVar4 = postion.value.substring(0,7) + "\n" + postion.value.substring(7);
	   }else{
	       tempVar4 = postion.value;
	   }
	   if (dept.value.length > 7){
			tempVar5 = dept.value.substring(0,7) + "\n" + dept.value.substring(7);
	   }else{
		    tempVar5 = dept.value;
	   }
	   if (deptlv1_nm.value.length > 7){
			tempVar6 = deptlv1_nm.value.substring(0,7) + "\n" + deptlv1_nm.value.substring(7);
	   }else{
		    tempVar6 = deptlv1_nm.value;
	   }
//		tempVar4 = postion.value;
//		tempVar5 = dept.value;
//		tempVar6 = deptlv1_nm.value;		
	 }
	
	
	//totalrow=eval(_tblUser.rows.length);
	var irow;

	_tblUser = eval(document.frames["searchUserList"].tbapprovalUser);
	
	row1 = document.frames["searchUserList"].tbapprovalUser.rows.length
	
	//alert(irow);
	addrow = _tblUser.insertRow(row1);
    addrow.onMouseOver=function(){tbapprovalUser.clickedRowIndex=this.rowIndex};            
	addrow.className="rowOff";
	addrow.id="urowId";
	addrow.name="urowId";
	
	cel1       = addrow.insertCell();
	cel2       = addrow.insertCell();
	cel3       = addrow.insertCell();
	cel4       = addrow.insertCell();
	cel5       = addrow.insertCell();
	cel6       = addrow.insertCell();
	cel7       = addrow.insertCell();
	cel8       = addrow.insertCell();
	cel9       = addrow.insertCell();
	
	cel1.height = 24;
	
	cel1.width= 26;
	cel3.width= 42;
	cel5.width= 95;
	cel7.width= 95;
	cel9.width= 95;
	
	cel1.align 	= "center";
	cel2.align 	= "";
	cel3.align 	= "center";
	cel4.align 	= "";
	cel5.align 	= "left";
	cel6.align 	= "";
	cel7.align 	= "left";
	cel8.align 	= "";
	cel9.align 	= "left";
	
	cel1.className 	= "tbllistcon";
	cel2.className 	= "";
	cel3.className 	= "tbllistcon";
	cel4.className 	= "";
	cel5.className 	= "tbllistcon";
	cel6.className 	= "";
	cel7.className 	= "tbllistcon";
	cel8.className 	= "";
	cel9.className 	= "tbllistcon";
	
	cel1.innerHTML  	= '<input type="checkbox" name="checkbox" id="checkbox">'+tempVar;
	cel2.innerHTML  	= "";
	cel3.innerHTML  	= tempVar3;
	cel4.innerHTML  	= "";
	cel5.innerHTML  	= tempVar4;
	cel6.innerHTML  	= "";
	cel7.innerHTML  	= tempVar5;
	cel8.innerHTML  	= "";
	cel9.innerHTML  	= tempVar6;
	
	

	//objRow = eval("document.all.urowId");
	//alert("tbapprovalUser  ::: "+objRow);
	_tbl.deleteRow(rowid);
	objRow = eval("document.all.rowId");
	rowColor(objRow);
	document.recalc();
	
}

function Approval_fDelRow() {

	_tbl = eval("document.all.tbapproval");
	var totcnt = _tbl.rows.length;
	//alert(totcnt);
	var mrIndex = 0;
	var rCk=false;
    objs = eval("document.all.mov_ck");
	
    if (totcnt > 1 || (totcnt == 1 && document.all.mov_ck[0] != null)){
	  	for(i=0;i<objs.length;i++) {
	        if(objs[i].checked){
	    	    mrIndex = i;
	    	    rCk=true;
	    	    //alert(mrIndex);
	    	    addRowResult(mrIndex);
	    	    //_tbl.deleteRow(_tbl.clickedRowIndex);
	    	}
	 	}
	 }else if (totcnt == 1){
	 	if(document.all.mov_ck.checked){
	 		mrIndex = 0;
	 		rCk=true;
	 		addRowResult(_tbl.clickedRowIndex);
	 		
	 	}
	 }
	 	  	

	if (!rCk) {
		alert("삭제할 데이터를 선택하세요!");
		return;
	}
	
	objRow = eval(document.frames["searchUserList"].tbapprovalUser.all.urowId);
	
	rowColor2(objRow);		
}


function appSubmmit(){
	_tbl = eval("document.all.tbapproval");
	var totcnt = _tbl.rows.length;
	
	empnos 			= document.getElementsByName("empno");
	koreannames 	= document.getElementsByName("koreanname");
	deptfullnames = document.getElementsByName("deptfullname");
	remarks 			= document.getElementsByName("remark");
	types 			= document.getElementsByName("type");
	preconfirms 	= document.getElementsByName("preconfirm");
	statuss 			= document.getElementsByName("status");
	////////////////////////////////////////////////////////////////////////
	comnames 		= document.getElementsByName("deptLv1Nm");
	phones 			= document.getElementsByName("telNo");
	
	
	var selectedOrganizationList = new Array();	

	var selectedCount=0;			
	for(i=0;i<totcnt;i++){
		if(statuss[i].value =='대기' && preconfirms[i].value != 'CompletedNotification'){
			var user = new SelectedInfo();
			
			user.empno 			= empnos[i].value;			// id
			user.koreanname 		= koreannames[i].value;	// 이름
			user.deptfullname	= deptfullnames[i].value;	// 부서명
			user.remark 			= remarks[i].value;			// 직급
			user.type 				= types[i].value;				//
			user.preconfirm		= preconfirms[i].value;		//
			user.status				= statuss[i].value;				//
			
			user.comname			= comnames[i].value;		// 회사명
			user.phone				= phones[i].value;			// 연락처
			
			//alert(user.empno[1]);
			selectedOrganizationList [selectedCount++] = user;
		}
	}
	//return;
	
	parent.onOk(selectedOrganizationList);
	parent.close();
}

function SelectedInfo() {
		var empno 			= '';
		var koreanname 		= '';
		var deptfullname 	= '';
		var type 				= '';
		var remark				= '';
		var preconfirm 		= '';
		var status				= '';
		var comname 		= '';
		var phone 				= '';
}


function init_approval(){
	var selectedUsers = parent.parent.opener.document.forms[0].all["approvalLine"];
	var size_list = selectedUsers.length;
	if(size_list > 0){
			for(var i=0; i<size_list; i++) {
				var userInfo    = selectedUsers[i];
				var userInfoStr = userInfo.value.split(";");

				var empno			= userInfoStr[0];
				//alert(userInfoStr[0]);
				var koreanname		= userInfoStr[1];
				//alert(userInfoStr[1]);
				var deptfullname	= userInfoStr[2];
				//alert(userInfoStr[2]);
				var remark		= userInfoStr[3];
				//alert(userInfoStr[3]);
				var type		= userInfoStr[4];
				//alert(userInfoStr[4]);
				var preconfirm	= userInfoStr[5];
				//alert(userInfoStr[5]);
				var status      = userInfoStr[6];
				//alert(userInfoStr[6]);
				var comname      = userInfoStr[7];
				//alert(userInfoStr[7]);
				var phone      = userInfoStr[8];
				//alert(userInfoStr[8]);
				//alert(empno+"   ||| "+koreanname+"   ||| "+deptfullname+"   ||| "+remark+"   ||| "+type+"   ||| "+preconfirm+"   ||| "+status+"   ||| "+comname+" ::: "+phone);
				
				addRow(koreanname,remark,deptfullname,empno,'T','T','T','T',comname,phone,status,type,preconfirm);	
				}			
	}	

	
}

function deptSettng(deptcd){
	treeUrl = "/srms/common/dept/userpickerDeptF?deptCd="+deptcd;
	document.all.deptTree.src=treeUrl;
}

function searchUser(){
	var f = document.searchForm;
	var obj = document.getElementsByName("rdiv");
	var sword = f.searchWord.value;
	var ifUrl = "/srms/common/dept/searchUserResultF";
	var rtype;
	for(i=0;i<obj.length;i++){

		if(obj[i].checked == true)rtype=obj[i].value;
	}
	if(sword == '' || sword == null){
		alert("검색어를  입력하세요!");
		return;
	}
	if(sword.length <=1){
		alert("검색어를  2자이상 입력하세요!");
		return;	
	}

	f.searchDiv.value = rtype;
	f.action=ifUrl;
	f.target = "searchUserList";
	f.submit();
}
function searchUserDept(sword){
	var ifUrl = "/srms/common/dept/searchUserResultF?";
	document.all.searchUserList.src=ifUrl+"searchDiv=DEPTCD&searchWord="+sword;
}


function allDelRow() {

  _tbl = eval("document.all.tbapproval");
  objs = eval("document.all.mov_ck");
 
  //alert(objs);
  if(objs == '' || objs == 'undefined' || objs == null){
  	//alert(objs);
  }else{
  	  var ol = objs.length;
	  for (i=1; i<=ol; i++) {
	  	//alert(i);
	  	_tbl.deleteRow(ol-i);
	  }
  }
	
}

function goSave() {
	var f = document.approvalLineForm;
	idx = document.getElementById("tbapproval").rows.length
	var aname = f.apvNms;
	if (idx > 0){
		f.action="/srms/common/dept/approvalLineSave";
		f.target="approvalLine";
		f.submit();
	} else {
		alert("결재선을 지정해야 합니다.");
		return;
	}
}
function grpNo(grpNo){
	document.getElementsByName("grpNo").value=grpNo;
}
function getNo(){
	var gseq = document.getElementsByName("grpNo").value;
	return gseq;
}


function setGseq(gseq){
	var f = document.deleteForm;
	f.gseq.value=gseq;
}
function deleteGrp(){
	var f = document.deleteForm;
	var grpNo = f.gseq.value;
	if(grpNo != null && grpNo != ''){
		f.action="/srms/common/dept/approvalLineDelF";
		f.target="_self";
		f.submit();
	}else{
		alert("삭제할 개인 결재선을 선택하세요.");
		return;
	}
}

// Dojo 속도가 느려서 기본으로 변경 Add by truewater 2009.03.30
function fcnDivShow(divName, id)
{
	searchDiv.style.display="none";
	document.all.searchBtn.src="/images/ico_btn/userpicker_btn1.gif";
	organDiv.style.display="none";
	document.all.organBtn.src="/images/ico_btn/userpicker_btn2.gif";
	personalDiv.style.display="none";
	document.all.personalBtn.src="/images/ico_btn/userpicker_btn3.gif";
	
	eval(divName+"Div.style.display='';");
	eval("document.all."+divName+"Btn.src='/images/ico_btn/userpicker_btn"+ id +"_over.gif'");
}
</script>	  
</head>
<body onload="init_approval()">
<input type="hidden" name="grpNo">
<form name="deleteForm" method="post">
	<input type="hidden" name="gseq" >
</form>
<div id="popwrap" >
<div id="toptitle"><span>결재선 지정</span></div>
<div id="popcontaner" style="position:block; height:300">
	<div class="popcontentleft" >
		
		<!-- <div dojoType="dijit.layout.TabContainer" region="center" id="centerPane" class="popsearch"> -->
		<div id="centerPane" class="popsearch">
			<table border=0 cellpadding=0 cellspacing=0>
				<tr>
					<td height=3></td>
				</tr>
				<tr>
					<td>&nbsp;<a href="javascript:fcnDivShow('search','1')"><img id='searchBtn' src="/images/ico_btn/userpicker_btn1_over.gif" border=0 align=absmiddle ></a>
					<a href="javascript:fcnDivShow('organ','2')"><img id='organBtn' src="/images/ico_btn/userpicker_btn2.gif" border=0 align=absmiddle></a>
					<a href="javascript:fcnDivShow('personal','3')"><img id='personalBtn' src="/images/ico_btn/userpicker_btn3.gif" border=0 align=absmiddle></a></td>
				</tr>
			</table>
			<div id='ContentPane1' dojoType="dijit.layout.ContentPane" title="검색">
				<div id="searchDiv" style="display:;" class="box">
				<form name="searchForm" method="post" onSubmit="searchUser()">                     
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="3" height="3"><img src="/images/Common/GrayBoxMo01.gif" width="3" height="3"></td>
						<td background="/images/Common/GrayBoxLine01.gif"></td>
						<td width="3"><img src="/images/Common/GrayBoxMo02.gif" width="3" height="3"></td>
					</tr>
					<tr>
						<td background="/images/Common/GrayBoxLine04.gif"></td>
						<td align="center" bgcolor="#E6E6E6">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="tbltbtitle" height="26">구분<input type="hidden" name="searchDiv"></td>
								<td class="tblpadding10">
									<input type="radio" name="rdiv" value="USERNM" checked />임직원 
									<input type="radio" name="rdiv" value="DEPTNM" />부서 
									<input type="radio" name="rdiv" value="DEPTCD" />점코드
								</td>
							</tr>
							<tr>
								<td class="tblline" colspan="2" height="1"></td>
							</tr>
							<tr>
								<td class="tbltbtitle" height="26">검색어</td>
								<td class="tblpadding10">
									<input class="tblinput" size=20 name="searchWord" type="text" />
									&nbsp;<a href="javascript:searchUser()"><img src="/images/Common/B_seaarch.gif" width="59" height="20" align=absmiddle></a>
								</td>
							</tr>
						</table>
						</td>
                        <td background="/images/Common/GrayBoxLine02.gif"></td>
                    </tr>
                    <tr>
                        <td height="3"><img src="/images/Common/GrayBoxMo04.gif" width="3" height="3"></td>
                        <td background="/images/Common/GrayBoxLine03.gif"></td>
                        <td><img src="/images/Common/GrayBoxMo03.gif" width="3" height="3"></td>
                    </tr>
				</table>
				</form>
           		</div>
			</div>
			<div dojoType="dijit.layout.ContentPane" title="<div onclick='fcnOrganDivShow()'>조직도</div>">				
				<div id="organDiv" class="box" width="100%" style="display:none">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<select id="deptLv1" onChange="javascript:deptSettng(this.value);">
							<option value="">계열사</option> 			
<%
/* data list count */
StringUtil su = new StringUtil();
for(DeptBean data : dept1LvList){
	out.print("<option value='"+data.getDeptCd()+"'>"+data.getDeptNm()+"</option>");
}
%>
						</select>
						</td>
					</tr>
					<tr>
						<td><iframe src="about:blank" name="deptTree" frameborder="0"  scrolling="auto" width=100% height=170 marginwidth=0 marginheight=0 style="border:1px #dcdcdc solid"></iframe></td>
					</tr>
				</table>
				</div>
			</div>             
			<div dojoType="dijit.layout.ContentPane" title="<div onclick='fcnPersonalDivShow()'>개인결재선</div>" id="userApv">
				<div id="personalDiv" class="box" width="100%" style=" display:none">
				<iframe src="/srms/common/dept/approvalLine" name="approvalLine" frameborder="0" scrolling="auto" width=100% height=180 marginwidth=0 marginheight=0 style="border:1px #dcdcdc solid;"></iframe>
				</div>
			</div>
		</div>
		<div id="dept2"></div>	
    	<div class="popvalue">
    		<div style="height:221;">
    			<iframe src="/srms/common/dept/searchUserResultF?searchDiv=DEPTCD&searchWord=AA" name="searchUserList" frameborder="0" style="overflow:auto; width: 100%; height:221;"></iframe>
    		</div>
		</div>       
	</div>
	<div class="popcontentcenter">
		<div class="popbtn"><a href="javascript:Approval_fAddRow();"><img src="/images/Common/B_arrowR.gif" alt="결재적용"></a>
		<a href="javascript:Approval_fDelRow()"><img src="/images/Common/B_arrowL.gif" alt="결재적용"></a>
		</div>
	</div>
	<div class="popcontentright">
		<div class="poptopbtn">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<a href="javascript:Approval_MoveRow(-1)"><img src="/images/Common/B_up.gif" width="15" height="15" align="absmiddle"><span class="style1"> 위로</span> </a>&nbsp;&nbsp;
						<a href="javascript:Approval_MoveRow(1)"><img src="/images/Common/b_down.gif" width="15" height="15" align="absmiddle"> 아래로</a></td>
					<td>&nbsp;</td>
					<td align=right>
						<a href="javascript:Approval_fDelRow()"><img src="/images/Common/b_delete.gif" align=absmiddle></a>&nbsp;&nbsp;
<script type="text/javascript">

function opennewsletter(){
	idx = document.getElementById("tbapproval").rows.length;
	if(idx > 0){
		var param = document.getElementsByName("grpNo").value;
		
		if(param == 'undefined'||param==null||param=='')param='0';
		
		var url = '/srms/common/dept/approvalLineSaveF?gseq='+param;
		emailwindow=dhtmlmodal.open('EmailBox', 'iframe', url, '결재선 저장', 'width=430px,height=100px,center=1,resize=0,scrolling=0')
	
		emailwindow.onclose=function(){ 
			var theform=this.contentDoc.forms[0] 
			var theemail=this.contentDoc.getElementById("grpNm");
			var closes =this.contentDoc.getElementById("closes");
			if(closes.value==''){
				if (theemail.value== ''){ 
					alert("결재선이름을 입력하세요,")
					return false 
				}else{
					document.approvalLineForm.grpNm.value=theemail.value //Assign the email to a span on the page
					goSave();
					return true 
				}
			}else{
				return true
			}
		}
	}else{
		alert("결재선을 선택하여 주세요.");
	}
} 

</script>
						<a href="#" onClick="opennewsletter(); return false"><img src="/images/Common/B_prevline.gif" align=absmiddle></a>&nbsp;&nbsp;
						<a href="#" onClick="javascript:deleteGrp()"><img src="/images/Common/B_help.gif" align=absmiddle></a>
					</td>
    	        </tr>
    	    </table>
    	</div>
    	<div class="poprightvalue">
    	<form name="approvalLineForm" method="post">
    	<input type="hidden" name="grpNm">
    	<table  cellspacing="0" cellpadding="0" width="100%" align="center" border="0" >
		   	<tr>
		   		<td class="tbllisttitle" align="center" height="24"  width="8%">선택</td>
				<td class="tbllistbg"></td>
				<td class="tbllisttitle" align="center"  width="17%">성명</td>
				<td class="tbllistbg"></td>
				<td class="tbllisttitle" align="center"  width="21%">직위</td>
				<td class="tbllistbg"></td>
				<td align="center" class="tbllisttitle"  width="12%">상태</td>
				<td class="tbllistbg"></td>
				<td align="center" class="tbllisttitle" width="12%">종류</td>
				<td class="tbllistbg"></td>
				<td align="center" class="tbllisttitle" width="30%">부서</td>
			</tr>
			<tr>
				<td colspan="11" class="tblline"></td>
			</tr>
			<tr>
				<td colspan="11" height="2" bgcolor="#eaeaea"></td>
			</tr>
		</table>
		<table cellspacing="0" cellpadding="0" width="100%" align="center" border="0" id="tbapproval">
		</table>
		</form>
		</div>    
	</div>
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="1" bgcolor="#DBDBDB"></td>
	</tr>
	<tr>
		<td height="50" align="center"> 
			<a href="javascript:appSubmmit()"><img src="/images/Common/b_btm_completion.gif" /></a>
			<a href="javascript:parent.close()"><img src="/images/Common/b_btm_cancel.gif" /></a>
		</td>
	</tr>
</table>

</body>
</html>