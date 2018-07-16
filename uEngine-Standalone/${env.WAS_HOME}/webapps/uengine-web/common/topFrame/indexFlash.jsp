<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="loadframe">
	<div class="loadinner">
		<div class="loadbar">
			<img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/i_dash_load.gif">
		</div>
    </div>
</div>
<div id="flashArea">
    <script type="text/javascript">
		AC_FL_RunContent(
				 'codebase', 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0',
				 'width','565',
				 'height','100%',
				 'src', '<%=GlobalContext.WEB_CONTEXT_ROOT%>/Flash/top_navi',
				 'quality','high',
				 'wmode','transparent',
				 'pluginspage', 'http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash',
				 'movie', '<%=GlobalContext.WEB_CONTEXT_ROOT%>/Flash/top_navi?userlevel=<%=sUserLevel%>&mNum=<%=iMuneNum%>&localeset=<%=loggedUserLocale%>&rootNum=<%=GlobalContext.WEB_CONTEXT_ROOT%>'
		); 
	</script>
    <noscript>
    <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="575" height="140" title="menu" 
    codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" >
        <param name="movie" value='<%=GlobalContext.WEB_CONTEXT_ROOT%>/Flash/top_navi?userlevel=<%=sUserLevel%>&mNum=<%=iMuneNum%>&_localeset=<%=loggedUserLocale%>&rootNum=<%=GlobalContext.WEB_CONTEXT_ROOT%>'>
        <param name="quality" value="high">
        <param name="wmode" value="transparent">
        <embed src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/Flash/top_navi.swf" 
        quality="high" type="application/x-shockwave-flash" width="575" height="100%"
        pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" />
    </object>
    </noscript>
</div>