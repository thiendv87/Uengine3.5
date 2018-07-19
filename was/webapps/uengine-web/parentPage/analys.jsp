<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.uengine.kernel.GlobalContext"%>
<%
	String loggedUserId=(String)session.getAttribute("loggedUserId");
	String loggedUserFullName=(String)session.getAttribute("loggedUserFullName");

	if(loggedUserId!=null){
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/default.css" />
<link rel="stylesheet" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/formdefault.css" />
<script src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/topmenuLayer.js" type="text/javascript"></script>
<script src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/AC_RunActiveContent.js" type="text/javascript"></script>
<script src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/layer_popup.js" type="text/javascript"></script>
<script src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/leftclose.js" type="text/javascript"></script>
<script LANGUAGE="JavaScript">
<!--
	function sendUrl(linkNo){
		document.all.bodyName.src=linkNo;
	}
	
	function sendNavi(naviUrl){
		//alert(naviUrl);
		document.all.navi.src=naviUrl;
	}
	function leftUrl(leftUrl){
	  document.all.leftmenu.src=leftUrl
	  var urlsplit = leftUrl.split("?");
	  var naviurl = "/srms/main/navi?"+urlsplit[1];
	  sendNavi(naviurl);
	}
//-->
</script>
<script>
	var loggedUserId = '<%=loggedUserId%>';
	if(loggedUserId==""){
		parent.location = "../loginForm.jsp";
	}
</script>
</head>

<body scroll="no">
<div id="flashArea" style="Z-INDEX: 10; LEFT: 220px; WIDTH: 565px; POSITION: absolute; TOP: 24px; HEIGHT: 36px; border: 0px none #000000; ">
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
<div id="prtwrap">
    <!-- Head Start-->
	<form name="titleform" action="../loginForm.jsp" target="_top" method="post">
    <div id="prtheader"> <span class="headerbg"><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/parentPage/worklistMain.jsp"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/Logo.gif" alt="logo" class="logo" /></a></span>
        <div class="userbtn"><a href="#" class="rollover"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/B_EditInfo.gif" /><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/B_EditInfo_on.gif" class="over"/></a><a href="javascript:titleform.submit();" class="rollover"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/B_LogoOut.gif" /><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/B_LogoOut_on.gif" class="over"/></a></div>
        <div class="userinfo"><span class="fontbold"><%=loggedUserFullName%>님</span></div>
        
        <div class="notice" > <span class="noticebg"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/NaniBG_R.gif" /></span><span style="float:right;">
           <table width="39%" border="0" cellspacing="0" cellpadding="0" style="margin-top:5px; TABLE-LAYOUT: fixed;">
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
            </table>
        </span> </div>
         <div class="naviline" style="background:<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/naviBG.gif) repeat-x :#F0F0F0;"></div>
        
    </div>
    </form>
	<!-- Head End-->
    <!-- Body Start-->
            <div class="contensright" >
		
		
		<div class="workarea">
			<iframe src="../../mondrian/testpage.jsp?query=uengine"  frameborder="0" style="width:100%;  height:expression(document.body.clientHeight-114);"></iframe>
		</div>
    </div>
    <!-- Body End-->
    <!-- Footer Start-->
    <div id="prtfooter"><span class="footerbg"></span></div>
    <!-- Footer End-->
</div>
</body>





<%	}else{ %>
<script>
 location = "../loginForm.jsp";
</script>

<%	}%>
