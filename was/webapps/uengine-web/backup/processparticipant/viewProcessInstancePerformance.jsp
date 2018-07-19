<%@ page import="org.uengine.util.*,org.uengine.kernel.GlobalContext,java.util.*,java.lang.*,org.uengine.kernel.*"%>

<%
	String chartColor[] = {
		"AFD8F8",
		"F6BD0F",
		"8BBA00",
		"FF8E46",
		"008E8E",
		"D64646",
		"8E468E",
		"588526",
		"B3AA00",
		"008ED6",
		"9D080D",
		"A186BE"
	};
	long max = 0l;
	
	int colorCnt = 0;
	final ProcessInstance piTemp = pm.getProcessInstance(instanceId);
	Vector baseActivities = new Vector();
	final Vector activities = new Vector();
	final Vector roleList = new Vector();
	final HashMap rolesElapsedTime = new HashMap();
	final HashMap deadLineHt = new HashMap();

	baseActivities = piTemp.getActivitiesDeeply(Activity.STATUS_COMPLETED + Activity.STATUS_RUNNING);
	
	for (int i = 0; i < baseActivities.size(); i++) {

		ActivityInstanceContext aic = (ActivityInstanceContext) baseActivities.get(i);
		Activity tempActivity = aic.getActivity();
		ProcessInstance tempInstance = aic.getInstance();

		if (tempActivity instanceof HumanActivity) {
			HumanActivity humanActivity = (HumanActivity) tempActivity;

			Vector unitActivity = new Vector();

			String activityName = humanActivity.getName().getText();
			long elapsedTime = humanActivity.getElapsedTimeAsLong(tempInstance) / 60000;
			String resourceName = humanActivity.getRole().getName();

			unitActivity.add(activityName);
			unitActivity.add(elapsedTime);

			activities.add(unitActivity);

			if (!roleList.contains(resourceName)) {
				roleList.add(resourceName);
			}

			if (!rolesElapsedTime.containsKey(resourceName)) {
				rolesElapsedTime.put(resourceName, elapsedTime);
			} else {
				long tempValue = ((Long) rolesElapsedTime.get(resourceName)).longValue() + elapsedTime;
				rolesElapsedTime.put(resourceName, tempValue);
			}

			int DEADLNHT = 1;
			{
				java.util.Calendar endTime;
				String activityStatus = humanActivity.getStatus(tempInstance);
				if(activityStatus.equals(Activity.STATUS_RUNNING)){
					endTime = Calendar.getInstance();
				}else if(activityStatus.equals(Activity.STATUS_TIMEOUT)){
					endTime = Calendar.getInstance();
				}else{
					endTime = humanActivity.getEndTime(tempInstance);	
				}
				java.util.Calendar dueDate = humanActivity.getDueDate(tempInstance);
				if (endTime.compareTo(dueDate) <= 0) {
					if (!deadLineHt.containsKey("completeInDueDate")) {
						deadLineHt.put("completeInDueDate", DEADLNHT);
					} else {
						int deadln = ((Integer) deadLineHt.get("completeInDueDate")).intValue();
						deadln++;
						deadLineHt.put("completeInDueDate", deadln);
					}
				}
			}
		}
	}
	pm.remove();
	
	String performanceByWorkItemValue = new String();
	Long[] rolePerformanceValue = new Long[roleList.size()];
	String deadlnXml = new String();

	if (activities.size() != 0) {
		// for performance by workitem chart
		String yAxisValue = "";
		boolean isExistValue = false;
		for (int i = 0; i < activities.size(); i++) {
			long compareLongValue = ((Long) ((Vector) activities.get(i)).get(1)).longValue();
			if (compareLongValue > 0) {
				isExistValue = true;
			}
		}

		if (isExistValue == false) {
			yAxisValue = "yAxisMaxValue=\'1\' ";
		}

		performanceByWorkItemValue = "<graph caption=\'"
				+ GlobalContext.getLocalizedMessageForWeb("processing_time_by_workitem",loggedUserLocale,"Processing Time By Workitem")
				+ "\'"
				+ " xAxisName=\'"
				+ GlobalContext.getLocalizedMessageForWeb("completed_work", loggedUserLocale,"Completed Work")
				+ "\'"
				+ " yAxisName=\'Processing Time (min)\' "
				+ yAxisValue
				+ "yAxisMinValue=\'0\'"
				+ " bgAlpha=\'100\' bgColor=\'ffffff\' canvasBgAlha=\'100\' showNames=\'1\' decimalPrecision=\'0\' formatNumberScale=\'0\' baseFontSize=\'15\'>";

		for (int activityCnt = 0; activityCnt < activities.size(); activityCnt++) {
			if (colorCnt >= (chartColor.length - 1)) {
				colorCnt = 0;
			} else {
				colorCnt++;
			}
			Vector data = (Vector) activities.get(activityCnt);
			performanceByWorkItemValue += "<set name=\'" + data.get(0) + "\' value=\'" + data.get(1) + "\' color=\'" + chartColor[colorCnt] + "\'/>";
		}
		performanceByWorkItemValue += "</graph>";

		//for role performance	
		for (int roleCnt = 0; roleCnt < roleList.size(); roleCnt++) {
			String roleName = (String) roleList.get(roleCnt);
			long tempValue = ((Long) rolesElapsedTime.get(roleName)).longValue();
			long performanceValue;
			if (tempValue != 0) {
				performanceValue = 60 * 24 / tempValue;
			} else {
				performanceValue = tempValue;
			}
			if (max < performanceValue)
				max = performanceValue;
			
			rolePerformanceValue[roleCnt] = performanceValue;
		}

		//for deadlnht
		int deadLineHitCnt = 1;
		if (deadLineHt.get("completeInDueDate") != null) {
			deadLineHitCnt = ((Integer) deadLineHt.get("completeInDueDate")).intValue();
		}
		String delayCnt = "" + (activities.size() - deadLineHitCnt);
		deadlnXml = "<graph caption=\'"
				+ GlobalContext.getLocalizedMessageForWeb("deadlinehit_rate", loggedUserLocale,"Deadline Hit Rate")
				+ "\'"
				+ " bgAlpha=\'100\' bgColor=\'ffffff\' canvasBgAlpha=\'100\'showNames=\'1\' decimalPrecision=\'0\' formatNumberScale=\'0\' baseFontSize=\'15\' showPercentageInLabel=\'1\'>";

		deadlnXml += "<set name=\'"
				+ GlobalContext.getLocalizedMessageForWeb("complete_in_duedate", loggedUserLocale,"Complete in duedate") + "\' value=\'"
				+ deadLineHitCnt + "\' color=\'" + chartColor[1]
				+ "\' />";
		deadlnXml += "<set name=\'"
				+ GlobalContext.getLocalizedMessageForWeb("delayed_workitem", loggedUserLocale,"Delayed Complete") + "\' value=\'" + delayCnt
				+ "\' color=\'" + chartColor[5] + "\' />";
		deadlnXml += "</graph>";
	}else{
		
		performanceByWorkItemValue = performanceByWorkItemValue = "<graph caption=\'"
			+ GlobalContext.getLocalizedMessageForWeb("processing_time_by_workitem",loggedUserLocale,"Processing Time By Workitem")	+ "\'"
			+ " xAxisName=\'"
			+ GlobalContext.getLocalizedMessageForWeb("completed_work", loggedUserLocale,"Completed Work") + "\'"
			+ " yAxisName=\'Processing Time (min)\' yAxisMaxValue=\'1\' yAxisMinValue=\'0\'"
			+ " bgAlpha=\'100\' bgColor=\'ffffff\' canvasBgAlha=\'100\' showNames=\'1\' decimalPrecision=\'0\' formatNumberScale=\'0\' baseFontSize=\'15\'>"
			+ "<set name=\'" + " " + "\' value=\'" + "0" + "\' /></graph>";

		deadlnXml = "<graph caption=\'"
			+ GlobalContext.getLocalizedMessageForWeb("deadlinehit_rate", loggedUserLocale,"Deadline Hit Rate") + " (" 
			+ GlobalContext.getLocalizedMessageForWeb("no_completed_workItem", loggedUserLocale,"No Completed Workitem") + ")"
			+ "\'"
			+ " bgAlpha=\'100\' bgColor=\'ffffff\' canvasBgAlpha=\'100\' showNames=\'1\' showValues=\'0\' showhovercap=\'0\' baseFontSize=\'15\' animation=\'0\'>"
			+ "<set name=\'" + " " + "\' value=\'"
			+ "1" + "\' color=\'" + chartColor[1] + "\' /></graph>";
		
			for (int roleCnt = 0; roleCnt < roleList.size(); roleCnt++) {
				String roleName = (String) roleList.get(roleCnt);
				long performanceValue = 0l;
				rolePerformanceValue[roleCnt] = performanceValue;
			}
		
	}
	
