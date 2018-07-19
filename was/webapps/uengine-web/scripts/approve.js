//**************************************************************** 
// 오피스메이트 결재
//**************************************************************** 

var workingFlag = "off";
var clickFG = "false";  //황기평 추가 두번클릭 막는다

//결재 상신 
function upDocument(){
  //(상신두번클릭막는다
  if (clickFG == "true") {	
		return; //황기평 추가
	}

	//--------------- 황기평 수정 Start
	var varTp = document.upform.docClassifyId.value;
	var varKnd = document.upform.docKindId.value;
	var isEdms = document.upform.isedms.value;
	if(isEdms == "1") {
      // EDM 사용 회사
  	  if (varTp =="" || varTp =="-1"){
	  	  alert("문서 분류가 선택되지 않았습니다."	);
		  return ;
	  }
	
	  if (varKnd =="" || varKnd =="-1"){
		  alert("문서 종류가 선택되지 않았습니다."	);
		  return ;
	  }
	}
	else {
	  document.upform.docClassifyId.value = "0";
	  document.upform.docClassifyName.value = " ";
	  document.upform.docKindId.value = "0";
	  document.upform.docKindName.value = " ";

	}
	
	//--------------- 황기평 수정 End

  if(document.upform.smssendflag.checked) {
		document.upform.smssendflag.value = "Y";
	} else {	
	  document.upform.smssendflag.value = "N";	
	}
	                 
	if(document.upform.processid.value == ""){
		alert("결재선을 지정하지 않았습니다. 결재선을 지정하세요!");
		return;
	}
	
	// S&C ERP 폼 체크
	if ( ! checkERP_SNC() ) return;


/*********한농버젼 : EDMS의 문서분류, 문서종류 체계 따름=> 향후 EDMS 업그레이드시 본사에도 적용예정임.*********

	//문서분류 코드
	if(document.upform.docClassifyId){
		if(document.upform.docClassifyId.value == "" || document.upform.docClassifyId.value == -1){
			alert("문서분류 코드을 입력하세요!");
			//document.upform.docClassifyId.focus();
			return;
		} 
	}
	
	//문서분류 명
	if(document.upform.docClassifyName){
		if(document.upform.docClassifyName.value == "" || document.upform.docClassifyName.value == " "){
			alert("문서분류 명을 입력하세요!");
			//document.upform.docClassifyName.focus();
			return;
		} 
	}
	
	//문서종류 코드
	if(document.upform.docKindId){
		if(document.upform.docKindId.value == "" || document.upform.docKindId.value == -1){
			alert("문서종류 코드을 입력하세요!");
			//document.upform.docKindId.focus();
			return;
		} 
	}
	
	//문서종류 명
	if(document.upform.docKindName){
		if(document.upform.docKindName.value == "" || document.upform.docKindName.value == " "){
			alert("문서종류 명을 입력하세요!");
			//document.upform.docKindName.focus();
			return;
		} 
	}	

*********한농버젼 : EDMS의 문서분류, 문서종류 체계 따름=> 향후 EDMS 업그레이드시 본사에도 적용예정임.*********/	

//	document.upform.docClassifyId.value = "0";
//	document.upform.docClassifyName.value = " ";
//	document.upform.docKindId.value = "0";
//	document.upform.docKindName.value = " ";

	
	if(document.upform.view_title){
		if(document.upform.view_title.value == ""){
			alert("문서 제목을 입력하세요!");
			document.upform.view_title.focus();
			return;
		} 
	}
	

	//사용자에게 alert할 결재 상신정보를 만든다.
	var transferMode;
	var securitylevel;
	var belongterm;
	var title;
	if(document.upform.transfermode[0].checked == true){
		transferMode = "자동이관";
	}
	else
		transferMode = "수동이관";


	securitylevel 	= document.upform.securitylevel.options[document.upform.securitylevel.selectedIndex].value + "등급";
	belongterm 	= document.upform.belongterm.options[document.upform.belongterm.selectedIndex].value + "년";
	title 		= document.upform.view_title.value;

	var reportInfo = "결재 상신정보 : [제목: "+title
			+"   이관방법: " +transferMode
			+"  문서등급: " + securitylevel
			+"  보존기간: " +belongterm
			+ "]   문서를 상신하시겠습니까?"  ;

	
	if(confirm(reportInfo)){
                 clickFG = "true"; //황기평 추가(결재중 버튼 재 클릭 막기 위해 필요)

		//처리중 화면을 띄운다...
		popupWorkingDlg();

		if(document.we){
		  document.upform.freehtml.value = document.we.bodyvalue;
			document.upform.mimefreehtml.value = document.we.MIMEValue;
			                                                 
		}
//		document.upform.writer.value = document.upform.view_writer.value;
		var strTemp = document.upform.work.value;
		
		if((strTemp == "reload")||(strTemp == "rewrite")) document.upform.work.value = "reportagain";
		else
			document.upform.work.value = "report";

		workingFlag = "on";
		document.upform.target="_self";
		document.upform.action = "reportdoc.jsp";
		document.upform.submit();

	}
}

