var monthName=new Array("1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월");
var monthDate=new Array("1","2","3","4","5","6","7","8","9","10","11","12");
var monthDays=new Array(31,28,31,30,31,30,31,31,30,31,30,31);
var now=new Date;
var nowd=now.getDate();
var nowm=now.getMonth();
var nowy=now.getYear();
var today = nowy + "-" + monthDate[nowm].toUpperCase() + "-" + nowd;

//열려진 달력 박스 닫기
function calenderBoxClose(id_name)
{
	document.getElementById(""+ id_name +"").innerHTML = "";
	document.getElementById(""+ id_name +"").style.visibility = "hidden";
}

// 날짜 입력
function insertDate(insert_date, insert_form_name, id_name)
{
	document.getElementById(insert_form_name).value = insert_date;
	calenderBoxClose(id_name);
	
	//by1010. 날짜 선택시  달력판 id가 srchCalendar일때만 조회하는 함수 호출. 프로젝트관리화면에서 쓰임.
	if(id_name == 'srchCalendar'){
		select();
	}
}

//달력 박스 출력
function showCalendar(day, month, year, id_name, insert_form_name, dateFormType)
{
	if(dateFormType == null || dateFormType == "" || dateFormType == undefined){ //월 변경하는 이미지 클릭시 호출되는 함수의 인자를 위해...
		dateFormType = "";
	}
	if ((year%4==0||year%100==0)&&(year%400==0)) monthDays[1]=29; else monthDays[1]=28; //leap year test
	var firstDay=new Date(year,month,1).getDay();
	var calStr= ""
	
	calStr += "<table width='177' border=0 cellpadding=0 cellspacing=0 align=center>\n";
	calStr += "	<tr>\n"
	calStr += "		<td><img src='/jsp/web/common/calendar/images/cal_top.gif'></td>\n"
	calStr += "	</tr>\n"
	calStr += "	<tr>\n"
	calStr += "		<td background='/jsp/web/common/calendar/images/cal_bg.gif'><table border=0 cellpadding=0 cellspacing=0 align=center>\n"
	calStr += "			<tr bgcolor=white height='23'>\n";
	calStr += "				<td colspan=2 align='center'>\n";
	calStr += "					<a href='javascript:;' onClick=\"nowm--; if (nowm<0) { nowy--; nowm=11; } showCalendar(nowd,nowm,nowy,'" + id_name + "','" + insert_form_name + "','" + dateFormType + "');\">\n";
	calStr += "					<img src='/jsp/web/common/calendar/images/btn_pre.gif' border='0' align='absmiddle'></a>\n";
	calStr += "				</td>\n";
	calStr += "				<td colspan=3 align='center'>\n";
	calStr += "					<strong>" + year + "</strong>년 <strong>"+monthDate[month].toUpperCase()+"</strong>월\n";
	calStr += "				</td>\n";
	calStr += "				<td colspan=2 align='center'>\n";
	calStr += "					<a href='javascript:;'  onClick=\"nowm++; if (nowm>11) { nowy++; nowm=0; } showCalendar(nowd,nowm,nowy,'" + id_name + "','" + insert_form_name + "','" + dateFormType + "');\">\n";
	calStr += "					<img src='/jsp/web/common/calendar/images/btn_next.gif' border='0' align='absmiddle'>\n";
	calStr += "					</a>\n";
	calStr += "				</td>\n";
	calStr += "			</tr>\n";
	calStr += "			<tr align=center bgcolor='#A6D0C8' style='padding:4 0 2 0;'>\n";
	calStr += "				<td width='23'><font color='red'>일</font></td>\n";
	calStr += "				<td width='23'><font color='white'>월</font></td>\n";
	calStr += "				<td width='23'><font color='white'>화</font></td>\n";
	calStr += "				<td width='23'><font color='white'>수</font></td>\n";
	calStr += "				<td width='23'><font color='white'>목</font></td>\n";
	calStr += "				<td width='23'><font color='white'>금</font></td>\n";
	calStr += "				<td width='23'><font color='#333399'>토</font></td>\n";
	calStr += "			</tr>\n";
	calStr += "			<tr>\n";
	calStr += "				<td colspan='7' height='5'></td>\n";
	calStr += "			</tr>\n";

	var dayCount=1;

	calStr += "			<tr bgcolor=white height='23'>\n";

	for (var i=0;i<firstDay;i++)
		calStr += "				<td></td>\n";  //공백

	for (var i=0;i<monthDays[month];i++) {
		if(dayCount==nowd) {
			calStr += "				<td align=center bgcolor='#DFE7DE'>\n"; // 오늘 날짜일때 배경색 지정,글자 진하게
		} else {
			calStr += "				<td align=center>\n";  // 오늘 날짜가 아닐때 배경색 지정
		}
		
		month_date = dayCount++;

		//입력할 날의 날짜형
		if(dateFormType == null || dateFormType == "" || dateFormType == undefined){ //기본형
			insert_date = year + "-" + monthDate[month].toUpperCase() + "-" + month_date;
		}else if(dateFormType.toUpperCase() == "YYYY-MM"){
			insert_date = year + "-" + monthDate[month].toUpperCase();
		}else if(dateFormType.toUpperCase() == "YYYYMMDD"){
			insert_date = year + monthDate[month].toUpperCase()  + month_date;
		}

		calStr += "					<a href=\"javascript:insertDate('" + insert_date + "','" + insert_form_name + "','" + id_name + "');\">\n"; // 링크설정
		calStr += month_date;   // 날짜
		calStr += "					</a>\n";

		if(dayCount==nowd) {
			calStr += ""; // 오늘 날짜일때 글자 진하게
		} else {
			calStr += "";  // 오늘 날짜가 글자 진하게 안함
		}
		
		if ((i+firstDay+1)%7==0&&(dayCount<monthDays[month]+1)) {
			calStr += "			</tr>\n";
			calStr += "			<tr bgcolor=white height='23'>\n";
		}
	}
	
	var totCells=firstDay+monthDays[month];

	for (var i=0;i<(totCells>28?(totCells>35?42:35):28)-totCells;i++)
		calStr += "				<td></td>\n";

	calStr += "			</tr>\n";
	calStr += "			<tr>\n";
	calStr += "				<td colspan='7' height='5'></td>\n";
	calStr += "			</tr>\n";
	calStr += "			<tr>\n";
	calStr += "				<td colspan='7' align='right'>\n";
	calStr += "					<a href=\"javascript:calenderBoxClose('" + id_name + "');\"><img src='/jsp/web/common/calendar/images/close.gif' border='0'></a>\n";
	calStr += "				</td>\n";
	calStr += "			</tr>\n";
	calStr += "		</table></td>\n";
	calStr += "	</tr>\n";
	calStr += "	<tr>\n"
	calStr += "		<td><img src='/jsp/web/common/calendar/images/cal_bottom.gif'></td>\n"
	calStr += "	</tr>\n"
	calStr += "</table><BR>";
	

	// 해당레이어에 달력 박스 html 입력
	document.getElementById(""+ id_name + "").innerHTML = calStr;
	// 해당레이어 visible 처리
	document.getElementById(""+ id_name + "").style.visibility = "visible";
}
