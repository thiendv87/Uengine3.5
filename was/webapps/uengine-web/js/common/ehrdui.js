/**
 *------------------------------------------------------------------------------
 * PROJ : wooribank
 * NAME : wooribankui.js
 * DESC : common util functions
 * Author : iblackpet_admin
 * VER  : v1.0  * 
 * Copyright 2007 wooribank S&C All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항                       
 *------------------------------------------------------------------------------
 *    DATE     AUTHOR                      DESCRIPTION                        
 * ----------  ------  --------------------------------------------------------- 
 * 2007. 12. 26  	iblackpet_admin  최초 프로그램 작성                                     
 *----------------------------------------------------------------------------
 */

/* 
 * --------------------------------------------------------------------
 * Validation Util Functions
 * --------------------------------------------------------------------
 * cfCheckNullString( ctl, desc ) 
 * 	<DESC>
 * 		{ctl}에 값이 입력되지 않았을 경우(공백Only포함) {desc} alert
 * 	</DESC>
 * 	<CODE>
 * 		if( !cfCheckNullString( frm.userNm, "사용자이름" ) ) return;
 * 	</CODE>
 * 
 * cfCheckNullString2( ctl1, ctl2, desc )
 * 	<DESC>
 * 		{ctl1}과 {ctl2}중 하나라도 값이 입력되지 않았을 경우 {desc} alert
 * 	</DESC>
 * 	<CODE>
 * 		if( !cfCheckNullString2( frm.ssn1, frm.ssn2, "주민등록번호" ) ) return;
 * 	</CODE>
 * 
 * cfCheckNullStrings()
 * 	<DESC>
 * 		파라메터로 입력된 모든 컨트롤 중 하나라도 값이 입력되지 않았을 경우 마지막 String type의 파라메터 alert
 * 	</DESC>
 * 	<CODE>
 * 		if( !cfCheckNullStrings( frm.txt1, frm.txt2, frm.txt3, frm.txt4, ... , "체크된 모든항목" ) ) return;
 * 	</CODE>
 * 
 * cfIsNullStrings()
 * 	<DESC>
 * 		cfCheckNullStrings와 동일하나 alert 없이 true/false만 리턴 (기타처리가 필요할 시 사용)
 * 	</DESC>
 * 	<CODE>
 * 		if( !cfIsNullStrings( frm.txt1, frm.txt2, frm.txt3 ) ) {
 * 			// process logic here!
 * 		}
 * 	</CODE>
 * 
 * cfCheckSelectIndex( ctl, desc, checkIndex )
 * 	<DESC>
 * 		ComboBox에 유효한 항목이 선택되지 않았을 경우 {desc} alert
 * 		{checkIndex} default value : 0
 * 	</DESC>
 * 	<CODE>
 * 		if( !cfCheckSelectIndex( frm.sel1, "지역" ) ) return;
 * 
 * 		if( !cfCheckSelectIndex( frm.sel1, "지역", 1 ) ) return;  // 반드시 2번째(index:1) 이외의 항목을 선택해야한다!
 * 	</CODE> 
 * 
 * cfCheckMultiChecked( ctl, desc, limit )
 * 	<DESC>
 * 		Radio/CheckBox에 {limit}개 이하로 선택됬을 경우 {desc} alert
 * 		{limit} default value : 1
 * 	</DESC>
 * 	<CODE>
 * 		if( cfCheckMultiChecked( frm.chk1, "취미", 2 ) ) return;  // 취미는 반드시 2개 이상 선택해야한다!
 * 	</CODE>
 * 
 * cfSameValue( ctl1, ctl2, ctl1Name, ctl2Name )
 * 	<DESC>
 * 		{ctl1}값과 {ctl2}값의 미 일치시 "{ctl1Name}과 {ctl2Name}의 값이 일치하지 않습니다." alert
 * 	</DESC>
 * 	<CODE>
 * 		if( cfSameValue( frm.pass, frm.pass2, "비밀번호", "비밀번호확인" ) ) return;
 * 	</CODE>
 * 
 * 
 * --------------------------------------------------------------------
 * Form Control Util Functions
 * --------------------------------------------------------------------
 * cfRemoveFileValue( obj )
 *  <DESC>
 *  	<INPUT type="file"> Control의 value 값을 지워준다. (readonly 이므로 value="" 으로 설정할 수 없다!)
 *  </DESC>
 *  <CODE>
 *  	<INPUT type="file" name="file1"> // HTML Code
 *  
 *  	cfRemoveFileValue( frm.file1 ); // SCRIPT Code
 *  </CODE>
 * 
 * cfChangeAllCheckedState( ctl, state )
 *  <DESC>
 * 		{ctl} checkbox group의 checked 상태를 일괄적으로 변경
 *  </DESC>
 *  <CODE>
 *  	<INPUT type="checkbox" onclick="cfChangeAllCheckedState( frm.chkList, this.checked )">전체선택
 *  </CODE>
 * 
 * cfSelectOptionByValue( obj, val, _defaultIdx )
 *  <DESC>
 *  	ComboBox의 selectedIndex를 {OPTION value} == {val} 인 항목으로 변경 (지정된 {val}이 없을경우 _defaultIdx로 selected된다!)
 *  </DESC>
 *  <CODE>
 *  	cfSelectOptionByValue( frm.sel1, "01" );
 *  	cfSelectOptionByValue( frm.sel1, "01", 1 ); // "01" 이 없을경우 index 1의 항목이 selected된다!
 *  </CODE>
 * 
 * cfCheckItemByValue( obj, val, _defaultIdx )
 *  <DESC>
 *  	Radio control의 checked 항목을 value == {val} 인 항목으로 변경 (지정된 {val}이 없을경우 _defaultIdx로 selected된다!)
 *  </DESC>
 *  <CODE>
 *  	cfCheckItemByValue( frm.rdo1, "001" );
 *  	cfCheckItemByValue( frm.rdo1, "001", 0 ); // "001" 이 없을경우 index 0의 항목이 checked된다!
 *  </CODE>
 * 
 * cfGetCheckedValues( obj )
 *  <DESC>
 *  	Radio / CheckBox control의 checked된 item value를 Array로 반환
 *  </DESC>
 *  <CODE>
 *  	var values = cfGetCheckedValues( frm.chk1 ); // [ "val1", "val2", "val5" ] 처럼 Array로 return
 *  </CODE>
 *  
 * cfSubmit( obj, _loading, _uri )
 *  <DESC>
 *    [일반페이지 / BPF.Popup]을 Form submit() 한다!
 *    submit() 전에 loading block 호출!
 *  </DESC>
 *  <CODE>
 *    // HTML Code
 *    <form name="frm">
 *      <button onclick="submit1( this );">저장</button>
 *    </form>
 *    
 *    // SCRIPT Code
 *    function submit1( obj ) {
 *      // TODO something...(e.g. validation)
 *      cfSubmit( obj, false, '/wooribank/submitPageUri' );
 *      // @param _loading : loading block 호출여부 (default : true) 
 *      // FORM.action이 기 지정되어 있을 경우 [_uri]인자는 생략가능!
 *      // [obj]는 FORM Element이어도 되고 FORM 하위의 Form Control이어도 상관없음!
 *    }
 *  </CODE>
 *  
 * 
 * --------------------------------------------------------------------
 * Common Util Function
 * --------------------------------------------------------------------
 *  
 * cfShowCalendar( el )
 *  <DESC>
 *  	TextBox control에 입력할 날짜를 선택할 수 있는 달력팝업 호출
 *  </DESC>
 *  <CODE>
 *  	cfShowCalendar( 'txt1' ); // <INPUT type='text' id='txt1'>에 입력할 날짜선택 달력을 호출한다!
 *  </CODE>
 *  
 * cfShowTooltip( e, width, body, _title )
 *  <DESC>
 *    Tooltip layer를 보여준다
 *  </DESC>
 *  <CODE>
 *    <!-- {width:200px} tooltip을 보여주자! -->
 *    <td onmouseover="cfShowTooltip(event, 200, '· 일정:xxxxxxx~xxxxxxxx<br>· 강의:yyyyyy~yyyyyyyy', '제목은여기에');">
 *    <!-- 제목은 option 이다! -->
 *    <td onmouseover="cfShowTooltip(event, 200, '· 일정:xxxxxxx~xxxxxxxx<br>· 강의:yyyyyy~yyyyyyyy');">
 *  </CODE>
 * 
 * cfOpenUserSearch( frm, userId, _userName, _dept, _position )
 *  <DESC>
 *    사용자검색 팝업 호출, 선택된 사용자정보를 base page control에 출력해준다.
 *  </DESC>
 *  <CODE>
 *    // HTML Code
 *    <form name="frm">
 *      아이디: <input type="text" name="userId">
 *      이름: <input type="text" name="userName">
 *      소속부서: <input type="text" name="dept">
 *      직급: <input type="text" name="position">
 *    </form>
 *    
 *    // SCRIPT Code
 *    cfOpenUserSearch( "frm", "userId", "userName", "dept", "position" );
 *    // frm, userId param은 필수이며
 *    // userName, dept, position param은 선택사항이다!
 *  </CODE>
 * 
 * cfShowGridNoData( el, dataSize, _height )
 *  <DESC>
 *  	Ext grid / TABLE grid에 binding된 데이터가 없을경우 GRID_NO_DATA(데이터가 없습니다)를 보여준다.
 *  </DESC>
 *  <CODE>
 *  	<div class='ext_grid'><div id='classList'></div></div> // HTML Code
 *  
 *  	// SCRIPT Code
 *  	// Ext Grid dataStore의 {datachanged} Event Handler 정의
 *  	storeGrd.addListener( "datachanged", onDataChanged );
 *  	function onDataChanged( store ) {
 *  		cfShowGridNoData( 'classList', store.getTotalCount() );
 *  		// cfShowGridNoData( 'classList', store.getTotalCount(), 100 ); // _height만큼 top을 개방한다!
 *  	}
 *  	// window.onresize의 경우 grid resize 시 GRID_NO_DATA도 동일하게 resize되어야 한다!
 *  	window.onresize = function() {
 *  		cfResizeGrid( [ grid ] ); // Ext Grid resize
 *  		cfShowGridNoData( 'classList' ); // GRID_NO_DATA resize
 *  	}
 *  </CODE>
 *  
 * cfResizeGrid( grids )
 *  <DESC>
 *  	resize window 시 Ext grid의 width를 변경해 준다!
 *  </DESC>
 *  <CODE>
 *  	window.onresize = function() {
 *  		cfResizeGrid( [ grid1, grid2, grid3,... ] ); // Ext Grid resize
 *  		cfShowGridNoData( 'classList' ); // GRID_NO_DATA resize
 *  	}
 *  	// grid1, grid2, grid3 : instances of Ext.grid.GridPanel
 *  	// cfShowGridNoData도 동일하게 적용되어야 한다!
 *  </CODE>
 *  
 * cfFormatDate( str, _format )
 *  <DESC>
 *    날짜문자열을 _format에 맞게 formatting 해준다.
 *  </DESC>
 *  <CODE>
 *    cfFormatDate( '20080123' ) // return '2008/01/23'
 *    cfFormatDate( '20071105', 'yyyy-MM-dd' ) // return '2007-11-05'
 *  </CODE>
 *  
 * cfAddCommas( no )
 *  <DESC>
 *    숫자에 3자리마다 [,]를 추가해준다. (기 존재하는 [,]는 제거 후 신규로 생성해준다!)
 *  </DESC>
 *  <CODE>
 *    cfAddCommas( 123456 ) // return '123,456'
 *    cfAddCommas( 44323.22 ) // return '44,323.22'
 *    cfAddCommas( '1234,21' ) // return '123,421'
 *  </CODE>
 *  
 * cfRemoveCommas( no )
 *  <DESC>
 *    [,]를 제거해 준다.
 *  </DESC>
 *  <CODE>
 *    cfRemoveCommas( '123,456' ) // return '123456'
 *    cfRemoveCommas( '44,323.22' ) // return '44323.22'
 *  </CODE>
 *  
 * cfHighlightImage( img, _outEvent )
 *  <DESC>
 *    이미지 highlight
 *    (_outEvent = false)이면 mouseOut event를 직접 지정해야한다. 기본값이 true이며 자동으로 mouseOut event를 장착해준다!
 *  </DESC>
 *  <CODE>
 *    <img src="aaa.gif" onmouseover="cfHighlightImage( this );"> <!-- mouseOut event 자동장착 -->
 *    <img src="aaa.gif" onmouseover="cfHighlightImage( this, false );" onmouseout="cfRestoreImage( this );">
 *  </CODE>
 *  
 * cfRestoreImage( img )
 *  <DESC>
 *    highlight된 이미지 restore
 *    cfHighlightImage( img )를 사용할 경우 자동으로 mouseOut event에 장착된다!
 *  </DESC>
 *  <CODE>
 *    <img src="aaa.gif" onmouseover="cfHighlightImage( this, false );" onmouseout="cfRestoreImage( this );">
 *  </CODE>
 *  
 * cfSetValueOfHashArray( arr, compareKey, compareValue, targetKey, targetValue )
 *  <DESC>
 *    array의 [compareKey == compareValue] 인 항목의 [targetKey]를 [targetValue]로 변경한다.
 *  </DESC>
 *  <CODE>
 *    var arr = [ {key1:'val1-1', key2:'val1-2', key3:'val1-3'}, 
 *                {key1:'val2-1', key2:'val2-2', key3:'val2-3'},
 *                {key1:'val3-1', key2:'val3-2', key3:'val3-3'} ];
 *    // key1 == 'val2-1'인 항목의 key3 값을 'foo'로 변경한다!
 *    cfSetValueOfHashArray( arr, "key1", "val2-1", "key3", "foo" );
 *  </CODE>
 *  
 * cfGetItemOfHashArray( arr, key, value )
 *  <DESC>
 *    array의 [key == value] 인 항목을 return
 *  </DESC>
 *  <CODE>
 *    var arr = [ {key1:'val1-1', key2:'val1-2', key3:'val1-3'}, 
 *                {key1:'val2-1', key2:'val2-2', key3:'val2-3'},
 *                {key1:'val3-1', key2:'val3-2', key3:'val3-3'} ];
 *    // key1 == 'val2-1'인 항목을 얻어온다!
 *    var item = cfGetItemOfHashArray( arr, "key1", "val2-1" ); // return {key1:'val2-1', key2:'val2-2', key3:'val2-3'}
 *  </CODE>
 * 
 * cfIndexOfHashArray( arr, key, value )
 *  <DESC>
 *    array의 [key == value] 인 항목의 index를 return
 *  </DESC>
 *  <CODE>
 *    var arr = [ {key1:'val1-1', key2:'val1-2', key3:'val1-3'}, 
 *                {key1:'val2-1', key2:'val2-2', key3:'val2-3'},
 *                {key1:'val3-1', key2:'val3-2', key3:'val3-3'} ];
 *    // key1 == 'val2-1'인 항목의 index를 얻어온다!
 *    var item = cfGetItemOfHashArray( arr, "key1", "val2-1" ); // return 1
 *  </CODE>
 */ 

