	Calendar._DN = new Array(
		"Sunday",
		"Monday",
		"Tuesday",
		"Wednesday",
		"Thursday",
		"Friday",
		"Saturday",
		"Sunday"
	);
	
	Calendar._SDN = new Array(
		"Sun",
		"Mon",
		"Tue",
		"Wed",
		"Thu",
		"Fri",
		"Sat",
		"Sun"
	);
	
	Calendar._MN = new Array(
		"January",
		"February",
		"March",
		"April",
		"May",
		"June",
		"July",
		"August",
		"September",
		"October",
		"November",
		"December"
	);

	Calendar._SMN = new Array(
		"Jan",
		"Feb",
		"Mar",
		"Apr",
		"May",
		"Jun",
		"Jul",
		"Aug",
		"Sep",
		"Oct",
		"Nov",
		"Dec"
	);

// tooltips
Calendar._TT = {};
Calendar._TT["ABOUT"] = "Use the \xab and \xbb buttons to select the year. Use the {0} and {1} buttons to select the month. Hold the mouse button on any of the above buttons for faster selection.";
Calendar._TT["ABOUT"] = Calendar._TT["ABOUT"].replace("{0}", String.fromCharCode(0x2039));
Calendar._TT["ABOUT"] = Calendar._TT["ABOUT"].replace("{1}", String.fromCharCode(0x203a));
Calendar._TT["TOGGLE"] = "Toggle first day of week";
Calendar._TT["PREV_YEAR"] = "Previous Year";
Calendar._TT["PREV_MONTH"] = "Previous Month";
Calendar._TT["GO_TODAY"] = "Today";
Calendar._TT["NEXT_MONTH"] = "Next Month";
Calendar._TT["NEXT_YEAR"] = "Next Year";
Calendar._TT["SEL_DATE"] = "Select Date";
Calendar._TT["DRAG_TO_MOVE"] = "";
Calendar._TT["PART_TODAY"] = "";
Calendar._TT["MON_FIRST"] = "";
Calendar._TT["SUN_FIRST"] = "";
Calendar._TT["CLOSE"] = "Close";
Calendar._TT["TODAY"] = "Today";

// date formats
Calendar._TT["DEF_DATE_FORMAT"] = "%Y-%m-%d";
Calendar._TT["TT_DATE_FORMAT"] = "M d, D";

Calendar._TT["WK"] = "";

Calendar._TT["DAY_FIRST"] = "Display %s first"; 
Calendar._TT["WEEKEND"] = "0,6"; 
Calendar._TT["TIME"] = "Time:"; 
