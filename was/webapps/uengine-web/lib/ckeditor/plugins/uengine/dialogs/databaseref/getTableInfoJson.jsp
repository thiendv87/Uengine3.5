<%@page pageEncoding="UTF-8" language="java" contentType="text/html; charset=UTF-8" import="java.util.Arrays,java.util.List,org.uengine.util.dao.*"%>
<%
List tableList = null;
String dataSourceName = request.getParameter("dataSourceName");
DataSourceConnectionFactory dataSourceConnectionFactory = new DataSourceConnectionFactory();

dataSourceConnectionFactory.setDataSourceJndiName("java:/comp/env/" + dataSourceName);
tableList = org.uengine.kernel.descriptor.DatabaseMappingActivityDescriptor.getTableNames(dataSourceConnectionFactory);

StringBuffer jsonBuffer = new StringBuffer();
for (int i=0; i<tableList.size(); i++) {
	if (i > 0) {
		jsonBuffer.append(",");
	}
	jsonBuffer.append("\"");
	jsonBuffer.append(tableList.get(i));
	jsonBuffer.append("\"");
}

out.print("{\"name\":[" + jsonBuffer.toString() + "]}");
%>