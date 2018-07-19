<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="org.uengine.util.dao.*"%>
<%@ page import="org.uengine.persistence.dao.*"%>
<%@ page import="org.uengine.persistence.processinstance.*"%>
<%@ page import="org.uengine.ui.list.datamodel.DataMap"%>
<%@ page import="org.uengine.ui.list.datamodel.DataList"%>
<%@ page import="org.uengine.ui.list.datamodel.QueryCondition"%>
<%@ page import="org.uengine.ui.list.util.HttpUtils"%>
<%@ page import="org.uengine.ui.list.util.DAOListCursorUtil"%>
<%@ page import="org.uengine.util.dao.DefaultConnectionFactory"%>

<%@ page import="java.text.*"%>


<html>
<head>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/getLoggedUser.jsp"%>
<%@ include file="../common/styleHeader.jsp"%>
<link rel='stylesheet' type='text/css' href='<%=GlobalContext.WEB_CONTEXT_ROOT%>/lib/jquery/css/cupertino/jquery-ui-1.8.7.custom.css' /> 
<script type='text/javascript' src='<%=GlobalContext.WEB_CONTEXT_ROOT%>/lib/jquery/jquery-1.4.4.js'></script>
<script type='text/javascript' src='<%=GlobalContext.WEB_CONTEXT_ROOT%>/lib/jquery/jquery-ui-1.8.7.custom.min.js'></script>
<script type='text/javascript' src='<%=GlobalContext.WEB_CONTEXT_ROOT%>/lib/jquery/jcalendar.js'></script>

<%@ taglib uri="http://www.uengine.org/taglibs/bpm" prefix="bpm" %>

<script>
	window.onload = function(){  
		setCalender("<%=loggedUserLocale%>", {buttonImage:"<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Icon/btn_calendar.gif"});
	} 
	function cSubmit(mm){
		var year  = parseInt(document.getElementById("year").value);
		var month = parseInt(document.getElementById("month").value);
		    month = month + mm;
		
		if(month == 0){
			year  = year - 1;
			month = 12;
		}else if(month == 13){
			year  = year + 1;
			month = 1;
		}
		
		document.getElementById("year").value  = year;
		document.getElementById("month").value = month;
		document.attendenceForm.submit();
	}
	
	function orderby(ord, asc){
		document.getElementById("ord").value = ord;
		document.getElementById("asc").value = asc;
		document.attendenceForm.submit();
	}
</script>
</head>


