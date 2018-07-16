function createXMLHttpRequest() {
	var xmlHttp;
	
	if (window.ActiveXObject) {
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				xmlHttp = new ActioveXObject("Microsoft.XMLHTTP");
			} catch (e1) {
				xmlHttp = null;
			}
		}
	} else if (window.XMLHttpRequest) {
		try {
			xmlHttp = new XMLHttpRequest();
		} catch (e) {
			xmlHttp = null;
		}
	}
	if (xmlHttp == null)
		errorMessage();
	return xmlHttp;
}

function errorMessage() {
	alert("Your browser cannot handle this script");
}

function findElementsByDIVTag(divId, elementType, elementId) {
	var obj = document.getElementById(divId);
	var item = obj.getElementsByTagName(elementType);

	var result = new Array();
	var count = 0;

	if (item != null && item.length > 0) {
		for ( var i = 0; i < item.length; i++) {
			if (elementId != null) {
				if (item[i].id == elementId) {
					result[count] = item[i]; 
					count++;
				}
			}
		}
	}
	
	return result;
}

function findElementsByTag(div, elementType, inputElementType, elementName) {
	var obj;
	var item;
	var type = typeof div; 

	if (type == "string") {
		obj = document.getElementById(div);
		item = obj.getElementsByTagName(elementType);
	} else {
		item = div.getElementsByTagName(elementType);
	}

	var result = new Array();
	var count = 0;

	if (item != null && item.length > 0) {
		for ( var i = 0; i < item.length; i++) {
			if (elementName != null) {
				if (item[i].name == elementName) {
					if (inputElementType != null) {
						if (item[i].type == inputElementType) {
							result[count] = item[i];
							count++;
						}
					} else {
						result[count] = item[i];
						count++;
					}
				}
			} else {
				if (inputElementType != null) {
					if (item[i].type == inputElementType) {
						result[count] = item[i];
						count++;
					}
				} else {
					result[count] = item[i];
					count++;
				}
			}
		}
	}

	return result;
}

