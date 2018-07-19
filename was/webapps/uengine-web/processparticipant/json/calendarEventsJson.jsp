<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.sql.Timestamp"%>
<%@page import="com.defaultcompany.organization.web.chartpicker.*"%>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@page import="javax.sql.DataSource"%>

<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>
<%
		DataSource dataSource = DefaultConnectionFactory.create().getDataSource();
		StringBuffer sbJson = new StringBuffer();

		Timestamp timeStart = Timestamp.valueOf(request.getParameter("dtStart"));
		Timestamp timeEnd = Timestamp.valueOf(request.getParameter("dtEnd"));
		
		String empCode = reqMap.getString("empCode", loggedUserId);

		CalendarEventDAO calendarDAO = new CalendarEventDAO(dataSource);
		List<CalendarEvent> salendarEvents= calendarDAO.getEvents(timeStart, timeEnd, empCode);

		if(salendarEvents != null)
		{
			boolean isFirst = true;
			
			for(CalendarEvent calendarEvent : salendarEvents)
			{
				if (isFirst) {
					isFirst = false;
				} else {
					sbJson.append(", ");
				}
				
				sbJson.append(calendarEvent.toJson());
			}
		}
 %>
[<%=sbJson %>];