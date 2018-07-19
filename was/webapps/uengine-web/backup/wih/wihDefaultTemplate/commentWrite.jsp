<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  

<%@page import="org.uengine.kernel.GlobalContext"%><center>
<div class="size90per">
<div id="srctiontab">
    <ul>
        <li><span>결재 의견</span></li>
    </ul>
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td width="3" height="3"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/GrayBoxMo01.gif" width="3" height="3"></td>
    <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/GrayBoxLine01.gif"></td>
    <td width="3"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/GrayBoxMo02.gif" width="3" height="3"></td>
</tr>
<tr>
    <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/GrayBoxLine04.gif"></td>
    <td>
	    <table cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
			<tr>
			    <td class="tbltbtitle" height="26" width="100" align="center">
			    	<strong>결재 의견</strong><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Icon/8-em-check.gif" width="8" height="8" align="middle">
			    </td>
			    <td  class="tblpadding10" colspan="3" height="27" width="*">
			    	<div>
			    		<input id="MyEditor_approvalComment" type="hidden" name="approvalComment" />
			    		<input id="approvalComment___Config" type="hidden" />
			    		<iframe id="approvalComment___Frame"  frameborder="no" width="100%" scrolling="no" height="150"
			    		src="<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT %>/lib/FCKeditor/editor/fckeditor.html?InstanceName=approvalComment&Toolbar=Basic"></iframe>
			    	</div>
				</td>
			</tr>
	    </table>
    </td>
    <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/GrayBoxLine02.gif"></td>
</tr>
<tr>
        <td height="3"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/GrayBoxMo04.gif" width="3" height="3"></td>
        <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/GrayBoxLine03.gif"></td>
        <td><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/GrayBoxMo03.gif" width="3" height="3"></td>
</tr>
</table>
</div>
</center>