// Array Remove - By John Resig (MIT Licensed)
Array.prototype.remove = function(from, to) {
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
};

/**
 * Check Control Value is null or Empty String
 * Alert when is null
 *
 * @param : ctl - Form Control
 * @param : desc (Optional) - Description
 * @return : true / false
 */
function cfCheckNullString( ctl, desc ) {
	if ( !desc ) desc = "내용";
	
	with( ctl ) {
		if( value == "" ) {
			alert( desc + "을(를) 입력해 주십시오" );
			focus();
			return false;
		}
		
		if( /^\s+$/.test(value) ) {
			alert( desc + "에 공백문자만 입력되었습니다.\n\n올바른 " + desc + "을(를) 입력해 주십시오" );
			value = "";
			focus();
			return false;
		}
	}
	return true;
}


/**
 * Check Two Control Values is null or Empty String
 * Alert when is null
 *
 * @param : ctl1 - Form Control1
 * @param : ctl2 - Form Control2
 * @param : desc (Optional) - Description
 * @return : true / false
 */
function cfCheckNullString2( ctl1, ctl2, desc ) {
	if ( !desc ) desc = "내용";
	
	if( ctl1.value == "" || ctl2.value == "" ) {
		alert( desc + "을(를) 입력해 주십시오" );
		ctl1.focus();
		return false;
	}
	
	if( /^\s+$/.test(ctl1.value) || /^\s+$/.test(ctl2.value) ) {
		alert( desc + "에 공백문자만 입력되었습니다.\n\n올바른 " + desc + "을(를) 입력해 주십시오" );
		ctl1.value = "";
		ctl2.value = "";
		ctl1.focus();
		return false;
	}
	return true;
}


