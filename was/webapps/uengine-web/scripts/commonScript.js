function userInfoMgt(userid) {
	fcnOpen('450','250','/srms/common/userInfoMgt?user_id='+userid,'userInfoMgt',false)
}
//document.write("<object id='factory' viewastext style='display:none' classid='clsid:1663ed61-23eb-11d2-b92f-008048fdd814' codebase='./smsx2.cab#Version=6,4,438,06'></object>")

function moveListPage(idx)
{
	var f = document.pageForm;
	f.page.value = idx;
	f.submit();
}
function setValueField(fld){
	var arrFldName = fld.name.split('[');
	var strFldId = arrFldName[0] + "_target";
	if (arrFldName.length > 1) {
		strFldId += "[" + arrFldName[1];
	}
	
	document.getElementById(strFldId).value = fld.value;
}

String.prototype.trim = function() {return this.replace(/(^\s*)|(\s*$)|($\s*)/g, "");} 

function jsCheckPoint( toCheck , Positive , Negative )
{
     var strPos = toCheck + "" ;
     var isPoint = true ;
     if ( jsCheckFloat ( toCheck ) )
     {
         var inx = strPos.indexOf(".") ;
         if ( inx == -1 )
         {
              if ( strPos.length > parseInt(Positive) )
                 isPoint = false ;
              else
                 isPoint = true ;
          }
          else
          {
               var pos = strPos.substring( 0, inx ) ;
               var nev = strPos.substring(inx + 1) ;
               if ( pos.length > parseInt(Positive) )
                     isPoint = false ;
               else if ( nev.length > parseInt(Negative) )
                     isPoint = false ;
               else
                     isPoint = true ;
          }
      }
      else if ( jsCheckNumber (toCheck) )
            isPoint = true  ;
      else
            isPoint = false ;

	  //alert(isPoint);
      return isPoint ;
}
function jsMakeForeignCurrency( varTextObj ) {
	//alert(varTextObj);
 //varTextObj.value = jsDeleteComma( varTextObj.value ) ;
 var varLength = varTextObj.value.length ;
 var varText   = "" ;
 var isPointed = false ;
 for ( var inx = 0 ; inx < varLength ; inx++ ) {
	 //varTextObj.value = 
  if ( jsCheckNumber(varTextObj.value.substring(inx, inx+1)) || (varTextObj.value.substring(inx, inx+1)=='.') ) {
   // 점이 안찍히고 처음으로 점이 들어왔을때
   if ( !isPointed && varTextObj.value.substring(inx, inx+1)=='.' ) {
    isPointed = true ;
    varText = varText + varTextObj.value.substring(inx, inx+1) ;
   // 숫자 일때
   } else if ( jsCheckNumber(varTextObj.value.substring(inx, inx+1)) ) {
    varText = varText + varTextObj.value.substring(inx, inx+1) ;
   }
  }
 }

 varTextObj.value = jsAddComma( varText ) ;
 }

 function jsCheckNumber(toCheck)
{
     var chkstr = toCheck+"" ;
     var isNum = true ;
     if ( jsCheckNull(toCheck) )
          return false;
     for (j = 0 ; isNum && (j < toCheck.length) ; j++)
     {
          if ((toCheck.substring(j,j+1) < "0") || (toCheck.substring(j,j+1) > "9"))
          {
             if ( toCheck.substring(j,j+1) == "-" || toCheck.substring(j,j+1) == "+")
             {
                if ( j != 0 )
                {
                   isNum = false;
                }
             }
             else
       isNum = false;
     }
     }
     if (chkstr == "+" || chkstr == "-") isNum = false;
     return isNum;
}

function jsDeleteComma( varNumber ){
 var varLength = varNumber.length ;
 varReturnNumber = "" ;
 for ( var inx = 0 ; inx < varLength ; inx++ ) {
  if ( varNumber.substring( inx, inx+1 ) != "," ) {
   varReturnNumber = varReturnNumber + varNumber.substring( inx, inx+1 ) ;
  }
 }
 return varReturnNumber ;
}

function jsCheckNull( toCheck )
{
     var chkstr = toCheck + "";
     var is_Space = true ;
     if ( ( chkstr == "") || ( chkstr == null ) )
    return( true );
     for ( j = 0 ; is_Space && ( j < chkstr.length ) ; j++)
     {
      if( chkstr.substring( j , j+1 ) != " " )
         {
        is_Space = false ;
         }
     }
     return ( is_Space );
}


