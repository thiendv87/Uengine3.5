//function compareDate(startFieldName, endFieldName) {
//
//   	var startDateField = document.getElementById(startFieldName);
//   	var startDateString = startDateField.value;
//   	intYear = parseInt(startDateString.substr(0,4),10);
//	intMon = parseInt(startDateString.substr(5,2),10);
//	intDay = parseInt(startDateString.substr(8,2),10);	
//	var startDate = new Date(intYear, intMon-1, intDay);
//	
//	var endDateField = document.getElementById(endFieldName);
//	var endDateString = endDateField.value;
//	intEndYear = parseInt(endDateString.substr(0,4),10);
//	intEndMon = parseInt(endDateString.substr(5,2),10);
//	intEndDay = parseInt(endDateString.substr(8,2),10);
//	var endDate = new Date(intEndYear, intEndMon-1, intEndDay);
//	
//	if(endDate.getTime() - startDate.getTime() < 0) {
//		alert("날짜 선택 에러메세지");
//	} 
//}

// TEXT FIELD CONTROL //////////////////////////////////////////////////////////////////////////
function formatInteger(strNumber) {
	strNumber = strNumber.replace(/,/g, '');
	strNumber = strNumber.replace(/[^0-9]/g, '');
	return strNumber.replace(/(\d)(?=(?:\d{3})+(?!\d))/g,'$1,');
}

function handlerNum( objInput ) {
	//숫자만 입력 받게끔 하는 함수.
	var e = window.event; //윈도우의 event를 잡는것입니다.
	var code = e.keyCode;

	//입력 허용 키
	if (
		( code >=  48 && code <=  57 ) || 	//숫자열 0 ~ 9 : 48 ~ 57
		( code >=  96 && code <= 105 ) || 	//키패드 0 ~ 9 : 96 ~ 105
		code == 110 || 	//소수점(.) : 문자키배열
		code == 190 || 	//소수점(.) : 키패드
		code == 46 || 	//Delete
		code == 37 || 	//좌 화살표
		code == 39 || 	//우 화살표
		code == 35 || 	//End 키
		code == 36 || 	//Home 키
		code == 8 ||   	//BackSpace
		code == 9    	//Tab 키
	) {
		e.returnValue = true;
	}
	else {
		alert('숫자만 입력할 수 있습니다');
		e.returnValue = false;
	}
}


function formatNumber(objInput) {
	var code = window.event.keyCode;
	//숫자열 0 ~ 9 : 48 ~ 57 || 키패드 0 ~ 9 : 96 ~ 105
	if (( code >=  48 && code <=  57 ) || ( code >=  96 && code <= 105 )
		|| code == 110 || code == 190
	) {
		var strData = objInput.value;
		var splitStrData = strData.split('.');
		var strInteger = formatInteger(splitStrData[0]);
		var strDecimal = splitStrData[1]

//		alert(strDecimal);
		if (strDecimal != undefined) {
			strDecimal = "." + strDecimal.substr(0, 1);
		} else {
			strDecimal = "";
		}
		
		objInput.value = strInteger + strDecimal;
	}
}

// value 값 처리 09.04.08 신경인  /////////////////////////////////////////////////////////////
function formatNumberValue(Input) {
		var strData = Input;
		
		var splitStrData = strData.split('.');
		var strInteger = formatInteger(splitStrData[0]);
		var strDecimal = splitStrData[1]

		if (strDecimal != undefined) {
			strDecimal = "." + strDecimal.substr(0, 1);
		} else {
			strDecimal = "";
		}
		
		Input = strInteger + strDecimal;
		return Input;
}

// TEXT DATA 입력데이터 사이즈 체크 //////////////////////////////////////////////////////////////
function checkLimitText(objInput) {
	maxlengthLimit(objInput, 2, 300);
}

// textarea 입력데이터 사이즈 체크
function checkLimitTextarea(objInput) {
	maxlengthLimit(objInput, 2, 4000);
}

function maxlengthLimit(input, gubunflag, maxByte) {
	//위:38,아래:40,오른쪽:39,왼쪽:37
	if ( event.keyCode < 37 || event.keyCode > 40 ) {
		//input.focus();
		var checkedData = getCheckLimitString(input.value, gubunflag, maxByte);
		if (checkedData) {
			input.value = checkedData;
		}
	}
}

function addIframeLimitEvent(objFrame) {
	var xEditingArea = objFrame.contentWindow.document.getElementById("xEditingArea");
	xEditingArea.attachEvent("onclick", function() { checkLimitRichText(xEditingArea); });
}

function checkLimitRichText(editingArea) {
	//위:38,아래:40,오른쪽:39,왼쪽:37
	if ( event.keyCode <37 || event.keyCode >40 ) {
		//editingArea.focus();
		var checkedData = getCheckLimitString(editingArea.innerHTML, 2, 4000);
		if (checkedData) {
			editingArea.innerHTML = checkedData
		}
	}
}