/**
 * Check Control Value is null or Empty String
 * Alert when is null
 *
 * @params : Controls, Description(String)
 * @return : true / false
 */
function cfCheckNullStrings() {
	var args = cfCcheckNullStrings.arguments;
	var desc = null;
	var objType = null;
	var isNull = false;
	var isEmpty = false;
	
	// 1. Check Null Value & 2. Get Description Value
	for( var i = 0; i < args.length; i++ ) {
		if( typeof args[i] == "object" ) {				// 1
			objType = args[i].type;
			if( objType == "text" || objType == "password" ) {
				if( args[i].value == "" ) isNull = true;
				if( /^\s+$/.test(args[i].value) ) {
					isEmpty = true;
					args[i].value = "";
				}
			}
		} else if( typeof args[i] == "string" ) {		// 2
			desc = args[i];
		}
	}
	if( desc == null ) desc = "내용";
	
	if( isNull ) {
		alert( desc + "을(를) 입력해 주십시오" );
		args[0].focus();
		return false;
	}
	
	if( isEmpty ) {
		alert( desc + "에 공백문자만 입력되었습니다.\n\n올바른 " + desc + "을(를) 입력해 주십시오" );
		args[0].focus();
		return false;
	}
	return true;
}


/**
 * Check Control Value is null or Empty String
 *
 * @params : Controls
 * @return : true / false
 */
function cfIsNullStrings() {
	var args = cfIsNullStrings.arguments;
	var objType = null;
	
	// Check Null Value
	for( var i = 0; i < args.length; i++ ) {
		if( typeof args[i] == "object" ) {
			objType = args[i].type;
			if( objType == "text" || objType == "password" ) {
				if( args[i].value == "" ) return false;
				if( /^\s+$/.test(args[i].value) ) return false;
			}
		}
	}
	return true;
}


/**
 * Check Specified Index to SelectBox Control's SelectedIndex
 *
 * @param : ctl - Form Control
 * @param : desc (Optional) - Description
 * @param : checkedIndex (Optional) - Checked Index
 * @return : true / false
 */
function cfCheckSelectIndex( ctl, desc, checkIndex ) {
	if( !desc ) desc = "알맞은 값";
	if( !checkIndex ) checkIndex = 0;
	
	with( ctl ) {
		if( selectedIndex == checkIndex ) {
			alert( desc + "을(를) 선택해 주십시오." );
			focus();
			return false;
		}
	}
	return true;
}

/**
 * Check MultiValue Control(checkbox, radio) is checked as Specified limit count
 *
 * @param : ctl - Form Control
 * @param : desc - Description
 * @param : limit (Optional) - checked limit count
 */
function cfCheckMultiChecked( ctl, desc, limit ) {
	if( !desc ) desc = "알맞은 항목";
	if( !limit ) limit = 1;
	
	var cnt = 0;
	// one control only
	if( !ctl.length && ctl.checked ) {
		cnt++;
	} else {
		// more then
		for( var i = 0; i < ctl.length; i++ ) {
			if( ctl[i].checked ) cnt++;
		}
	}
	
	if( cnt < limit ) {
		alert( desc + "을(를)" + (limit > 1 ? limit + " 개 이상 " : "") + " 선택해 주십시오." );
		return false;
	}
	return true;
}


