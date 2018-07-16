
<%@page import="com.defaultcompany.organization.web.chartpicker.*"%>
<%@page import="com.defaultcompany.organization.web.chartpicker.Role"%>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@page import="javax.sql.DataSource"%>

<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>
[
<%
		String comCode = reqMap.getString("comCode", "");
		String roleCode = reqMap.getString("roleCode", "");
		
		DataSource dataSource = DefaultConnectionFactory.create().getDataSource();
		StringBuilder sbJson = new StringBuilder();
		
		if (UEngineUtil.isNotEmpty(roleCode))
		{
			RoleUserDAO userDAO = new RoleUserDAO(dataSource);
			List<RoleUser> users = null;
			
			users = userDAO.getRoleUsers(roleCode);

			if (users != null) {
				for (RoleUser user : users) {
					if (sbJson.length() > 0) sbJson.append(", ");
					sbJson.append(user.toJson());
				}
			}
		}
		else if(UEngineUtil.isNotEmpty(comCode))
		{
			RoleDAO roleDAO = new RoleDAO(dataSource);
			List<Role> roles = null;
			
			roles = roleDAO.getRoles(comCode);

			if (roles != null) {
				for (Role role : roles) {
					if (sbJson.length() > 0) sbJson.append(", ");					
					sbJson.append(role.toJson());
				}
			}
		}
		else
		{
			CompanyDAO companyDAO = new CompanyDAO(dataSource);
			List<Company> companies = null;
			
			if (loggedUserIsMaster) {
				companies = companyDAO.getCompany();
			} else {
				companies = companyDAO.getCompany(loggedUserGlobalCom);
			}
			
			if (companies != null) {
				for (Company company : companies) {
					if (sbJson.length() > 0) sbJson.append(", ");
					sbJson.append(company.toJson());
				}
			}
		}
		
		out.println(sbJson.toString());
 %>
 ];