<body>
<form name="attendenceForm" action="workPerfList.jsp" method="POST">
<%
	String dbfactnm = DAOFactory.getInstance(null).getDBMSProductName();
	Calendar calendar = Calendar.getInstance(); 
	String lastday = String.valueOf(calendar.getActualMaximum(Calendar.DAY_OF_MONTH)); 

	java.util.Date     d = new java.util.Date();
	SimpleDateFormat df1 = new SimpleDateFormat("yyyy"); 
	SimpleDateFormat df2 = new SimpleDateFormat("MM");
	String year  		 = request.getParameter("year") ==null?df1.format(d):request.getParameter("year");
	String month 		 = request.getParameter("month")==null?df2.format(d):request.getParameter("month");
	String ord 			 = request.getParameter("ord")  ==null?"((LATED_WORKCNT+LATE_WORKCNT)*100/(LATED_WORKCNT+RUNNING_WORKCNT+COMPLETE_WORKCNT+CANCEL_WORKCNT)) ":request.getParameter("ord") + " ";
	String asc 			 = request.getParameter("asc")  ==null?" DESC":" " + request.getParameter("asc");
	String orderby       = ord+asc;
		
	DecimalFormat mm = new DecimalFormat("00");
	month = mm.format(Double.parseDouble(month));

	String fromday = request.getParameter("fromday") == null?year+"-"+month+"-"+"01":request.getParameter("fromday");
	String today   = request.getParameter("today")   == null?year+"-"+month+"-"+mm.format(Double.parseDouble(lastday)):request.getParameter("today");
	
	StringBuffer sql = new StringBuffer();
		
	sql.append("\n SELECT 	*	FROM (			");
	sql.append("\n 	 SELECT 					");
	sql.append("\n 	   DEPT.PARTNAME			");
	sql.append("\n 	  ,EMP.EMPNAME				");
	if("HSQL".equals(dbfactnm.toUpperCase()) || "MYSQL".equals(dbfactnm.toUpperCase())){
		sql.append("\n 	  ,IFNULL(WKL.LATED_WORKCNT		, 0) LATED_WORKCNT 	  ");
		sql.append("\n 	  ,IFNULL(LTE.LATE_WORKCNT		, 0) LATE_WORKCNT 	  ");
		sql.append("\n 	  ,IFNULL(RNL.RUNNING_WORKCNT	, 0) RUNNING_WORKCNT  ");
		sql.append("\n 	  ,IFNULL(CPL.COMPLETE_WORKCNT	, 0) COMPLETE_WORKCNT ");
		sql.append("\n 	  ,IFNULL(CAN.CANCEL_WORKCNT	, 0) CANCEL_WORKCNT   ");
	}else if("ORACLE".equals(dbfactnm.toUpperCase())){
		sql.append("\n 	  ,NVL(WKL.LATED_WORKCNT		, 0) LATED_WORKCNT 	  ");
		sql.append("\n 	  ,NVL(LTE.LATE_WORKCNT			, 0) LATE_WORKCNT 	  ");
		sql.append("\n 	  ,NVL(RNL.RUNNING_WORKCNT		, 0) RUNNING_WORKCNT  ");
		sql.append("\n 	  ,NVL(CPL.COMPLETE_WORKCNT		, 0) COMPLETE_WORKCNT ");
		sql.append("\n 	  ,NVL(CAN.CANCEL_WORKCNT		, 0) CANCEL_WORKCNT   ");
	}
	sql.append("\n 	 FROM EMPTABLE EMP													");
	sql.append("\n 	   LEFT OUTER JOIN PARTTABLE DEPT ON DEPT.PARTCODE = EMP.PARTCODE	");
	sql.append("\n 	   LEFT OUTER JOIN 	( 												");
	sql.append("\n 	 	SELECT 															");
	sql.append("\n 	   		COUNT(WK.TASKID) LATED_WORKCNT, WK.ENDPOINT					");
	sql.append("\n 	 	FROM BPM_WORKLIST	WK											");
	sql.append("\n 	 		INNER JOIN BPM_PROCINST 	PI ON PI.INSTID = WK.ROOTINSTID AND PI.ISDELETED = 0		");
	sql.append("\n 	 	WHERE WK.STATUS IN ('NEW', 'CONFIRMED')							");
	if("HSQL".equals(dbfactnm.toUpperCase()) || "ORACLE".equals(dbfactnm.toUpperCase())){
		sql.append("\n 	 	AND WK.DUEDATE < SYSDATE									");	
	}else{
		sql.append("\n 	 	AND WK.DUEDATE < now()										");
	}
	sql.append("\n 	 	GROUP BY WK.ENDPOINT											");
	sql.append("\n 	 ) WKL ON WKL.ENDPOINT = EMP.EMPCODE								");
	sql.append("\n 	   LEFT OUTER JOIN 	( 												");
	sql.append("\n 	 	SELECT 															");
	sql.append("\n 	   		COUNT(WK.TASKID) RUNNING_WORKCNT, WK.ENDPOINT				");
	sql.append("\n 	 	FROM BPM_WORKLIST	WK											");
	sql.append("\n 	 		INNER JOIN BPM_PROCINST 	PI ON PI.INSTID = WK.ROOTINSTID AND PI.ISDELETED = 0		");
	sql.append("\n 	 	WHERE WK.STATUS IN ('NEW', 'CONFIRMED')							");
	if("HSQL".equals(dbfactnm.toUpperCase()) || "ORACLE".equals(dbfactnm.toUpperCase())){
		sql.append("\n 	 	AND WK.DUEDATE >= SYSDATE									");	
	}else{
		sql.append("\n 	 	AND WK.DUEDATE >= now()										");
	}
	sql.append("\n 	 	GROUP BY WK.ENDPOINT											");
	sql.append("\n 	 ) RNL ON RNL.ENDPOINT = EMP.EMPCODE								");
	sql.append("\n 	   LEFT OUTER JOIN 	( 												");
	sql.append("\n 	 	SELECT 															");
	sql.append("\n 	   		COUNT(WK.TASKID) COMPLETE_WORKCNT, WK.ENDPOINT				");
	sql.append("\n 	 	FROM BPM_WORKLIST	WK											");
	sql.append("\n 	 		INNER JOIN BPM_PROCINST 	PI ON PI.INSTID = WK.ROOTINSTID AND PI.ISDELETED = 0		");
	sql.append("\n 	 	WHERE WK.STATUS = 'COMPLETED'									");
	sql.append("\n 	 	AND WK.STARTDATE >= '"+fromday+"'								");
	sql.append("\n 	 	AND WK.ENDDATE   <= '"+today+"'									");
	sql.append("\n 	 	GROUP BY WK.ENDPOINT											");
	sql.append("\n 	 ) CPL ON CPL.ENDPOINT = EMP.EMPCODE								");
	sql.append("\n 	   LEFT OUTER JOIN 	( 												");
	sql.append("\n 	 	SELECT 															");
	sql.append("\n 	   		COUNT(WK.TASKID) CANCEL_WORKCNT, WK.ENDPOINT				");
	sql.append("\n 	 	FROM BPM_WORKLIST	WK											");
	sql.append("\n 	 		INNER JOIN BPM_PROCINST 	PI ON PI.INSTID = WK.ROOTINSTID AND PI.ISDELETED = 0		");
	sql.append("\n 	 	WHERE WK.STATUS = 'CANCELLED'									");
	sql.append("\n 	 	AND WK.STARTDATE >= '"+fromday+"'								");
	sql.append("\n 	 	AND WK.ENDDATE   <= '"+today+"'									");
	sql.append("\n 	 	GROUP BY WK.ENDPOINT											");
	sql.append("\n 	 ) CAN ON CAN.ENDPOINT = EMP.EMPCODE								");
	sql.append("\n 	   LEFT OUTER JOIN 	( 												");
	sql.append("\n 	 	SELECT 															");
	sql.append("\n 	   		COUNT(A) LATE_WORKCNT, ENDPOINT								");
	sql.append("\n 	 	FROM (															");
	sql.append("\n 	 	 	SELECT														");
	sql.append("\n 	 	 		WK.ENDPOINT												");
	if("HSQL".equals(dbfactnm.toUpperCase())){
		sql.append("\n 	 	 		,DATEDIFF('DD', STARTDATE, WK.DUEDATE)*0.2 A		");
		sql.append("\n 	 	 		,DATEDIFF('DD', SYSDATE,   WK.DUEDATE) B			");
	}else if("MYSQL".equals(dbfactnm.toUpperCase())){
		sql.append("\n 	 	 		,DATEDIFF(STARTDATE, WK.DUEDATE)*0.2 A				");
		sql.append("\n 	 	 		,DATEDIFF(now(),     WK.DUEDATE) B					");
	}
	sql.append("\n 	 		FROM BPM_WORKLIST	WK										");
	sql.append("\n 	 			INNER JOIN BPM_PROCINST 	PI ON PI.INSTID = WK.ROOTINSTID AND PI.ISDELETED = 0	");
	sql.append("\n 	 		WHERE WK.STATUS IN ('NEW', 'CONFIRMED')						");
	if("HSQL".equals(dbfactnm.toUpperCase()) || "ORACLE".equals(dbfactnm.toUpperCase())){
		sql.append("\n 	 	AND WK.DUEDATE >= SYSDATE									");	
	}else{
		sql.append("\n 	 	AND WK.DUEDATE >= now()										");
	}
	sql.append("\n 	 	)	LTE															");
	sql.append("\n 	 	WHERE LTE.A  >= LTE.B											");
	sql.append("\n 	 	GROUP BY ENDPOINT												");
	sql.append("\n 	 ) LTE ON LTE.ENDPOINT = EMP.EMPCODE								");
	sql.append("\n WHERE EMP.ISDELETED = '0'											");
	sql.append("\n ) TOT																");
	sql.append("\n ORDER BY "+orderby+"													");
	
	
	DataList dl = null;
	QueryCondition condition = new QueryCondition();
	condition.setOnePageCount(100);