/**
 * Check Values of Two Controls is Same Value
 * 
 * @param : ctl1 - Control 1
 * @param : ctl2 - Control 2
 * @param : ctl1Name - Control 1's Name
 * @param : ctl2Name - Control 2's Name
 */
function cfSameValue( ctl1, ctl2, ctl1Name, ctl2Name ) {
	if( ctl1.value != ctl2.value ) {
		alert( ctl1Name + "의 값과 " + ctl2Name + "의 값이 일치하지 않습니다." );
		ctl1.value = "";
		ctl2.value = "";
		ctl1.focus();
		
		return false;
	}
	return true;
}


/**
 * Remove Value of <input type="file">
 *
 * @param : obj - Form Control
 */
function cfRemoveFileValue( obj ) {
	obj.select();
	document.selection.clear();
}

/**
 * Change checked state of Controls
 *
 * @param : ctl - A Control's Name
 * @param : state - true/false
 */
function cfChangeAllCheckedState( ctl, state ) {
	if( !ctl ) return;
	if( !ctl.length ) {
		ctl.checked = state;
	} else {
		for( var i = 0; i < ctl.length; i++ ) {
			ctl[i].checked = state;
		}
	}
}

/**
 * DropDownList(<SELECT>)의 value를 찾아 selectedIndex를 변경한다.
 * 
 * @param obj : DropDownList object
 * @param val : 선택할 option value
 * @param _defaultIdx : (optional, default:0) 해당 item이 없을 경우의 index 기본값 
 */
function cfSelectOptionByValue( obj, val, _defaultIdx ) {
	// index 기본값 설정
	var defaultIdx;
	var exists = false;
	defaultIdx = _defaultIdx || 0;
	
	with( obj ) {
		for( var i = 0; i < options.length; i++ ) {
			if( options[i].value == val ) {
				selectedIndex = i;
				exists = true;
				break;
			}
		}
		// 선택된 항목이 없으면 기본 index로 설정!
		if( !exists ) selectedIndex = defaultIdx;
	}
}

/**
 * Radio Button(<INPUT type=RADIO>)의 value를 찾아 checked 항목을 설정한다.
 * 
 * @param obj : radio button object
 * @param val : 선택할 item value
 * @param _defaultIdx : (optional, default:0) 해당 item이 없을 경우의 index 기본값 
 */
function cfCheckItemByValue( obj, val, _defaultIdx ) {
	// index 기본값 설정
	var defaultIdx;
	var exists = false;
	defaultIdx = _defaultIdx || 0;
	
	for( var i = 0; i < obj.length; i++ ) {
		if( obj[i].value == val ) {
			obj[i].checked = true;
			exists = true;
			break;
		}
	}
	// 선택된 항목이 없으면 기본 index로 설정!
	if( !exists ) obj[defaultIdx].checked = true;
}

/**
 * Input Array(checkbox, radio)의 checked item의 value를 Array로 return
 * 
 * @param obj : checkbox/radio object
 */
function cfGetCheckedValues( obj ) {
	var values = [];
	
	if( !obj.length ) {
		if( obj.checked ) values.push( obj.value );
	} else {
		for( var i = 0, length = obj.length; i < length; i++ ) {
			if( obj[i].checked ) values.push( obj[i].value );
		}
	}
	
	return values;
}

/**
 * Submit Form (일반페이지/BPF.Popup)
 * 
 * @param obj : submit event를 호출한 FormElement ( BUTTON / FORM )
 * @param _loading : (Boolean) loading block 호출여부 (default : true)
 * @param _uri (Optional) : form action uri (FORM action이 기 지정되어 있을경우는 기술하지 않아도 됨)
 */
function cfSubmit( obj, _loading, _uri ) {
	// obj가 FORM Element가 아니면 form을 구하자!
	var frm = ( obj.tagName == "FORM" ? obj : obj.form );
	
	_loading = typeof _loading == "undefined" ? true : _loading;
	if( _loading ) {
		// loading block!
		cfActiveLoadingBlock();
	}
	
	// uri를 구하자!
	_uri = _uri || frm.action;
	frm.action = _uri;
	frm.submit();
}

/**
 * (private) Submit Form in BPF.Popup
 * 
 * @param obj : submit event를 호출한 FormElement ( BUTTON / FORM )
 * @param _uri (Optional) : form action uri (FORM action이 기 지정되어 있을경우는 기술하지 않아도 됨)
 */
function cfSubmitPopup( obj, _uri ) {
	var poppyId = BPF.Popup.getPoppyId();
	
	// obj가 FORM Element가 아니면 form을 구하자!
	var frm = ( obj.tagName == "FORM" ? obj : obj.form );
	
	// uri를 구하자!
	_uri = _uri || frm.action;
	
	// FORM.method에 따른 처리!
	if( frm.method.toUpperCase() == "POST" ) {
		// add {poppyId} param to uri
		var params = {};
		if( _uri.indexOf("?") > -1 ) {
			params = _uri.substring( uri.indexOf("?") ).toQueryParams();
			_uri = _uri.substring( 0, uri.indexOf("?") );
		}
		params.poppyId = poppyId;
		_uri = _uri + "?" + $H(params).toQueryString();
	} else {
		// add {poppyId} param to FORM
		var ctl = document.createElement( "<input type='hidden' name='poppyId' value='#{poppyId}'>"
				.interpolate( { poppyId: poppyId } ) );
		frm.appendChild( ctl );
	}
	
	frm.action = _uri;
	frm.submit();
}

/**
 * (공통)파일첨부 팝업
 * 
 * @param conf {	params: [	displayElement, 
 * 													FormControl(originalFile), 
 * 													FormControl(systemFile), 
 * 													upload path ],
 * 								uri,
 * 								displayWidth,
 * 								nearBy,
 * 								replace,
 * 								callback,
 * 								limit }
 * @config params[0] displayElement : 첨부된 파일정보를 표시할 panel (DIV 영역)
 * @config parmas[1] FormControl(originalFile) : 첨부된파일명을 저장할 FORM Control (hidden control)
 * @config params[2] FormControl(systemFile) : 서버에 저장된 물리적인 파일명 (hidden control)
 * @config params[3] upload path : 파일이 업로드될 기준 경로
 * @config uri : popup uri
 * @config displayWidth : params[0] displayElement에 파일정보가 추가될 때 차지할 영역의 width
 * @config (optional) nearBy : (Object) 팝업이 위치할 좌표의 기준이 되는 object
 * @config (optional) replace : (boolean) 단일파일 업로드일 경우 기존에 업로드된 파일 정보를 갱신한다. (default: false)
 * @config (optional) callback : (function) override default callback function
 * @config (optional) limit : (int) 첨부파일 개수제한
 */
