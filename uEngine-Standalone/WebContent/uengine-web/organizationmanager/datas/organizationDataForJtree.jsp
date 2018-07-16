
<%@page import="com.defaultcompany.organization.web.chartpicker.Company"%>
<%@page import="com.defaultcompany.organization.web.chartpicker.CompanyDAO"%>
<%@page import="com.defaultcompany.organization.web.chartpicker.Department"%>
<%@page import="com.defaultcompany.organization.web.chartpicker.DepartmentDAO"%>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@page import="javax.sql.DataSource"%>

<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>
[
<%
		String comCode = request.getParameter("comCode");
		String parentCode = request.getParameter("parentCode");
		
		DataSource dataSource = DefaultConnectionFactory.create().getDataSource();
		StringBuilder sbJson = new StringBuilder();
		
		if (UEngineUtil.isNotEmpty(parentCode) || UEngineUtil.isNotEmpty(comCode)) {
			DepartmentDAO departmentDAO = new DepartmentDAO(dataSource);
			List<Department> departments = null;
			
			if (UEngineUtil.isNotEmpty(parentCode)) {
				departments = departmentDAO.getChildrenOfDeparment(parentCode);
			} else if(UEngineUtil.isNotEmpty(comCode)) {
				departments = departmentDAO.getChildrenOfCompany(comCode);
			}

			if (departments != null) {
				for (Department department : departments) {
					if (sbJson.length() > 0) sbJson.append(", ");

					sbJson.append(department.toJsonForJstree());
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
					
					sbJson.append(company.toJsonForJstree());
				}
			}
		}
		//System.out.println(sbJson.toString());
		out.println(sbJson.toString());
 %>
]