function jsAddComma( varNumber ){
 // 숫자가 아니면 -1을 리턴한다.
 if ( jsCheckNull(varNumber) ) return "" ;
 if ( !jsCheckFloat(varNumber) ) {
  return -1 ;
 }
 // 소수 이상, 이하 부분을 따로 보관.
 var PointIndex = varNumber.indexOf(".") ;
 var varUnderPoint = "" ;
 var isPointed = false ;
 // 소수 이하가 없을때
 if ( PointIndex < 0 ) {
  isPointed = false ;
  // 소수 이하 부분
  varUnderPoint = "" ;
  // 소수 이상 부분
  varOverPoint = varNumber ;
 // 소수 이하가 있을때
 } else {
  isPointed = true ;
  // 소수 이하 부분
  varUnderPoint = varNumber.substring(PointIndex+1, varNumber.length ) ;
  // 소수 이상 부분
  varOverPoint = varNumber.substring(0, PointIndex) ;
 }
 // 음수일때 앞의 "-" 따로 보관
 var negativeFlag = false ;
 if ( varOverPoint.substring(0,1) == "-" ) {
  negativeFlag = true ;
  varOverPoint = varOverPoint.substring(1,varOverPoint.length+1) ;
 }
 // 소수 이상 부분에 comma 넣기
 var varLength = varOverPoint.length ;
 var varCnt = 0 ;
 var varTempReturnNumber = "" ;
 for ( var inx = varLength-1 ; inx >= 0 ; inx-- ) {
  varCnt++ ;
  // 소수점 찍기
  if ( varCnt == 4 ) {
   varTempReturnNumber = varOverPoint.substring( inx, inx+1 ) + "," + varTempReturnNumber ;
   varCnt = 1 ;
  // 소수점 안찍기
  } else {
   varTempReturnNumber = varOverPoint.substring( inx, inx+1 ) + varTempReturnNumber ;
  }
 }
 // 앞에 붙은 0 없애기 (예) 00200 -> 200
 varLength = varTempReturnNumber.length ;
 var varReturnNumber = "" ;
 for ( var inx = 0 ; inx < varLength ; inx++ ) {
  if ( varTempReturnNumber.substring(inx, inx+1) == '0' ) {
   // '0' 이 넘어왔을 경우 '0'을 그대로 리턴해야 한다.
   if ( varLength == 1 ) varReturnNumber = "0" ;
   else if ( eval(jsDeleteComma(varTempReturnNumber)) == '0' ) {
    varReturnNumber = "0" ;
    break ;
   }
  } else {
   varReturnNumber = varTempReturnNumber.substring(inx, varLength+1) ;
   break ;
  }
 }
 // 소수점 이하 붙이기
 if ( isPointed ) {
  varReturnNumber = varReturnNumber + "." + varUnderPoint ;
 }
 // 음수 붙이기
 if ( negativeFlag ) {
  varReturnNumber = "-" + varReturnNumber ;
 }
 return varReturnNumber ;
}

function jsCheckFloat(toCheck)
{
     var chkstr = toCheck+"" ;
     var isFloat = true;
     var chkPoint = false;
     var chkMinus = false;
     if ( jsCheckNull(toCheck) )
     {
           return false;
     }
     for (j = 0 ; isFloat && (j < toCheck.length); j++)
     {
         if ( (toCheck.substring(j,j+1) < "0") || (toCheck.substring(j,j+1) > "9"))
         {
            if ( toCheck.substring(j,j+1) == "." )
            {
               if ( !chkPoint ) chkPoint = true ;
               else  isFloat = false ;
            }
            else if ( toCheck.substring(j,j+1) == "-" || toCheck.substring(j,j+1) == "+")
            {
               if ( ( j == 0 ) && ( !chkMinus ) ) chkMinus = true ;
               else isFloat = false;
            }
            else isFloat = false;
        }
    }
    return isFloat;
}

function getCutNumber(num, place) {
 var returnNum;
 var str = "1";
 return Math.floor( num * Math.pow(10,parseInt(place,10)) ) / Math.pow(10,parseInt(place,10)); 
}

/*--------------------------------------------------
  기능   : 한글이든 영문이든 제대로 갯수 체크를 해준다.
  INPUT  : String
  RETURN :
----------------------------------------------------*/
function getByteLength(s){
   var len = 0;
   if ( s == null ) return 0;
   for(var i=0;i<s.length;i++){
      var c = escape(s.charAt(i));
      if ( c.length == 1 ) len ++;
      else if ( c.indexOf("%u") != -1 ) len += 2;
      else if ( c.indexOf("%") != -1 ) len += c.length/3;
   }
   return len;
}


/* Edit by truewater 영업일 체크 관련*/
/* 사용법 : formValidation.js 파일의 isAfterToday 함수 */
var xmlHttp;
document.write("<input type='hidden' name='tmpValue'>")

function createXMLHttpRequest() {
	if (window.ActiveXObject) {
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	} 
	else if (window.XMLHttpRequest) {
		xmlHttp = new XMLHttpRequest();
	}
	return xmlHttp;
}
    
function fcnCheckHoilday(L_Day) {
	
	createXMLHttpRequest();
	xmlHttp.onreadystatechange = handleStateChange;
	xmlHttp.open("GET", "/srms/common/code/checkHoilday?hoDate="+L_Day, false);
	xmlHttp.send(null);

}
    
