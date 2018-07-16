function viewTaskInfo(taskid, instanceId, tracingTag) {
	var screenWidth = screen.width;
	var screenHeight = screen.Height;
	var windowWidth = 950;
	var windowHeight = 650;
	var window_left = (screenWidth - windowWidth) / 2;
	var window_top = (screenHeight - windowHeight) / 2;	

	var option = "left=" + window_left + ", top=" + window_top + ", width=" + windowWidth + ", height=" + windowHeight + " ,scrollbars=yes,resizable=yes";
	var url = "processparticipant/worklist/workitemHandler.jsp?taskId="+taskid+"&instanceId="+instanceId+"&tracingTag="+tracingTag;
	var openedWih = window.open(url, "processView", option);
}

function viewProcInfo(instanceid) {
	var option = "width=950,height=650,scrollbars=yes,resizable=yes";
	var url = "processparticipant/viewProcessInformation.jsp?omitHeader=yes&instanceId=" + instanceid;
	window.open(url, "", option)
}

function init() {
	var contentMinLength = 25;
	var listLength = 5;
	
	var openWorkList = document.getElementById("openWorkList");
	var runningProcessList = document.getElementById("runningProcessList");
	var completedProcessList = document.getElementById("completedProcessList");
	var dashboardCount = document.getElementById("dashboardCount");
	
	oneRowContent(openWorkList, "<img src='images/Common/i_dash_load.gif'>");
	oneRowContent(runningProcessList, "<img src='images/Common/i_dash_load.gif'>");
	oneRowContent(completedProcessList, "<img src='images/Common/i_dash_load.gif'>");
	var dafaultCount = new Array(6);
	for (i = 0; i < dafaultCount.length; i++) {
		if (i == 3) {
			dafaultCount[i] = "";
		} else {
			dafaultCount[i] = "<img src='images/Common/i_dash_count_progress.gif'>";
		}
	}
	dashboardCountContent(dashboardCount, dafaultCount);
	
	getDashboardOpenWorkListToJSON(endpoint, contentMinLength, listLength);
	getDashboardRunningProcessListToJSON(endpoint, contentMinLength, listLength);
	getDashboardCompletedProcessListToJSON(endpoint, contentMinLength, listLength);
	getDashboardCountToJSON(endpoint);
}

function createXMLHttpRequest() {
	if (window.ActiveXObject) {
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	} else if (window.XMLHttpRequest) {
		xmlHttp = new XMLHttpRequest();
	}
	return xmlHttp;
}

function oneRowContent(table, content) {
	var row = appendRow(table);
	var cell = appendCell(row);
	cell.innerHTML = content;
	cell.style.height = 50;
	cell.align = "center";
	cell.colSpan = 3;
}

function dashboardCountContent(table, counts) {
	
	var url = new Array(6);
	url[0] = "<a href=\"processparticipant/worklist/index.jsp?type=worklist&filtering=0\" target=\"_parent\">";	//filtering=0: new work
	url[1] = "<a href=\"processparticipant/worklist/index.jsp?type=worklist&filtering=5\" target=\"_parent\">"; //filtering=5: save work
	url[2] = "<a href=\"processparticipant/worklist/index.jsp?type=worklist&filtering=1\" target=\"_parent\">";	//filtering=1: complete work
	url[3] = "<a href=\"javascript:void(0);\" >";
	url[4] = "<a href=\"processparticipant/participationProcess/index.jsp?type=instancelist&filtering=0\" target=\"_parent\">";
	url[5] = "<a href=\"processparticipant/participationProcess/index.jsp?type=instancelist&filtering=1\" target=\"_parent\">";
	
	for (i = 0; i < counts.length; i++) {
		var row = appendRow(table);
		var cell = appendCell(row);

		cell.innerHTML = url[i] + counts[i] + "</a>";
		
		if (i == 3) {
			cell.style.height = 40;
		} else {
			cell.style.height = 19;
		}
		cell.style.width = 255;
		cell.style.textAlign = "right";
		cell.style.paddingRight = "50px";
		cell.className = "boldfont";
	}
}

function getDashboardCountToJSON(endpoint) {
	var url = WEB_CONTEXT_ROOT + "/dashboardCount?endpoint=" + endpoint;

	var xmlHttp = createXMLHttpRequest();
	xmlHttp.open("GET", url, true); 
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				var result = xmlHttp.responseText;
				var dashboardCount = eval('(' + result + ')');

				var dashboardCountTable = document.getElementById("dashboardCount");
				formatTable(dashboardCountTable);

				var counts = new Array();
				counts[0] = dashboardCount.newWork;
				counts[1] = dashboardCount.savedWork;
				counts[2] = dashboardCount.completedWork;
				counts[3] = "";
				counts[4] = dashboardCount.runningProcess;
				counts[5] = dashboardCount.completedProcess;

				dashboardCountContent(dashboardCountTable, counts);
			}
		}
	};
	xmlHttp.send(null);
}

