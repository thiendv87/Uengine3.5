<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="../common/header.jsp"%>
<%@include file="../common/styleHeader.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script>
	function initManual() {

		var manual_minutes		= document.getElementsByName("manual_minutes")[0];
		for (i=0;i<60 ;i++ ) {
			manual_minutes = createOption(manual_minutes, i, i, i);
		}
		manual_minutes = createOption(manual_minutes, 60, "*", "*");


		var manual_hours		= document.getElementsByName("manual_hours")[0];
		for (i=0;i<24 ;i++ ) {
			manual_hours = createOption(manual_hours, i, i, i);
		}
		manual_hours = createOption(manual_hours, 24, "*", "*");


		var manual_dayofmonth	= document.getElementsByName("manual_dayofmonth")[0];
		var count = 0;
		for (i=1;i<32 ;i++ ) {
			manual_dayofmonth = createOption(manual_dayofmonth, count, i, i);
			count++;
		}
		manual_dayofmonth = createOption(manual_dayofmonth, 31, "L", "L")
		manual_dayofmonth = createOption(manual_dayofmonth, 32, "*", "*")
		manual_dayofmonth = createOption(manual_dayofmonth, 33, "?", "?")


		var manual_month		= document.getElementsByName("manual_month")[0];
		var count = 0;
		for (i=1;i<13 ;i++ ) {
			manual_month = createOption(manual_month, count, i, i);
			count++;
		}
		manual_month = createOption(manual_month, 12, "*", "*")


		var manual_dayofweek_array = new Array("MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN", "MON-FRI", "*", "?");
		var manual_dayofweek = document.getElementsByName("manual_dayofweek")[0];
		for (i=0;i<manual_dayofweek_array.length ;i++ ) {
			manual_month = createOption(manual_dayofweek, i, manual_dayofweek_array[i], manual_dayofweek_array[i]);
		}
		manual_month.options.selectedIndex = 9;

	}

	function createOption(element, index, text, value) {

		var newOption = document.createElement('option');
		newOption.text = text;
		newOption.value = value;
		
		try {
			element.add(newOption, index);
		} catch(ex) {
			element.options[index] = newOption;
		}

		return element;
	}

	function saveManual() {
		var manual_minutes		= document.getElementsByName("manual_minutes")[0];
		var manual_hours		= document.getElementsByName("manual_hours")[0];
		var manual_dayofmonth	= document.getElementsByName("manual_dayofmonth")[0];
		var manual_month		= document.getElementsByName("manual_month")[0];
		var manual_dayofweek	= document.getElementsByName("manual_dayofweek")[0];

		var minutesValue	= manual_minutes.options[manual_minutes.options.selectedIndex].value;
		var hoursValue		= manual_hours.options[manual_hours.options.selectedIndex].value;
		var dayofmonthValue = manual_dayofmonth.options[manual_dayofmonth.options.selectedIndex].value;
		var monthValue		= manual_month.options[manual_month.options.selectedIndex].value;
		var dayofweekValue	= manual_dayofweek.options[manual_dayofweek.options.selectedIndex].value;

		var vaildCount = 0;
		if (dayofmonthValue.indexOf("?") != -1) {
			vaildCount++;
		}
		if (dayofweekValue.indexOf("?") != -1) {
			vaildCount++;
		}

		if (vaildCount != 1) {
			alert("Scheduler Cron Expression Error\n\"Day Of Month\" and \"Day Of Week\", one must necessarily be \"?\"");
		} else {
			var cronExpression = "0 " + minutesValue + " "+ hoursValue + " " + dayofmonthValue + " " + monthValue + " " + dayofweekValue;
			returnVal(cronExpression);
		}
	}

	function saveAuto() {
		var after_minutes	= document.getElementsByName("after_minutes")[0];
		var after_hours		= document.getElementsByName("after_hours")[0];
		var after_days		= document.getElementsByName("after_days")[0];
		var after_months	= document.getElementsByName("after_months")[0];

		var minutesValue	= after_minutes.value;
		var hoursValue		= after_hours.value;
		var dayofmonthValue = after_days.value;
		var monthValue		= after_months.value;

		if (minutesValue.length == 0 && hoursValue.length == 0 && dayofmonthValue.length == 0 && monthValue.length == 0) {
			alert("Input Cron Expression");
			return;
		}

		var mydate = new Date();
		
		if (minutesValue.length != 0)
			mydate.setMinutes(mydate.getMinutes() + eval(minutesValue));

		if (hoursValue.length != 0)
			mydate.setHours(mydate.getHours() + eval(hoursValue));
		
		if (dayofmonthValue.length != 0)
			mydate.setDate(mydate.getDate() + eval(dayofmonthValue));
		
		if (monthValue.length != 0)
			mydate.setMonth(mydate.getMonth() + eval(monthValue));

		var todayDate = mydate;

		var mm = todayDate.getMonth() + 1;
		var dd = todayDate.getDate();
		var hour = todayDate.getHours();
		var min = todayDate.getMinutes();
		var ss = todayDate.getSeconds();

		var cronExpression = ss + " " + min + " "+ hour + " " + dd + " " + mm + " ?";
		returnVal(cronExpression);
	}

	function returnVal(cronExpression) {
		var obj = cronExpression.split(" ");

		var seconds		= obj[0];
		var minutes		= obj[1];
		var hours		= obj[2];
		var dayofmonth	= obj[3];
		var month		= obj[4];
		var dayofweek	= obj[5];

		var displayVar = "";

		if (month != "*") {
			displayVar += month + " month";
		} else {
			displayVar += "every month";
		}
		displayVar += " , ";


		if (dayofmonth == "*") {
			displayVar += "every day";
		} else if (dayofmonth == "L") {
			displayVar += "last day of month";
		} else if (dayofmonth == "?") {

		} else {
			displayVar += dayofmonth + " day";
		}

		if (dayofweek == "MON") {
			displayVar += "every Monday"
		} else if (dayofweek == "TUE") {
			displayVar += "every Tuesday"
		} else if (dayofweek == "WED") {
			displayVar += "every Wednesday"
		} else if (dayofweek == "THU") {
			displayVar += "every Thursday"
		} else if (dayofweek == "FRI") {
			displayVar += "every Friday"
		} else if (dayofweek == "SAT") {
			displayVar += "every Saturday"
		} else if (dayofweek == "SUN") {
			displayVar += "every Sunday"
		} else if (dayofweek == "MON-FRI") {
			displayVar += "every Monday through Friday"
		} else if (dayofweek == "*") {

		}
		displayVar += " , ";


		if (hours != "*") {
			displayVar += hours + " hour";
		} else {
			displayVar += "every hour";
		}
		displayVar += " , ";


		if (minutes != "*") {
			displayVar += minutes + " minute";
		} else {
			displayVar += "every minute";
		}
		displayVar += " , ";


		if (seconds != "*") {
			displayVar += seconds + " second";
		} else {
			displayVar += "every second ";
		}

		alert("CronExpression : " + cronExpression + "\n" + displayVar);

		var Result = new Array();
		Result[0] = cronExpression;
		Result[1] = displayVar;
		window.returnValue = Result;
		parent.close();
	}
