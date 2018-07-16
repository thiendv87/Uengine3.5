
var flowchart = new FlowChartDefinition();

function showActivityDetails(instId, trcTag) {
	window.open('viewActivityDetails.jsp?instanceID=' + instId + '&tracingTag=' + trcTag,'activitydetails','width=500,height=400,scrollbars=yes,resizable=yes');
}

function locateWorkItem(defId, defVersionId, tracingTag, instanceId, propertyString){
	window.open(
			WEB_CONTEXT_ROOT + "/processparticipant/worklist/workitemHandler.jsp?instanceId=" + instanceId + "&tracingTag=" + tracingTag, 
			"wihspace", 
			"width=800,height=550,scrollbars=yes,resizable=yes"
	);
}

function initateProcess(defverid){
	var url = WEB_CONTEXT_ROOT + "/processparticipant/initiateForm.jsp?processDefinition=" + defverid;
	if (window.opener) {
		window.top.location.href = url;
	} else {
		window.open(url,'initiateProcess','top=100,left=500,width=1014,height=700,resizable=true,scrollbars=yes');
	}
}

function openDetailActivity(activityId) {
	$("#" + activityId).toggle();
}

function setTableDrawAreas(instId, defVerId) {
	tableDrawAreas = [];
	
	var flowchartId = "";
	if(instId.isTrue()) {
		var instIds = instId.split(";");
		for (var i = instIds.length - 1; i >= 0; i--) {
			tableDrawAreas.push(document.getElementById("tableFlowchartCanvas_instance_" + instIds[i]));
		}
	} else if(defVerId.isTrue()) {
		tableDrawAreas.push(document.getElementById("tableFlowchartCanvas_definition_" + defVerId));
	}
}

function swapSubProcessView(instId, defVerId, activityName, trcTag, parentElement) {
	flowchart.appendParentDefVerId();
	getProcessFlowchart(
			instId,
			'',
			defVerId,
			flowchart.getParentDefVerId(),
			flowchart.getViewType(),
			flowchart.getViewOption(),
			flowchart.getLastInstId(),
			flowchart.getInitiate()
	);
}

function getSubProcess(instId, defVerId, activityName, trcTag, parentElement) {
	var parentFlowchartId = "divOutLineArea_" + trcTag;
	
	if (document.getElementById(parentFlowchartId)) {
		$("#" + parentFlowchartId).toggle();
		drawAll();
	} else {
		$.get(
			WEB_CONTEXT_ROOT + "/processmanager/flowchart/processFlowchartData.jsp",
			{
				"instanceId": instId,
				"definitionVersionId": defVerId,
				"parentTracingTag": trcTag,
				"viewType": flowchart.getViewType(),
				"viewOption": flowchart.getViewOption()
			},
			function(result){
				drawSubProcessFlowchart(
						result,
						instId,
						defVerId,
						activityName,
						trcTag,
						parentElement
				);
			}
		);
	}
}


function viewSubProcess(instId, defVerId, activityName, trcTag, parentElement) {
	switch (flowchart.getSubProcessViewType()) {
		case "multiple":
			getSubProcess(instId, defVerId, activityName, trcTag, parentElement);
		break;
		case "cascade":
			swapSubProcessView(instId, defVerId, activityName, trcTag, parentElement);
		break;
	}
}

function swapViewType(viewType, viewOption) {
	getProcessFlowchart(
			flowchart.getInstId(),
			flowchart.getDefId(),
			flowchart.getDefVerId(),
			flowchart.getParentDefVerId(),
			viewType,
			viewOption,
			flowchart.getLastInstId(),
			flowchart.getInitiate()
	);
}

function getProcessFlowchart(
		instId,
		defId,
		defVerId,
		parentDefVerId,
		viewType,
		viewOption,
		lastInstId,
		initiate
) {
	formatDrawAreas();
	$.get(
			WEB_CONTEXT_ROOT + "/processmanager/flowchart/getProcessFlowchart.jsp",
			{
				"instanceId"			: instId,
				"processDefinition"		: defId,
				"definitionVersionId"	: defVerId,
				"parentPdver"			: parentDefVerId,
				"viewType"				: viewType,
				"viewOption"			: viewOption,
				"lastInstance"			: lastInstId,
				"initiate"				: initiate
			},
			function(resultString) {
				drawProcessFlowchart(resultString, viewOption, instId, defId, defVerId);
			}
	);
}