function cfOpenFileUpload( conf ) {
	// 첨부파일 개수제한 확인!
	if( conf.limit ) {
		var cnt = 0;
		$( conf.params[1] ).select( "DIV.file" ).each( function( e ) { cnt++ } );
		if( cnt >= conf.limit ) {
			alert( "파일첨부는 " + conf.limit + "개까지만 가능 합니다." );
			return;
		}
	}
	// {uri} QueryString에 {uploadPath} 파라메터를 추가한다!
	var params = {};
	
	var uri;
	if ( location.pathname.startsWith("/wooribank/front/") ) {	// front 화면인 경우
		uri = "/wooribank/common/front/selectFileUploadForm";
	} else {	// 관리자 화면인 경우
		uri = "/wooribank/selectFileUploadForm";
	}
	
	if( conf.uri && conf.uri.indexOf("?") > -1 ) {
		params = conf.uri.substring( conf.uri.indexOf("?") ).toQueryParams();
		uri = conf.uri.substring( 0, uri.indexOf("?") );
	}
	params.uploadPath = conf.params[3];
	
	uri = uri + "?" + $H(params).toQueryString();
	
	// callback Stack에 추가할 params를 생성하자!
	var callbackParams = {
			displayEl: conf.params[0],
			originalFileEl: conf.params[1],
			systemFileEl: conf.params[2],
			uploadPath: conf.params[3],
			replace: conf.replace || null,
			displayWidth: conf.displayWidth
	};
	
	BPF.Popup.create( { 
			callback: conf.callback || cfFileUploadCallback, 
			params: callbackParams,
			uri: uri,
			width: 500,
			height: 100,
			nearBy: conf.nearBy,
			modal: true,
			instance: true
	} );
}

/**
 * 파일첨부 팝업 default callback function
 */
function cfFileUploadCallback( data, params ) {
	var displayEl = $( params.displayEl );
	var deleteButton = 
		'<button onclick=\'cfDeleteFile(this, "#{systemFilename}", "#{originalFilename}", "#{uploadPath}");\' class="delete" style="float: right;">삭제</button>'
		.interpolate( {
			systemFilename: data.systemFilename,
			originalFilename: data.originalFilename,
			uploadPath: params.uploadPath
		} );
	var html = ( ''
		+ '<div class="file" #{styleWidth}>'
		+ '#{deleteButton}'
		+ '<div style="line-height:2em;"><span>#{originalFilename}</span>'
		+ '#{fileSize}'
		+ '<input type="hidden" name="#{systemFileEl}" value="#{systemFilename}">'
		+ '<input type="hidden" name="#{originalFileEl}" value="#{originalFilename}">'
		+ '</div></div>' ).interpolate( {
			styleWidth: ( params.displayWidth ? " style='width:" + params.displayWidth + "px;'" : "" ),
			// 파일이 없을 경우 삭제버튼은 보여주지 않는다! (상세페이지용)
			deleteButton: deleteButton,
			systemFileEl: params.systemFileEl,
			originalFileEl: params.originalFileEl,
			systemFilename: data.systemFilename,
			originalFilename: data.originalFilename,
			// 파일사이즈는 있는경우에만 노출한다!
			fileSize: ( data.fileSize ? " (" + data.fileSize + "bytes)" : "" )
		} );
	
	// 출력! 업로드된 파일 추가(APPEND)/갱신(REPLACE) 여부에 따른 처리!
	if( params.replace ) {
		displayEl.update( html );
	} else {
		displayEl.insert( html );
	}
}

/**
 * 파일첨부된 정보를 출력 (파일첨부 callback function 재사용)
 */
function cfRenderFileUploadInfo( config ) {
	// 첨부된 파일이 없으면 동작하지 않는다!
	if( config.originalFilename.blank() || config.systemFilename.blank() ) return;
	
	var data = { 
			originalFilename: config.originalFilename,
			systemFilename: config.systemFilename,
			fileSize: config.fileSize
	};
	
	var params = {
			displayEl: config.displayEl,
			systemFileEl: config.systemFileEl,
			originalFileEl: config.originalFileEl,
			displayWidth: config.displayWidth,
			uploadPath: config.uploadPath,
			replace: config.replace
	}
	
	cfFileUploadCallback( data, params );
}

/**
 * (private) 첨부된 파일 삭제
 * 
 * @param o : (button Object)
 * @param systemFilename : (String) system filename
 * @param originalFilename : (String) original filename
 * @param uploadPath : (String) upload path
 */
function cfDeleteFile( o, systemFilename, originalFilename, uploadPath ) {
	// 삭제확인!
	if( confirm( "[" + originalFilename + "] 파일을 삭제하시겠습니까?" ) ) {
		var params = {
			uploadPath: uploadPath,
			systemFilename: systemFilename
		};
		BPF.Ajax.request( "/wooribank/deleteFile", params, cfDeleteFileCallback );
		
		// 파일정보를 제거한다!
		$( o ).up().remove();
	}
}

/**
 * (private) 첨부된 파일 삭제 callback function
 */
function cfDeleteFileCallback( httpResponseObj ) {
	var json = httpResponseObj.responseText.evalJSON();
	alert( json.message );
}

/**
 * (공통)달력 팝업
 * 
 * @param el : <input type='text'>의 id / element object
 * 
 * TODO blackpet > 현재는 TextBox(<input type='text'>)만 지원한다! 나중에 확장하자!
 */
function cfShowCalendar( el ) {
	var year, month, day, format;
	el = $( el );

	var currDate = new Date();
	month = currDate.getMonth() + 1;
	year = currDate.getFullYear();
	day = currDate.getDay();
	format = "YYYYMMDD";
	
	// 기 입력된 값이 있을 경우 기 입력된 날짜로 설정하자!
	if( cfIsNullStrings( el ) ) {
		with( el ) {
			year = value.substring( 0, 4 );
			month = value.substring( 4, 6 );
		}
	}
	
	// callback Stack에 추가할 params를 생성하자!
	var callbackParams = { el: el };
	
	var params = {
			year: year,
			month: month,
			day: day,
			format: format
	}
	var uri = "/wooribank/common/showCalendar?" + $H( params ).toQueryString();
	
	BPF.Popup.create( { 
			callback: cfShowCalendarCallback, 
			params: callbackParams,
			uri: uri,
			width: 205,
			height: 122,
			nearBy: el,
			modal: true,
			instance:true
			
	} );
}