function runTelnetSevlet(eventParentDivName, eventDivName, endpoint) {

	var eventDiv = findElementsByDIVTag(eventParentDivName, "DIV", eventDivName)[0];
	
	var instanceId = document.getElementsByName("instanceId")[0].value;
	var processDefinition = document.getElementsByName("processDefinition")[0].value;;
	var tracingTag = document.getElementsByName("tracingTag")[0].value;
	
	var hostName = findElementsByTag(eventParentDivName, "input", null, "hostName")[0].value;
	var port = findElementsByTag(eventParentDivName, "input", null, "port")[0].value;
	//var userId = findElementsByTag(eventParentDivName, "input", null, "userId")[0].value;

	var xmlDoc;
	if (window.ActiveXObject) {
		xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
		xmlDoc.async = "false";
	} else if (document.implementation && document.implementation.createDocument) {
		xmlDoc = document.implementation.createDocument("", "", null);
		xmlDoc.async = "false";
	} else {
		errorMessage();
	}

	//var PInode=xmlDoc.createProcessingInstruction("xml", "version='1.0' encoding='UTF-8'");
	var rootNode = xmlDoc.createElement("TelnetMessage");

	var eventParentDivNameNode = xmlDoc.createElement("eventParentDivName");
	var eventParentDivNameTextNode = xmlDoc.createTextNode(eventParentDivName);
	
	var eventDivNameNode = xmlDoc.createElement("eventDivName");
	var eventDivNameTextNode = xmlDoc.createTextNode(eventDivName);
	
	var endpointNode = xmlDoc.createElement("endpoint");
	var endpointTextNode = xmlDoc.createTextNode(endpoint);
	
	var instanceIdNode = xmlDoc.createElement("instanceId");
	var instanceIdTextNode = xmlDoc.createTextNode(instanceId);
	
	var tracingTagNode = xmlDoc.createElement("tracingTag");
	var tracingTagTextNode = xmlDoc.createTextNode(tracingTag);
	
	var processDefinitionNode = xmlDoc.createElement("processDefinition");
	var processDefinitionTextNode = xmlDoc.createTextNode(processDefinition);

	var hostNameNode = xmlDoc.createElement("hostName");
	var hostNameTextNode = xmlDoc.createTextNode(hostName);

	var portNode = xmlDoc.createElement("port");
	var portTextNode = xmlDoc.createTextNode(port);

	//var userIdNode = xmlDoc.createElement("userId");
	//var userIdTextNode = xmlDoc.createTextNode(userId);

	var sessionTimeoutNode = xmlDoc.createElement("sessionTimeout");
	/*
	var isEchoNode = xmlDoc.createElement("isEcho");

	var isEcho = findElementsByTag(eventDiv, "input", null, "isEcho_"+eventDivName.substring(eventDivName.indexOf("_")+1, eventDivName.length));
	var isEchoValue = "";
	for (i = 0; i < isEcho.length; i++) {
		if (isEcho[i].checked)
			isEchoValue = isEcho[i].value;
	}
	var isEchoNodeTextNode =  xmlDoc.createTextNode(isEchoValue);
	*/
	
	
	var serverTypeNode = xmlDoc.createElement("serverType");

	var serverType = findElementsByTag(eventDiv, "input", null, "serverType_"+eventDivName.substring(eventDivName.indexOf("_")+1, eventDivName.length));
	var serverTypeValue = "";
	for (i = 0; i < serverType.length; i++) {
		if (serverType[i].checked)
			serverTypeValue = serverType[i].value;
	}
	var serverTypeNodeTextNode =  xmlDoc.createTextNode(serverTypeValue);

	
	var telnetCommandNode = xmlDoc.createElement("telnetCommand");

	// xmlDoc.appendChild(PInode);
	xmlDoc.appendChild(rootNode);
	
	rootNode.appendChild(eventParentDivNameNode);
	rootNode.appendChild(eventDivNameNode);
	rootNode.appendChild(endpointNode);
	rootNode.appendChild(instanceIdNode);
	rootNode.appendChild(tracingTagNode);
	rootNode.appendChild(processDefinitionNode);
	rootNode.appendChild(hostNameNode);
	rootNode.appendChild(portNode);
	//rootNode.appendChild(userIdNode);
	//rootNode.appendChild(isEchoNode);
	rootNode.appendChild(serverTypeNode);
	rootNode.appendChild(sessionTimeoutNode);
	rootNode.appendChild(telnetCommandNode);
	
	eventParentDivNameNode.appendChild(eventParentDivNameTextNode);
	eventDivNameNode.appendChild(eventDivNameTextNode);
	endpointNode.appendChild(endpointTextNode);
	instanceIdNode.appendChild(instanceIdTextNode);
	tracingTagNode.appendChild(tracingTagTextNode);
	processDefinitionNode.appendChild(processDefinitionTextNode);
	hostNameNode.appendChild(hostNameTextNode);
	portNode.appendChild(portTextNode);
	//isEchoNode.appendChild(isEchoNodeTextNode);
	serverTypeNode.appendChild(serverTypeNodeTextNode);
	//userIdNode.appendChild(userIdTextNode);

	
	var waitFor = findElementsByTag(eventDiv, "input", null, "waitFor");
	var command = findElementsByTag(eventDiv, "input", null, "command");
	var timeout = findElementsByTag(eventDiv, "input", null, "timeout");
	
	var sessionTimeout = findElementsByTag(eventDiv, "input", null, "sessionTimeOut");
	sessionTimeout = sessionTimeout[0].value;
	var sessionTimeoutTextNode = xmlDoc.createTextNode(sessionTimeout);
	sessionTimeoutNode.appendChild(sessionTimeoutTextNode);

	for (i = 0; i < waitFor.length; i++) {
		var childTelnetCommandNode = xmlDoc.createElement("TelnetCommand");

		var waitForNode = xmlDoc.createElement("waitFor");
		var waitForTextNode = xmlDoc.createTextNode(encodeURIComponent(waitFor[i].value));

		var parameters = findElementsByTag(eventDiv, "input", null, "parameter" + i);
		var parameter = "";
		for (j = 0; j < parameters.length; j++) {
			if (parameters[j].value != "")
				parameter += " " + encodeURIComponent(parameters[j].value);
		}
		
		var commandNode = xmlDoc.createElement("command");
		var commandTextNode = xmlDoc.createTextNode(encodeURIComponent(command[i].value + parameter));
		
		var timeoutNode = xmlDoc.createElement("timeout");
		var timeoutTextNode = xmlDoc.createTextNode(encodeURIComponent(timeout[i].value));

		childTelnetCommandNode.appendChild(waitForNode);
		childTelnetCommandNode.appendChild(commandNode);
		childTelnetCommandNode.appendChild(timeoutNode);
		
		waitForNode.appendChild(waitForTextNode);
		commandNode.appendChild(commandTextNode);
		timeoutNode.appendChild(timeoutTextNode);

		telnetCommandNode.appendChild(childTelnetCommandNode);
	}

	var xmlStr;
	if (window.ActiveXObject) {
		xmlStr = xmlDoc.xml;
	} else if (document.implementation && document.implementation.createDocument) {
		xmlStr = (new XMLSerializer()).serializeToString(xmlDoc);
	} else {
		errorMessage();
	}
	
	//alert(xmlStr);

	var xmlHttp = createXMLHttpRequest();
	var url = "/uengine-web/TelnetNormalServlet.jsp";
	xmlHttp.open("POST", url, true);
	xmlHttp.setRequestHeader("Content-Type", "text/xml");
	loading();
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			loaded();
			if (xmlHttp.status == 200) {
				var xmlDoc = xmlHttp.responseXML;
				if (xmlDoc != null) {
					
					var errorLog = xmlDoc.getElementsByTagName("error")[0];
					if (errorLog != null) {
						errorLog = errorLog.firstChild.nodeValue;
						if (errorLog != "none")
							alert(errorLog);
					}
					
					var eventDiv = findElementsByDIVTag(eventParentDivName, "DIV", eventDivName)[0];
					
					findElementsByTag(eventDiv, "input", null, "processingTime")[0].value = getTodayDate();
					
					var instanceId = xmlDoc.getElementsByTagName("instanceId")[0];

					if (instanceId != null) {
						instanceId = instanceId.firstChild.nodeValue;
						document.getElementsByName("instanceId")[0].value = instanceId;
						
						var totalResultFileName = findElementsByTag(eventDiv, "input", null, "totalResultFileName");
						for (i = 0; i < totalResultFileName.length; i++) {
							var tempTotalResultFileName = totalResultFileName[i].value;
							tempTotalResultFileName = tempTotalResultFileName.substring(tempTotalResultFileName.indexOf("."), tempTotalResultFileName.length);
							totalResultFileName[i].value = instanceId + tempTotalResultFileName;
						}
						
						var resultFileName = findElementsByTag(eventDiv, "input", null, "resultFileName");
						for (i = 0; i < resultFileName.length; i++) {
							var tempResultFileName = resultFileName[i].value;
							tempResultFileName = tempResultFileName.substring(tempResultFileName.indexOf("."), tempResultFileName.length);
							resultFileName[i].value = instanceId + tempResultFileName;
						}
					}
					
					var totalResult = xmlDoc.getElementsByTagName("totalResult")[0];
					if (totalResult != null) {
						if (totalResult.firstChild != null) {
							totalResult = totalResult.firstChild.nodeValue;
							totalResult = decodeURIComponent(totalResult).replace(/%20/gi, " ");
							
							findElementsByTag(eventDiv, "textarea", null, "totalResult")[0].value = totalResult;
						}
					}

					var results = xmlDoc.getElementsByTagName("result");
					if (results != null) {
						for (i = 0; i < results.length; i++) {
							if (results[i].firstChild != null) {
								var result = results[i].firstChild.nodeValue;
								result = decodeURIComponent(result).replace(/%20/gi, " ");
	
								findElementsByTag(eventDiv, "textarea", null, "result")[i].value = result;
							}
						}
					}

				}

			} else if (xmlHttp.status == 404) {
				alert("Requested URL is not found.");
			} else if (xmlHttp.status == 403) {
				alert("Access denied.");
			} else {
				alert("status is " + xmlHttp.status);
			}
		}
		
	};
	xmlHttp.send(xmlStr);
}

