//**************************************************************** 
// ���ǽ�����Ʈ ����
//**************************************************************** 

var workingFlag = "off";
var clickFG = "false";  //Ȳ���� �߰� �ι�Ŭ�� ���´�

//���� ��� 
function upDocument(){
  //(��ŵι�Ŭ�����´�
  if (clickFG == "true") {	
		return; //Ȳ���� �߰�
	}

	//--------------- Ȳ���� ���� Start
	var varTp = document.upform.docClassifyId.value;
	var varKnd = document.upform.docKindId.value;
	var isEdms = document.upform.isedms.value;
	if(isEdms == "1") {
      // EDM ��� ȸ��
  	  if (varTp =="" || varTp =="-1"){
	  	  alert("���� �з��� ���õ��� �ʾҽ��ϴ�."	);
		  return ;
	  }
	
	  if (varKnd =="" || varKnd =="-1"){
		  alert("���� ������ ���õ��� �ʾҽ��ϴ�."	);
		  return ;
	  }
	}
	else {
	  document.upform.docClassifyId.value = "0";
	  document.upform.docClassifyName.value = " ";
	  document.upform.docKindId.value = "0";
	  document.upform.docKindName.value = " ";

	}
	
	//--------------- Ȳ���� ���� End

  if(document.upform.smssendflag.checked) {
		document.upform.smssendflag.value = "Y";
	} else {	
	  document.upform.smssendflag.value = "N";	
	}
	                 
	if(document.upform.processid.value == ""){
		alert("���缱�� �������� �ʾҽ��ϴ�. ���缱�� �����ϼ���!");
		return;
	}
	
	// S&C ERP �� üũ
	if ( ! checkERP_SNC() ) return;


/*********�ѳ���� : EDMS�� �����з�, �������� ü�� ����=> ���� EDMS ���׷��̵�� ���翡�� ���뿹����.*********

	//�����з� �ڵ�
	if(document.upform.docClassifyId){
		if(document.upform.docClassifyId.value == "" || document.upform.docClassifyId.value == -1){
			alert("�����з� �ڵ��� �Է��ϼ���!");
			//document.upform.docClassifyId.focus();
			return;
		} 
	}
	
	//�����з� ��
	if(document.upform.docClassifyName){
		if(document.upform.docClassifyName.value == "" || document.upform.docClassifyName.value == " "){
			alert("�����з� ���� �Է��ϼ���!");
			//document.upform.docClassifyName.focus();
			return;
		} 
	}
	
	//�������� �ڵ�
	if(document.upform.docKindId){
		if(document.upform.docKindId.value == "" || document.upform.docKindId.value == -1){
			alert("�������� �ڵ��� �Է��ϼ���!");
			//document.upform.docKindId.focus();
			return;
		} 
	}
	
	//�������� ��
	if(document.upform.docKindName){
		if(document.upform.docKindName.value == "" || document.upform.docKindName.value == " "){
			alert("�������� ���� �Է��ϼ���!");
			//document.upform.docKindName.focus();
			return;
		} 
	}	

*********�ѳ���� : EDMS�� �����з�, �������� ü�� ����=> ���� EDMS ���׷��̵�� ���翡�� ���뿹����.*********/	

//	document.upform.docClassifyId.value = "0";
//	document.upform.docClassifyName.value = " ";
//	document.upform.docKindId.value = "0";
//	document.upform.docKindName.value = " ";

	
	if(document.upform.view_title){
		if(document.upform.view_title.value == ""){
			alert("���� ������ �Է��ϼ���!");
			document.upform.view_title.focus();
			return;
		} 
	}
	

	//����ڿ��� alert�� ���� ��������� �����.
	var transferMode;
	var securitylevel;
	var belongterm;
	var title;
	if(document.upform.transfermode[0].checked == true){
		transferMode = "�ڵ��̰�";
	}
	else
		transferMode = "�����̰�";


	securitylevel 	= document.upform.securitylevel.options[document.upform.securitylevel.selectedIndex].value + "���";
	belongterm 	= document.upform.belongterm.options[document.upform.belongterm.selectedIndex].value + "��";
	title 		= document.upform.view_title.value;

	var reportInfo = "���� ������� : [����: "+title
			+"   �̰����: " +transferMode
			+"  �������: " + securitylevel
			+"  �����Ⱓ: " +belongterm
			+ "]   ������ ����Ͻðڽ��ϱ�?"  ;

	
	if(confirm(reportInfo)){
                 clickFG = "true"; //Ȳ���� �߰�(������ ��ư �� Ŭ�� ���� ���� �ʿ�)

		//ó���� ȭ���� ����...
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

//�ۼ����� �ӽ� ����
function saveDocument(){
	var varTp = document.upform.docClassifyId.value;
	var varKnd = document.upform.docKindId.value;
	var isEdms = document.upform.isedms.value;
	
	if(isEdms == "1") {
      // EDM ��� ȸ��
  	  if (varTp =="" || varTp =="-1"){
	  	  alert("���� �з��� ���õ��� �ʾҽ��ϴ�."	);
		  return ;
	  }
	
	  if (varKnd =="" || varKnd =="-1"){
		  alert("���� ������ ���õ��� �ʾҽ��ϴ�."	);
		  return ;
	  }
	}
	else {
	
	  document.upform.docClassifyId.value = "0";
	  document.upform.docClassifyName.value = " ";
	  document.upform.docKindId.value = "0";
	  document.upform.docKindName.value = " ";

	}
	
/*********�ѳ���� : EDMS�� �����з�, �������� ü�� ����=> ���� EDMS ���׷��̵�� ���翡�� ���뿹����.*********

	//�����з� �ڵ�
	if(document.upform.docClassifyId){
		if(document.upform.docClassifyId.value == "" || document.upform.docClassifyId.value == -1){
			alert("�����з� �ڵ��� �Է��ϼ���!");
			//document.upform.docClassifyId.focus();
			return;
		} 
	}
	
	//�����з� ��
	if(document.upform.docClassifyName){
		if(document.upform.docClassifyName.value == "" || document.upform.docClassifyName.value == " "){
			alert("�����з� ���� �Է��ϼ���!");
			//document.upform.docClassifyName.focus();
			return;
		} 
	}
	
	//�������� �ڵ�
	if(document.upform.docKindId){
		if(document.upform.docKindId.value == "" || document.upform.docKindId.value == -1){
			alert("�������� �ڵ��� �Է��ϼ���!");
			//document.upform.docKindId.focus();
			return;
		} 
	}
	
	//�������� ��
	if(document.upform.docKindName){
		if(document.upform.docKindName.value == "" || document.upform.docKindName.value == " "){
			alert("�������� ���� �Է��ϼ���!");
			//document.upform.docKindName.focus();
			return;
		} 
	}	

*********�ѳ���� : EDMS�� �����з�, �������� ü�� ����=> ���� EDMS ���׷��̵�� ���翡�� ���뿹����.*********/	

//	document.upform.docClassifyId.value = "0";
//	document.upform.docClassifyName.value = " ";
//	document.upform.docKindId.value = "0";
//	document.upform.docKindName.value = " ";

	if(document.upform.view_title){
		if(document.upform.view_title.value == ""){
			alert("���� ������ �Է��ϼ���!");
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

//============2002.02.10 �����߰�=========================
//�����ڰ� ������ �����Ұ��work�� edit�� �ٲ�
//���ݱ����� work���´� reload����
//work���� �ٲ��ٻ� ���� ��� ������ �����
//========================================================
function saveEditDocument(){
         if (clickFG == "true"){	
		return; //Ȳ���� �߰�
	}

	//�����з� �ڵ�
	if(document.upform.docClassifyId){
		if(document.upform.docClassifyId.value == ""){
			alert("�����з� �ڵ��� �Է��ϼ���!");
			document.upform.docClassifyId.focus();
			return;
		} 
	}
	
	//�����з� ��
	if(document.upform.docClassifyName){
		if(document.upform.docClassifyName.value == ""){
			alert("�����з� ���� �Է��ϼ���!");
			document.upform.docClassifyName.focus();
			return;
		} 
	}
	
	//�������� �ڵ�
	if(document.upform.docKindId){
		if(document.upform.docKindId.value == ""){
			alert("�������� �ڵ��� �Է��ϼ���!");
			document.upform.docKindId.focus();
			return;
		} 
	}
	
	//�������� ��
	if(document.upform.docKindName){
		if(document.upform.docKindName.value == ""){
			alert("�������� ���� �Է��ϼ���!");
			document.upform.docKindName.focus();
			return;
		} 
	}
	
	//��ǰ���� �ڵ�
	/*if(document.upform.productId){
		if(document.upform.productId.value == ""){
			alert("��ǰ���� �ڵ��� �Է��ϼ���!");
			document.upform.productId.focus();
			return;
		} 
	}
	
	//��ǰ���� ��
	if(document.upform.productName){
		if(document.upform.productName.value == ""){
			alert("��ǰ���� ���� �Է��ϼ���!");
			document.upform.productName.focus();
			return;
		} 
	}*/

	//���� ���� -�����ִ���
	if(document.upform.view_title){
		if(document.upform.view_title.value == ""){
			alert("���� ������ �Է��ϼ���!");
			document.upform.view_title.focus();
			return;
		} 
	}
	
	//����ڿ��� alert�� ���� ���������� �����.
	//var transferMode;
	var securitylevel;
	var belongterm;
	var title;
	//if(document.upform.transfermode[0].checked == true){
		//transferMode = "�ڵ��̰�";
	//}
	//else
		//transferMode = "�����̰�";


	securitylevel 	= document.upform.securitylevel.options[document.upform.securitylevel.selectedIndex].value + "���";
	belongterm 	= document.upform.belongterm.options[document.upform.belongterm.selectedIndex].value + "��";
	title 		= document.upform.view_title.value;

	var reportInfo = "���� ������� : [����: "+title
			//+"   �̰����: " +transferMode
			+"  �������: " + securitylevel
			+"  �����Ⱓ: " +belongterm
			+ "]   �ۼ��� ���繮���� �����Ͻðڽ��ϱ�?";

	
	if(confirm(reportInfo)){
                
                clickFG = "true"; //Ȳ���� �߰�( ������ ��ư �� Ŭ�� ���� ���� �ʿ�)

		//ó���� ȭ���� ����...
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
//=============================�߰� ��===================================


var workingWnd = null;

function popupWorkingDlg(){

	var t = screen.height/2 - 35;
	var l = screen.width/2 - 145;
        var param = "width=290 height=70 scrollbars=no left= " + l + " top=" + t + " resizable=no" ;

	workingWnd = window.open("working.jsp", "ó����", param);
	workingWnd.focus();

}


function unloadPage(){
	if(workingWnd != null) workingWnd.close();
}



//����÷���� ÷�ι��� ����
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
	//---------Ȳ���� �߰� ---> ���� ������ �����ʾƼ� �ϴ� ����---------
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


//����������� ���ų� ����, ������ ������.
function viewUser(userid){
        var sFeatures = "dialogHeight: 100px; dialogWidth: 50px; center:on; scroll:no; status:no; unadorned:yes; help:no;"; 
	var win = window.showModalDialog("selectfunction.jsp?userid=" + userid , "", sFeatures);
}

//���缱 �߰� �� ����
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
     		alert(">, < �� ���� Ư�����ڰ� ���� ���ԵǾ� �ֽ��ϴ� ");
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
	var win = window.open(url , "���缱����", param);
	win.focus();
}

//������ process(���缱)ID�� �����´�
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

//���� �������� ����
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



//���������� ÷���Ѵ�.
function attachDoc(){

  var l = screen.width / 2 - 375;
  var t = screen.height / 2 - 225;
  var param = "width=750 height=480 scrollbars=no left=" +l+ " top=" +t; 
  var deptid = document.upform.deptid.value;
  var compid = document.upform.compid.value;
  var url = "attachcabinetframe.jsp?deptid=" + deptid + "&compid=" + compid;
  var win = window.open(url, "�����߰�", param);
  win.focus();	
}

function attachEdmsDoc(){
		var companycd = document.upform.companycd.value; //Ȳ���� �߰�
		var tempuploadurl = document.upform.tempuploadurl.value; //Ȳ���� �߰�
    var iMyWidth = (window.screen.width-700)/2
    var iMyHeight = (window.screen.height-476)/2
    win = window.open("/ed/modal/mdl_geardocframe.jsp?companycd=" + companycd + "&tempuploadurl=" + tempuploadurl, "sendedms","width=700, height=476, left=" + iMyWidth + ",top="+ iMyHeight +",screenX="+ iMyWidth +",screenY="+ iMyHeight +",toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no")
}


//÷�ε� ���������� ����Ʈ�ڽ��� �߰��Ѵ�.
function addAttachFile(filename, title){
	var index = document.upform.attachfile.options.length;
	var opt = new Option;
	opt.text = title;
	opt.value = filename;
	document.upform.attachfile.options[index] = opt;
}



//���� �ۼ�â �ݱ�
function closeDocument(){
	if(confirm("�����ۼ��� ����Ͻðڽ��ϱ�?"))
		parent.menu.refreshWindow();
}
 

function clearAttachFile(){
	var len = document.upform.attachfile.length;
	for(var i=len-1; i>0; i--){
		document.upform.attachfile.options[i] = null;
	}
	
}

//÷������ ���� ����
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

//����÷�� ������ ����
function attachFile(){

	var l = screen.width / 2 - 205;
	var t = screen.height / 2 - 85;

	var param = "width=400 height=177 scrollbars=no left=" + l + " top=" + t + "scrollbars=no";

	var win = window.open("attachfile.jsp", "����÷��", param);
	win.focus();
}

//÷������ ����߰�
function addFile(text){
	var opt = new Option;
	opt.value="";
	opt.text = text;	
	index = document.upform.attachfile.length;
	document.upform.attachfile.options[index] = opt;
}

//÷������ ��� ����
function deleteFile(index){
	document.upform.attachfile.options[index+1] = null;	
}

//÷������ ��� ����
function clearFile(){
	for(var i = document.upform.attachfile.length-1; i > 0; i--){
		document.upform.attachfile.options[i] = null;
	}
}

function delayTime(param){
	var funct ="openMime('"+param+"')";
	window.setTimeout(funct, 1);
//	document.we.setDefaultFont("����", 10, "����ü", 10);
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
	//shiftŰ�� ������
	if(event.shiftKey){
		if(event.keyCode == 222){
			alert("ū����ǥ�� �Է��� �� �����ϴ�");
		}
	}

}
