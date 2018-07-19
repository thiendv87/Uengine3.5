<%@page pageEncoding="UTF-8" language="java" contentType="text/html; charset=UTF-8" import="java.util.*,org.uengine.kernel.*,org.uengine.kernel.descriptor.*,org.uengine.processmanager.*,org.uengine.util.dao.*"%>

<html><head><title>List of database values</title> 
<script>
	function tableChange(selector,dsn){
		var tableSelectedIndex = selector.selectedIndex-1;
		window.location.href = "databaseref.jsp?tableSelectedIndex=" + tableSelectedIndex+ "&DSN="+dsn;
		removeListener();
	}
	
	function dsnLoading(){
		var dsn = document.databaseRef.dsnName.value;
		window.location.href = "databaseref.jsp?DSN=" + dsn;
		removeListener();
	}
	
	String.prototype.replaceAll = function(str1, str2)
	{
  		var temp_str = this.trim();
  		temp_str = temp_str.replace(eval("/" + str1 + "/gi"), str2);
  		return temp_str;
	}
	
	String.prototype.trim = function()
	{
 		 return this.replace(/(^\s*)|(\s*$)/gi, "");
	}

	function sqlString(){
		tableIndex = document.databaseRef.tableNameList.selectedIndex;
        fieldIndex = document.databaseRef.fieldNameList.selectedIndex;
        displayfieldIndex = document.databaseRef.displayFieldNameList.selectedIndex;
		tableValue = document.databaseRef.tableNameList.options[tableIndex].value;
        fieldValue = document.databaseRef.fieldNameList.options[fieldIndex].value;
        displayFieldValue = document.databaseRef.displayFieldNameList.options[displayfieldIndex].value;
		sql = "select "+fieldValue+" as value, "+displayFieldValue +" as displayValue from "+tableValue;
		if(fieldValue!=""&&displayFieldValue!=""){
			document.databaseRef.sql_string.value = sql;
		}
	}


	var CKEDITOR = window.parent.CKEDITOR;
	
	var okListener = function(ev) {
		var ctrlName = document.databaseRef.controlName.value;
        var dsn = document.databaseRef.dsnName.value;
		var html = "";
		var sqlTemp = document.databaseRef.sql_string.value;
		sqlTemp=sqlTemp.replaceAll("'","$"); 
		sqlTemp=sqlTemp.replaceAll("%","@"); 

        if(sqlTemp == ""){
			alert("SQL is NULL!!");
		}else if(ctrlName == ""){
			alert("CTRL Name is NULL!!");
		}else{
	        //var html = "<input:databaseref name=\""+ctrlName+"\" sql=\""+sqlTemp+"\" dsn=\""+dsn+"\" viewmode=0 value=databaseref /></input:databaseref>";
			element = CKEDITOR.env.ie ? this._.editor.document.createElement( '<input:databaseref name="' + CKEDITOR.tools.htmlEncode( name ) + '">' ) : this._.editor.document.createElement( 'input:databaseref' );
			element.setAttribute("name", ctrlName);
			element.setAttribute("sql", sqlTemp);
			element.setAttribute("dsn", dsn);
			element.setAttribute("viewmode", "0");
			element.setAttribute("value", "databaseref");
			
			var fakeElement = this._.editor.createFakeElement( element, 'uengine_databaseref', 'databaseref' );
			alert(this._.databaseref);
			//if ( !this.calendar )
				this._.editor.insertElement( fakeElement );
			//else
			//{
			//	fakeElement.replace( this.calendar );
			//	editor.getSelection().selectElement( fakeElement );
			//}
		   	//this._.editor.insertHtml(html);
 	    }
        removeListener();
	};
	
	var showListener = function(ev) {
		alert('show');
		alert(CKEDITOR.instance.CKeditor1.getCurrent());
		if (CKEDITOR.getCurrent().databaseref) {
			alert('exist databaseref')
			delete CKEDITOR.getCurrent().databaseref;
		}

		var editor = this.getParentEditor(),
			selection = editor.getSelection(),
			element = selection.getSelectedElement();

		if ( element && element.getAttribute( '_cke_real_element_type' ) && element.getAttribute( '_cke_real_element_type' ) == 'calendar' )
		{
			this.calendar = element;
			element = editor.restoreRealElement( this.calendar );
			this.setupContent( element );
			selection.selectElement( this.calendar );
		}
	}

	function removeListener() {
	   	CKEDITOR.dialog.getCurrent().removeListener("ok", okListener);
	}
	
	CKEDITOR.dialog.getCurrent().on("ok", okListener);
	CKEDITOR.dialog.getCurrent().on("show", showListener);