function loading() {
	document.getElementById("loading").style.display = "block";
	loadingDivScroll();
}

function loaded() {
	document.getElementById("loading").style.display = "none";
}

function loadingDivScroll() {
	if (document.getElementById("loading").style.display == "block") {
	    var loading = document.getElementById("loading");
		var s_top = document.body.scrollTop;
		loading.style.top = s_top > 0 ? s_top : 0;
	}
}

function completeWorkHandler() {
	var instanceId = document.getElementsByName("instanceId")[0].value;
	
	if (instanceId == "null")
		alert("텔넷 실행을 하지 않았거나, 인스턴스 아이디가 존재하지 않습니다.");
	else
		document.rootForm.submit();
}

function viewTotalResult(fileName) {
	var instanceId = document.getElementsByName("instanceId")[0].value;
	var mypage = "viewTotalResult.jsp?fileName=" + instanceId + "." + fileName;
	
	var iframeViewTotalResult = document.getElementById("iframeViewTotalResult");
	iframeViewTotalResult.src = mypage;
	
	$('#iframeViewTotalResult').modal();
}

function getTodayDate() {
	var today = new Date();
	
	var yy = today.getFullYear();
	var mm = today.getMonth() + 1;
	var dd = today.getDay();
	var hour = today.getHours();
	var min = today.getMinutes();
	var sec = today.getSeconds();
	
	if (mm < 10)
		mm = "0" + mm;
	if (dd < 10)
		dd = "0" + dd;
	if (hour < 10)
		hour = "0" + hour;
	if (min < 10)
		min = "0" + min;
	if (sec < 10)
		sec = "0" + sec;

	var todayDate = yy + "-" + mm + "-" + dd + " " + hour + ":" + min + ":" + sec;
	
	return todayDate;
}