function getParentNameSpace(nameSpace) {
	var tempTracingTags = nameSpace.split("act");
	var parentNameSpace = "";
	
	for (var i = 0, il = tempTracingTags.length - 1; i < il; i++) {
		if (i > 0) { parentNameSpace += "act"; }
		parentNameSpace += tempTracingTags[i];
	}
	
	return parentNameSpace;
}

function drawSubProcessFlowchart(result, instId, defVerId, activityName, parentTracingTag, parentElement) {
	var flowchartId = "divOutLineArea_" + parentTracingTag;
	var parentDrawArea = getDrawArea(getParentNameSpace(parentTracingTag));

	var table = document.createElement("table");
	parentDrawArea.appendChildCover(table);
	var cell = appendCell(appendRow(table));
	table.border = "0";
	table.align = "center";
	
	var divOutLineCanvas = document.createElement("div");
	var divFlowchart = document.createElement("div");
	
	cell.appendChild(divOutLineCanvas);
	divOutLineCanvas.appendChild(divFlowchart);
	
	divOutLineCanvas.id = "canvasForProcessDefinition" + flowchartId;
	divFlowchart.id = flowchartId;
	divFlowchart.className = "flowchart-subprocess-cover";
	
	var drawArea = setDrawArea(
		flowchartId,
		(function() {
			if (divFlowchart.offsetHeight > 0) {
				showSubProcessOutline(getDrawArea(flowchartId).getPaper(), parentElement.parentNode.parentNode, divFlowchart);
			}
		})
	);
	
	parentDrawArea.appendChild(drawArea);
	insertFlowchartData(result, divFlowchart);
	drawAll();
}

var oZoom = null;
var tableDrawAreas = null;

function insertFlowchartData(result, div) {
	var htmlData = new StringBuffer();
	var scriptData = new StringBuffer();
	
	var splitData = result.split("\n<script type=\"text/javascript\">\n\/\/<![CDATA[\n");
	
	htmlData.append(splitData[0]);
	
	for (var i = 1, il = splitData.length; i < il; i++) {
		var commentData = splitData[i].split("\n \/\/]]>\n</script>");
		scriptData.append(commentData[0]);
		htmlData.append(commentData[1]);
	}
	
	div.innerHTML = htmlData.toString();
	eval(scriptData.toString());
	enableTooltips();
}

function drawProcessFlowchart(reqData, viewOption, instId, defId, defVerId) {
	var divFlowchartArea = document.getElementById("divFlowchartArea");
	
	insertFlowchartData(reqData, divFlowchartArea);
	window.onresize = drawAll;
	
	var instId = document.getElementById("flowchartVariable_instanceId").value;
	var defVerId = document.getElementById("flowchartVariable_definitionVersionId").value;
	
	flowchart.setInstId(instId);
	flowchart.setDefVerId(defVerId);
	
	flowchart.setDefId(document.getElementById("flowchartVariable_processDefinition").value);
	flowchart.setViewType(document.getElementById("flowchartVariable_viewType").value);
	flowchart.setViewOption(document.getElementById("flowchartVariable_viewOption").value);
	flowchart.setLastInstId(document.getElementById("flowchartVariable_lastInstance").value);
	flowchart.setInitiate(document.getElementById("flowchartVariable_initiate").value);
	flowchart.setParentDefVerId(document.getElementById("flowchartVariable_parentPdver").value);

	setTableDrawAreas(instId, defVerId);
	
	var radios = document.getElementsByName("subProcessViewType");
	for(var i = 0, item; item = radios[i]; i++) {
		if (item.value == flowchart.getSubProcessViewType()) {
			item.checked = true;
			break;
		}
	}
	
	drawChildLine();
}

var chartCount = 0;

function drawChildLine() {
	chartCount++;
	var tableParantTitle = document.getElementById("tableParantTitle_" + chartCount);
	
	if(tableParantTitle) {
		Js1005.show(tableParantTitle);
		Js1005.show(document.getElementById("divImgLine_" + chartCount));
		drawChildLine();
	} else {
		chartCount--;
		
		for (var i = 0, table; table = tableDrawAreas[i]; i++) {
			Js1005.show(table);
		}
		drawAll();
	}
}

function setUnkwonImage(image){image.src = WEB_CONTEXT_ROOT + "/images/portrait/unknown_user.gif";}
