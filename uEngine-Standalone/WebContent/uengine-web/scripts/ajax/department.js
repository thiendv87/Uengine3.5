/*
 * How to use :
 * falow step.
 * 		1.. <script type="text/javascript">
 *				var WEB_ROOT = "<%=GlobalContext.WEB_CONTEXT_ROOT %>";
 *			</script>
 * 		2.  <script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/ajax/ajaxCommon.js"></script>
 *			<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/ajax/department.js"></script> 
 * 		3.  <select onchange="changCompany(this);"></select>
 * 			<select name="partCode" id="selectPartCode"></select>
 */
function formatSelectDept(oSelect) {
	formatSelect(oSelect);

	var objOption = document.createElement("option");
	objOption.text = "Choose Department";
	objOption.value = "";
	
	try {
		oSelect.add(objOption);
	} catch (e) {
		oSelect.appendChild(objOption);
	}
}

var changeDept = function(returnValue) {
	var dom = getDom(returnValue);
	
	var deptCodes = dom.getElementsByTagName("code");
	var deptNames = dom.getElementsByTagName("name");
	var oSelect = document.getElementById("selectPartCode");
	
	formatSelectDept(oSelect);
	
	for (var iCount = 0; iCount < deptCodes.length; iCount++) {
		var oOption = addOptionForSelect(oSelect);
		
		var sText = unescape(decodeURIComponent(deptNames[iCount].childNodes[0].nodeValue));
		var sValue = unescape(decodeURIComponent(deptCodes[iCount].childNodes[0].nodeValue));
		
		oOption.text = sText;
		oOption.value = sValue;
	}
}

function changCompany(o) {
	var comCode = o;
	if (o.value) {
		comCode = o.value;
	}
	
	if (comCode != null && comCode != "") {
		var url = WEB_ROOT + "/deptList?comCode=" + comCode;
		submitAjaxServlet(url, "Get", changeDept, null);
	} else {
		formatSelectDept(document.getElementById("selectPartCode"));
	}
}