//작성문서 임시 저장
function saveDocument(){
	var varTp = document.upform.docClassifyId.value;
	var varKnd = document.upform.docKindId.value;
	var isEdms = document.upform.isedms.value;
	
	if(isEdms == "1") {
      // EDM 사용 회사
  	  if (varTp =="" || varTp =="-1"){
	  	  alert("문서 분류가 선택되지 않았습니다."	);
		  return ;
	  }
	
	  if (varKnd =="" || varKnd =="-1"){
		  alert("문서 종류가 선택되지 않았습니다."	);
		  return ;
	  }
	}
	else {
	
	  document.upform.docClassifyId.value = "0";
	  document.upform.docClassifyName.value = " ";
	  document.upform.docKindId.value = "0";
	  document.upform.docKindName.value = " ";

	}
	
/*********한농버젼 : EDMS의 문서분류, 문서종류 체계 따름=> 향후 EDMS 업그레이드시 본사에도 적용예정임.*********

	//문서분류 코드
	if(document.upform.docClassifyId){
		if(document.upform.docClassifyId.value == "" || document.upform.docClassifyId.value == -1){
			alert("문서분류 코드을 입력하세요!");
			//document.upform.docClassifyId.focus();
			return;
		} 
	}
	
	//문서분류 명
	if(document.upform.docClassifyName){
		if(document.upform.docClassifyName.value == "" || document.upform.docClassifyName.value == " "){
			alert("문서분류 명을 입력하세요!");
			//document.upform.docClassifyName.focus();
			return;
		} 
	}
	
	//문서종류 코드
	if(document.upform.docKindId){
		if(document.upform.docKindId.value == "" || document.upform.docKindId.value == -1){
			alert("문서종류 코드을 입력하세요!");
			//document.upform.docKindId.focus();
			return;
		} 
	}
	
	//문서종류 명
	if(document.upform.docKindName){
		if(document.upform.docKindName.value == "" || document.upform.docKindName.value == " "){
			alert("문서종류 명을 입력하세요!");
			//document.upform.docKindName.focus();
			return;
		} 
	}	

*********한농버젼 : EDMS의 문서분류, 문서종류 체계 따름=> 향후 EDMS 업그레이드시 본사에도 적용예정임.*********/	

//	document.upform.docClassifyId.value = "0";
//	document.upform.docClassifyName.value = " ";
//	document.upform.docKindId.value = "0";
//	document.upform.docKindName.value = " ";

	if(document.upform.view_title){
		if(document.upform.view_title.value == ""){
			alert("문서 제목을 입력하세요!");
			document.upform.view_title.focus();
			return;
		} 
	}
	
	if(document.we){
		document.upform.freehtml.value = document.we.bodyvalue;
		document.upform.mimefreehtml.value = document.we.MIMEValue;
	}

//	document.upform.writer.value = document.upform.view_writer.value;
	var strTemp = document.upform.work.value;
	document.upform.work.value = "savetemporary";
	document.upform.target = "_blank";
	document.upform.action = "saveresult.jsp";
	document.upform.submit();
}

