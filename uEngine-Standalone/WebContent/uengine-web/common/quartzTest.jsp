<%@page import="javax.naming.InitialContext"%>
<%@page import="org.quartz.Scheduler"%>

<%
  InitialContext context = new InitialContext();
  Scheduler quartz1 = (Scheduler) context.lookup("app1/Quartz");
  String name = quartz1.getSchedulerName(); // => "App2QuartzScheduler"
 %>
 <%=name%>