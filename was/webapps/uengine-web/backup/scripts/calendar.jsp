<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT %>/lib/calendar/js/jscal2.js"></script> 
<script src="<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT %>/lib/calendar/js/lang/en.js"></script> 
<link rel="stylesheet" type="text/css" href="<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT %>/lib/calendar/css/jscal2.css" /> 
<link rel="stylesheet" type="text/css" href="<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT %>/lib/calendar/css/border-radius.css" /> 
<link rel="stylesheet" type="text/css" href="<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT %>/lib/calendar/css/win2k/win2k.css" /> 

<script type="text/javascript">//<![CDATA[

	var cal = Calendar.setup({
		onSelect: function(cal) { cal.hide() }
	});
  
//]]></script> 