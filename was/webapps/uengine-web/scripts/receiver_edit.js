/**************************************************************************
	
	receiver_edit 
	
	@author Sungsoo Park ( ghbpark@hanwha.co.kr )
	@since 2005.02.15
	
***************************************************************************/
function ReceiverEditor (editorName) 
{
	this.editorName = editorName;
	
	this.editedDocument = null;
	this.receiverElement = null;
	
	this.isReceiverChanged = false;
	
	this.init = ARE_Init;
	this.createNewNode = ARE_CreateNewNode;
	
	this.getXML = ARE_GetXML;
	this.getReceiverHTML = ARE_GetReceiverHTML
	
	this.addReceiver = ARE_AddReceiver;
	
	this.removeReceiver = ARE_RemoveReceiver;
	
	this.makeRecevierArray = ARE_MakeRecevierArray;
}

/**
 * 
 */
function ARE_Init ( receiverDom )
{
	this.editedDocument = receiverDom.cloneNode(true);
	this.receiverElement = this.editedDocument.selectSingleNode("//data");
}


/**
 *
 */
function ARE_AddReceiver ( id, name, loginName, title, deptName )
{
	if ( this.editedDocument == null ) {
		this.editedDocument = new ActiveXObject("Msxml2.DOMDocument");
		var rootElement = this.editedDocument.createElement ( "data" );
		this.editedDocument.appendChild(rootElement);	
		this.receiverElement = this.editedDocument.selectSingleNode("//data");	
	}
	var contents = this.editedDocument.createNode(1,"contents", "");
	contents.setAttribute("id", id);
	contents.appendChild(this.createNewNode("id",id));
	contents.appendChild(this.createNewNode("name",name));
	contents.appendChild(this.createNewNode("loginName",loginName));
	contents.appendChild(this.createNewNode("title",title));
	contents.appendChild(this.createNewNode("deptName",deptName));
	
	this.receiverElement.appendChild (contents);
	this.isReceiverChanged = true;
}

function ARE_CreateNewNode ( nameString, valueString )
{
	var param = this.editedDocument.createNode(1,"param", "");
	param.setAttribute("name", nameString);
	param.text = valueString;
	return param;
}

function ARE_RemoveReceiver ( id )
{
	//alert(this.editedDocument.xml);
	var xpath = "//contents[@id='"+id+"']";
	var signerNode = this.editedDocument.selectSingleNode(xpath);
	//alert(xpath + ", " + signerNode + this.receiverElement.selectSingleNode(xpath));
	
	if ( signerNode != null )
	{
		signerNode.parentNode.removeChild(signerNode);
	}
}


function ARE_GetXML() 
{
	if ( this.editedDocument == null ) {
		this.editedDocument = new ActiveXObject("Msxml2.DOMDocument");
		var rootElement = this.editedDocument.createElement ( "data" );
		this.editedDocument.appendChild(rootElement);	
		this.receiverElement = this.editedDocument.selectSingleNode("//data");	
	}	
	return this.editedDocument.cloneNode(true);
}

function ARE_GetReceiverHTML()
{
	var objContentsNodeList;
	objContentsNodeList = this.editedDocument.getElementsByTagName("contents");	
	
	var html = "";
	html += "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
	html += 	"<tr>";
	html += 		"<td>";

	for (var i=0; i<objContentsNodeList.length; i++) {
		var idObj = objContentsNodeList.item(i).selectSingleNode("param[@name='id']/text()");
		var objName = objContentsNodeList.item(i).selectSingleNode("param[@name='name']/text()");
		var objDept = objContentsNodeList.item(i).selectSingleNode("param[@name='deptName']/text()");
		var objTitle = objContentsNodeList.item(i).selectSingleNode("param[@name='title']/text()");

		html +=			"<tr>";
		html +=				"<td width=\"20\">";
		html +=					"<input type=\"checkbox\" style=\"margin:0px;height:16px;\" name=\"" + this.editorName+"Check" + "\" value=\"" + idObj.text + "\">";
		html +=				"</td>";
		html +=				"<td width=\"16\">";
		html +=					"<img src=\"images/org/org_person.gif\" align=\"absmiddle\">";
		html +=				"</td>";
		html +=				"<td>";
		html +=					objName.text + " ( " + objDept.text + " : " + objTitle.text + " )";
		html +=				"</td>";
		html +=			"</tr>";
	}
	
	html +=			"</td>"
	html +=		"</tr>"
	html +=	"</table>";
	return html;	
}

function ARE_MakeRecevierArray(hiddenPane) {

	var hiddenOptions = hiddenPane.all(this.editorName+"List").options;
	for ( i=0; i< hiddenOptions.length; i++) {
		hiddenOptions.remove(i);
	}	
	
	var objContentsNodeList;
	objContentsNodeList = this.editedDocument.getElementsByTagName("contents");	
	var	pDel = "|";
	for (var i=0; i<objContentsNodeList.length; i++) {
		var idObj = objContentsNodeList.item(i).selectSingleNode("param[@name='id']/text()");
		var objName = objContentsNodeList.item(i).selectSingleNode("param[@name='name']/text()");
		var objDept = objContentsNodeList.item(i).selectSingleNode("param[@name='deptName']/text()");
		var objTitle = objContentsNodeList.item(i).selectSingleNode("param[@name='title']/text()");		
		
		var refererValue  = idObj.text + pDel + objName.text + pDel + objDept.text + pDel + objTitle.text;
		var optElement = document.createElement("option");
		hiddenPane.all(this.editorName+"List").options.add(optElement);
		optElement.text = objName.text;
		optElement.value = refererValue;
		optElement.selected = true;
//		alert(refererValue);
	}	
}