/**
 * 달력팝업 callback function. 선택된 날짜를 Control value로 Binding
 */
function cfShowCalendarCallback( data, params ) {
	params.el.value = data.date;
}

/**
 * show Tooptip layer
 * 
 * @param e : (Event)
 * @param width : (int) layer width
 * @param body : (String) layer body contents
 * @param (Optional) _title : (String) layer title
 */
function cfShowTooltip( e, width, body, _title ) {
	if( window.event ) e = event;
	
	var titleTemplate = ''
		+ '<table class="sub_search" width="100%" border="0" cellpadding="0" cellspacing="0">'
		+ '	<tr>'
		+ '		<td class="left"></td>'
		+ '		<td class="center title">#{title}</td>'
		+ '		<td class="right"></td>'
		+ '	</tr>'
		+ '</table>';
	var bodyTemplate = ''
		+ '<div class="body">#{body}</div>';
	;
	var content = '#{titleTemplate}#{bodyTemplate}';
	var params = { body: body, titleTemplate: '' };
	params.bodyTemplate = bodyTemplate.interpolate( params );
	// title은 있는경우만 추가한다! (Optional)
	if( _title ) {
		params.title = _title;
		params.titleTemplate = titleTemplate.interpolate( params );
	}
	content = content.interpolate( params );
	
	// {__descLayer}가 없으면 새로 만들자!
	var layer = $( 'TOOLTIP_LAYER' );
	if( !layer ) {
		$( document.body ).insert( '<div id="TOOLTIP_LAYER"></div>' );
		layer = $( 'TOOLTIP_LAYER' );
	}
	// 내용 갱신하고, position 셋팅하고, 보여주자!
	layer.update( content );

	var left = Event.pointerX( e ) + 10;
	if( left + width > document.body.clientWidth ) left -= ( left + width ) - document.body.clientWidth;
	layer.setStyle( {
		width: width,
		left: left,
		top: ( Event.pointerY( e ) + 5 ),
		display: 'block',
		position: 'absolute'
	} );
	
	// attach mouseOut/mouseMove event automatically
	Event.element( e ).observe( 'mousemove', cfMoveTooltip );
	Event.element( e ).observe( 'mouseout', cfHideTooltip );
}

/**
 * (private) move Tooltip layer (mouse point tracking)
 * 
 * @param e : (Event)
 */
function cfMoveTooltip( e ) {
	var layer = $( 'TOOLTIP_LAYER' );
	
	var width = layer.getWidth();
	var left = Event.pointerX( e ) + 10;
	if( left + width > document.body.clientWidth ) left -= ( left + width ) - document.body.clientWidth;
	layer.setStyle( {
		left: left,
		top: ( Event.pointerY( e ) + 5 )
	} );
}

/**
 * (private) hide Tooltip layer
 */
function cfHideTooltip() {
	var layer = $( 'TOOLTIP_LAYER' );
	if( layer ) {
		layer.setStyle( { display: 'none' } );
	}
}

/**
 * (공통)사용자검색 팝업
 * 
 * @param frm : (String) form name string
 * @param userId : (String) 사용자아이디 control name string
 * @param (Optional) _userName : (String) 사용자이름 control name string
 * @param (Optional) _dept : (String) 소속부서 control name string
 * @param (Optional) _position : (String) 직급 control name string
 */
function cfOpenUserSearch( frm, userId, _userName, _dept, _position ) {	
	frm = "document." + frm + ".";
	// callback Stack에 추가할 params를 생성하자!
	var callbackParams = {};
	// params 존재 시 callbackParams에 추가하자!
	// 사용자ID
	if( userId ) callbackParams.userIdEl = eval( frm + userId );
	// 사용자이름
	if( _userName ) callbackParams.userNameEl = eval( frm + _userName ); 
	// 소속부서
	if( _dept ) callbackParams.deptEl = eval( frm + _dept );
	// 직급
	if( _position ) callbackParams.positionEl = eval( frm + _position );
	
	var uri;
	if ( location.pathname.startsWith("/wooribank/front/") ) {	// front 화면인 경우
		uri = "/wooribank/common/front/selectUserSearchForm";
	} else {	// 관리자 화면인 경우
		uri = "/wooribank/common/selectUserSearchForm";
	}
	
	var pop = BPF.Popup.create( { 
			callback: cfCallbackUserSearch, 
			params: callbackParams,
			uri:uri,
			width: 480,
			height: 450,
			modal: true,
			instance:true
	} );
}	

/**
 * 사용자검색 팝업 callback function
 * 
 * {사용자아이디, 이름, 소속부서, 직급}데이터를 화면에 출력해준다!
 */
function cfCallbackUserSearch( data, params ) {
	// params 존재 시 callbackParams에 추가하자!
	// 사용자ID
	if( params.userIdEl ) params.userIdEl.value = data.userId;
	// 사용자이름
	if( params.userNameEl ) params.userNameEl.value = data.userNm;
	// 소속부서
	if( params.deptEl ) params.deptEl.value = data.departNm;
	// 직급
	if( params.positionEl ) params.positionEl.value = data.positionNm;
}

/**
 * (공통)엑셀 import 팝업
 * 
 * @param actionUrl : (String) 데이터를 가져올 액션명 form.action의 String 값
 * @param callback : (String) callback함수 
 */
function cfOpenImportExcel( actionUrl, callback ) {

		var param = {
			actionUrl : actionUrl
		}
		var uri = "/wooribank/common/importExcelForm?"+$H(param).toQueryString();
	
		BPF.Popup.create( { 
				callback: callback, 
				uri:uri,
				width: 400,
				height: 130,
				modal:true
		});
}

/**
 * 해당 함수 호출시 특정 영역 비활성화 & 메시지 표시할 div 삽입
 * 
 * @author sirtyrx
 * @param innerHTML : 영역안에 들어갈 태그
 * @param config : left, top , width ,height 의 값
 * @param positionEl : 해당 Element를 기준으로 우측하단 부분을 모두 비활성화
 */
