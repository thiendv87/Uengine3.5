<%@page import="java.sql.*"%>
<%@page import="javax.naming.*"%>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory"%>

<br>
<table  width="100%" border="0" cellspacing="0" cellpadding="0">
<%
	if(!initiate){
%>
	<tr>
		<td valign=top colspan=3>
			<fieldset class="block-labels">
				<legend><%=GlobalContext.getLocalizedMessageForWeb("ganttchat", loggedUserLocale, "Gantt Chart") %></legend>
				<%@include file="../../dashboard/instanceGanttChart.jsp"%>
			</fieldset>
		</td>
	</tr>
<%
	}
%>
	<tr>
		<td width=50% valign=top>
<fieldset class="block-labels">
<legend><%=GlobalContext.getLocalizedMessageForWeb("completion_time", loggedUserLocale, "Deadline") %></legend>
<%
	Calendar dueDate = currentTempActivity.getDueDate(piRemote);
	long dueDateTimeInMillis = dueDate.getTimeInMillis();
	java.text.DateFormat dfDueDate = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:SS" );
	String duedateString =	dfDueDate.format( dueDate.getTime() );
	if(duedateString.length() > 19){
		duedateString = duedateString.substring(0,19);
	}
	
	Calendar nowDate = GlobalContext.getNow(piRemote.getProcessTransactionContext());
	long nowDateTimeInMillis = nowDate.getTimeInMillis();
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<center><font size=5><%=duedateString%></font></center><br>
		</td>
	</tr>
	<tr>
		<td>
			<fieldset class="block-labels">
<%
	if(dueDateTimeInMillis > nowDateTimeInMillis){
%>
				<legend><%=GlobalContext.getLocalizedMessageForWeb("remain_time", loggedUserLocale, "Time before deadline") %></legend>
<%
	}else{
%>
				<legend><%=GlobalContext.getLocalizedMessageForWeb("delay_time", loggedUserLocale, "Delay Time") %></legend>	
<%
	}
%>
			    <center><div id=remainTime></div></center>
			</fieldset>
		</td>
	</tr>
</table>
			</fieldset>
		</td >
		<td >&nbsp; </td > 
		<td width=50% valign=top>