/*
function autoRunAjax() {
	var href = document.getElementsByTagName("A");

	var divTelnetHost = new Array();
	var divTelnet = new Array();
	var endpoint = new Array();

	var count = 0;
	for (i = 0; i < href.length; i++) {
		var functionName = href[i].getAttribute('onClick');
		if (functionName != null) {
			functionName = "" + functionName;
			if (functionName.indexOf("runTelnetSevlet") != -1) {
				var splitedFunctionName = functionName.split(",");
				
				divTelnetHost[count] = splitedFunctionName[0].substring(
						splitedFunctionName[0].indexOf("'") + 1,
						splitedFunctionName[0].lastIndexOf("'"));
				
				divTelnet[count] = splitedFunctionName[1].substring(
						splitedFunctionName[1].indexOf("'") + 1,
						splitedFunctionName[1].lastIndexOf("'"));
				
				endpoint[count] = splitedFunctionName[2].substring(
						splitedFunctionName[2].indexOf("'") + 1,
						splitedFunctionName[2].lastIndexOf("'"));
				
				count++;
			}
		}
	}
	
	if (count != 0) {
		for (i = 0; i < count; i++) {
			while (isRun == false) {
				runTelnetSevlet(divTelnetHost[i], divTelnet[i], endpoint[i]);
				while (isRun == true) {
					if (isRun == false) {
						break;
					}
				}
				break;
			}
		}
	}
}
*/