%>
<table width=100% cellpadding"5" cellspacing="5">
	<tr>
		<td colspan=2 align=center>
		<fieldset class="block-labels">
		<legend><%=GlobalContext.getLocalizedMessageForWeb(
							"analyzer_ganttchart", loggedUserLocale,
							"Gantt Chat")%></legend>
		<%@include file="../dashboard/instanceGanttChart.jsp"%>
		</fieldset>
		</td>
	</tr>
	<tr>
		<td width=50%>
		<center>
		<fieldset class="block-labels"><legend><%=GlobalContext.getLocalizedMessageForWeb(
							"processing_time_by_workitem", loggedUserLocale,
							"Processing Time By Workitem")%></legend>
		<table>
			<tr>
				<td>
				<div align="center"><OBJECT
					classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
					codebase=http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0
					" width="600" height="250">
					<param name="movie" value="../images/chart/Column3D.swf" />
					<param name="FlashVars"
						value="&dataXML=<%=performanceByWorkItemValue %>&chartWidth=600&chartHeight=250">
					<param name="quality" value="high" />
					<embed src="../images/chart/Column3D.swf" width="600" height="250"
						flashVars="&dataXML=<%=performanceByWorkItemValue %>&chartWidth=600&chartHeight=250"
						quality="high" type="application/x-shockwave-flash"
						pluginspage="http://www.macromedia.com/go/getflashplayer" /></object></div>
				</td>
			</tr>
		</table>
		</fieldset>
		</td>
		<td width=50%>
		<center>
		<fieldset class="block-labels"><legend><%=GlobalContext.getMessageForWeb("DeadlineHit Rate", loggedUserLocale)%></legend>
		<table>
			<tr>
				<td>
				<div align="center"><OBJECT
					classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
					codebase=http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0
					" width="400" height="250">
					<param name="movie" value="../images/chart/Doughnut2D.swf" />
					<param name="FlashVars"
						value="&dataXML=<%=deadlnXml %>&chartWidth=400&chartHeight=250">
					<param name="quality" value="high" />
					<embed src="../images/chart/Doughnut2D.swf" width="400"
						height="250"
						flashVars="&dataXML=<%=deadlnXml %>&chartWidth=400&chartHeight=250"
						quality="high" type="application/x-shockwave-flash"
						pluginspage="http://www.macromedia.com/go/getflashplayer" /></object></div>
				</td>
			</tr>
		</table>
		</fieldset>
		</td>
	</tr>
	<tr>
		<td width=100% colspan=2>
		<fieldset class="block-labels"><legend><%=GlobalContext.getMessageForWeb("Performance By Role", loggedUserLocale)%></legend>
