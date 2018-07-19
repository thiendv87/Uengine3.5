<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");
    
	String strPagePath = request.getParameter("pagePath");
	if (!UEngineUtil.isNotEmpty(strPagePath)) {
		strPagePath = "wl2_workList.jsp?filtering=0&currentPage=1";
	}

	String loggedUserId_t = (String) session.getAttribute("loggedUserId");
	String loggedUserFullName_t = (String) session.getAttribute("loggedUserFullName");
	

	if (loggedUserId_t != null) {
%>

	<title>Welcome to UEngine BPM standAlone ver3.5 Release</title>
	
	<link rel="stylesheet" href="/uengine-web/dojo/dojox/layout/tests/_expando.css" />
	<link rel="stylesheet" href="/uengine-web/style/default.css" />
	<script src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/AC_RunActiveContent.js" type="text/javascript"></script>
	<script src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/topmenuLayer.js" type="text/javascript"></script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/dojo/dojo/dojo.js" djConfig="parseOnLoad:true, isDebug:false"></script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/dojo/dijit/tests/_testCommon.js"></script>
	<script src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/dojo/dojox/layout/ExpandoPane.js" type="text/javascript"></script>
	<script type="text/javascript">
		dojo.require("dojo.data.ItemFileReadStore");
		dojo.require("dijit.form.ComboBox");
		dojo.require("dijit.Tree");
		dojo.require("dijit.layout.AccordionContainer");

		dojo.require("dijit.layout.BorderContainer");			
        dojo.require("dijit.Declaration");
        dojo.require("dojo.data.ItemFileWriteStore");	

		dojo.require("dijit.Menu");
		dojo.require("dojo.parser");	// scan page for widgets and instantiate them
		dojo.require("dijit.layout.LayoutContainer");    
		var global_tn = '';
	</script>
	<link rel="stylesheet" href="../style/calendar-win2k-cold-1.css" type="text/css"/>
