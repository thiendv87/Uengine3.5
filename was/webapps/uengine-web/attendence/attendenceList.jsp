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
<form name="attendenceForm" action="attendenceList.jsp" method="POST">
<%
	java.util.Date     d = new java.util.Date();
	d.setMonth(d.getMonth()-1);
	SimpleDateFormat df1 = new SimpleDateFormat("yyyy"); 
	SimpleDateFormat df2 = new SimpleDateFormat("MM");
	
	String year  		 = request.getParameter("year") ==null?df1.format(d):request.getParameter("year");
	String month 		 = request.getParameter("month")==null?df2.format(d):request.getParameter("month");
	String ord 			 = request.getParameter("ord")==null?"((BR.BIZDAY-BR.LATEDDAY)*100/BR.BIZDAY) ":request.getParameter("ord") + " ";
	String asc 			 = request.getParameter("asc")==null?" DESC":" " + request.getParameter("asc");
	String orderby       = ord+asc;
	
	DecimalFormat mm = new DecimalFormat("00");
	month = mm.format(Double.parseDouble(month));
	
	StringBuffer sql = new StringBuffer();
	sql.append("   SELECT				");
	sql.append("\n 	 DEPT.PARTNAME		");
	sql.append("\n 	,EMP.EMPNAME		");
	sql.append("\n 	,'' AS RATE 		");
	sql.append("\n 	,BR.BIZDAY			");
	sql.append("\n 	,BR.WORKEDDAY		");
	sql.append("\n 	,BR.LATEDDAY		");
	sql.append("\n FROM EMPTABLE EMP	");
	sql.append("\n	LEFT OUTER JOIN BIZRATE BR     ON EMP.EMPCODE = BR.EMPCODE 		");
	sql.append("\n  	AND BR.YEARMM = '"+year+month+"'");
	sql.append("\n	LEFT OUTER JOIN PARTTABLE DEPT ON DEPT.PARTCODE = EMP.PARTCODE	");
	sql.append("\n WHERE EMP.ISDELETED = '0'");
	sql.append("\n ORDER BY "+orderby+"");
	
	DataList dl = null;
	QueryCondition condition = new QueryCondition();
	condition.setOnePageCount(100);
%>
<div id="calen" align="center">
	<img onclick="cSubmit(-1)" alt="" src="../images/Icon/prevmonth.gif"><%=year %>. <%=month %><img onclick="cSubmit(1)" alt="" src="../images/Icon/nextmonth.gif">
	<input type="hidden" name="year"  value="<%=year %>">
	<input type="hidden" name="month" value="<%=month %>">
	<input type="hidden" name="ord" value="<%=ord %>">
	<input type="hidden" name="asc" value="<%=asc %>">
</div>
<table width=100% >
    <tr>
        <td>
        	<table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder" style="border-bottom:1px solid #C5D2E3;">
                <tr class="tabletitle">
	                <th nowrap="nowrap" style="cursor:hand;" class="col-0" align="center" onclick="orderby('PARTNAME', '<%="DESC".equals(asc.trim())?"ASC":"DESC"%>');"> <%=GlobalContext.getMessageForWeb("department", loggedUserLocale)%></th>
                   	<th width="1"><img src="../../images/Common/tabletitleline.gif" width="2" height="27"></th>
                   	<th nowrap="nowrap" class="col-1" align="center"> <%=GlobalContext.getMessageForWeb("name", loggedUserLocale)%></th>
                   	<th width="1"><img src="../../images/Common/tabletitleline.gif" width="2" height="27"></th>
                   	<th nowrap="nowrap" style="cursor:hand;" class="col-2" align="center" onclick="orderby('((BR.BIZDAY-BR.LATEDDAY)*100/BR.BIZDAY)', '<%="DESC".equals(asc.trim())?"ASC":"DESC"%>');"> <%=GlobalContext.getMessageForWeb("attendence_rate", loggedUserLocale)%></th>
                   	<th width="1"><img src="../../images/Common/tabletitleline.gif" width="2" height="27"></th>
                   	<th nowrap="nowrap" style="cursor:hand;" class="col-3" align="center" onclick="orderby('BIZDAY', '<%="DESC".equals(asc.trim())?"ASC":"DESC"%>');"> <%=GlobalContext.getMessageForWeb("attendence_bizday", loggedUserLocale)%></th>
                   	<th width="1"><img src="../../images/Common/tabletitleline.gif" width="2" height="27"></th>
                   	<th nowrap="nowrap" style="cursor:hand;" class="col-4" align="center" onclick="orderby('WORKEDDAY', '<%="DESC".equals(asc.trim())?"ASC":"DESC"%>');"> <%=GlobalContext.getMessageForWeb("attendence_day", loggedUserLocale)%></th>
                   	<th width="1"><img src="../../images/Common/tabletitleline.gif" width="2" height="27"></th>
                   	<th nowrap="nowrap" style="cursor:hand;" class="col-5" align="center" onclick="orderby('LATEDDAY', '<%="DESC".equals(asc.trim())?"ASC":"DESC"%>');"> <%=GlobalContext.getMessageForWeb("attendence_lateday", loggedUserLocale)%></th>
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
               		String bizday;
               		String workedday;
               		String latedday;
               		Double per = 0.0;
               		
               		if (dl.size() > 0) {
               			for (int i = 0; i < dl.size(); i++) {
               				DataMap tmpMap = (DataMap) dl.get(i);
               				partname 	= tmpMap.getString("PARTNAME"	, "-");
               				empname 	= tmpMap.getString("EMPNAME"	, "-");
                       		bizday 		= tmpMap.getString("BIZDAY"		, "0");
                       		workedday 	= tmpMap.getString("WORKEDDAY"	, "0");
                       		latedday 	= tmpMap.getString("LATEDDAY"	, "0");
                       		
                       		per = Double.parseDouble(bizday) - Double.parseDouble(latedday);
                       		per = per*100/Double.parseDouble(bizday);
                       			
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
                    <td colspan="2" align="center">
                    	<span id="progressbar_<%=i %>" style="margin:0 10px; height:18px; width:100px"></span><b><%=per.intValue() %>%</b>
                    </td>
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
                    <td colspan="2" align="center"><b><%=bizday%>일</b></td>
                    <td colspan="2" align="center"><b><%=workedday%>일</b></td>
                    <td colspan="2" align="center"><b><%=latedday%>일</b></td>
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