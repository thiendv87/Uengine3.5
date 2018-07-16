// common.js 삽입한 페이지의 경우 진행 상태 박스 스크립트 자동 삽입됨
loadingHtml = 	"<div id=\"loadingBox\" style=\"z-index:10;position:absolute;width:100%;height:100%;top:0;left:0;display:none;\">"
							+ "<table width=\"835\" height=\"100%\">"
							+ "<tr>"
							+ "<td align=center class=\"f03\"><u>* 조회중입니다. 잠시만 기다려 주시기 바랍니다. *</u><p><img src=\"/jsp/web/images/loading_wait.gif\"></td>"
							+ "</tr>"
							+ "</table>"
							+ "</div>";
document.write( loadingHtml );
document.all.loadingBox.style.backgroundColor = "#ffffff";
document.all.loadingBox.style.filter = "alpha(opacity:55)";

// 진행 상태 박스 View 함수
function loadingBoxView()
{
	if(document.all.loadingBox) {
		if(document.all.loadingBox.style.display == "none") {
			document.all.loadingBox.style.display = "block";
		}
	}
}

// 진행 상태 박스 Hidden 함수
function loadingBoxClose()
{
	if(document.all.loadingBox) {
		if(document.all.loadingBox.style.display == "block") {
			document.all.loadingBox.style.display = "none";
		}
	}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function flashObject(file_name,flashVar,width,height){
  document.write('<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="' + width + '" height="' + height + '">');
  document.write('<param name="movie" value="' + file_name + '">');
  document.write('<param name=FlashVars value="' + flashVar + '">');
  document.write('<param name="quality" value="high">');
  document.write('<param name="wmode" value="transparent">');
  document.write('<embed src="' + file_name +'" FlashVars="' + flashVar +'" width="' + width + '" height="' + height + '" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" wmode="transparent"></embed>');
  document.write('</object>');
}


function imgResize(img){ 
  img1= new Image(); 
  img1.src=(img); 
  imgControll(img); 
} 

function imgControll(img){ 
  if((img1.width!=0)&&(img1.height!=0)){ 
    viewImage(img); 
  } 
  else{ 
    controller="imgControll('"+img+"')"; 
    intervalID=setTimeout(controller,20); 
  } 
} 

function viewImage(img){ 
        W=img1.width; 
        H=img1.height; 
        O="width="+W+",height="+H; 
        imgWin=window.open("","",O); 
        imgWin.document.write("<html><head><title>Dobongsan parish</title></head>"); 
        imgWin.document.write("<body topmargin=0 leftmargin=0>"); 
        imgWin.document.write("<img src="+img+" onclick='self.close()' style='cursor:hand'>"); 
        imgWin.document.close(); 
} 

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}

function MM_popupMsg(msg) { //v1.0
  alert(msg);
}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}

function MM_popupMsg(msg) { //v1.0
  alert(msg);
}

// iframe resize Function
function resize() {
	var objBody = ifrm.document.body;
	var objFrame = document.all["ifrm"];
	objFrame.style.width = '100%';

	objFrame.style.width = objBody.scrollWidth + (objBody.offsetWidth - objBody.clientWidth);
	objFrame.style.height = objBody.scrollHeight + (objBody.offsetHeight - objBody.clientHeight);
}

// iframe initialize Function
function initFrame() {
	loadingBoxClose();
  parent.resize();
}

