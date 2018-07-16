<%@include file="../common/header.jsp"%><%@page import="org.springframework.web.bind.ServletRequestUtils"%><%@page import="com.defaultcompany.web.strategy.StrategyService"%><%

	//String name = reqMap.getString( "name", "");
	String name = new String(reqMap.getString( "name", "").getBytes("ISO8859_1"), "UTF-8");
	String partCode = ServletRequestUtils.getStringParameter(request, "partCode", "");
	String period = ServletRequestUtils.getStringParameter(request, "period", "");
	String selectedPeriod = ServletRequestUtils.getStringParameter(request, "selectedPeriod", "");
	boolean isNotCompleted = "".equals(ServletRequestUtils.getStringParameter(request, "includingNotCompleted", ""))? false:true;
	
	try{
		StrategyService ss = new StrategyService();
		out.print(ss.allStrategyToJSON(name,selectedPeriod,partCode,period,isNotCompleted));
	}catch(Exception e){
		e.printStackTrace();
	}    
%>

	