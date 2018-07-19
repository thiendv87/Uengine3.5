<%@page import="com.defaultcompany.login.LoginService"%>
<%@page import="org.uengine.util.UEngineUtil"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,javax.sql.*,javax.naming.*"  %>
<%@ page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@page import="org.uengine.kernel.GlobalContext"%>
<%
	boolean useCookie = "true".equals(GlobalContext.getPropertyString("web.cookie.use","false"));
	String cookieExpires = GlobalContext.getPropertyString("web.cookie.expires", "1");
	
	response.setHeader ("Pragma", "No-cache"); 
	response.setDateHeader ("Expires", 0);
	response.setHeader ("Cache-Control", "no-cache");
%>
<html>
<head>
    <title>Login Form</title>
    
	<!-- import common libraries -->
	<%@include file="./scripts/importCommonScripts.jsp" %>


	<script type="text/javascript">
		var USE_COOKIE = <%=useCookie%>;
		var COOKIE_EXPIRES = <%=cookieExpires%>;
		var COOKIE_KEY_SAVE_ID = "<%=LoginService.COOKIE_SAVE_ID%>";
		var COOKIE_KEY_AUTO_LOGIN = "<%=LoginService.COOKIE_AUTO_LOGIN%>";
		
		function formValidate(){
			return true;
		}
	
		function initateProcess(defverid) {
			var option = "width=900,height=550,scrollbars=yes,resizable=yes";
			var url = "<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/initiateForm.jsp?processDefinition=" + defverid + "&regUser=true";
			window.open(url, "wihspace", option)
		}
		
		function loginAction() {
			var userId = $("input[name=userId]").val();
			var passWd = $("input[name=passWd]").val(); 
			if (window.console)	console.log(userId);
			if (window.console)	console.log(passWd);
			
			$.ajax({
			    type: "GET",
			    data: {"userId":userId,"passWd":passWd},
			    contentType: "application/json;charset=utf-8", 
			    url: WEB_CONTEXT_ROOT+"/LoginNew.jsp",
			   //url: "http://localhost:8080/uengine-web/LoginNew.jsp",
			    success: function(msg, status) {
			    	if(window.console)	console.log(msg);
			    	jsonobj = eval("("+msg+")");
			    	if(jsonobj.condition=="Success"){
						if (USE_COOKIE) {
							if ($("input[name='chksaveid']").attr("checked")) {
								$.cookie(COOKIE_KEY_SAVE_ID, $("input[name='userId']").val(), {'expires':COOKIE_EXPIRES});
							} else {
								$.cookie(COOKIE_KEY_SAVE_ID, "");
							}
		    			
			    			$.cookie(COOKIE_KEY_AUTO_LOGIN, $("input[name=chkautologin]").attr("checked"), {'expires':COOKIE_EXPIRES});
						}
			    		
			    		document.location.href=WEB_CONTEXT_ROOT+"/index.jsp";
			    	}else if(jsonobj.condition=="Fail"){
			    		alert(jsonobj.msg);
			    	}
			    },			
			    error: function(msg, status) {
			    	if ( window.console ) console.log(msg);
			    }
			});
		}

	
	<%if(useCookie){ %>
		$(document).ready(function(){
			if (!isEmpty(COOKIE_KEY_SAVE_ID)) {
				setSaveId();
			}
			
			if (!isEmpty(COOKIE_KEY_AUTO_LOGIN)) {
				setAutoLogin();
				setSaveId();
			}
			
			$("#divCookie").toggle();
		});
		
		function setSaveId() {
			var cookieUidValue = $.cookie(COOKIE_KEY_SAVE_ID);
			if (!isEmpty(cookieUidValue)) {
				$("input[name='chksaveid']").attr({
					"checked":true
				});
				
				$("input[name='userId']").attr({
					"value":cookieUidValue
				});
			}
		}
		
		function setAutoLogin() {
			var cookieAutoLogin = $.cookie(COOKIE_KEY_AUTO_LOGIN);
			if (!isEmpty(cookieAutoLogin)) {
				$($("input[name='chkautologin']")).attr({
					"checked":cookieAutoLogin
				});
			}
		}
	<% } %>
	</script>

	<link href="style/uengine.css" type="text/css" rel="stylesheet">

    <style>
	    p { font-family: georgia, sans-serif; font-size: 11px; }
		html, body {
			height: 100%;
			margin:0;
			padding:0;
		}
		
		* {
			margin:0;
			padding:0;
			font-family:"돋움", Dotum, "굴림", Gulim, AppleGothic, Sans-serif;
			font-size:11px;
			color:#333333;
		}
	</style>
	
	</head>

<body >

<div style="height:518px; width:896px; background:url(images/login/1.gif) no-repeat; top:50%; left:50%; margin-left:-448px; margin-top:-309px; position:absolute; border:0px">
	<div style="margin:90px 0 0 194px; height:61px;">
    	<div style="float:left;"><img src="images/login/logo_new.gif" border="0"></div>
    	<!-- <div style="float:left;"><img src="images/login/logo.gif" border="0"></div>  -->
        <div style="float:left; margin-top:28px;"><span style="font-size:11px; color:#999; ">Ver 3.5.5 standalone</span></div>    
    </div>
  
    <div style=" height:50px; width:369px; margin:53px 0 0 250px;">
        <!-- login form -->
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="15%" height="30"><img src="images/login/i_id.gif" width="41" height="13"></td>
                <td width="69%" rowspan="2">
                    <input type="hidden" name="return_to" value="" />
                    <input type="hidden" name="login" value="Login">
					<input name="userId" style="width:190px;ime-mode:inactive"/>
                    <br />
                    <span><input type="password" name="passWd" style="width:190px; margin-top:8px;"/></span>
                    <br />
                   </td>
                <td width="16%" rowspan="2"><input type="image" src="images/login/b_login.gif" title="click is login" alt="click is login" onclick="javascript:loginAction();"/></td> </form>
            </tr>
            <tr>
                <td height="30"><img src="images/login/i_pw.gif" width="41" height="13"></td>
            </tr>
        </table>
    </div>
    <!-- login option -->
    <div id="divCookie" style="display:none; background:url(images/login/i_blue01.gif) no-repeat 2px;; padding:0 0 0 10px;  margin:14px 0 0 250px; width:380px; color:#808080 ">Save Id <input type="checkbox" name="chksaveid" />&nbsp;&nbsp;&nbsp;Auto Login <input type="checkbox" name="chkautologin" /></div>
    <div style=" background:url(images/login/i_blue01.gif) no-repeat 2px;; padding:0 0 0 10px;  margin:<%=useCookie ? "7" : "28"%>px 0 0 250px; width:380px; color:#808080 ">Administrator (<b>EN</b>) User/Password is <span style="color:#09C;">test / test</span></div>
    <div style=" background:url(images/login/i_blue01.gif) no-repeat 2px;; padding:0 0 0 10px;  margin:7px 0 0 250px; width:380px; color:#808080 ">Administrator (<b>KO</b>) User/Password is <span style="color:#09C;">test_ko / test</span>
    </div>
    <!-- div style=" background:url(images/login/i_blue01.gif) no-repeat 2px;; padding:0 0 0 10px;  margin:28px 0 0 250px; width:380px; color:#808080 ">If you want registration new company <strong><span style="color:#09C;"><a href="javascript: initateProcess('812');">CLICK HERE</a></span></strong></div -->
</div>
    
</body>
</html>