<%
	if(!initiate){
%>
<fieldset class="block-labels">
<legend><%=GlobalContext.getLocalizedMessageForWeb("requestor", loggedUserLocale, "Requestor") %></legend>
<%
	if(completedActivity.size()>0){
		HumanActivity humanActivity = (HumanActivity)completedActivity.get(completedActivity.size()-1);
		RoleMapping rm = humanActivity.getRole().getMapping(piRemote);
		if(!UEngineUtil.isNotEmpty(rm.getUserPortrait())) rm.fill(piRemote);
%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width=90 align=center><img border="0" width="70" src="<%=rm.getUserPortrait() %>"  />
					<br><%=rm.getResourceName()%>
				</td>

				<td >
						<%=GlobalContext.getLocalizedMessageForWeb("Title", loggedUserLocale, "Workitem") %>
					   : <%=humanActivity.getName()%>(<%=humanActivity.getTracingTag()%>)<br>
<%
	Calendar endTime = (Calendar)piRemote.getProperty(humanActivity.getTracingTag(), Activity.VAR_END_TIME);
	java.text.DateFormat dfEndTime = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:SS" );
%>
						<%=GlobalContext.getLocalizedMessageForWeb("end_date", loggedUserLocale, "Finished Time") %>
						: <%=dfEndTime.format( endTime.getTime()).substring(0,19)%><br>
						<%=GlobalContext.getLocalizedMessageForWeb("description", loggedUserLocale, "Description") %>
						: <%=humanActivity.getDescription()%>
				</td>
			</tr>	
		</table>		
<%
	
	}
	if(completedActivity.size()==0){
%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width= 90 align=center><img border="0" width="65" src="<%= GlobalContext.WEB_CONTEXT_ROOT+"/images/portrait/unknown_user.gif" %>"  />
					<br>unknown
				</td>

				<td >
						<%=GlobalContext.getLocalizedMessageForWeb("Title", loggedUserLocale, "Workitem") %>
					   : <br>
						<%=GlobalContext.getLocalizedMessageForWeb("end_date", loggedUserLocale, "Finished Time") %>
						: <br>
						<%=GlobalContext.getLocalizedMessageForWeb("description", loggedUserLocale, "Description") %>
						: 
				</td>

			</tr>	
		</table>	
<%
	}
%>
</fieldset>
		</td>
	</tr>
	<tr>
		<td width=50% valign=top><center>
<%
	Connection 	    conn	= null;
	Statement 		stmt 	= null;
	ResultSet 		rs 		= null;
	String 	sqlString 	= "";
	String max="";
	String min="";
	String avg="";
	String defid = piRemote.getProcessDefinition().getBelongingDefinitionId();
	try{
		conn = piRemote.getProcessTransactionContext().getConnection();
		stmt = conn.createStatement();
				
		sqlString="select MAX(prsngtime) as maxValue from bpm_prfm_fact_2006 where def_id="+defid +" and act_id="+tracingTag;										
		rs = stmt.executeQuery(sqlString);
		while(rs.next()){
			max=""+rs.getObject("maxValue");
			if(UEngineUtil.isNotEmpty(max)|| "null".equals(max)) max="0";
			else 	max=""+(60/Integer.parseInt(max))*24;
		}
		rs.close();
		
		sqlString="select MIN(prsngtime) as minValue from bpm_prfm_fact_2006 where def_id="+defid +" and act_id="+tracingTag;										
		rs = stmt.executeQuery(sqlString);
		while(rs.next()){
			min=""+ rs.getObject("minValue");
			if(UEngineUtil.isNotEmpty(min)|| "null".equals(min)) min="0";
			else 	min=""+(60/Integer.parseInt(min))*24;
		}
		rs.close();
		
		sqlString="select AVG(prsngtime) as avgValue from bpm_prfm_fact_2006 where def_id="+defid +" and act_id="+tracingTag+" and rsrc_id='"+loggedUserId + "'";										
		rs = stmt.executeQuery(sqlString);
		while(rs.next()){
			avg=""+ rs.getObject("avgValue");
			if(UEngineUtil.isNotEmpty(avg)|| "null".equals(avg)) avg="0";
			else 	avg=""+(60/Integer.parseInt(avg))*24;
		}
		rs.close();		
		
	}finally{
		if ( stmt != null ) try { stmt.close(); } catch (Exception e) {}
	}	
	
%>
<fieldset class="block-labels">
<legend><%=GlobalContext.getLocalizedMessageForWeb("performance", loggedUserLocale, "Performance") %></legend>
<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" name="df" width="200" height="130" id="df">
          <param name="movie" value="../../images/chart/guage_chart.swf?min=<%=max%>&max=<%=min%>&inputValue=<%=avg%>&chartName=Performance&bgColor=ffffff">
          <param name="quality" value="high">
          <embed src="../../images/chart/guage_chart.swf?min=50&max=180&inputValue=100" width="200" height="100" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" name="df">
          </embed>
</object><br></center>
*<%=GlobalContext.getLocalizedMessageForWeb("unit_item_day", loggedUserLocale, "unit : WorkItem/day") %> 
</fieldset>
		</td>
		<td >&nbsp;</td > 
		<td width=50% valign=top>
<fieldset class="block-labels">
<legend><%=GlobalContext.getLocalizedMessageForWeb("initiator", loggedUserLocale, "Initiator") %></legend>
<%
	if(completedActivity.size()>0){
		HumanActivity humanActivity = (HumanActivity)completedActivity.get(0);
		RoleMapping rm = humanActivity.getRole().getMapping(piRemote);
		if(!UEngineUtil.isNotEmpty(rm.getUserPortrait())) rm.fill(piRemote);
%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width=90 align=center><img border="0" width="70" src="<%=rm.getUserPortrait() %>"  />
					<br><%=rm.getResourceName()%>
				</td>

				<td >
						<%=GlobalContext.getLocalizedMessageForWeb("Title", loggedUserLocale, "Workitem") %>
					   : <%=humanActivity.getName()%>(<%=humanActivity.getTracingTag()%>)<br>
<%
	Calendar endTime = (Calendar)piRemote.getProperty(humanActivity.getTracingTag(), Activity.VAR_END_TIME);
	java.text.DateFormat dfEndTime = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:SS" );
%>
						<%=GlobalContext.getLocalizedMessageForWeb("end_date", loggedUserLocale, "Finished Time") %>
						: <%=dfEndTime.format( endTime.getTime()).substring(0,19)%><br>
						<%=GlobalContext.getLocalizedMessageForWeb("description", loggedUserLocale, "Description") %>
						: <%=humanActivity.getDescription()%>
				</td>
			</tr>	
		</table>		
<%
	
	}
	if(completedActivity.size()==0){
%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width= 90 align=center><img border="0" width="65" src="<%= GlobalContext.WEB_CONTEXT_ROOT+"/images/portrait/unknown_user.gif" %>"  />
					<br>unknown
				</td>

				<td >
						<%=GlobalContext.getLocalizedMessageForWeb("Title", loggedUserLocale, "Workitem") %>
					   : <br>
						<%=GlobalContext.getLocalizedMessageForWeb("end_date", loggedUserLocale, "Finished Time") %>
						: <br>
						<%=GlobalContext.getLocalizedMessageForWeb("description", loggedUserLocale, "Description") %>
						: 
				</td>

			</tr>	
		</table>	
<%
	}
%>
</fieldset>
		</td>
<%
	}else{
%>
		<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td align=center><br><br>
					<a href="javascript:changeDisplay('showInputForm;showActions','showFlowChart;showRelatedKnowledges')">
					<img src="../../processmanager/images/run.gif" align=absmiddle border=0> 
					<font size=2><%=GlobalContext.getLocalizedMessageForWeb("go_to_do", loggedUserLocale, "Go to workitem ...") %>
					</a>
				</td>
			</tr>
		</table>
	</td > 

<%
	}
