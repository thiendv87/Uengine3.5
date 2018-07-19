<%@page import="com.defaultcompany.organization.web.chartpicker.*"%>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@page import="javax.sql.DataSource"%>

<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>
arrayOfResult = [
<%
		String comCode = request.getParameter("comCode");
		String parentCode = request.getParameter("parentCode");
		
		//if(parentCode != null || "null".equals(parentCode))
		//	parentCode = new String((parentCode).getBytes("8859_1"), "KSC5601");
		
		DataSource dataSource = DefaultConnectionFactory.create().getDataSource();
		StringBuilder sbJson = new StringBuilder();
		
		if (UEngineUtil.isNotEmpty(parentCode) || UEngineUtil.isNotEmpty(comCode)) {
			DepartmentDAO departmentDAO = new DepartmentDAO(dataSource);
			List<Department> departments = null;
			List hm = null;
			
			if (UEngineUtil.isNotEmpty(parentCode)) {
				departments = departmentDAO.getChildrenOfDeparment(parentCode);
			} else if(UEngineUtil.isNotEmpty(comCode)) {
				departments = departmentDAO.getChildrenOfCompany(comCode);
			}
			
			if (departments != null) {
				for (Department department : departments) {
					if (sbJson.length() > 0) sbJson.append(", ");
					sbJson.append(department.toJson());
				}
			}

			UserDAO userDAO = new UserDAO(dataSource);
			List<User> users = userDAO.getUsersOfDepartment(parentCode);

			if (users != null) {
				boolean isFirst = true;
				
				for (User user : users) {
					if (isFirst && !UEngineUtil.isNotEmpty(sbJson.toString())) {
						isFirst = false;
					} else {
						sbJson.append(", ");
					}
					
					sbJson.append(user.toJson());
				}
			}
		} else {
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