function cfMakePageBlock( innerHTML , config , positionEl ) {
	
	var intHtml ;
	if($('pre_search_page_block') == null)
	{
		intHtml=	"<div id=\"pre_search_page_block\" style='display:block;'></div><DIV id='block_msg' style='display:block;'>"+ innerHTML +"</div>"
		document.body.insertAdjacentHTML( "beforeEnd", intHtml);
	}
	
	if(typeof positionEl == "undefined"){
		// 화면 전 영역을 막자! (주로 loading block에서 사용)
		// config.alpha가 지정되었을 시 투명도를 설정하자! 아닌경우 초기값 0.5
		config.alpha = config.alpha || 0.5;
		// config.bgColor가 지정되었을 시 배경색을 설정하자! 아닌경우 초기값 #202020
		config.bgColor = config.bgColor || "#202020";
		$('pre_search_page_block').setStyle( {
			left: config.left,
			top: config.top,
			width: document.body.scrollWidth,
			height: document.body.scrollHeight,
			opacity: config.alpha,
			backgroundColor: config.bgColor
		} );
		$('block_msg').style.width= config.msgWidth;
		$('block_msg').style.height= config.msgHeight;
		$('block_msg').style.left= document.body.clientWidth/2 - $('block_msg').offsetWidth/2;;
		$('block_msg').style.top= document.body.clientHeight/2 - $('block_msg').offsetHeight/2;
	}
	else{
		// 지정된 positionEl을 기준으로 position을 잡자!
		var el = positionEl.positionedOffset();
		$('pre_search_page_block').style.left = el[0]-10;
		$('pre_search_page_block').style.top = el[1]+ positionEl.offsetHeight;
		$('pre_search_page_block').style.width =  $( document.body ).getWidth()- el[0];
		$('pre_search_page_block').style.height =  document.body.scrollHeight - el[1];
		
		$('block_msg').style.width = config.msgWidth;
		$('block_msg').style.height = config.msgHeight;
		$('block_msg').style.left = document.body.clientWidth/2 - $('block_msg').offsetWidth/2;
		$('block_msg').style.top = document.body.clientHeight/2 - $('block_msg').offsetHeight/2;
	}		
	$('pre_search_page_block').style.display = "block";
	$('block_msg').style.display = "block";	
	loadingState++;	
	
}

/**
 * 선택된 과정이 없을시 하위 컨텐츠 비활성.
 * 
 * @author sirtyrx
 * @param msg : 				비활성 역역안의 메세지 
 * @param positionEl : 	비활성 영역 시작점을 알기위한 Element
 * @config left : 			블록 페이지 left
 * @config top : 				블록 페이지 top
 * @config msgWidth : 	메시지 width
 * @config msgHeight : 	메시지 height  
 * @desc left ,top , width , height 값을 사용자가 정의 하고 싶다면 설정된 json 데이터를 파라미터로... 없으면 초기화 
 */		
function cfActivePageBlock( positionEl , msg , config ) {
	msg = msg || '과정을 선택해 주세요.';
	
	var innerHTML =  " <table width='275' border='0' cellspacing='0' cellpadding='0'> "+
							 "  <tr> "+
							 "    <td><img src='/images/common/srch_info_01.gif' width='275' height='14'></td> "+
							 "  </tr> "+
							 "  <tr> "+
							 "    <td align='center' background='/images/common/srch_info_02.gif'> "+
							 "    	<table width='252' border='0' cellspacing='0' cellpadding='0'> "+
							 "      <tr border='1'> "+
							 "        <td height='26' align='left' background='/images/common/srch_info_04.gif' class='srch' style='padding:0 5 0 25;'> "+
							 "        	<span width='10'>&nbsp;</span>"+ msg +"</td> "+
							 "      </tr> "+
							 "    	</table> "+
							 "    </td> "+
							 "  </tr> "+
							 "  <tr> "+
							 "    <td><img src='/images/common/srch_info_03.gif' width='275' height='15'></td> "+
							 "  </tr> "+
							 "</table> ";


	if(typeof config == "undefined"){
		config = {
			left: '0',
			top : '0',
			msgWidth: '275',
			msgHeight: '52'
		}
	}
	cfMakePageBlock( innerHTML, config , positionEl );
}

/**
 * 과정 미선택시 비활성화 & 메시지 없애기 
 * 
 * @author sirtyrx
 */
function cfDeactivePageBlock() {
	--loadingState;
	// page block이 호출된 갯수만큼 해제됐냐?
	if(loadingState <= 0){
		// 혹 해제가 더 많이 호출될 경우도 있을 수 있다. 초기화 시켜주자!
		loadingState = 0;
		$('pre_search_page_block').style.display="none";
		$('block_msg').style.display="none";
	}
}

/**
 * 작업중 로딩화면 호출 화면을 비활성화 시키고 로딩중이라는 상태를 표시
 * 
 * @author sirtyrx
 * @desc left, top, width, height, size 값을 사용자가 정의 하고 싶다면 설정된 json 데이터를 파라미터로...없으면 초기
 */	
var loadingState = 0;
function cfActiveLoadingBlock( config ) {
	var innerHTML = "<img src='/images/common/loading_state.gif' width='45' height='45' border='0'><span style='font-size:45pt;font-family:Arial;color:#4b4b4b;'>Loading...</span>";
	if( typeof config == "undefined" ) {
		config = {
			left: '0',
			top : '0',
			msgWidth: '320',
			msgHeight: '52',
			size: 45
		};
	} else {
		config.left = config.left || 0;
		config.top = config.top || 0;
		config.msgWidth = config.msgWidth || 320;
		config.msgHeight = config.msgHeight || 52;
		config.size = config.size || 45;
	}

	cfMakePageBlock( innerHTML, config );	
}

/**
 * 해당 함수 호출시 로딩 비활성역역 메시지 가리기
 * 
 * @author sirtyrx
 */
function cfDeactiveLoadingBlock() {
		cfDeactivePageBlock();
}

/**
 * 파일의 확장자에 해당하는 아이콘 이미지명을 반환함
 */
function cfGetFileExtIconf( filename ) {
	var ext = filename.substring( filename.lastIndexOf('.')+1, filename.length );
	return ext+".gif";
}
	
/**
 * 페이지 이동 (Loading Block 호출)
 * 
 * @param uri : 이동하고자하는 URI	 
 */
function cfGoto( uri ) {
	cfActiveLoadingBlock();
	
	// BPF.Popup인 경우 poppyId에 대한 처리가 필요하다!
	var poppyId;
	if( poppyId = BPF.Popup.getPoppyId() ) {
		uri = BPF.Popup.appendPoppyId( uri, poppyId );
	}
	location.href =  uri;
}

/**
 * Ext grid / TABLE grid에 binding된 데이터가 없을경우 GRID_NO_DATA(데이터가 없습니다)를 보여준다.
 * 
 * @param el : (String/Object) Ext grid가 binding될 <DIV> object(또는 id string) 
 * 							혹은 TABLE GRID를 감싸고 있는 <DIV class="grid_table_panel"> object(또는 id string)
 * @param dataSize : (int) Data Source의 size ( == 0 이면 GRID_NO_DATA 표시)
 * @param (Optional) _height : (int) _height만큼 top을 개방한다. grid header size만큼 지정. (default: 52)
 */
