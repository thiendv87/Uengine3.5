


/** List Form */
var listForm;

/**
 * 페이지 클릭시 해당 FORM SUBMIT
 * 개발자가 별도의 작업이 필요하면 이 메소드를  Overriding한다.
 */
function goPage(page){
	if (!checkForm()) return;
	listForm.currentPage.value = page;
	listForm.submit();
}

/**
 * 헤더 타이틀 클릭시 소트
 * 해당 JSP의 JavaScript query()호출한다.
 * 개발자가 별도의 작업이 필요하면 이 메소드를  Overriding한다.
 */
function headerSort(column, sortcolumn, sortcond){
	if (!checkForm()) return;
	if(column == sortcolumn && sortcond == 'ASC'){
	   sortcond = 'DESC';
	}else{
	   sortcond = 'ASC';
	}
	listForm.sort_column.value=column;
	listForm.sort_cond.value=sortcond;
	try{	
	   goPage(1);
	}catch(Exception){
	   alert("goPage(page) 메소드 호출 오류.");
	}
}

/**
 * 검색
 */
function search() {
	if (!checkForm()) return;
	listForm.sort_column.value = "";
	listForm.sort_cond.value = "";
	goPage(1);
}

/**
 * 검색 Keyword Input Field 에서 엔터 입력시.
 */
function searchKeyEnter() {
	if(window.event.keyCode == 13) search();
}

/**
 * List Form 설정 체크.
 */
function checkForm(){
	try{
		if( listForm.currentPage ){
			return true;
		}
	}catch(e){
		return setListForm(document.refreshForm);
	}
}

/**
 * List Form 설정.
 */
function setListForm(form){
	try{
		if( form.currentPage ){
			listForm = form;
			return true;
		}
	}catch(e){
		alert("List Form 설정 실패.");
		return false;
	}
}

function selectStartDate(name) {
    Calendar.setup({
        inputField     :    name + "_start_date",    
        ifFormat       :    "y-mm-dd",      
        button         :    name + "_start_date_trigger",  
        align          :    "TI",           // alignment (defaults to "Bl")(BC)
        singleClick    :    true,
        callback       :    true
    });
}

function selectEndDate(name) {
    Calendar.setup({
        inputField     :    name + "_end_date",    
        ifFormat       :    "y-mm-dd",     
        button         :    name + "_end_date_trigger",  
        align          :    "TI",           
        singleClick    :    true,
        callback       :    true
    });
}
function viewCalendar(){
	if(document.listForm.targetCond.selectedIndex==2){
		document.all.searchTd.style.display="none";
		document.all.calTd.style.display="";
	}else{
		
		document.all.calTd.style.display="none";
		document.all.searchTd.style.display="";
	}
}