<%if(roleList.size() != 0){ %>
		<table>
			<tr>
				<%
					for (int chartCnt = 0; chartCnt < rolePerformanceValue.length; chartCnt++) {
				%>
				<td>
				<div align="left"><OBJECT
					classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
					codebase=http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0
					" width="200" height="150">
					<param name="movie" value="../images/chart/guage_chart.swf" />
					<param name="FlashVars" value="&min=0&max=<%=max %>&inputValue=<%=((Long)rolePerformanceValue[chartCnt]).longValue() %>&chartName=<%=roleList.get(chartCnt) %>&bgColor=ffffff">
					<param name="quality" value="high" />
					<embed src="../images/chart/guage_chart.swf" width="200"
						height="150" flashVars="&min=0&max=<%=max %>&inputValue=<%=((Long)rolePerformanceValue[chartCnt]).longValue() %>&chartName=<%=roleList.get(chartCnt) %>&bgColor=ffffff"
						quality="high" type="application/x-shockwave-flash"
						pluginspage="http://www.macromedia.com/go/getflashplayer" /></object></div>
				</td>
				<%
					}
				%>
			</tr>
			<tr>
			<td align="left">
			<b>* <%=GlobalContext.getLocalizedMessageForWeb("unit_item_day",
							loggedUserLocale, "Unit : Item/day")%></b>
			</td>
			</tr>
		</table>
<%}else{%>
		<font size=3><%=GlobalContext.getLocalizedMessageForWeb("no_completed_workItem", loggedUserLocale,"No Completed Workitem") %></font>
<%} %>
		</fieldset>
		</td>
	</tr>
</table>
</center>