function cfShowGridNoData( el, dataSize, _height ) {
	el = $( el );
	var noData = $( el.id + '_GRID_NO_DATA' );
	// [dataSize > 0]인 경우 GRID_NO_DATA가 존재하면 GRID_NO_DATA Element를 제거한다!
	if( dataSize && dataSize > 0 ) {
		if( noData ) noData.remove();
		return;
	}
	// [dataSize == undefined]이고 GRID_NO_DATA 존재하지 않으면 동작하지 않는다! (resize경우!)
	if( !noData && !dataSize ) return;
	
	var offset = el.cumulativeOffset();
	// Ext grid 여부
	var isExt = false;
	if( el.up().hasClassName( 'ext_grid' ) ) isExt = true;
	
	var height = _height || ( isExt ? 52 : 24 );
	var width = el.getWidth();
	var top = offset.top + height;
	var left = offset.left;
	height = el.getHeight() - height;
	// Ext grid인 경우 position을 재정의한다!
	if( isExt ) {
		// each border size:7px
		width -= 14;
		height -= 7;
		left += 7;
	} else {
		height -= 4; // bottom border:4px
	}
	
	// GRID_NO_DATA가 기 존재할 경우 resize만 적용!
	if( !noData ) {
		$( document.body ).insert( "<div id='" + el.id + "_GRID_NO_DATA'>데이터가 없습니다.</div>" );
		noData = $( el.id + '_GRID_NO_DATA' );
	}
	
	noData.setStyle( {
		position: 'absolute',
		width: width,
		height: height,
		top: top,
		left: left,
		backgroundColor: '#F7F7F7',
		color: '#3F3F3F',
		textAlign: 'center',
		paddingTop: '5%',
		fontSize: 14,
		display: 'block'
	} );
}

/**
 * resize window 시 Ext grid의 width를 변경해 준다.
 * 
 * @param grids : (Array) Ext.grid.GridPanel instances (e.g)[ grid1, grid2, grid3 ]
 */
function cfResizeGrid( grids ) {
	$A( grids ).each( function( grid ) {
		var width = $( 'dumy' ).getWidth();
		grid.setWidth( width );
	} );
}

/**
 * 날짜문자열을 _format에 맞게 formatting 해준다.
 * 
 * @param str : (String) 'yyyyMMdd'/'yyyy-MM-dd' format의 날짜문자열
 * @param (Optional) _format : 변경할 format (default : 'yyyy/MM/dd')
 */
function cfFormatDate( str, _format ) {
	var originalFormat = 'yyyyMMdd';
	if( str.length > 10 ) {
		str = str.substring( 0, 10 );
		originalFormat = "yyyy-MM-dd";
	}
	var newFormat = _format || 'yyyy/MM/dd';
	// date.js function call
	return formatDate( new Date( getDateFromFormat( str, originalFormat ) ), newFormat );
}

/**
 * 숫자에 3자리마다 [,]를 추가해준다.
 * 
 * @param no : int
 */
function cfAddCommas( no ) {
	no += '';
	// , 가 이미 존재할 시 제거해서 숫자문자열로 만들고 작업하자!
	no = cfRemoveCommas( no );
	
	var x = no.split('.');
	var x1 = x[0];
	var x2 = x.length > 1 ? '.' + x[1] : '';
	var reg = /(\d+)(\d{3})/;
	while( reg.test( x1 ) ) {
		x1 = x1.replace( reg, '$1,$2' );
	}
	return x1 + x2;
}

/**
 * [,]를 제거해 준다.
 * 
 * @param no : int
 */
function cfRemoveCommas( no ) {
	return no.replace( /,/g, "" );
}

/**
 * 이미지 highlight (img.src + "_on")
 * 
 * @param img : (Image) object / id String
 * @param (Optional) _outEvent : mouseOut event를 자동 장착! (default: true)
 */
function cfHighlightImage( img, _outEvent ) {
	_outEvent = _outEvent || true;
	img = $( img );
	
	// mouse_over class 적용
	img.addClassName( 'mouse_over' );
	
	var src = img.src;
	var nonRe = /\w+:\/\/[^/:]+(:\d*)?([^# ]*)_on.gif/;
	var re = /\w+:\/\/[^/:]+(:\d*)?([^# ]*).gif/;

	if( img ) {
		if( src.match( nonRe ) ) {
			return;
		}else if( src.match( re ) ) {
			img.src = RegExp.$2 + "_on.gif";
		}
	}
	// attach mouseOut event automatically
	if( _outEvent ) img.observe( 'mouseout', cfRestoreImage.bind( this, img ) );
}

/**
 * highlight 이미지 restore (img.src - "_on")
 * 
 * @param img : (Image) object / id String
 */
function cfRestoreImage( img ) {
	img = $( img );
	var src = img.src;
	var re = /\w+:\/\/[^/:]+(:\d*)?([^# ]*)_on.gif/;

	if( img ) {
		if( src.match( re ) ) {
			img.src = RegExp.$2 + ".gif";
		}
	}
}

/**
 * array의 [compareKey == compareValue] 인 항목의 [targetKey]를 [targetValue]로 변경한다.
 * 
 * @param arr : (Array) 
 * @param compareKey : (String) 검색 key
 * @param compareValue : (String/Object) 검색 key의 value
 * @param targetKey : (String) 변경할 key
 * @param targetValue : (String/Object) 변경할 value
 */
function cfSetValueOfHashArray( arr, compareKey, compareValue, targetKey, targetValue ) {
	var item = null;
	for( var i = 0, size = arr.size(); i < size; i++ ) {
		item = arr[i];
		if( item[ compareKey ] == compareValue ) {
			item[ targetKey ] = targetValue;
			// 딱걸렸으니 그만하자!
			break;
		}
	}
}

/**
 * array의 [key == value] 인 항목을 return
 * 
 * @param arr : (Array)
 * @param key : (String) 검색 key
 * @param value : (String/Object) 검색 key의 value
 */
function cfGetItemOfHashArray( arr, key, value ) {
	var idx = -1;
	if( (idx = cfIndexOfHashArray( arr, key, value ) ) > -1 ) {
		return arr[idx];
	}
	return null;
}

/**
 * array의 [key == value]인 항목의 index를 return
 * 
 * @param arr : (Array)
 * @param key : (String) 검색 key
 * @param value : (String/Object) 검색 key의 value
 */
function cfIndexOfHashArray( arr, key, value ) {
	var item = null;
	for( var i = 0, size = arr.size(); i < size; i++ ) {
		item = arr[i];
		if( item[ key ] == value ) {
			return i;
		}
	}
	return -1;
}

