<%@page import="org.uengine.persistence.dao.*"%>
<%@page import="org.uengine.util.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.naming.*"%>
<%@page import="javax.sql.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.lang.reflect.*"%>
<%
	String daoClassName = request.getParameter("_daoClassName");
	String tableName = request.getParameter("_tableName");
	String keyField = "";
	Class daoClass = Class.forName(daoClassName);
	String classNameOnly = org.uengine.util.UEngineUtil.getClassNameOnly(daoClass);
	String daoInstName = classNameOnly.toLowerCase();

	ArrayList properties = new ArrayList();	
	HashMap propertyTypes = new HashMap();
	
	Method[] methods = daoClass.getMethods();
	propertyTypes = new HashMap(methods.length);
	for(int i=0; i<methods.length; i++){
		String propName = methods[i].getName();
		
		if(propName.startsWith("get") && methods[i].getParameterTypes().length==0){
			propName = propName.substring(3);
			properties.add(propName);
			propertyTypes.put(propName, methods[i].getReturnType());
			
			if(propName.endsWith("Id"))
				keyField = propName;
		}
	}
	
%>

<h1>Generate Simple Lister: 1.Enter Parameters > <font color=green>2.Customize JSP</font> > 3.Deploy </h1>

<form action=deploy.jsp method=POST>

<textarea name=_source cols=100 rows=30>

&lt;%@page import="dao.*"%&gt;
&lt;%@page import="org.uengine.util.dao.*"%&gt;
&lt;%@page import="java.util.*"%&gt;
&lt;%@page import="javax.naming.*"%&gt;
&lt;%@page import="javax.sql.*"%&gt;
&lt;%@page import="java.sql.*"%&gt;


&lt;table border=1&gt;
&lt;tr&gt;
<%
	for(int i=0; i<properties.size(); i++){
		%>&lt;td&gt;<%=properties.get(i)%>&lt;/td&gt;
		<%
	}
	
%>
&lt;/tr&gt;

&lt;%

	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url="jdbc:oracle:thin:@172.16.2.163:1521:demoora";
	Connection conn = DriverManager.getConnection(url, "renewal", "renewal");
	
	<%=daoClassName%> <%=daoInstName%> = (<%=daoClassName%>)GenericDAO.createDAOImpl(conn, "select * from <%=tableName%>", <%=daoClassName%>.class);
	
	<%=daoInstName%>.select();
	
	while(<%=daoInstName%>.next()){
%&gt;
	&lt;tr&gt;
	<%
		for(int i=0; i<properties.size(); i++){
			String propertyName = (String)properties.get(i);		
			
			if(!propertyName.equals(keyField)){			
				%>&lt;td&gt;&lt;%=<%=daoInstName%>.get<%=propertyName%>()%&gt;&lt;/td&gt;
				<%
			}else{
				%>&lt;td&gt;&lt;a href="edit.jsp?key=&lt;%=<%=daoInstName%>.get<%=propertyName%>()%&gt;"&gt;&lt;%=<%=daoInstName%>.get<%=propertyName%>()%&gt;&lt;/a&gt;&lt;/td&gt;
				<%
			}
		}
		
	%>
	
	&lt;/tr&gt;
&lt;%
	}
%&gt;
&lt;/table&gt;

</textarea>
<p>

File Name: <input size=100 name="_fileName" value="genericWebApp/generatedApps/<%=classNameOnly%>_Lister.jsp">
<p>
<input type="submit" value="Deploy">
</form>