function getCheckLimitString(strData, gubunflag, maxByte) {
	var strCount = 0;
	var tempStr, tempStr2;
	for(var i = 0; i < strData.length; i++) {
		tempStr = strData.charAt(i);
		if(escape(tempStr).length > 4) strCount += 2;
		else strCount += 1 ;
	}

	if (strCount > maxByte) {
		if ( gubunflag == 2 ) {
			alert("최대 " + maxByte + "byte이므로 초과된 글자수는 자동으로 삭제됩니다.");
		}
		strCount = 0;
		tempStr2 = "";

		for(var i = 0; i < strData.length; i++)	{
			tempStr = strData.charAt(i);
			if(escape(tempStr).length > 4) strCount += 2;
			else strCount += 1 ;
			if (strCount > maxByte)							{
				if(escape(tempStr).length > 4) strCount -= 2;
				else strCount -= 1 ;

				break;
			} else {
				tempStr2 += tempStr;
			}
		}
	}

	return tempStr2;
}

// CALENDAR CONTROL /////////////////////////////////////////////////////////////////////////
function getStrDate(dt, sep) {
	var separator = sep || "";
	var arrDate = new Array();
	
	var date = dt.getDate();
	var month = dt.getMonth() + 1;
	
	arrDate[0] = dt.getFullYear();
	arrDate[1] = month.toString().length < 2 ? month = "0" + month : month;
	arrDate[2] = date.toString().length < 2 ? date = "0" + date : date;
	
	return arrDate.join(separator); 
}

function isAfterToday(objDate) {
	var strDate = objDate.value;

	if (strDate) {
		var splitStrDate = strDate.split('-');
		var dateToday = new Date();
		var intToday = parseInt(getStrDate(dateToday, ""));
		// - 1 은 한 month 가 0부터 시작하기 때문이다.
		var dateUserday = new Date(splitStrDate[0], splitStrDate[1] -1, splitStrDate[2]);
		var intUserday = parseInt(getStrDate(dateUserday, ""));


		if (dateUserday != "NaN") {
			if (intToday > intUserday) {
				alert("날자선택 오류! \n오늘 이후 날자를 선택해 주세요!");
				clearInputObject(objDate);
				return;
			}
		} else {
			alert(" 올바른 날자의 형식이 아닙니다. \nYYYY-MM-dd 의 형식이 필요합니다.");
			clearInputObject(objDate);
			return;
		}
		
//		fcnCheckHoilday(intUserday, objDate);
		if(!fcnFormCheck(intUserday))
		{
			alert("날자선택 오류! \n휴일은 선택할 수 없습니다!");
			clearInputObject(objDate);
		}
	}
	
	return intUserday;
}


function compareDate(strSdateId, objEdate) {
	var isTrue = true;
	var objSdate = document.getElementById(strSdateId);
	var intSdate = isAfterToday(objSdate);
	var intEdate = isAfterToday(objEdate);
	if (intSdate > intEdate) {
		isTrue = false;
		alert("Massage : 시작일이 종료일보다 뒤에 있습니다.");
		clearInputObject(objEdate);
	}
	return isTrue;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

function fmtNumber(tmpInt) {
	
	onlyNumber(tmpInt);
	//var re = new RegExp('(-?[0-9]+)([0-9]{3})'); 
	//var re = new RegExp('^[+-]?[\d,]*(\.?\d*)$');
	//var re = new RegExp('([0-9])([0-9][0-9][0-9][,.])');
	//tmpInt.value = tmpInt.value.toString().replace(re, "$1,$2");
	
	var reg = /(^[+-]?\d+)(\d{3})/;
    while (reg.test(tmpInt.value)) {
    	tmpInt.value = tmpInt.value.toString().replace(reg, '$1' + ',' + '$2');
    }

}

function calBytes(str) {
  var tcount = 0;
  var tmpStr = new String(str);
  var temp = tmpStr.length;
  

  var onechar;
  for ( k=0; k<temp; k++ ) {
    onechar = tmpStr.charAt(k);
    if (escape(onechar).length > 4)
    {
      tcount += 2;
    }
    else
    {
      tcount += 1;
    }
  }
  return tcount;
}


function onlyNumber(loc) {
	if(/[^0123456789,]/g.test(loc.value)) {
		alert("숫자가 아닙니다.\n\n0-9의 정수만 허용합니다.");
		loc.value = "";
		loc.focus();
	}
}

function clearInputObject(objInput) {
	objInput.value = "";
	objInput.focus();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// EX - 사용 예제

// 숫자 콤마 + 소수점1자리 + 입력제한
//<input type="text" onkeydown="handlerNum(this);" onkeyup="formatNumber(this);" />

// 글자 바이트 제한 걸기
//<input type="text" onKeyUp="checkLimitText(this);"/>
//<textarea onkeyup="checkLimitTextarea(this);"></textarea>
//<iframe onkeyup="checkLimitRichText(this);"></iframe>

// 날자 비교 
//시작 : <input type="text" id="mySdate"  value="2009-02-28" onchange="isAfterToday(this);" /> <br />
//종료 : <input type="text" id="myEdate"  value="2009-02-28" onchange="compareDate('mySdate', this);" /> <br />
//태그라이브러리
//시작 : <input:calendar name="mySdate" limited="today" ....
//종료 : <input:calendar name="myEdate" limited="mySdate" ....
/////////////////////////////////////////////////////////////////////////////////////////////////////////

function stripCommas(numString) {
 
    numString = numString + "";
 
    var re = /,/g;
    return numString.replace(re,"");
}

