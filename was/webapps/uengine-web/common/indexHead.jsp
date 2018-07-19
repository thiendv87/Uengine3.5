
	<title>Welcome to UEngine BPM standAlone ver3.5 Release</title>
	
	<link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/dojo/dijit/tests/css/dijitTests.css" />
	<link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/dojo/dojox/layout/tests/_expando.css" />
	<link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/default.css" />
	<link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/calendar-win2k-cold-1.css" />
	
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/AC_RunActiveContent.js" ></script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/topmenuLayer.js"></script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/dojo/dojo/dojo.js" djConfig="parseOnLoad:true, isDebug:false"></script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/dojo/dijit/tests/_testCommon.js"></script>
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/dojo/dojox/layout/ExpandoPane.js"></script>
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
