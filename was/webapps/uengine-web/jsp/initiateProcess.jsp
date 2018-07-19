<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<link rel="stylesheet" href="/style/_expando2.css" />
<link rel="stylesheet" href="/style/formdefault.css" />
<script src="/scripts/layer_popup.js" type="text/javascript"></script>
<script type="text/javascript" src="/dojo/dojo/dojo.js"	djConfig="parseOnLoad:true, isDebug:false"></script>
<script type="text/javascript" src="/dojo/dijit/tests/_testCommon.js"></script>
<script src="/dojo/dojox/layout/ExpandoPane.js" type="text/javascript"></script>
<script type="text/javascript">
		dojo.require("dijit.layout.TabContainer");
		dojo.require("dijit.layout.ContentPane");
		dojo.require("dijit.layout.LayoutContainer");
		dojo.require("dojo.parser");
</script>
<!--우리은행 = 1, 광주,경남=2 , 우리FIS=3, 나머지=1-->
<script>
	function initiateProcess(alias){
		location = "../processmanager/initiateForm.jsp?alias=" + alias + "&cus_com=2";
	}
</script>
 
</head>
</html>  
<div dojoType="dijit.layout.LayoutContainer" style="width: auto; height: 100%; ">
<div id="mainTabContainer" layoutAlign="client" dojoType="dijit.layout.TabContainer" scrolling="true" style="height:100%; background:url(/images/Common/tab_bg.gif) repeat-x;  ">

	<!--<div id="tab1" dojoType="dijit.layout.ContentPane" href="tab1.jsp" title="공통"></div>-->

	<div id="woori" dojoType="dijit.layout.ContentPane" href="tab2.jsp"  title="우리은행"></div>
	
	<!-- 광주은행 -->
	<div id="kj" dojoType="dijit.layout.ContentPane" href="tab3.jsp" title="광주은행"></div>
	
	<!-- 경남은행 -->
	<div id="kn" dojoType="dijit.layout.ContentPane" href="tab4.jsp" title="경남은행"></div>
	
	<!-- 우리금융정보시스템 -->
	<div id="wooriFIS" dojoType="dijit.layout.ContentPane" href="tab5.jsp" title="우리FIS"></div>
	
	<!-- 우리금융지주회사 -->
	<div id="wr" dojoType="dijit.layout.ContentPane" href="tab6.jsp" title="우리금융지주회사"></div>
	
	<!-- 우리투자증권 -->
	<div id="wr2" dojoType="dijit.layout.ContentPane" href="tab7.jsp" title="우리투자증권"></div>
	
	<!-- 자동입력 -->
	<div id="auto" dojoType="dijit.layout.ContentPane" href="tab8.jsp" title="자동입력"></div>
</div>
</div>