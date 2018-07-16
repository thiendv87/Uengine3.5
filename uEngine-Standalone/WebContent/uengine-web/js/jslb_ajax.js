/**
* 파일명 : jslb_ajax.js
* 출처 : Ajax 입문 / 타카하시토시로 / p75
* 소스원본 : www.hanbitbook.co.kr/exam/1310
* 테스트 : 김동우
*/


/*
* 기능 : 동작가능한 브라우저 판정
* @sample	if(chkAjaBroser())	{ location.href='nonajax.htm' }
* @sample	oj = new chkAjaBrowser(); if(oj.bw.safari){ //safari code}
* @return	라이브러리가 동작가능한 브라우저이면 true true|false
* 
* Enable list
* IE 5.5+
* Konqueror 3.3+
* AppleWebKit 계열(Safari, omniWeb, Shiira) 124+
* Mozilla 계열(Firefox, Netscape, Galeon, Epiphany, K-Meleon, Sylera) 20011128+
* Opera 8+
*/
function chkAjaBrowser()
{
	var a, ua = navigator.userAgent;
	this.bw = {
		sarafi : ( (a=ua.split('AppleWebKit/')[1])?a.split('(')[0]:0)>=124 ,
		konqueror : ( (a=ua.split('Konqueror/')[1])?a.split(';')[0]:0)>=303 ,
		mozes : ( (a=ua.split('Gecko/')[1])?a.split(" ")[0]:0)>=20011128 ,
		opera : (!!window.opera) && ( (typeof XMLHttpRequest)=='function') ,
		msie : (!!window.ActiveXObject)?(!!createHttpRequest()):false
	}
	return (this.bw.safari||this.bw.konqueror||this.bw.mozes||this.bw.opera||this.bw.msie)
}

/*
* 기능 : XMLHttpRequest 오브젝트 생성
* @sample	oj = createHttpRequest()
* @return	XMLHttpRequest 오브젝트(인스턴스)
*/
function createHttpRequest()
{
	if(window.ActiveXObject)
	{
		// win ie 4,5,6 용
		try{
			return new ActiveXObject("Msxm12.XMLHTTP");
		}catch(e){
			try{
				return new ActiveXObject("Microsoft.XMLHTTP");
			}catch(e2){
				return null;
			}
		}
	}
	else if(window.XMLHttpRequest)
	{
		// win mac linux m1,f1,o8 mac s1 linux k3용
		return new XMLHttpRequest();
	}
	else
	{
		null;
	}
}

/*
* 기능 : 송수신
* @sample	sendRequest(onloaded, '&prog=1', 'POST', './about2.php', true, true)
* @param callback	송수신시에 기동하는 함수 이름
* @param data		송수신하는 데이터 (&이름1=값1&이름2=값2...)
* @param method		"POST" 또는 "GET"
* @param url		요청하는 파일의 URL
* @param async		비동기:true 동기:false
* @param sload		수퍼로드 true로 강제생략 또는 false는 기본
* @param user		인증 페이지용 사용자 이름
* @param password	인증 페이지용 암호
*/
function sendRequest(callback, data, method, url, async, sload, user, password)
{
	// XMLHttpRequest 오브젝트 생성
	var oj = createHttpRequest();
	if(oj == null)	return null;

	// 강제 로드의 설정
	var sload = (!!sendRequest.arguments[5])?sload:false;
	if(sload || method.toUpperCase() == 'GET') url += "?";
	if(sload) url = url+"t="+(new Date()).getTime();

	// 브라우저 판정
	var bwoj = new chkAjaBrowser();
	var opera = bwoj.bw.opera;
	var safari = bwoj.bw.safari;
	var konqueror = bwoj.bw.konqueror;
	var mozes = bwoj.bw.mozes;

	// 송신처리
	if(opera || safari || mozes){
		oj.onload = function() { callback(oj); }
	}else{
		oj.onreadystatechange = function()
		{
			if(oj.readyState == 4){
				callback(oj);
			}
		}//function
	}//if-else

	// URL 인코딩
	data = uriEncode(data);
	if(method.toUpperCase() == 'GET'){
		url += data;
	}

	// open 메소드
	oj.open(method, url, async, user, password);

	// 헤더 application/x-www-form-urlencoded 설정
	setEncHeader(oj);

	// 디버그
//	alert("////jslib_ajaxxx.js////\n data:"+data+"\n method:"+method+"\n url:"+url+"\n async:"+async);

	// send 메소드
	oj.send(data);

	// URI 인코딩 헤더 설정
	function setEncHeader(oj){
		var contentTypeUrlenc = 'application/x-www-form-urlencoded; charset=UTF-8';
		if(!window.opera){
			oj.setRequestHeader('Content-Type', contentTypeUrlenc);
		}else{
			if((typeof o.setRequestHeader)=='function')
				oj.setRequestHeader('Content-Type', contentTypeUrlenc);
		}
		return oj;
	}

	// URL 인코딩
	function uriEncode(data){
		if(data!=""){
			var encdata = '';
			var datas = data.split('&');
			for(i=1 ; i<datas.length ; i++)
			{
				var dataq = datas[i].split('=');
				encdata += '&'+encodeURIComponent(dataq[0])+'='+encodeURIComponent(dataq[1]);
			}
		}else{
			encdata = "";
		}

		return encdata;
	}

	return oj;
}
