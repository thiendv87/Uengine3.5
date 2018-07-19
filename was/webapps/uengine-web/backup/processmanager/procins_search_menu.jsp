<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<%@page import="org.uengine.persistence.dao.*"%>
<%
	String target = request.getParameter("target");
%>
<html>
<head>
<title>Process Instances</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<LINK href="../style/uengine.css" type=text/css rel=stylesheet>
<LINK rel="stylesheet" href="../style/portlet.css" type="text/css"/>	
<LINK rel="stylesheet" href="../style/portal.css" type="text/css"/>	
<LINK rel="stylesheet" href="../style/groupware.css" type="text/css"/>
<LINK REL="stylesheet" type="text/css" href="../css/common.css">
<script type="text/javascript" src="../script/css.js"></script>


<script type="text/javascript" src="../scripts/calendar.js"></script>
<script type="text/javascript" src="../scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../scripts/calendar-en.js"></script>
<script type="text/javascript">
	function search() {
  		//document.searchForm.target = "right";
  		document.searchForm.submit();		
	}	
	
	function selectStartDate(name) {
        Calendar.setup({
            inputField     :    name + "_start_date",    
            ifFormat       :    "y-mm-dd",      
            button         :    name + "_start_date_trigger",  
            align          :    "BC",           // alignment (defaults to "Bl")
            singleClick    :    true,
            callback       :    true
        });
	}
    
	function selectEndDate(name) {
        Calendar.setup({
            inputField     :    name + "_end_date",    
            ifFormat       :    "y-mm-dd",     
            button         :    name + "_end_date_trigger",  
            align          :    "BC",           
            singleClick    :    true,
            callback       :    true
        });
	}	

	function callback(cal) {
		//checkDate();
	}
	
	var userType = 'initiator';
	
	function selectUser(id, name, loginName) {
		if ( userType == 'initiator' ) {
			document.searchForm.initiatorId.value = id;
			document.searchForm.initiatorName.value = name;
			document.searchForm.initiatorLoginName.value = loginName;
		} else if ( userType == 'currentUser' ) {
			document.searchForm.currentUserId.value = id;
			document.searchForm.currentUserName.value = name;
			document.searchForm.currentUserLoginName.value = loginName;
		}
	}	
	
	function selectInitiator(keyword, mode) {
		userType = 'initiator';
		showSearchUserDlg(keyword, mode);	
	}	
	
	function selectCurrentUser(keyword, mode) {
		userType = 'currentUser';
		showSearchUserDlg(keyword, mode);	
	}	

	function showSearchUserDlg(keyword, mode) {
		var url = "../common/org/search_user_frame.jsp?";
		if ( keyword != '' || keyword != null ) {
			url += ("&keyword=" + keyword);
		}
		if ( mode != '' || mode != null ) {
			url += ("&mode=" + mode);
		}		
	    var StrOption ;
	    StrOption  = "dialogWidth:700px;dialogHeight:360px;";
	    StrOption += "center:on;scroll:auto;status:off;resizable:off";
	
	    showModalDialog (url , window, StrOption);
	}
	
	function init() {
		selectStartDate('init');
		selectEndDate('init');
		selectStartDate('due');
		selectEndDate('due');
		selectStartDate('complete');
		selectEndDate('complete');		
	}	
	
	function initInputBox() {
		var sForm = document.searchForm;
		sForm.initiatorId.value = "";
		sForm.initiatorName.value = "";
		sForm.currentUserId.value = "";
		sForm.currentUserName.value = "";
		sForm.init_start_date.value = "";
		sForm.init_end_date.value = "";
		sForm.due_start_date.value = "";
		sForm.due_end_date.value = "";
		sForm.complete_start_date.value = "";
		sForm.complete_end_date.value = "";
		sForm.docTitle.value = "";
		sForm.workName.value = "";
	}
</script>	
</head>

<form name="searchForm" method="post" action="processInstanceListDetail.jsp" target="instancelist">
<input type="hidden" name="initiatorId">
<input type="hidden" name="initiatorLoginName">
<input type="hidden" name="currentUserId">
<input type="hidden" name="currentUserLoginName">

<body topmargin="3">
<img src="../images/icon_root.gif" align="middle" width="10" height="11" border="0"> 
<b>Search Instances</b>
<img src="../images/refresh.gif" onclick="searchForm.reset()"><img src="images/find_obj.gif" onclick="search()">


<table border=0 width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr height="1">
		<td align="center" colspan="6" height="1" class="bgcolor_head_underline"></td>
	</tr>			

	<tr height="30" >
		<td width="50" align=left bgcolor="f4f4f4">
			&nbsp;<font size=-2>Status</font>
		</td>
		<td width="10"></td>
		<td width="*" align=left>
							<select name="status" size="1" class="black" >
								<option value="All" <%=(target.equals("All"))?"selected":""%>>All</option>
								<option value="Running" <%=(target.equals("Running"))?"selected":""%>>Running</option>
								<option value="Completed" <%=(target.equals("Completed"))?"selected":""%>>Completed</option>
							</select>
			
		</td>
		<td width="50" align=left bgcolor="f4f4f4">
			&nbsp;<font size=-2>Name</font>
		</td>
		<td width="10"></td>
		<td width="*" align=left>
			<input name="docTitle" type="text"  class="gray" size=20 maxlength="20" value="">
		</td>
	</tr>
	<tr height="1">
		<td align="center" colspan="6" height="1" class="bgcolor_head_underline"></td>
	</tr>	

	<tr height="30" >
		<td width="50" align=left bgcolor="f4f4f4">
			&nbsp;<font size=-2>Started</font>
		</td>
		<td width="10"></td>
		<td width="*" align=left>
						From <input type="text" name="init_start_date" size="10" value="" />
						<img src="../images/icon_dayselect.gif" style="cursor:hand" onclick="selectStartDate('init');" id="init_start_date_trigger">
						To <input type="text" name="init_end_date" size="10" value="" />
						<img src="../images/icon_dayselect.gif" style="cursor:hand" onclick="selectEndDate('init');" id="init_end_date_trigger"> 
			
		</td>
		
				<td width="50" align=left bgcolor="f4f4f4">
			&nbsp;<font size=-2>Ended</font>
		</td>
		<td width="10"></td>
		<td width="*" align=left>
				From <input type="text" name="complete_start_date" size="10" value="" />
				<img src="../images/icon_dayselect.gif" style="cursor:hand" onclick="selectStartDate('complete');" id="complete_start_date_trigger">  
				
				To <input type="text" name="complete_end_date" size="10" value="" />
				<img src="../images/icon_dayselect.gif" style="cursor:hand" onclick="selectEndDate('complete');" id="complete_end_date_trigger"> 
			
		</td>
		
	</tr>
	<tr height="1">
		<td align="center" colspan="6" height="1" class="bgcolor_head_underline"></td>
	</tr>	


	<!--tr height="30" >
		<td width="50" align=left bgcolor="f4f4f4">
			&nbsp;<font size=-2>Ext1</font>
		</td>
		<td width="10"></td>
		<td width="*" align=left>
			<input name="ext1" type="text"  class="gray" size=20 maxlength="20" value="">
		</td>
		<td>&nbsp;</td>
		<td width="10">&nbsp;</td>
		<td width="*" align=left>&nbsp;
		</td>
	</tr>
	<tr height="1">
		<td align="center" colspan="6" height="1" class="bgcolor_head_underline"></td>
	</tr-->	
</form>
</body>
</html>