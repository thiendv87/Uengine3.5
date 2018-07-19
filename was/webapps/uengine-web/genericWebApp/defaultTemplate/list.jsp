<%@page import="org.uengine.persistence.dao.*"%>
<%@page import="org.uengine.util.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.naming.*"%>
<%@page import="javax.sql.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.lang.reflect.*"%>
<%
	String daoClassName = request.getParameter("_daoClassName");
	String keyField = "";
	
	Class daoClass = Class.forName(daoClassName);
	ArrayList properties = new ArrayList();	
	HashMap propertyTypes = new HashMap();
	
	Method[] methods = daoClass.getMethods();
	propertyTypes = new HashMap(methods.length);
	for(int i=0; i<methods.length; i++){
		String propName = methods[i].getName();
		
		if(propName.startsWith("get")){
			propName = propName.substring(3);
			properties.add(propName);
			propertyTypes.put(propName, methods[i].getReturnType());
			
			if(propName.endsWith("Id"))
				keyField = propName;
		}
	}
	
	//-----customization area--------
	
		//ex) properties.remove("some field");
	
	//-------------------------------
%>

<table border=1>
<tr>
<%
	for(int i=0; i<properties.size(); i++){
		%><td><%=properties.get(i)%></td><%
	}
	
%>
</tr>

<%
/*	InitialContext ctx = null;
	ctx = new InitialContext();
	DataSource ds = (javax.sql.DataSource) ctx.lookup("java:/uEngineDS");
	Connection conn = ds.getConnection();*/
	Class.forName("oracle.jdbc.driver.OracleDriver"); 
	String url="jdbc:oracle:thin:@172.16.2.163:1521:demoora"; 
	Connection conn = DriverManager.getConnection(url, "renewal", "renewal");
	
	IDAO dao = (IDAO)GenericDAO.createDAOImpl(conn, "select * from bpm_worklist", daoClass);

	dao.select();
	
	while(dao.next()){
%>
	<tr>
	<%
		for(int i=0; i<properties.size(); i++){
			String propertyName = (String)properties.get(i);		
			Method getter = daoClass.getMethod("get" + propertyName, new Class[]{});		
			Object value = getter.invoke(dao, new Object[]{});

			if(!propertyName.equals(keyField)){			
				%><td><%=value%></td><%
			}else{
				%><td><a href="edit.jsp?_daoClassName=<%=daoClassName%>&key=<%=value%>"><%=value%></a></td><%
			}
		}
		
	%>
	</tr>
<%
	}
%>

</table>
