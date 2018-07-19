
<%@page import="com.defaultcompany.organization.web.chartpicker.*"%>
<%@page import="com.defaultcompany.organization.web.chartpicker.Role"%>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@page import="javax.sql.DataSource"%>

<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>

<%
		String rolecode = reqMap.getString("rolecode", "");
		String[] empcodelist  = reqMap.getString("empcode", "").split(";");
		
		DataSource dataSource = DefaultConnectionFactory.create().getDataSource();
		RoleUserDAO roleUserDAO = new RoleUserDAO(dataSource);

		boolean flag = false;
		int[] result=null;
		try{
			result = roleUserDAO.deleteRoleUsers(rolecode, empcodelist);	
		}catch(Exception e){
			System.out.println(e.getMessage());
			flag = true;
		}
		if(flag)
			out.print("alert('"+GlobalContext.getMessageForWeb("delete_roleuser_error", loggedUserLocale)+"')");
		else
			out.print("alert('"+GlobalContext.getMessageForWeb("delete_roleuser_ok", loggedUserLocale)+"')");
 %>
