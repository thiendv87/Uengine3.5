<%@page import="com.defaultcompany.organization.web.chartpicker.*"%>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@page import="javax.sql.DataSource"%>

<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>
[
<%
		String comCode = reqMap.getString("comCode", loggedUserGlobalCom);
		String parentCode = reqMap.getString("parentCode", "");
		
		DataSource dataSource = DefaultConnectionFactory.create().getDataSource();
		StringBuffer sbJson = new StringBuffer();
		
		if (UEngineUtil.isNotEmpty(parentCode))
		{
			DepartmentDAO departmentDAO = new DepartmentDAO(dataSource);
			List<Department> departments= departmentDAO.getDeparment(parentCode);

			if(departments != null)
			{
				for(Department department : departments)
				{
					sbJson.append(department.toJson());
					break;
				}
			}
		}
		else
		{
			CompanyDAO companyDAO = new CompanyDAO(dataSource);
			List<Company> companies = companyDAO.getCompany(comCode);
			
			if(companies != null)
			{
				for(Company company : companies)
				{
					sbJson.append(company.toJson());
					break;
				}
			}
		}
		
		out.println(sbJson.toString());
 %>
 ];