%>
<div id="calen" align="center">
	<input type='text' name="fromday" readonly=true id="fromday" value="<%=fromday %>" size="10" class='j_calendar' />
    ~ <input type='text' name="today" readonly=true id="today" value="<%=today %>" size="10" class='j_calendar'/>
    <input type="button" value="검색" onclick="document.attendenceForm.submit()">
	<input type="hidden" name="year"  value="<%=year %>">
	<input type="hidden" name="month" value="<%=month %>">
	<input type="hidden" name="ord" value="<%=ord %>">
	<input type="hidden" name="asc" value="<%=asc %>">
</div>
<table width=100% >
    <tr>
        <td ><table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder" style="border-bottom:1px solid #C5D2E3;">
                <tr class="tabletitle">
	                <th nowrap="nowrap" style="cursor:hand;" class="col-0" align="center" onclick="orderby('PARTNAME', '<%="DESC".equals(asc.trim())?"ASC":"DESC"%>');"> <%=GlobalContext.getMessageForWeb("department", loggedUserLocale)%></th>
                   	<th width="1"><img src="../../images/Common/tabletitleline.gif" width="2" height="27"></th>
                   	<th nowrap="nowrap" class="col-1" align="center"> <%=GlobalContext.getMessageForWeb("name", loggedUserLocale)%></th>
                   	<th width="1"><img src="../../images/Common/tabletitleline.gif" width="2" height="27"></th>
                   	<th nowrap="nowrap" style="cursor:hand;" class="col-2" align="center" onclick="orderby('((LATED_WORKCNT+LATE_WORKCNT)*100/(LATED_WORKCNT+RUNNING_WORKCNT+COMPLETE_WORKCNT+CANCEL_WORKCNT))', '<%="DESC".equals(asc.trim())?"ASC":"DESC"%>');"> <%=GlobalContext.getMessageForWeb("lated_workrate", loggedUserLocale)%></th>
                   	<th width="1"><img src="../../images/Common/tabletitleline.gif" width="2" height="27"></th>
                   	<th nowrap="nowrap" style="cursor:hand;" class="col-3" align="center" onclick="orderby('LATED_WORKCNT', '<%="DESC".equals(asc.trim())?"ASC":"DESC"%>');"> <%=GlobalContext.getMessageForWeb("lated_workcnt", loggedUserLocale)%></th>
                   	<th width="1"><img src="../../images/Common/tabletitleline.gif" width="2" height="27"></th>
                   	<th nowrap="nowrap" style="cursor:hand;" class="col-4" align="center" onclick="orderby('LATE_WORKCNT', '<%="DESC".equals(asc.trim())?"ASC":"DESC"%>');"> <%=GlobalContext.getMessageForWeb("late_workcnt", loggedUserLocale)%></th>
                   	<th width="1"><img src="../../images/Common/tabletitleline.gif" width="2" height="27"></th>
                   	<th nowrap="nowrap" style="cursor:hand;" class="col-5" align="center" onclick="orderby('RUNNING_WORKCNT', '<%="DESC".equals(asc.trim())?"ASC":"DESC"%>');"> <%=GlobalContext.getMessageForWeb("running_work", loggedUserLocale)%></th>
                   	<th width="1"><img src="../../images/Common/tabletitleline.gif" width="2" height="27"></th>
                   	<th nowrap="nowrap" style="cursor:hand;" class="col-6" align="center" onclick="orderby('COMPLETE_WORKCNT', '<%="DESC".equals(asc.trim())?"ASC":"DESC"%>');"> <%=GlobalContext.getMessageForWeb("complete_work", loggedUserLocale)%></th>
                   	<th width="1"><img src="../../images/Common/tabletitleline.gif" width="2" height="27"></th>
                </tr>
                <%
                	boolean isGray = false;
               		java.sql.Connection con = DefaultConnectionFactory.create().getConnection();
               		
               		try {
               			dl = DAOListCursorUtil.executeList(sql.toString(), condition, new ArrayList(), con);
               		} catch (Exception e) {
               			throw e;
               		} finally {
               			if (con != null) {
               				con.close();
               			}
               		}

               		String partname;
               		String empname;
               		String lated_workcnt;
               		String late_workcnt;
               		String running_workcnt;
               		String complete_workcnt;
               		String cancel_workcnt;
               		
               		int totalCnt = 0;
               		Double per = 0.0;
               		
               		if (dl.size() > 0) {
               			for (int i = 0; i < dl.size(); i++) {
               				per = 0.0;
               				DataMap tmpMap 		= (DataMap) dl.get(i);
               				partname 			= tmpMap.getString("PARTNAME"			, "-");
               				empname 			= tmpMap.getString("EMPNAME"			, "-");
               				lated_workcnt 		= tmpMap.getString("LATED_WORKCNT"		, "0");
               				late_workcnt 		= tmpMap.getString("LATE_WORKCNT"		, "0");
               				running_workcnt 	= tmpMap.getString("RUNNING_WORKCNT"	, "0");
               				complete_workcnt 	= tmpMap.getString("COMPLETE_WORKCNT"	, "0");
               				cancel_workcnt 		= tmpMap.getString("CANCEL_WORKCNT"		, "0");
               				
               				totalCnt = Integer.parseInt(lated_workcnt)+Integer.parseInt(running_workcnt)+Integer.parseInt(complete_workcnt)+Integer.parseInt(cancel_workcnt);
               				if(totalCnt>0){
               					per = Double.parseDouble(lated_workcnt) + Double.parseDouble(late_workcnt);
                           		per = per*100/totalCnt;
               				}
               				running_workcnt = String.valueOf(Integer.parseInt(running_workcnt) - Integer.parseInt(late_workcnt));
                       		
                       			
               				String bold = ("NEW".equals(tmpMap.getString("STATUS", "-")) ? "<b>" : "");
               				String bgcolor = (
               						isGray
               						? "class=\"portlet-section-body\""
               								+ " onmouseover=\"this.className = 'portlet-section-body-hover';\""
               								+ " onmouseout=\"this.className = 'portlet-section-body';\""
               						: "class=\"portlet-section-alternate\""
               								+ " onmouseover=\"this.className = 'portlet-section-alternate-hover';\""
               								+ " onmouseout=\"this.className = 'portlet-section-alternate';\""
               				);
               				isGray = !isGray;
                %>
                <tr <%=bgcolor%>>
                    <td colspan="2" align="center"><b><%=partname%></b></td>
                    <td colspan="2" align="center"><b><%=empname%></b></td>
                    <td colspan="2" align="center"><span id="progressbar_<%=i %>" style="margin:0 10px; height:18px; width:100px"></span><b><%=per.intValue() %>%</b></td>
                    <style>
					.ui-progressbar-value { background-image: url(images/pbar-ani.gif); }
					</style>
                    <script type="text/javascript">
                    $(function() {
                		$( "#progressbar_<%=i %>" ).progressbar({
                			value: <%=per.intValue()%>
                		});
                	});
					</script>
					<td colspan="2" align="center"><b><%=lated_workcnt%>건</b></td>
                    <td colspan="2" align="center"><b><%=late_workcnt%>건</b></td>
                    <td colspan="2" align="center"><b><%=running_workcnt%>건</b></td>
                    <td colspan="2" align="center"><b><%=complete_workcnt%>건</b></td>
                </tr>
            	<%
            		} // for( int j=0; j<dl.size(); j++ ){
            	} // if(dl.size() > 0) {
            %>
            </table>
    	</td>
    </tr>
</table>

</form>
</body>
</html>