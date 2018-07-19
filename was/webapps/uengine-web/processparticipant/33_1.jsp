<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.uengine.kernel.GlobalContext"%>
<%
	String loggedUserId_t=(String)session.getAttribute("loggedUserId");
	String loggedUserFullName_t=(String)session.getAttribute("loggedUserFullName");

	if(loggedUserId_t!=null){
%>
<head>
<title>dojox.layout.ExpandoPane</title>
<link rel="stylesheet" href="<%=GlobalContext.WEB_CONTEXT_ROOT %>/dojo/dojox/layout/tests/_expando.css" />
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
		dojo.require("dijit.layout.TabContainer");
		dojo.require("dijit.layout.ContentPane");
		dojo.require("dijit.layout.BorderContainer");
		dojo.require("dojox.layout.FloatingPane");
		dojo.require("dojox.fx.easing");
		dojo.require("dojox.rpc.Service");
		dojo.require("dojo.io.script");
	</script>
<LINK rel="stylesheet" href="../style/calendar-win2k-cold-1.css" type="text/css"/>
<style>
#logo {
	position:absolute;
	top:20px;
	left:20px;
}
#topline {
	display:inline;
}
.userinfo {
	float:right;
	font-size:11px;
	background:url(../images/Common/i_userinfo.gif) no-repeat;
	padding-left:17px;
	margin:3px 15px 0px 0px;
}
.fontbold {
	font-weight:bold;
}
.userbtn {
	float:right;
}
#topmenu {
	margin-left:200px;
	margin-top:25px;
	background:url(../images/Common/NaniBG.gif);
	width:auto;
	height:35px;
}
#flashArea {
	Z-INDEX: 10;
	LEFT: 200px;
	WIDTH: 565px;
	POSITION: absolute;
	TOP: 25px;
	HEIGHT: 36px;
	border: 0px none #000000;
}
a.rollover img {
	border:0;
	display:inline;
}
a.rollover img.over {
	display:none;
}
a.rollover img.click {
	display:none;
}
a.rollover:hover {
	border:0
}
a.rollover:hover img {
	display:none;
}
a.rollover:hover img.over {
	display:inline;
}
</style>
</head>
<body>
<div id="flashArea">
    <script type="text/javascript">
AC_FL_RunContent( 'codebase','http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0','width','565','height','100%','src','<%=GlobalContext.WEB_CONTEXT_ROOT%>/Flash/top_navi','quality','high','wmode','transparent','pluginspage','http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash','movie','<%=GlobalContext.WEB_CONTEXT_ROOT%>/Flash/top_navi?userlevel=1' ); //end AC code
</script>
    <noscript>
    <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" width="575" height="140" title="menu">
        <param name="movie" value="<%=GlobalContext.WEB_CONTEXT_ROOT%>/Flash/top_navi?userlevel=1">
        <param name="quality" value="high">
        <param name="wmode" value="transparent">
        <embed src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/Flash/top_navi.swf" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="575" height="100%"></embed>
    </object>
    </noscript>
</div>
<div id="bc" style="width:100%; height:100%;" dojoType="dijit.layout.BorderContainer">
<div id="header" dojoType="dijit.layout.ContentPane" region="top" style="height:73px; border:none; background:#f0f0f0;">
    <div id="logo"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/logo.gif" width="137" height="49"></div>
    <div id="topline">
        <div class="userbtn"><a href="#" class="rollover"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/B_EditInfo.gif" /><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/B_EditInfo_on.gif" class="over"/></a><a href="javascript:titleform.submit();" class="rollover"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/B_LogoOut.gif" /><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/B_LogoOut_on.gif" class="over"/></a></div>
        <div class="userinfo"><span class="fontbold"><%=loggedUserFullName_t%></span> 님 접속중</div>
    </div>
    <div id="topmenu">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="575">&nbsp;</td>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin:0px; TABLE-LAYOUT: fixed;">
                        <tr>
                            <td height="4" width="4"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/NoticeMo01.gif" /></td>
                            <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/NoticeLine01.gif"></td>
                            <td width="4"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/NoticeMo02.gif" /></td>
                        </tr>
                        <tr>
                            <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/NoticeLine04.gif"></td>
                            <td bgcolor="#FFFFFF" height="16"><div style="width:100%; background:url(<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/I_notice.gif); background-repeat:no-repeat; padding-left:15px;">
                                    <table width="100%" height="17" style="TABLE-LAYOUT: fixed;">
                                        <tr>
                                            <td><iframe width="100%" height="13" overflow="hidden" frameborder="0" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/jsp/notice.html"></iframe></td>
                                        </tr>
                                    </table>
                                </div></td>
                            <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/NoticeLine02.gif"></td>
                        </tr>
                        <tr>
                            <td height="4" width="4"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/NoticeMo04.gif" /></td>
                            <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/NoticeLine03.gif"></td>
                            <td width="4"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/NoticeMo03.gif" /></td>
                        </tr>
                    </table></td>
                <td><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/NaniBG_R.gif" /></td>
            </tr>
        </table>
    </div>
</div>
<div dojoType="dojox.layout.ExpandoPane" 
				splitter="true" 
				duration="125" 
				region="left" 
				title="프로세스" 
				id="leftPane" 
				maxWidth="275" 
				style="width: 275px; background: #fafafa;">
<%@include file="processDefinitionTreeList.jsp" %>
</div>
<div dojoType="dijit.layout.ContentPane" region="center" id="centerPane">
     <iframe style="width: 100%; height: 100%" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/processparticipant/initiateProcessFlowChart.jsp" name="innerworkarea" frameborder="0"></iframe>
</div>
</div>

</body>
<%	}else{ %>
<script>
 location = "../loginForm.jsp";
</script>
<%	}%>
