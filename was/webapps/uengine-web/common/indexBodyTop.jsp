<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div id="header" dojoType="dijit.layout.ContentPane" region="top" style="height:73px; border:none; background:#f0f0f0;">
	    <div id="logo"><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/index.jsp"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/logo.gif" width="137" height="49"></a></div>
	    <form name="titleform" action="<%=GlobalContext.WEB_CONTEXT_ROOT%>/loginForm.jsp" target="_top" method="post">
	    <div id="topline">
	        <div class="userbtn"><a href="#" class="rollover"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/B_EditInfo.gif" /><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/B_EditInfo_on.gif" class="over"/></a><a href="javascript:titleform.submit();" class="rollover"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/B_LogoOut.gif" /><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/B_LogoOut_on.gif" class="over"/></a></div>
	        <div class="userinfo"><span class="fontbold"><%=loggedUserFullName_t%></span> 님 접속중</div>
	    </div>
	    </form>
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
	                                            <td><iframe id="iframeTopNotice" width="100%" height="13" overflow="hidden" frameborder="0" src=" about:blank"></iframe></td>
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