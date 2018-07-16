
//ADDROW CONTROL ******************************************************************************
var strIndexKeysForAddRow = [
    "name", "id", "InstanceName"
];

function removeRow(element) {
	var table = element;
	var existingRow = null;

	while (!table.rows) {
		table = table.parentNode;
		if (table.cells) existingRow = table;
	}
	
	if (table.innerHTML.split("addRow(this)").length > 2) {
//		var elFirstRow = null;
//		for(var i=0; i<table.rows.length; i++) {
//			if (table.rows[i].innerHTML.indexOf("addRow(this)")) {
//				elFirstRow = table.rows[i];
//				break;
//			}
//		}

		var indexOfExistingRow = existingRow.rowIndex;
		
		//check first row
		if(indexOfExistingRow > 0 && table.rows[indexOfExistingRow - 1].innerHTML.indexOf("removeRow(this)") != -1) {
			table.deleteRow(indexOfExistingRow);
		}
	} 
}
/*
function addLineRow(existingRow) {
	var table = existingRow;
	
	while (!table.rows) {
		table = table.parentNode;
	}
	
	var iRowIndex = existingRow.rowIndex;
	var oRow = appendRowWithIndex(table, iRowIndex + 1);
	copyAttributes(existingRow, oRow);
	setLineStyle(oRow);

	for (var i=0; i<existingRow.cells.length; i++) {
		var oCell = appendCellWithIndex(oRow, i);
		copyAttributes(existingRow.cells[i], oCell);
		setLineStyle(oCell);
	}
}

function setLineStyle(object) {
	object.style.height = "1";
	object.style.backgroundColor = "#dddddd";
}
*/	
function addKeyIndexHtml(source, intAddCount) {
	for (var i = 0; i < strIndexKeysForAddRow.length; i++) {
		var strRegEx = "([\\s\?\&]"+ strIndexKeysForAddRow[i] + "=)(\"?[a-zA-Z0-9_]*)([\[]?)([0-9]*)([\]]?)";

		source = source.replace(
				new RegExp(strRegEx, "gim"),
				"$1$2[" + intAddCount + "]"
		);
	}
	return source;
}

function addRow(objBtn) {
	var table = objBtn;
	var keyName = table.name.split("[")[0];
	var existingRow = null;
	while (!table.rows) {
		table = table.parentNode;
		if (table.cells) existingRow = table;
	}
	
	var iRowIndex = existingRow.rowIndex;
	var oRow = appendRowWithIndex(table, iRowIndex + 1);
	var iRowCount = existingRow.parentNode.childNodes.length;
	
	copyAttributes(existingRow, oRow);
	var strOrgHTMLs = new Array();
	
	for (var i=0; i<existingRow.cells.length; i++) {
		var tmp = existingRow.cells[i].innerHTML;
		//remove calendar attribute for jquery
		tmp = tmp.replace(/jQuery[0-9]{1,15}="[0-9]+"/g, "")
		.replace(/( hasDatepicker){1}/g, "")
		.replace(/(complete=\"complete)\"/gi, "")
		.replace(/(<img class=ui-datepicker-trigger )(.*?)>/gi, "");
		strOrgHTMLs[i] = tmp;
		
		var strHTML = strOrgHTMLs[i];
		var oCell = appendCellWithIndex(oRow, i);
		
		copyAttributes(existingRow.cells[i], oCell);
		oCell.innerHTML = strHTML;
	}
	
	//initiate value of control
	for (var j = 0; j <oRow.cells.length; j++) {
		var cell = oRow.cells[j];
		cell.innerHTML = addKeyIndexHtml(cell.innerHTML, iRowCount - 1);

		//initiate value of file control
		if (cell.innerHTML.indexOf("_div_file_") != -1 && cell.innerHTML.indexOf("deleteFile(this)") != -1) {
			var fileFieldName = $("div[name^='_div_file_']", cell).attr("name").replace("_div_file_", "");
			deleteFile($("input[name='" + fileFieldName + "']"));
		}
		
		var nodes = cell.all;
		for (var k=0; k<nodes.length; k++) {
			if (nodes[k].tagName == "INPUT") {
				if (nodes[k].type.toLowerCase() == "text" || nodes[k].type.toLowerCase() == "hidden") {
					nodes[k].value = "";
				} else if (nodes[k].type.toLowerCase() == "checkbox" || nodes[k].type.toLowerCase() == "radio") {
					nodes[k].checked = false;
				}
			} else if (nodes[k].tagName == "TEXTAREA") {
				nodes[k].value = "";
			} else if (nodes[k].tagName == "SELECT") {
				nodes[k].value = "";
			} 
		}
	}
	//////////////////////////////////////////

	//initiate calendar control
	setCalender(LOGGED_USER_LOCALE);	
	
	return oRow;
}
//*****************************************************************************************************