function getDashboardOpenWorkListToJSON(endpoint, contentMinLength, listLength) {
	var url = WEB_CONTEXT_ROOT + "/dashboardWorkList?endpoint=" + endpoint + "&status=Open&contentMinLength=" + contentMinLength + "&listLength=" + listLength;
	
	var xmlHttp = createXMLHttpRequest();
	xmlHttp.open("GET", url, true); 
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				var result = xmlHttp.responseText;
				var dashboardWorkLists = eval('(' + result + ')');
				
				var openWorkList = document.getElementById("openWorkList");
				formatTable(openWorkList);
				
				if (dashboardWorkLists != null && dashboardWorkLists.length > 0) {
					for (i = 0; i < dashboardWorkLists.length; i++) {
						
						var row = appendRow(openWorkList);
						row.taskId = dashboardWorkLists[i].taskId;
						row.instId = dashboardWorkLists[i].instId;
						row.trcTag = dashboardWorkLists[i].trcTag;
						
						row.onclick = function() {
							viewTaskInfo(this.taskId, this.instId, this.trcTag);
						};
						row.style.cursor = "pointer";
						
						var cell = appendCell(row);
						
						cell.innerHTML = dashboardWorkLists[i].title;
						cell.style.height = 23;
//						cell.align = "left";
						cell.className = "999fontleft";
						
						cell = appendCell(row);
						cell.innerHTML = dashboardWorkLists[i].procinstnm;
						cell.className = "9999font";
						
						cell = appendCell(row);
						cell.innerHTML = (dashboardWorkLists[i].startDate).substring(0,10);
						cell.className = "999font";
						cell.align = "center";
					}
				} else {
					oneRowContent(openWorkList, notExistOpenWork);
				}
			}
		}
	};
	xmlHttp.send(null);
}

function getDashboardRunningProcessListToJSON(endpoint, contentMinLength, listLength) {
	var url = WEB_CONTEXT_ROOT + "/dashboardProcessList?endpoint=" + endpoint + "&status=Running" + "&contentMinLength=" + contentMinLength + "&listLength=" + listLength;
	
	var xmlHttp = createXMLHttpRequest();
	xmlHttp.open("GET", url, true); 
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				var result = xmlHttp.responseText;
				var dashboardProcessLists = eval('(' + result + ')');
				
				var runningProcessList = document.getElementById("runningProcessList");
				formatTable(runningProcessList);
				
				if (dashboardProcessLists != null && dashboardProcessLists.length > 0) {
					for (i = 0; i < dashboardProcessLists.length; i++) {
						
						var row = appendRow(runningProcessList);
						row.instId = dashboardProcessLists[i].instId;
						
						row.onclick = function() {
							viewProcInfo(this.instId);
						};
						row.style.cursor = "pointer";
						
						var cell = appendCell(row);
						
						cell.innerHTML = dashboardProcessLists[i].instName;
						cell.style.height = 23;
//						cell.align = "left";
						cell.className = "999fontleft";
						
						cell = appendCell(row);
						cell.innerHTML = dashboardProcessLists[i].defname;
						cell.align = "left";
						
						cell = appendCell(row);
						cell.innerHTML = (dashboardProcessLists[i].startDate).substring(0,10);
						cell.className = "999font";
						cell.align = "center";
					}
				} else {
					oneRowContent(runningProcessList, notExistRunningProcess);
				}
			}
		}
	};
	xmlHttp.send(null);
}

function getDashboardCompletedProcessListToJSON(endpoint, contentMinLength, listLength) {
	var url = WEB_CONTEXT_ROOT + "/dashboardProcessList?endpoint=" + endpoint + "&status=Completed" + "&contentMinLength=" + contentMinLength + "&listLength=" + listLength;
	
	var xmlHttp = createXMLHttpRequest();
	xmlHttp.open("GET", url, true); 
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				var result = xmlHttp.responseText;
				var dashboardProcessLists = eval('(' + result + ')');
				
				var completedProcessList = document.getElementById("completedProcessList");
				formatTable(completedProcessList);
				
				if (dashboardProcessLists != null && dashboardProcessLists.length > 0) {
					for (i = 0; i < dashboardProcessLists.length; i++) {
						
						var row = appendRow(completedProcessList);
						row.instId = dashboardProcessLists[i].instId;
						
						row.onclick = function() {
							viewProcInfo(this.instId);
						};
						row.style.cursor = "pointer";
						
						var cell = appendCell(row);
						
						cell.innerHTML = dashboardProcessLists[i].instName;
						cell.style.height = 23;
//						cell.align = "left";
						cell.className = "999fontleft";
						
						cell = appendCell(row);
						cell.innerHTML = dashboardProcessLists[i].defname;
						cell.align = "left";
						
						cell = appendCell(row);
						cell.innerHTML = (dashboardProcessLists[i].startDate).substring(0,10);
						cell.className = "999font";
						cell.align = "center";
					}
				} else {
					oneRowContent(completedProcessList, notExistCompletedProcess);
				}
			}
		}
	};
	xmlHttp.send(null);
}