//============2002.02.10 혜진추가=========================
//결재자가 수정을 저장할경우work를 edit로 바꿈
//지금까지의 work상태는 reload였음
//work값만 바꿔줄뿐 위의 상신 로직과 비슷함
//========================================================
function saveEditDocument(){
         if (clickFG == "true"){	
		return; //황기평 추가
	}

	//문서분류 코드
	if(document.upform.docClassifyId){
		if(document.upform.docClassifyId.value == ""){
			alert("문서분류 코드을 입력하세요!");
			document.upform.docClassifyId.focus();
			return;
		} 
	}
	
	//문서분류 명
	if(document.upform.docClassifyName){
		if(document.upform.docClassifyName.value == ""){
			alert("문서분류 명을 입력하세요!");
			document.upform.docClassifyName.focus();
			return;
		} 
	}
	
	//문서종류 코드
	if(document.upform.docKindId){
		if(document.upform.docKindId.value == ""){
			alert("문서종류 코드을 입력하세요!");
			document.upform.docKindId.focus();
			return;
		} 
	}
	
	//문서종류 명
	if(document.upform.docKindName){
		if(document.upform.docKindName.value == ""){
			alert("문서종류 명을 입력하세요!");
			document.upform.docKindName.focus();
			return;
		} 
	}
	
	//제품종류 코드
	/*if(document.upform.productId){
		if(document.upform.productId.value == ""){
			alert("제품종류 코드을 입력하세요!");
			document.upform.productId.focus();
			return;
		} 
	}
	
	//제품종류 명
	if(document.upform.productName){
		if(document.upform.productName.value == ""){
			alert("제품종류 명을 입력하세요!");
			document.upform.productName.focus();
			return;
		} 
	}*/

	//문서 제목 -원래있던거
	if(document.upform.view_title){
		if(document.upform.view_title.value == ""){
			alert("문서 제목을 입력하세요!");
			document.upform.view_title.focus();
			return;
		} 
	}
	
	//사용자에게 alert할 결재 수정정보를 만든다.
	//var transferMode;
	var securitylevel;
	var belongterm;
	var title;
	//if(document.upform.transfermode[0].checked == true){
		//transferMode = "자동이관";
	//}
	//else
		//transferMode = "수동이관";


	securitylevel 	= document.upform.securitylevel.options[document.upform.securitylevel.selectedIndex].value + "등급";
	belongterm 	= document.upform.belongterm.options[document.upform.belongterm.selectedIndex].value + "년";
	title 		= document.upform.view_title.value;

	var reportInfo = "결재 상신정보 : [제목: "+title
			//+"   이관방법: " +transferMode
			+"  문서등급: " + securitylevel
			+"  보존기간: " +belongterm
			+ "]   작성된 결재문서를 수정하시겠습니까?";

	
	if(confirm(reportInfo)){
                
                clickFG = "true"; //황기평 추가( 결재중 버튼 재 클릭 막기 위해 필요)

		//처리중 화면을 띄운다...
		popupWorkingDlg();

		if(document.we){
			document.upform.freehtml.value = document.we.bodyvalue;
			document.upform.mimefreehtml.value = document.we.MIMEValue;
		}
//		document.upform.writer.value = document.upform.view_writer.value;
		var strTemp = document.upform.work.value;				
		workingFlag = "on";
		document.upform.work.value = "edit";
		document.upform.target="_self";
		document.upform.action="reportdoc.jsp";
		document.upform.submit();
	}
}
//=============================추가 끝===================================


var workingWnd = null;

function popupWorkingDlg(){

	var t = screen.height/2 - 35;
	var l = screen.width/2 - 145;
        var param = "width=290 height=70 scrollbars=no left= " + l + " top=" + t + " resizable=no" ;

	workingWnd = window.open("working.jsp", "처리중", param);
	workingWnd.focus();

}


function unloadPage(){
	if(workingWnd != null) workingWnd.close();
}