</script>
</head>
<%
String selectedTable = request.getParameter("tableSelectedIndex");
String DSN = request.getParameter("DSN");
//System.out.println("DSN:"+DSN);
int indexOfSelectedTable = -1;
if(selectedTable!=null)	indexOfSelectedTable = Integer.parseInt(selectedTable);

List tableList=null;
List fieldList=null;
DataSourceConnectionFactory dsnCF = new DataSourceConnectionFactory();
%>

<form name=databaseRef action="databaseref.jsp" method="post">

<body leftmargin="0" topmargin="0" >
<table border=0 width=100% height=100% cellpadding=0 cellspacing=0>
	<tr>
		<td align=center bgcolor=F1F1E3>
			<table cellpadding=0 cellspacing=0>
				<tr>
					<td>
					  <font size=2 face="굴림">
ControlName
<br>
<input name="controlName" size=35>
<br>
DSN
<br>
<input name="dsnName" size=29 value="<%=DSN==null||"null".equals(DSN)?"java:/uEngineDS":DSN%>"><input type="button" value="SET" onclick ="dsnLoading()">

<br>
Table
<br>

<select name=tableNameList size=1 onchange="tableChange(this,'<%=DSN%>')"> 
<option <%=indexOfSelectedTable==-1 ? " selected":""%>>---- TABLES ----</option>

<%
//table list
if(DSN==null || "null".equals(DSN)){
	//DSN="java:/uEngineDS";
	tableList = org.uengine.kernel.descriptor.DatabaseMappingActivityDescriptor.getDatabaseDirectory(DefaultConnectionFactory.create(),"null");
}else{
	dsnCF.setDataSourceJndiName(DSN);
	tableList = org.uengine.kernel.descriptor.DatabaseMappingActivityDescriptor.getTableNames(dsnCF);
}
//System.out.println("tableList.size():"+tableList.size());
for(int i=0 ; i < tableList.size() ; i++){	
	String tableName = (String)tableList.get(i);
%>
	<option value=<%=tableName %> <%=indexOfSelectedTable==i ? " selected":""%>><%= tableName %></option>
<%      
}
%>
</select>

<br>
<br>
<font size=2 face="굴림">value of Field
<br>

<select name=fieldNameList size=1 onchange="sqlString()"> 
<option <%=indexOfSelectedTable==-1 ? " selected":""%>>---- FIELDS ----</option>
<%
if(indexOfSelectedTable>-1){
	if(DSN==null || "null".equals(DSN)){
		fieldList = org.uengine.kernel.descriptor.DatabaseMappingActivityDescriptor.getColumnNames(DefaultConnectionFactory.create(),(String)tableList.get(indexOfSelectedTable));
	}else{
		fieldList = org.uengine.kernel.descriptor.DatabaseMappingActivityDescriptor.getColumnNames(dsnCF,(String)tableList.get(indexOfSelectedTable));
	}
	for(int i=0 ; i < fieldList.size() ; i++){	
		ColumnProperty fields =(ColumnProperty)fieldList.get(i);
%>
	<option value=<%= fields.getColumnName() %>><%= fields.getColumnName() %></option>
<%      
	}
}
%>
</select>

<br>
<br>
<font size=2 face="굴림">Display of Field
<br>
<select name="displayFieldNameList" size=1 onchange="sqlString()"> 
<option <%=indexOfSelectedTable==-1 ? " selected":""%>>---- DISPLAY FIELDS ----</option>
<%
if(indexOfSelectedTable>-1){
	for(int i=0 ; i < fieldList.size() ; i++){	
		ColumnProperty displayFields = (ColumnProperty)fieldList.get(i);
%>
	<option value=<%= displayFields.getColumnName() %>><%= displayFields.getColumnName() %></option>
<%      
	}
}
%>
</select>

<br>
<br>	
<font size=2 face="굴림">SQL
<br>
<input type="text" name="sql_string" size=35>			
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</form>
