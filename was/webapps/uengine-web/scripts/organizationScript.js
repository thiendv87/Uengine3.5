var tbodyUsers, tbodyGroups;
var relSize = {x : 20, y: 20};
var detailInformation = null;

function viewUserInfo(keyString)
{
	window.location.href = WEB_CONTEXT_ROOT + "/organizationmanager/userInfo.jsp?empCode=" + keyString;
}

function setDescriptionDiv(strDescription, evt)
{
	var divDescriptionForGroup = document.getElementById("divDescriptionForGroup");
	
	showElement("divDescriptionForGroup");
	setPositionForMouse("divDescriptionForGroup", relSize.x, relSize.y, evt);

	divDescriptionForGroup.innerHTML = strDescription.decodeURI().toHtml();
}

function moveDescriptionDiv(evt)
{
	setPositionForMouse("divDescriptionForGroup", relSize.x, relSize.y, evt);
}

function showDescriptionDiv()
{
	showElement('divDescriptionForGroup');
}

function hideDescriptionDiv()
{
	hideElement('divDescriptionForGroup');
}

function setNoImage(imgElement)
{
	imgElement.src = WEB_CONTEXT_ROOT + "/images/portrait/groups/uEngine_logo.gif"
}

function changeGroupImage()
{
	var imgLogo = document.getElementById("idImgLogo");
	detailInformation.imgSrc = imgLogo.src;
	var options= "dialogWidth:300px; dialogHeight:350px; scrollbar:no; status:no; help:no;";
	var umodal = window.showModalDialog("group/modalGroupLogo.jsp", detailInformation, options);
	
	imgLogo.src = WEB_CONTEXT_ROOT + "/images/portrait/groups/" + detailInformation.code + "_logo.gif";
}

var setDetailInformation = function(resultString)
{
	var resultSet = eval(resultString);
	var divInformation = document.getElementById("idDivInformation");
	var rowLogoImage = document.getElementById("idRowLogoImage");
	
	
	
	if(resultSet.length > 0)
	{
		showElement(divInformation);
		var result = resultSet[0];
		
		if(result.type == "company")
		{
			showElement(rowLogoImage);
			detailInformation = result;
			document.getElementById("idImgLogo").src = WEB_CONTEXT_ROOT + "/images/portrait/groups/" + result.code + "_logo.gif";
		}
		else
		{
			hideElement(rowLogoImage);
			document.getElementById("span_child_grp_name").innerHTML = "Children groups of " + result.name.decodeURI() + " ";
			document.getElementById("span_child_usr_name").innerHTML = "Children users of "  + result.name.decodeURI() + " ";
		}

		appendTextNode(document.getElementById("idSpanName"), result.name.decodeURI());
		appendTextNode(document.getElementById("idSpanCode"), result.code.decodeURI());
		appendTextNode(document.getElementById("idSpanType"), result.type.decodeURI());
		document.getElementById("idSpanDescription").innerHTML = ((result.description != "null")?result.description.decodeURI().toHtml(): "");
		document.getElementById("idSpanTitle").innerHTML = result.name.decodeURI() + " Information";
	}
	else
	{
		hideElement(divInformation);
		hideElement(rowLogoImage)
	}
}

function appendDataCell(row, dataString)
{
	var cell = appendCell(row);
	cell.style.textAlign = "center";
	appendTextNode(cell, dataString.decodeURI());
}

var appendChildNodeToTable = function(resultString)
{
	var arrayOfResult = new Array();
	arrayOfResult = eval(resultString);
	
	
	formatTable(tbodyUsers);
	formatTable(tbodyGroups);
	
	var countUsers = 0;
	var countGroups = 0;
	
	for (var i = 0; i < arrayOfResult.length; i++)
	{
		var result = arrayOfResult[i];
		var row = null;
		var rowId = "idRow_" + result.code;
		
		if (result.type == "user")
		{
			var rowClass = getCrossClassName(countUsers, "portlet-section-body", "portlet-section-alternate");
			var rowOverClass = rowClass + "-hover";
			
			row = appendRow(tbodyUsers);
			row.style.cursor = "pointer";
			row.id = rowId;

			
			addEventWithFunctionString(row, "mouseover", "document.getElementById('" + rowId + "').className = '" + rowOverClass + "'");
			addEventWithFunctionString(row, "mouseout", "document.getElementById('" + rowId + "').className = '" + rowClass + "'");
			addEventWithFunctionString(row, "click", "viewUserInfo('" + result.code + "')");
			row.className = rowClass;
			
			
			appendDataCell(row, result.name);
			appendDataCell(row, result.partname);
			appendDataCell(row, result.globalcom);
			appendDataCell(row, result.email);
			
			countUsers++;
		}
		else
		{
			var rowClass = getCrossClassName(countGroups, "portlet-section-body", "portlet-section-alternate");
			var rowOverClass = rowClass + "-hover";
			
			row = appendRow(tbodyGroups);
			row.style.cursor = "pointer";
			row.id = rowId;

			//addEventWithFunctionString(row, "mouseover", "document.getElementById('" + rowId + "').className = '" + rowOverClass + "'; setDescriptionDiv('" + ((result.description != 'null')?result.description:"") + "', event);");
			//addEventWithFunctionString(row, "mouseout", "document.getElementById('" + rowId + "').className = '" + rowClass + "'; hideDescriptionDiv();");
			//addEventWithFunctionString(row, "mousemove", "moveDescriptionDiv(event)");
			addEventWithFunctionString(row, "click", "getGrouptList('" + result.type + "', '" + result.code + "');hideDescriptionDiv();");
			row.className = rowClass;
			
			var desc = ((result.description != 'null')?result.description:"");
			if(desc.length > 20){
				desc = desc.substring(0,19) + "...";
			}
//			appendDataCell(row, result.type);
			appendDataCell(row, result.name);
			appendDataCell(row, result.code);
			appendDataCell(row, desc);
			
			countGroups++;
		}
	}
}

function getGrouptList(type, parentCode)
{
	var param = null;
	
	if(type == "company")
	{
		param = "comCode=" + parentCode;
	}
	else if(type == "department")
	{
		param = "parentCode=" + parentCode;
	}
	
	submitAjaxServlet(
			WEB_CONTEXT_ROOT + "/organizationmanager/json/getDetailInformationJson.jsp",
			"POST",
			setDetailInformation,
			param
	);
	
	submitAjaxServlet(
			WEB_CONTEXT_ROOT + "/organizationmanager/json/getDepartmentsWithUsersToJson.jsp",
			"POST",
			appendChildNodeToTable,
			param
	);
}