//파일첨부중 첨부문서 보기
/*function viewAttachFile(){

	var win = null;
	var index = document.upform.attachfile.selectedIndex;
	if((index == 0) || (index == -1)) return;
	url = document.upform.uploadurl.value + document.upform.attachfile.options[index].value;

	win = window.open(url);
	win.focus();
}
*/

function viewAttachFile(){
	//---------황기평 추가 ---> 뷰기능 구현되 있지않아서 일단 막음---------
	return;
	//----------------------------------------------------------------------
	
	var win = null;
	var index = document.upform.attachfile.selectedIndex;
	if((index == 0) || (index == -1)) return;
//	url = document.upform.uploadurl.value + document.upform.attachfile.options[index].value;

  document.frmViewDoc.openFile.value = document.upform.attachfile.options[index].value;
  document.frmViewDoc.target = "_blank";
  document.frmViewDoc.action = "download.jsp";
  document.frmViewDoc.submit();
}


//사용자정보를 보거나 쪽지, 메일을 보낸다.
function viewUser(userid){
        var sFeatures = "dialogHeight: 100px; dialogWidth: 50px; center:on; scroll:no; status:no; unadorned:yes; help:no;"; 
	var win = window.showModalDialog("selectfunction.jsp?userid=" + userid , "", sFeatures);
}

//결재선 추가 및 변경
function setApproveLine(){

  if(document.upform.smssendflag.checked) {
		document.upform.smssendflag.value = "Y";
	} else {	
	  document.upform.smssendflag.value = "N";	
	}

	var formid = document.upform.formid.value;
	var deptid = document.upform.deptid.value;
	var compid = document.upform.compid.value;
 	var processid = document.upform.processid.value;
	var paramapprover = document.upform.paramapprover.value;
	var paramreceiver = document.upform.paramreceiver.value;
	var approveTitle = document.upform.view_title.value;
     if(approveTitle.indexOf(">") > -1 || approveTitle.indexOf("<") > -1)
     {
     		alert(">, < 와 같은 특수문자가 제목에 포함되어 있습니다 ");
     		return;
     }		 

	if(paramapprover != "") processid="-1";

        var url    = "selapplineframe.jsp?"
			+ "formid=" +formid
			+ "&deptid=" +deptid
			+ "&compid=" +compid
			+ "&processid=" + processid
			+ "&paramapprover=" + paramapprover
			+ "&paramreceiver=" + paramreceiver;

	var l = screen.width / 2 - 375;
	var t = screen.height / 2 - 280;

	var param = "width=775 height=490 scrollbars=no left=" + l + " top=" + t;
	var win = window.open(url , "결재선지정", param);
	win.focus();
}

//지정된 process(결재선)ID를 가져온다
function setProcessid(processid){
	if((processid != null) && (processid != "")){
		if(document.we != null){
			document.upform.freehtml.value = document.we.bodyvalue;
		}
		document.upform.processid.value = processid;
		document.upform.work.value = "write";
		document.upform.action = "reportform.jsp";
		document.upform.target="_self";
		document.upform.paramapprover.value="";
		document.upform.paramreceiver.value="";
		document.upform.submit();
	}
	
}

//이전 페이지로 가기
function goList(){
	history.go(-1);
}

//
function setAppline(approver, receiver){


	var strTemp = document.upform.work.value;
	if(document.we != null){
		document.upform.freehtml.value = document.we.bodyvalue;
	}
	if(strTemp == "reload") document.upform.work.value = "rewrite";
	document.upform.processid.value = "-1";
	document.upform.paramapprover.value = approver;
	document.upform.paramreceiver.value = receiver;
	document.upform.target="_self";
	document.upform.action = "reportform.jsp";
	document.upform.submit();
}



//보관문서를 첨부한다.
function attachDoc(){

  var l = screen.width / 2 - 375;
  var t = screen.height / 2 - 225;
  var param = "width=750 height=480 scrollbars=no left=" +l+ " top=" +t; 
  var deptid = document.upform.deptid.value;
  var compid = document.upform.compid.value;
  var url = "attachcabinetframe.jsp?deptid=" + deptid + "&compid=" + compid;
  var win = window.open(url, "문서추가", param);
  win.focus();	
}