//테이블 병합
function mergeCell(tbl, startRow, cNum, length, add)
	{
		var isAdd = false;
		if(tbl == null) return;
		if(startRow == null || startRow.length == 0) startRow = 1;
		if(cNum == null || cNum.length == 0) return ;
		if(add  == null || add.length == 0) {
			isAdd = false;
		}else {
			isAdd = true;
			add   = parseInt(add);
		}
		cNum   = parseInt(cNum);
		length = parseInt(length);
	
		rows   = tbl.rows;
		rowNum = rows.length;
	
		tempVal  = '';
		cnt      = 0;
		startRow = parseInt(startRow);
	
		for( i = startRow; i < rowNum; i++ ) { 
			curVal = rows[i].cells[cNum].innerHTML;
			if(isAdd) curVal += rows[i].cells[add].innerHTML;
			if( curVal == tempVal ) {
				if(cnt == 0) {
					cnt++;
					startRow = i - 1;
				}
				cnt++;
			}else if(cnt > 0) {
				merge(tbl, startRow, cnt, cNum, length);
				startRow = endRow = 0;
				cnt = 0;
			}else {
			}
			tempVal = curVal;
		}
	
		if(cnt > 0) {
			merge(tbl, startRow, cnt, cNum, length);
		}
	}
	
	function merge(tbl, startRow, cnt, cellNum, length)
	{
		rows = tbl.rows;
		row  = rows[startRow];
	
		for( i = startRow + 1; i < startRow + cnt; i++ ) {
			for( j = 0; j < length; j++) {
				rows[i].deleteCell(cellNum);
			}
		}
		for( j = 0; j < length; j++) {
			row.cells[cellNum + j].rowSpan = cnt;
		}
	}

	
	// 숫자만 입력가능한 함수
	function onlyNumber()
	{
		// 입력받은 키의 아스키코드값을 얻는다.
		t = event.keyCode;
	
		// 입력받은 키가 숫자, bs, del, tab, <-, ->, '.'중에 하나일 경우
		if((t >= 46 && t <= 57) || (t >= 96 && t <= 105) || t == 8 || t == 9 || t == 37 || t == 39 || t == 46 || t == 190 || t == 110)
			return true;
		else
			event.returnValue = false;	
	}
	
	//특수 문자 체크 함수
	function inputCheckSpecial(frm, on_off)
	{
		if(on_off == "on") {
			re = /[~\`!@\#$%^&*\()\=+_,.<>?;:\'\"\[\]\{\}\'\/\\\|]/;
		} else if(on_off == "off") {
			re = /[\`\'\"\'<>&]/;
		}
	
		if(re.test(frm.value)){
			alert("특수문자는 입력하실수 없습니다.");
			frm.focus();
			frm.value = "";
		}
	}

  // 공백검사
	function trim(val){
		if(val=='') return "";
		else{
			val = lTrim(val);
			val = rTrim(val);
			return val;
		}
	}
	
	// 왼쪽공백검사
	function lTrim(val){
		if ( val != null && val != "")	{
			var search = 0;
			while ( val.charAt(search) == " ")	{
				search = search + 1;
			}
			val = val.substring(search, (val.length));
		}
		return val;
	}
	
	// 오른쪽공백검사
	function rTrim(val){
		if ( val != null && val != "")	{
			var search = val.length - 1;
			while (val.charAt(search) == " ")	{
				search = search - 1;
			}
			val = val.substring(0, search + 1);
		}	return val;
	}

	// UTF-8로 변환 함수
	function toUTF8(szInput){
		var wch,x,uch="",szRet="";
		for (x=0; x<szInput.length; x++){
			wch=szInput.charCodeAt(x);
			if (!(wch & 0xFF80)) {
				//szRet += "%" + wch.toString(16);
				szRet += szInput.charAt(x);
			}else if (!(wch & 0xF000)) {
				uch = "%" + (wch>>6 | 0xC0).toString(16) + "%" + (wch & 0x3F | 0x80).toString(16);
				szRet += uch.toUpperCase();
			}else {
				uch = "%" + (wch >> 12 | 0xE0).toString(16) + "%" + (((wch >> 6) & 0x3F) | 0x80).toString(16) + "%" + (wch & 0x3F | 0x80).toString(16);
				szRet += uch.toUpperCase();
			}
		}
		return(szRet); 
	}
		
		
	/*
		페이지 이동 함수(페이징)
		@param : 현재 페이지 Index
		@task : 이동페이지 index의 파라미터 정보만 변경 / 이동
	*/
	function moveListPage(idx)
	{
		// 현재 페이지 URL정보
		var pageHref = document.location.href;
		// 현재 URL에 파라미터가 존재하는지 체크
		var parameterIndex = pageHref.indexOf("?");
		// 파라미터 시작 설정 : ?, &
		var pageParameter = "";
	
		if(parameterIndex == -1)  {
			pageParameter = "?page=" + idx;
			pageHref += pageParameter;
		} else {	
			// 현재 페이지 index 파라미터 위치
			var pageParameterIndex;
			// 현재 페이지 index 파라미터 다음 파라미터 위치
			var pageParameterNextIndex;
	
			// 파라미터를 제외한 기본 URL 정보
			var basePageHref = "";
			// 현재 페이지 index 파라미터 정보
			var pageParameterHref = "";
			// 현재 페이지 index 파라미터 다음 파라미터 정보
			var nextPageHref = "";
	
			// 현재 페이지 index 파라미터 시작 문구 설정 (파라미터 첫 시작이 아니므로 "&" 로 시작)
			pageParameter = "&";
			
			// 현재 페이지 index 가 시작하는 위치 설정
			pageParameterIndex = pageHref.indexOf("page=");
			
			// "page=" 파라미터가 존재하지 않는 경우
			if((pageParameterIndex < 0)) {
				// 현재 페이지 index 파라미터 정보 설정
				pageParameterHref = pageHref.substring(pageParameterIndex, pageHref.length);
				
				// 최종 이동 파라미터 설정
				pageHref = pageParameterHref + "&page=" + idx;				
			} else {
				// 기본 URL 정보 설정
				basePageHref = pageHref.substring(0, pageParameterIndex);
				// 현재 페이지 index 파라미터 정보 설정
				pageParameterHref = pageHref.substring(pageParameterIndex, pageHref.length);
					
				// 현재 페이지 index 파라미터 다음 파라미터 시작 위치 설정
				pageParameterNextIndex = pageHref.substring(pageParameterIndex, pageHref.length).indexOf("&");
				// 현재 페이지 index 파라미터 다음 파라미터 정보 설정
				nextPageHref = (pageParameterNextIndex == -1) ? "" : pageParameterHref.substring(pageParameterNextIndex, pageParameterHref.length);
				
				// 최종 이동 파라미터 설정
				pageHref = basePageHref + "page=" + idx + nextPageHref;				
			}
		}
		// 페이지 이동
		location.href = pageHref;
	}
	
	// 첨부파일 다운로드 함수
	function downloadFile(path, fileName, saveName)
	{
		if(saveName != null) {
			top.location.href = "/rms/common/page/download?filePath=" + path + "&fileName=" + fileName + "&saveName=" + toUTF8(saveName);
		} else {
			top.location.href = "/rms/common/page/download?filePath=" + path + "&fileName=" + fileName;
		}
	}


//aro_name 오브젝트의 입력 글자수를 ari_max바이트로 제한한다.
//해당 오브젝트에 onkeyup="chkByteLmtd(this,10);" 식으로 추가하면 됨.
function chkByteLmtd(aro_name,ari_max)
{

   var ls_str     = aro_name.value; // 이벤트가 일어난 컨트롤의 value 값
   var li_str_len = ls_str.length;  // 전체길이

   // 변수초기화
   var li_max      = ari_max; // 제한할 글자수 크기
   var i           = 0;  // for문에 사용
   var li_byte     = 0;  // 한글일경우는 2 그밗에는 1을 더함
   var li_len      = 0;  // substring하기 위해서 사용
   var ls_one_char = ""; // 한글자씩 검사한다
   var ls_str2     = ""; // 글자수를 초과하면 제한할수 글자전까지만 보여준다.

   for(i=0; i< li_str_len; i++)
   {
      // 한글자추출
      ls_one_char = ls_str.charAt(i);

      // 한글이면 2를 더한다.
      if (escape(ls_one_char).length > 4)
      {
         li_byte += 2;
      }
      // 그밗의 경우는 1을 더한다.
      else
      {
         li_byte++;
      }

      // 전체 크기가 li_max를 넘지않으면
      if(li_byte <= li_max)
      {
         li_len = i + 1;
      }
   }
   
   // 전체길이를 초과하면
   if(li_byte > li_max)
   {
      alert( li_max + " 글자를 초과 입력할수 없습니다. \n 초과된 내용은 자동으로 삭제 됩니다. ");
      ls_str2 = ls_str.substr(0, li_len);
      aro_name.value = ls_str2;
      
   }
   aro_name.focus();   
}

function openEmpDetailInfo(empNo)
{
		window.open("/rms/information/personnel/selectEmpInfo?compNo=" + empNo, "customInfo", "width=734, height=610, left=100, top=50, scrollbars=auto, resizable=yes");
}
