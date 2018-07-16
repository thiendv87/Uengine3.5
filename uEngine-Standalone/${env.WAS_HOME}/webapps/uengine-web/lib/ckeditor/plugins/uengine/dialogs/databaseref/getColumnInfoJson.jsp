<%@page pageEncoding="UTF-8" language="java" contentType="text/html; charset=UTF-8" import="java.util.Arrays,java.util.List,org.uengine.util.dao.*, org.uengine.kernel.descriptor.ColumnProperty"%>
<%
List fieldList = null;
String dataSourceName = request.getParameter("dataSourceName");
String tableName = request.getParameter("tableName");
DataSourceConnectionFactory dataSourceConnectionFactory = new DataSourceConnectionFactory();

dataSourceConnectionFactory.setDataSourceJndiName("java:/comp/env/" + dataSourceName);
fieldList = org.uengine.kernel.descriptor.DatabaseMappingActivityDescriptor.getColumnNames(dataSourceConnectionFactory, tableName);

StringBuffer jsonBuffer = new StringBuffer();
ColumnProperty columnProperty = null;
for (int i=0; i<fieldList.size(); i++) {
	columnProperty = (ColumnProperty)fieldList.get(i);
	if (i > 0) {
		jsonBuffer.append(",");
	}
	jsonBuffer.append("\"");
	jsonBuffer.append(columnProperty.getColumnName());
	jsonBuffer.append("\"");
}

out.print("{\"name\":[" + jsonBuffer.toString() + "]}");
%>