function attachEdmsDoc(){
		var companycd = document.upform.companycd.value; //황기평 추가
		var tempuploadurl = document.upform.tempuploadurl.value; //황기평 추가
    var iMyWidth = (window.screen.width-700)/2
    var iMyHeight = (window.screen.height-476)/2
    win = window.open("/ed/modal/mdl_geardocframe.jsp?companycd=" + companycd + "&tempuploadurl=" + tempuploadurl, "sendedms","width=700, height=476, left=" + iMyWidth + ",top="+ iMyHeight +",screenX="+ iMyWidth +",screenY="+ iMyHeight +",toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no")
}


//첨부된 보관문서를 리스트박스에 추가한다.
function addAttachFile(filename, title){
	var index = document.upform.attachfile.options.length;
	var opt = new Option;
	opt.text = title;
	opt.value = filename;
	document.upform.attachfile.options[index] = opt;
}



//문서 작성창 닫기
function closeDocument(){
	if(confirm("문서작성을 취소하시겠습니까?"))
		parent.menu.refreshWindow();
}
 

function clearAttachFile(){
	var len = document.upform.attachfile.length;
	for(var i=len-1; i>0; i--){
		document.upform.attachfile.options[i] = null;
	}
	
}

//첨부파일 갯수 변경
function changeAttachCount()
{
	var	i, index = document.attform.noattachfile.options[document.attform.noattachfile.selectedIndex].value;
	if  ( index == 0 ){
		document.all.AttachFileNone.style.display = "";
		for  ( i = 0 ; i < 10 ; i++ ){
			document.all.AttachFileInput[i].value = "";
			document.all.AttachFileInput[i].style.display = "none";
		}
		return;
	}
	else	if  ( index < 0 || index > 10 ){
		return;
	}
	document.all.AttachFileNone.style.display = "none";
	for  ( i = 0 ; i < index ; i++ ){
		document.all.AttachFileInput[i].style.display = "";
	}
	for  ( i = index ; i < 10 ; i++ ){
		document.all.AttachFileInput[i].value = "";
		document.all.AttachFileInput[i].style.display = "none";
	}
	return;
}

//파일첨부 페이지 열기
function attachFile(){

	var l = screen.width / 2 - 205;
	var t = screen.height / 2 - 85;

	var param = "width=400 height=177 scrollbars=no left=" + l + " top=" + t + "scrollbars=no";

	var win = window.open("attachfile.jsp", "파일첨부", param);
	win.focus();
}

//첨부파일 목록추가
function addFile(text){
	var opt = new Option;
	opt.value="";
	opt.text = text;	
	index = document.upform.attachfile.length;
	document.upform.attachfile.options[index] = opt;
}

//첨부파일 목록 제거
function deleteFile(index){
	document.upform.attachfile.options[index+1] = null;	
}

//첨부파일 모두 제거
function clearFile(){
	for(var i = document.upform.attachfile.length-1; i > 0; i--){
		document.upform.attachfile.options[i] = null;
	}
}

function delayTime(param){
	var funct ="openMime('"+param+"')";
	window.setTimeout(funct, 1);
//	document.we.setDefaultFont("굴림", 10, "굴림체", 10);
}


function openMime(url){
	document.we.Editingmode = 0;
//        document.we.OpenMIMEURL(url);
  document.we.OpenFile(url);
}

function closeDoc(){
	self.close();
}

function printDoc(){
	//self.print();
	if(document.we != null)
		document.we.Print(1)
}

function loadHtml(){
	invisible();
	if(document.upform.freehtml.value == "") return;
	document.we.bodyvalue = document.upform.freehtml.value;
//	alert("document.we.value : "+ document.we.value);
//	alert("document.we.bodyvalue : "+ document.we.bodyvalue);
}

function document_onkeydown() {
	//shift키가 눌리면
	if(event.shiftKey){
		if(event.keyCode == 222){
			alert("큰따옴표는 입력할 수 없습니다");
		}
	}

}
