<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<style type="text/css">
	 html, body {
	 	overflow: auto;
	 	margin: 0px;
	 	padding: 10px;
	 }
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			createFullcalendar(document.getElementById("divViewCalendarArea"), null);
		});
		
		function gotoDate()
		{
			var formCal = document.formCalendarMenu;
			var now = new Date();
			
			var year = parseInt(formCal.inputYear.value);
			var month = parseInt(formCal.inputMonth.value);
			var date = parseInt(formCal.inputDate.value);

			if (isNaN(year)) { year = now.getFullYear(); }
			if (isNaN(month)) { month = now.getMonth() + 1; }
			if (isNaN(date)) { date = now.getDate(); }
			
			$("#divViewCalendarArea").fullCalendar("gotoDate", year, month - 1, date);
			formCal.inputYear.value = year;
			formCal.inputMonth.value = month;
			formCal.inputDate.value = date;
		}
	</script>
	<title>Calendar</title>
</head>
<body>
	<div style="width: 1000px; margin: 0px; padding: 0px;" align="left">
		<div id="divViewCalendarArea" align="left" style="margin: 0px; width: 85%; float: left;"></div>
		<div align="right" style="width: 15%; margin: 0px; border: 1 solid #444444; float: right; line-height: 150%">
			<form name="formCalendarMenu" onsubmit="gotoDate();return false;">
				Year : <input type="text" name="inputYear" size="4" class="text ui-widget-content ui-corner-all" /> <br />
				Month : <input type="text" name="inputMonth" size="2" class="text ui-widget-content ui-corner-all" /> <br />
				Date : <input type="text" name="inputDate" size="2" class="text ui-widget-content ui-corner-all" /> <br />
				<br />
				<input type="button" value="Go direcet" onclick="gotoDate();" class="ui-state-default ui-corner-all"
				onmouseover="this.className='ui-state-hover ui-corner-all'" onmouseout="this.className='ui-state-default ui-corner-all'"
				onmousedown="this.className='ui-state-active ui-corner-all'" onmouseup="this.className='ui-state-default ui-corner-all'" 
				/>
			</form>
		</div>
	</div>
</body>
</html>