<%@page import="java.net.URLDecoder"%>
<%@page import="org.springframework.web.util.HtmlUtils"%>
<%@page import="org.uengine.util.UEngineUtil"%>
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
<%@page import="org.uengine.kernel.GlobalContext"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="javax.naming.*"%>

<%
String sql =request.getParameter("sql");
sql= sql.replace("$","'");
sql= sql.replace("@","%");

String dsn =request.getParameter("dsn");
String ctrlName = request.getParameter("ctrlName");

DataSourceConnectionFactory dsConFactory = new DataSourceConnectionFactory();
dsConFactory.setDataSourceJndiName("java:/comp/env/" + dsn);
Connection conn = dsConFactory.getConnection();

Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

%>

<link rel="stylesheet" href="<%=GlobalContext.WEB_CONTEXT_ROOT %>/style/formdefault.css" />
<link rel="stylesheet" href="<%=GlobalContext.WEB_CONTEXT_ROOT %>/style/popup.css" />

<script>
<!--
	var values = new Array();
	var displayValues = new Array();
	var extValue1 = new Array();
	var extValue2 = new Array();
	var extValue3 = new Array();

function loadDatas(){
<%
int i=0;
int rsSize=0;
while(rs.next()){
	Object o = rs.getObject("value");
	Object displayValue = rs.getObject("displayValue");
	
	Object extValue1 = null; try{extValue1 = rs.getObject("extValue1");}catch(Exception e){}
	Object extValue2 = null; try{extValue2 = rs.getObject("extValue2");}catch(Exception e){}
	Object extValue3 = null; try{extValue3 = rs.getObject("extValue3");}catch(Exception e){}	
%>
	
	values[<%=i%>]="<%=o%>";
	displayValues['<%=o%>']="<%=displayValue%>";
	extValue1['<%=o%>']="<%=extValue1%>";
	extValue2['<%=o%>']="<%=extValue2%>";
	extValue3['<%=o%>']="<%=extValue3%>";
	
<%
	i++;
}
rsSize=i;

if (rs != null) rs.close();
if (stmt != null) stmt.close();
if (conn != null) conn.close();
%>
	
	loadDataToSelect('');
}

function loadDataToSelect(string){

	var selectObj= document.getElementById("dataListSelect");
	selectObj.options.length = 0;
	
	if(string ==""){
		for(i=0 ; i< <%=rsSize%> ; i++){
			var valueString = values[i];
			var newOption = document.createElement("option");
			newOption.text = displayValues[valueString];
			newOption.value = valueString;
			selectObj.add(newOption);	
		}
	}else{
		for(i=0 ; i< <%=rsSize%> ; i++){
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
	var btnName = btnCtrl.name;
	var valueCtrlName = btnName.substring(0, btnName.length - "_database_button".length);
	var currElem = btnCtrl;
	
	var textField;
	var valueField;
	
	valueField= currElem.previousSibling;

	textField = valueField.previousSibling;
	
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
-->
</script>

<body leftmargin="0" topmargin="0" onLoad="loadDatas()">

<div id="toptitle"><span>Select Data</span></div>
<br>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="3" height="3"><img
			src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxMo01.gif" width="3" height="3"></td>
		<td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine01.gif"></td>
		<td width="3"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxMo02.gif" width="3" height="3"></td>
	</tr>
	<tr>
		<td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine04.gif"></td>
		<td align="center" bgcolor="#E6E6E6">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td class="fontbold"><font size="3" color="#737357">DATA SEARCH</font><br>
				<input type="text" name="tableName"
					style="width: 200px; border: 1px solid #c4c4c4;" onKeyUp="loadDataToSelect(this.value);"><br>
				<select name="dataListSelect" size="13"
					style="width: 200px; border: 1px solid #c4c4c4;">
				</select></td>
			</tr>
			<tr>
				<td align="right">
					<img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/b_btn_confirm.gif" width="39" height="23" style="cursor: pointer;" onClick="ok()" /> 
					<img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/b_btm_cancel.gif" width="39" height="23" style="cursor: pointer;" onClick="javascript:window.close();">
				</td>
			</tr>

		</table>
		</td>
		<td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine02.gif"></td>
	</tr>
	<tr>
		<td height="3"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxMo04.gif"
			width="3" height="3"></td>
		<td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine03.gif"></td>
		<td><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxMo03.gif" width="3"
			height="3"></td>
	</tr>
</table>
</body>