function handleStateChange() {
	
	if(xmlHttp.readyState == 4) {
		if(xmlHttp.status == 200) {
			document.all.tmpValue.value = xmlHttp.responseText;
		}		
	}
}

function fcnFormCheck(L_eDate)
{
	fcnCheckHoilday(L_eDate);
	var tmpValue = document.all.tmpValue.value;
	
	if(tmpValue.indexOf("0") > 0)
	{
		return false;
	}else
	{
		return true;
	}
}

// 창닫기
function fcnPopupClose()
{
	self.close();
}

//Radio, Check Box Value를 Checked해준다. 2009-03-20 BDS
function setCheckedValue(Obj, newValue) {
	if(!Obj) return;
	var objLength = Obj.length;
	if(objLength == undefined) {
		Obj.checked = (Obj.value == newValue.toString());
		return;
	}
	for(var i = 0; i < objLength; i++) {
		if(Obj[i].value == newValue.toString()) {
			Obj[i].checked = true;
			break;
		}
	}
	return;
}

function psbar(){
	var psbar = '<br>';
		psbar += '<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="230" height="54" id="loadbar" align="middle">';
        psbar += '<param name="allowScriptAccess" value="sameDomain">';
        psbar += '<param name="allowFullScreen" value="false">';
        psbar += '<param name="movie" value="/Flash/loadbar.swf">';
        psbar += '<param name="quality" value="high">';
        psbar += '<param name="bgcolor" value="#ffffff">';
        psbar += '<embed src="/Flash/loadbar.swf" quality="high" bgcolor="#ffffff" width="230" height="54" name="loadbar" align="middle" allowscriptaccess="sameDomain" allowfullscreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />';
        psbar += '</object>';
    
    return psbar;
}

function openLoadBar(){
	dhtmlmodal.open('bar', 'div', 'loadbar', 'Loading...', 'width=240px,height=65px,center=1,resize=0,scrolling=0');
}

/** 
 * string String::cut(int len)
 * 글자를 앞에서부터 원하는 바이트만큼 잘라 리턴합니다.
 * 한글의 경우 2바이트로 계산하며, 글자 중간에서 잘리지 않습니다.
 */
 String.prototype.cut = function(len) {
         var str = this;
         var l = 0;
         for (var i=0; i<str.length; i++) {
                 l += (str.charCodeAt(i) > 128) ? 2 : 1;
                 if (l > len) return str.substring(0,i) + "...";
         }
         return str;
 }
 /** 
 * bool String::bytes(void)
 * 해당스트링의 바이트단위 길이를 리턴합니다. (기존의 length 속성은 2바이트 문자를 한글자로 간주합니다)
 */
 String.prototype.bytes = function() {
         var str = this;
         var l = 0;
         for (var i=0; i<str.length; i++) l += (str.charCodeAt(i) > 128) ? 2 : 1;
         return l;
 }
 
/** 
 * 회의체 승인금액 합계 처리 
 * 
 */
 
tempValue = 0;

function asumtest(v){
	tempValue = eval(jsDeleteComma(v.value));
}

function amtSum(tmpElement) {
	var value = tmpElement.value;
	if (value == ""){
		value = 0;
	}else{
		value = eval(jsDeleteComma(value));
	}
	var splitId = tmpElement.id.split("[");
	var tmpElId = splitId[0];
	var tmpIndex = splitId[1];
	
	if (tmpIndex) {
		if (value == 0){
			value = 0;
			tempId = tmpElId+"["+tmpIndex;
			document.getElementById(tempId).value = 0;
		}
		var amtotsum = document.getElementById("amtotsum[" + tmpIndex).value;
		amtotsum = eval(jsDeleteComma(amtotsum));
		if (tempValue > value){
			value = Number(tempValue) - Number(value);
			value = Number(amtotsum) - Number(value);
			value = String(value);
			value = formatNumberValue(value);
			document.getElementById("amtotsum[" + tmpIndex).value = value;
		}else if (tempValue < value){
			value = Number(value) - Number(tempValue);
			value = Number(amtotsum) + Number(value);
			value = String(value);
			value = formatNumberValue(value);
			document.getElementById("amtotsum[" + tmpIndex).value = value;
		}
	} else {
		if (value == 0){
			value = 0;
			document.getElementById(tmpElId).value = 0;
		}
		var amtotsum = document.getElementById("amtotsum").value;
		amtotsum = eval(jsDeleteComma(amtotsum));
		if (tempValue > value){
			value = Number(tempValue) - Number(value);
			value = Number(amtotsum) - Number(value);
			value = String(value);
			value = formatNumberValue(value);
			document.getElementById("amtotsum").value = value;
		}else if (tempValue < value){
			value = Number(value) - Number(tempValue);
			value = Number(amtotsum) + Number(value);
			value = String(value);
			value = formatNumberValue(value);
			document.getElementById("amtotsum").value = value;
		}
	}
}
 
function fncOpenProcMgt(url){
	fcnOpen(1024,768,url,'ProcessMgt','Y')
}
 
 