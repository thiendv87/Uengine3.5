function setCalender(locale, options){
	if (!locale) {
		locale = "";
	} else if(locale == "en") {
		locale += "-GB";
	}

	$.datepicker.setDefaults($.datepicker.regional[locale]);
	//$(".j_calendar").datepicker($.datepicker.regional['ko']);
	
	$('.j_calendar').datepicker({
		showOn: "button",
	      buttonImage: "images/calendar.gif",
	      buttonImageOnly: true,
	      buttonText: "Select date",
	    dateFormat: 'yy-mm-dd'
	});
}