<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@page import="org.uengine.util.dao.*"%>
<%@page import="org.uengine.persistence.dao.*"%>
<%@page import="org.uengine.webservices.worklist.*"%>
<%@page import="org.uengine.ui.list.datamodel.DataMap"%>
<%@page import="org.uengine.ui.list.datamodel.DataList"%>
<%@page import="org.uengine.ui.list.datamodel.QueryCondition"%>
<%@page import="org.uengine.ui.list.util.HttpUtils"%>
<%@page import="org.uengine.ui.list.util.DAOListCursorUtil"%>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory"%>

<%
String sql =request.getParameter("sql");
sql= sql.replace("$","'");
sql= sql.replace("@","%");

String dsn =request.getParameter("dsn");
String ctrlName = request.getParameter("ctrlName");
IDAO dao=GenericDAO.createDAOImpl(dsn, sql, IDAO.class);
dao.select();
%>

<form name="dataList">
<script><!--
	var values = new Array(<%=dao.size()%>);
	var displayValues = new Array(<%=dao.size()%>);
	var extValue1 = new Array(<%=dao.size()%>);
	var extValue2 = new Array(<%=dao.size()%>);
	var extValue3 = new Array(<%=dao.size()%>);

function loadDatas(){
<%
int i=0;
while(dao.next()){
	Object o = dao.get("value");
	//System.out.println("sql:"+sql+" value:"+o+" size:"+dao.size());
	Object displayValue = dao.get("displayValue");
	
	Object extValue1 = null; try{extValue1 = dao.get("extValue1");}catch(Exception e){}
	Object extValue2 = null; try{extValue2 = dao.get("extValue2");}catch(Exception e){}
	Object extValue3 = null; try{extValue3 = dao.get("extValue3");}catch(Exception e){}
%>
	
	values[<%=i%>]="<%=o%>";
	displayValues['<%=o%>']="<%=displayValue%>";
	extValue1['<%=o%>']="<%=extValue1%>";
	extValue2['<%=o%>']="<%=extValue2%>";
	extValue3['<%=o%>']="<%=extValue3%>";
	
<%
	i++;
}
%>
	
	loadDataToSelect('');
}

function loadDataToSelect(string){
	var selectObj= document.getElementById("dataListSelect");
	selectObj.options.length = 0;
	
	if(string ==""){
		
		for(i=0 ; i< <%=dao.size()%> ; i++){
			var valueString = values[i];
			var newOption = document.createElement("option");
			newOption.text = displayValues[valueString];
			newOption.value = valueString;
			selectObj.add(newOption);	
		}
	}else{
		for(i=0 ; i< <%=dao.size()%> ; i++){
			var valueString = values[i];
			if(displayValues[valueString].indexOf(string)>-1){
				var newOption = document.createElement("option");
				newOption.text = displayValues[valueString];
				newOption.value = valueString;
				selectObj.add(newOption);	
			}	
		}
	}
}
function ok(){
	var selectObj= document.getElementById("dataListSelect");
	var value = selectObj.options[selectObj.selectedIndex].value;
	var displayValue = selectObj.options[selectObj.selectedIndex].text;
	var ex1 = extValue1[value];
	var ex2 = extValue2[value];
	var ex3 = extValue3[value];
	clickLink("<%=ctrlName%>",value,displayValue,ex1,ex2,ex3);
}
function clickLink(name,value,displayValue, extValue1, extValue2, extValue3){
	var btnCtrl = opener.dataReceiverCtrl;
				//alert("btnCtrl="+btnCtrl);
	var btnName = btnCtrl.name;
	var valueCtrlName = btnName.substring(0, btnName.length - "_database_button".length);
	var currElem = btnCtrl;
	
	var textField;
	var valueField;
	
/*	while(textField==null || valueField==null){
		currElem = currElem.previousSibling;
		
		if(currElem.name){
			if(currElem.name == valueCtrlName + "_database_text"){
				textField = currElem;
				alert("textField="+valueCtrlName);
			}else if(currElem.name == valueCtrlName){
				valueField = currElem;
				alert("valueField="+valueCtrlName);
			}
		}
	}*/
	
	valueField= currElem.previousSibling;

	textField = valueField.previousSibling;
		
/*	var textFieldName = name+"_database_text";
	var valueFieldName = name;
	window.opener.document.forms[0].all[textFieldName].value=displayValue;
	window.opener.document.forms[0].all[valueFieldName].value=value;*/
	
	textField.value=displayValue;
	valueField.value=value;
	
	if(opener.extValue1Receiver!=null)
		opener.extValue1Receiver.value = extValue1;
	
	if(opener.extValue2Receiver!=null)
		opener.extValue2Receiver.value = extValue2;
	
	if(opener.extValue3Receiver!=null)
		opener.extValue3Receiver.value = extValue3;
	
	var onChangeFieldName = "<%=ctrlName%>_onChange";
	
	if(window.opener.document.forms[0].all[onChangeFieldName]){
  		eval(window.opener.document.forms[0].all[onChangeFieldName].value);
 	}

	window.close();
} 
--></script>

<body leftmargin="0" topmargin="0" onload="loadDatas()">
<table width=100% height=100% cellpadding=0 cellspacing=0>
	<tr>
		<td bgcolor=E3E3C7 height= 5><font size=3 color=737357 face="돋음"></td>
	</tr>
	<tr>
		<td align=center bgcolor=F1F1E3>
			<table cellpadding=0 cellspacing=0>
				<tr>
					<td ><font size=3 color=737357 face="돋음">
						DATA SEARCH<br>
						<input type=text name=tableName size=27 onKeyUp="loadDataToSelect(this.value)"><br>
						<select name="dataListSelect" size="10" style="width:200px"></select>
					</td>
				</tr>
				<tr>
					<td align=right><input type=button value="OK" onclick="ok()"><input type=button value="CANCEL" onclick="javascript:window.close();"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td bgcolor=E3E3C7 height= 5 align=right></td>
	</tr>
</table>

</form>