</script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/tabs.js"></script>
 </head>

<body onLoad="initManual();">
<script type="text/javascript">
	var tmp = new Array(
			{title : "Auto CronExpression", onclick : ""},
			{title : "Manual CronExpression", onclick : ""}
	);
	createTabs(tmp);
</script>
    
<div id="divTabItem_Auto CronExpression" style="overflow: hidden; padding:15px;">


            <table width="100%">
                <tr>
                	<td colspan="5" bgcolor="#97aac6" height="2">
                	</td>
                </tr>
                <tr>
                    <td class="formtitle" width="110">Minutes after</td>
                    <td class="formcon"><input type="text" name="after_minutes" value="" size="5" /></td>
                </tr>
                <tr bgcolor="#b9cae3"><td colspan="4" height="1"></td></tr>
                <tr>
                    <td class="formtitle">Hours after</td>
                    <td class="formcon"><input type="text" name="after_hours" value="" size="5" /></td>
                </tr>
                 <tr bgcolor="#b9cae3"><td colspan="4" height="1"></td></tr>
                <tr>
                    <td class="formtitle">Days after</td>
                    <td class="formcon"><input type="text" name="after_days" value="" size="5" /></td>
                </tr>
                <tr bgcolor="#b9cae3"><td colspan="4" height="1"></td></tr>
                <tr>
                    <td class="formtitle">Months after</td>
                    <td class="formcon"><input type="text" name="after_months" value="" size="5" /></td>
                </tr>               
                <tr>
                	<td colspan="5" bgcolor="#97aac6" height="2"></td>
                </tr>
                <tr>
                    <td colspan="2" align="center" height="40">
                    	<table>
                            <tr>
                                <td class="gBtn">
                                    <a onClick="saveAuto();" >
                                    <span>Confirm</span></a>                    
                                </td>
                            </tr>
                        </table></td>
                </tr>                  
            </table>
                                    
		</td>	
</div>
<div id="divTabItem_Manual CronExpression" style="display: none; padding:15px;">
		<table width="100%">
                <tr>
                	<td colspan="5" bgcolor="#97aac6" height="2">
                	</td>
                </tr>
                <tr>
                    <td class="formtitle" width="110">Minutes</td>
                    <td class="formcon"><select name="manual_minutes"></select></td>
                </tr>
                <tr bgcolor="#b9cae3"><td colspan="4" height="1"></td></tr>
                <tr>
                    <td class="formtitle">Hours</td>
                    <td class="formcon"><select name="manual_hours"></select></td>
                </tr>
                 <tr bgcolor="#b9cae3"><td colspan="4" height="1"></td></tr>
                <tr>
                    <td class="formtitle">Day Of Month</td>
                    <td class="formcon"><select name="manual_dayofmonth"></select></td>
                </tr>
                <tr bgcolor="#b9cae3"><td colspan="4" height="1"></td></tr>
                <tr>
                    <td class="formtitle">Month</td>
                    <td class="formcon"><select name="manual_month"></select></td>
                </tr> 
                <tr bgcolor="#b9cae3"><td colspan="4" height="1"></td></tr>
                <tr>
                    <td class="formtitle">Day Of Week</td>
                    <td class="formcon"><select name="manual_dayofweek"></select></td>
                </tr>               
                <tr>
                	<td colspan="5" bgcolor="#97aac6" height="2"></td>
                </tr>
                <tr>
                    <td colspan="2" align="center" height="40">
                        <table>
                            <tr>
                                <td class="gBtn">
                                    <a onClick="saveManual();" >
                                    <span>Confirm</span></a>                    
                                </td>
                            </tr>
                        </table></td>
                </tr>                  
            </table>
	</div>
 </body>
</html>