%>
	</tr>
</table>


<script>
function setRemainTimer(addTimes){
    var remainTimeDiv= document.getElementById('remainTime');

	var nowDate = new Date();
	
	var remainTotal=<%=dueDateTimeInMillis%> - (nowDate.getTime()+addTimes);
	var remainDay = ""+remainTotal/(1000*60*60*24);
	remainDay = remainDay.split('.')[0];
	remainDay = remainDay.replace('-','');
	
	var remainHour = ""+(remainTotal%(1000*60*60*24))/(1000*60*60);
	remainHour = remainHour.split('.')[0];
	remainHour = remainHour.replace('-','');
		
	var remainMinute = ""+((remainTotal%(1000*60*60*24))%(1000*60*60))/(1000*60);
	remainMinute = remainMinute.split('.')[0];
	remainMinute = remainMinute.replace('-','');
		
	var remainSecond = ""+(((remainTotal%(1000*60*60*24))%(1000*60*60))%(1000*60))/(1000);		
	remainSecond = remainSecond.split('.')[0];
	var fontString = "";
	if(remainSecond.indexOf('-')>-1){
		fontString = "<font color=red>";
	}
	remainSecond = remainSecond.replace('-','');
	
	var remainString = remainDay+"<%=GlobalContext.getLocalizedMessageForWeb("day", loggedUserLocale, "Day") %> ";
	remainString +=remainHour+"<%=GlobalContext.getLocalizedMessageForWeb("hour", loggedUserLocale, "Hour") %> ";
	remainString +=remainMinute+"<%=GlobalContext.getLocalizedMessageForWeb("minute", loggedUserLocale, "Minute") %> ";
	remainString +=remainSecond+"<%=GlobalContext.getLocalizedMessageForWeb("seconds", loggedUserLocale, "Second") %>";
	
    remainTimeDiv.innerHTML=fontString+remainString;
    window.setTimeout("setRemainTimer("+addTimes+")",1000);
}


var request = false;
</script>

<script>
var nowDateTemp = new Date();
setRemainTimer(<%=nowDateTimeInMillis%>-nowDateTemp.getTime());

</script>
