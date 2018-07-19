<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<%@include file="../common/styleHeader.jsp"%>

<%@page import="org.uengine.util.dao.*"%>
<%@page import="org.uengine.persistence.dao.*"%>
<%@page import="org.uengine.webservices.worklist.*"%>
<%@page import="org.uengine.ui.list.datamodel.DataMap"%>
<%@page import="org.uengine.ui.list.datamodel.DataList"%>
<%@page import="org.uengine.ui.list.datamodel.QueryCondition"%>
<%@page import="org.uengine.ui.list.util.HttpUtils"%>
<%@page import="org.uengine.kernel.viewer.gantt.GanttChartUtil" %>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<%@ taglib uri="http://www.uengine.org/taglibs/bpm" prefix="bpm" %>

<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<%@page import="com.defaultcompany.web.strategy.StrategyService"%><html>
<head>
<title></title>
<LINK href="../style/uengine.css" type=text/css rel=stylesheet>
<%
	//selected strategyid
	int strategyId = ServletRequestUtils.getIntParameter(request, "strategyId", -1);

	/*
	* option of 'show strategy instance only'
	* isOnlyStrategyInstance == 'on' is checked and '' is unchecked.
	* Filtering definitions's alias are 'deleteStrategy' and 'addStrategy'  
	*/
	String isOnlyStrategyInstance = ServletRequestUtils.getStringParameter(request, "isOnlyStrategyInstance", "");

//	List<Integer> instanceIds = new ArrayList<Integer>();
	List<Integer> strategyIds = new ArrayList<Integer>();

	StrategyService strategyService = new StrategyService();
/*	for (Integer integer : strategyService.getStrategyIdListById(strategyId)) {
		instanceIds.addAll(strategyService.getInstanceIdListById(integer.intValue()));
	}
*/

	strategyIds =  strategyService.getStrategyIdListById(strategyId);
	strategyIds.add(strategyId); //add itself again

//	System.out.println("strategyIds"+strategyIds);


	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	String pd = reqMap.getString("processDefinition", "");
	String orderby = reqMap.getString("orderby", "instance");
	String endpoint = reqMap.getString("endpoint", "");
	
	int intPageCnt = 10;
	int nPagesetSize = 10;
	int currentPage = reqMap.getInt("CURRENTPAGE", 1);
	int totalCount = 0;
	
	int s_mondif = -1;
    try {
        s_mondif = Integer.parseInt(request.getParameter("mondif"));
    } catch(Exception e) {}
    
	Properties statusColors = new Properties();{
		statusColors.put("NEW", "GREEN");
		statusColors.put("CONFIRMED", "GREEN");
		statusColors.put("COMPLETED", "GRAY");
		statusColors.put("CANCELLED", "YELLOW");
		statusColors.put("RESERVED", "BLUE");
	}


	Calendar now; int firstDayOfMonth =0; int lastDateOfMonth=0; Calendar firstDate; Calendar lastDate; int monthOfNow;{
		now = Calendar.getInstance();

		now.add(Calendar.MONTH, s_mondif+1); 

		//if(s_mondif > -1)
			//now.set(Calendar.MONTH, s_mondif-1); 

		firstDate = (Calendar)now.clone();	
		firstDate.set(Calendar.DATE, 1);
		firstDayOfMonth = firstDate.get(Calendar.DAY_OF_WEEK) - 2;

		lastDate = (Calendar)now.clone();
		lastDate.set(Calendar.DATE, 27);

		monthOfNow = now.get(Calendar.MONTH);
		while(lastDate.get(Calendar.MONTH)==monthOfNow){
			lastDateOfMonth = lastDate.get(Calendar.DATE);
			lastDate.setTimeInMillis(lastDate.getTimeInMillis() + 86400000L);
		}
		lastDate.setTimeInMillis(lastDate.getTimeInMillis() - 86400000L);
	}

%>
isOnlyStrategyInstance : <%=isOnlyStrategyInstance %>

<script>
	function searchGo( i ) {
		document.refreshForm.mondif.value='<%=(s_mondif)%>'*1 + i;
		document.refreshForm.CURRENTPAGE.value=1;
		document.refreshForm.submit();
	}	

	function selectProcess() {
		var url = "../processparticipant/commonfilter/selectProcessDefinition_frame.jsp";
		var StrOption ;
		StrOption  = "dialogWidth:500px;dialogHeight:300px;";
		StrOption += "center:on;scroll:no;status:off;resizable:no";
		var arrResult = new Array(2);
		arrResult = showModalDialog (url , window, StrOption);
		//arrResult = window.open (url , "", StrOption);
		if( arrResult != null && arrResult[0] != null ){
			var processDefName = document.getElementsByName("processDefName")[0];
			var processDefValue = document.getElementsByName("processDefValue")[0];
			processDefName.value = arrResult[1];
			processDefValue.value = arrResult[0];
		}
	}

	function search() {
		var processDefValue = document.getElementsByName("processDefValue")[0];
		var displayEndpoints_display = document.getElementsByName("displayEndpoints_display")[0];

		if (displayEndpoints_display.value != ""){
			document.refreshForm.endpoint.value = displayEndpoints_display.value;
		}
		if (processDefValue.value != ""){
			document.refreshForm.processDefinition.value = processDefValue.value;
		}
		document.refreshForm.submit();
	}

	function goPage(page){
		refreshForm.CURRENTPAGE.value = page;
		refreshForm.submit();
	}

	function openProcess(instanceId){
		var option = "width=950,height=650,scrollbars=yes,resizable=yes";
		var url = "../processparticipant/viewProcessInformation.jsp?omitHeader=yes&instanceId="+instanceId;
		window.open(url, "", option)
	}
	
</script>

<link href="../style/default.css" rel="stylesheet" type="text/css">
<LINK href="../style/uengine.css" type=text/css rel=stylesheet>
<style>
a:link {color:#000;}
</style>

<br><br>

<table WIDTH="100%" cellspacing="0" cellpadding="0" border="0">
	<tr>
    	<td>
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                 <tr>
                     <td><span onClick="searchGo(-1);" style="cursor: pointer;"><img src="../images/Common/skip-back.gif" border="0"></span>
                        <span style="font-size:18px; font-weight:bold; line-height:16px; letter-spacing:-1;"><%=String.valueOf(now.get(Calendar.YEAR)) + "." + String.valueOf(monthOfNow+1) + "." %></span>
                        <span onClick="searchGo(+1);" style="cursor: pointer;"><img src="../images/Common/skip.gif" border="0"></span></td>         
                 </tr>
            </table>
        </td>
		<td align="right">
			<table>
				<tr>
					<td width=10 height=10><img src="../processmanager/images/ganttbar_greenBall.gif"></td>
					<td style="font-size:11px;"> <%=GlobalContext.getLocalizedMessageForWeb("Now_Working", loggedUserLocale, "Now Working") %> &nbsp;</td>
					<td width=10 height=10 ><img src="../processmanager/images/ganttbar_grayBall.gif"></td>
					<td style="font-size:11px;"> <%=GlobalContext.getLocalizedMessageForWeb("Work_Done", loggedUserLocale, "Work Done") %> &nbsp;</td>
					<td width=10 height=10 ><img src="../processmanager/images/ganttbar_orangeBall.gif"></td>
					<td style="font-size:11px;"> <%=GlobalContext.getLocalizedMessageForWeb("Delayed_Still_Working", loggedUserLocale, "Delayed/Still Working") %> &nbsp;</td>
					<td width=10 height=10 ><img src="../processmanager/images/ganttbar_blueBall.gif"></td>
					<td style="font-size:11px;"><%=GlobalContext.getLocalizedMessageForWeb("Time_left_to_due_date", loggedUserLocale, "Time left to due date")%></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<br />

<table WIDTH="100%" border="0" cellspacing="0" cellpadding="0">
	<td>
		<table class="gantable" style="table-layout:fixed;" bgcolor="#C7D3E4"  border="0" cellspacing="0" cellpadding="0" WIDTH="100%" >
			<tr class="tabletitle" style="height:25px;">
			
<%	boolean bShowProcess = false;//( invisibleField == null || (invisibleField != null  && !invisibleField.equals("process") ));
		if(bShowProcess){
%>			<th><%=GlobalContext.getLocalizedMessageForWeb("process", loggedUserLocale, "Process") %></th>
<%	}
%>			<th><%=GlobalContext.getLocalizedMessageForWeb("Task", loggedUserLocale, "Task") %></th>
<%
	for(int i=1; i<=lastDateOfMonth; i++) {//workday base
%>
			<th width=15><font size="-2">
<%
		if((i + firstDayOfMonth)%7==0) {
%>
					<font color=red>
<%
		}
%>
			<%=i%></font>
			</th>
<%
	}

	String colTitle = "";
	if (orderby.equals("resource")) {
		colTitle = GlobalContext.getLocalizedMessageForWeb("By_Instance", loggedUserLocale, "Instance");
	} else if (orderby.equals("instance")) {
    	colTitle = GlobalContext.getLocalizedMessageForWeb("Resource", loggedUserLocale, "Resource");
	}

%>
			<!--th bgcolor=white></th-->
			<th><%=colTitle%></th>
			</tr>

<%
	/*
	String filtering = "";
	if (!"".equals(endpoint)) {
		filtering += " and bpm_worklist.resname = ?username";
	}
	*/
	String filtering = "";
	
	if (!"".equals(endpoint)) {
		String[] endpoints = endpoint.split(";");
		filtering += " and bpm_worklist.resname in (";
		String ss = "";
		for (int i=0; i<endpoints.length; i++) {
			ss += "?endpoint" + i + "";
			if (i != endpoints.length -1) {
				ss += ", ";
			}
		}
		filtering += ss + ")";
	}
	
	if (strategyIds.size() > 0) {
		filtering += " and bpm_procinst.strategyId in (";
		String ss = "";
		for (int i=0; i<strategyIds.size(); i++) {
//			ss += "?strategyId" + i + "";
			ss += ""+strategyIds.get(i);
			if (i != strategyIds.size() -1) {
				ss += ", ";
			}
		}
		filtering += ss + ")";
	}
	

	boolean useOracle = DAOFactory.getInstance(null).getDBMSProductName().startsWith("Oracle");
	boolean useMySQL = DAOFactory.getInstance(null).getDBMSProductName().startsWith("MySQL");
	
	StringBuffer sql = new StringBuffer(); 
	sql.append(
			"select bpm_worklist.*, bpm_procinst.* "
			+ " from bpm_worklist, bpm_procinst "
			+ " where bpm_procinst.isdeleted=0  "
			+ (UEngineUtil.isNotEmpty(pd) ? " and bpm_procinst.defid = ?pd " : "")
			+ " and bpm_worklist.instId  = bpm_procinst.instId and bpm_worklist.status<>'CANCELLED' "
			+ " and bpm_worklist.startdate <= ?LAST_DAY_OF_THIS_MONTH "
			+ " and (  bpm_worklist.enddate >=  ?FIRST_DAY_OF_THIS_MONTH  or bpm_worklist.enddate is null)"
			+ filtering
	);
	if(!loggedUserIsMaster)
	{
		/*
		System.out.println(
				"\n========================================================="
				+ "\nloggedUserGlobalCom : " + loggedUserGlobalCom
				+ "\n========================================================="
		);
		*/
		sql.append(" AND bpm_procinst.defid in (SELECT distinct bpm_procdef.defid FROM bpm_procdef WHERE comcode = ?globalcom)");
	}
	
	sql.append(
			" order by "
			+ (orderby.equals("resource") ? " bpm_worklist.resname, bpm_worklist.instId desc, ":"bpm_worklist.instId desc, bpm_worklist.resname,")
			+ " bpm_worklist.taskid"
	);

	/*
	System.out.println(
			"\n========================================================="
			+ "\nSQL : " + sql
			+ "\n========================================================="
	);

	*/	
	
	//String sql = "select bpm_worklist.*, bpm_procinst.name as processinstanceName from bpm_worklist, bpm_procinst where "+ (pd.equals("") ? "":"bpm_procinst.defid = ?pd and") +" bpm_worklist.instId" + (useOracle ? "(+)":"") + " = bpm_procinst.instId and bpm_worklist.status<>'CANCELLED' and to_char(bpm_worklist.startdate,'YYYYMMDDHH24MISS') <= ?LAST_DAY_OF_THIS_MONTH and ( to_char(bpm_worklist.enddate,'YYYYMMDDHH24MISS') >= ?FIRST_DAY_OF_THIS_MONTH or bpm_worklist.enddate is null)" + filtering + " order by bpm_worklist.resname, bpm_worklist.instId, bpm_worklist.taskid";
	WorkListDAO task = (WorkListDAO)GenericDAO.createDAOImpl(DefaultConnectionFactory.create(), sql.toString(), WorkListDAO.class);

	if(useMySQL){
		String FIRST_DATE = Integer.toString( firstDate.get(Calendar.YEAR) );
		FIRST_DATE += (firstDate.get(Calendar.MONTH)+1)<10 ? "0"+(Integer.toString(firstDate.get(Calendar.MONTH)+1)) : (Integer.toString(firstDate.get(Calendar.MONTH)+1));
		FIRST_DATE += firstDate.get(Calendar.DAY_OF_MONTH)<10 ? "0"+(Integer.toString(firstDate.get(Calendar.DAY_OF_MONTH))) : (Integer.toString(firstDate.get(Calendar.DAY_OF_MONTH)));
	
		String LAST_DATE = Integer.toString( lastDate.get(Calendar.YEAR) );
		LAST_DATE += (lastDate.get(Calendar.MONTH)+1)<10 ? "0"+(Integer.toString(lastDate.get(Calendar.MONTH)+1)) : (Integer.toString(lastDate.get(Calendar.MONTH)+1));
		LAST_DATE += lastDate.get(Calendar.DAY_OF_MONTH)<10 ? "0"+(Integer.toString(lastDate.get(Calendar.DAY_OF_MONTH))) : (Integer.toString(lastDate.get(Calendar.DAY_OF_MONTH)));
	
		task.set("FIRST_DAY_OF_THIS_MONTH",FIRST_DATE);
		task.set("LAST_DAY_OF_THIS_MONTH", LAST_DATE);
	}else{
		task.set("FIRST_DAY_OF_THIS_MONTH",firstDate.getTime());
		task.set("LAST_DAY_OF_THIS_MONTH", lastDate.getTime());
	}
	task.set("pd", pd);
	task.set("globalcom", loggedUserGlobalCom);
	
	for (int i=0; i<endpoint.split(";").length; i++) {
		String[] endpoints = endpoint.split(";");
		task.set("endpoint"+i, endpoints[i]);
	}
	
/*	if (strategyIds.size() > 0) {
		for (int i=0; i<strategyIds.size(); i++) {
System.out.println("strategyId"+i+"=="+ strategyIds.get(i));

			task.set("instId"+i, strategyIds.get(i).intValue());
		}	
	}
*/	
	/*
	if (!"".equals(endpoint)) {
		task.set("username", endpoint);
	}
	*/
	
	task.select();
	totalCount = task.size();

	Calendar today = Calendar.getInstance();
	int todayDate = today.get(Calendar.DATE);
	String oldProcessInstance = "";
	String oldResName = "";

	int rowCount = 0;
	
	int firstRowCount = (currentPage == 1) ? 0 : (currentPage-1) * intPageCnt + 1;
	int lastRowCount = (currentPage * intPageCnt);
	while(task.next()){
		
		rowCount++;
		
		if (rowCount >= firstRowCount && rowCount <= lastRowCount) {
		
		int	start=1, end=-1, dueDate=-1;
		String status = task.getStatus();

		try{
			if(task.getStartDate()!=null){
				Calendar startCalendar = Calendar.getInstance();
				startCalendar.setTime(task.getStartDate());

				if(startCalendar.before(firstDate))
					start = 1;
				else
					start = task.getStartDate().getDate();
			}else
				start = todayDate;

			if(task.getEndDate()!=null){
				Calendar endCalendar = Calendar.getInstance();
				endCalendar.setTime(task.getEndDate());

				if(endCalendar.before(firstDate))
					end = 1;
				else
					end = task.getEndDate().getDate();
			}else
				end = todayDate;

			if(task.getDueDate()!=null){
				Calendar dueDateCalendar = Calendar.getInstance();
				dueDateCalendar.setTime(task.getDueDate());

				if(dueDateCalendar.before(firstDate)){
					dueDate = 1;
				}else if(dueDateCalendar.after(lastDate)){
					dueDate = lastDateOfMonth;//implicitly make it out of bound
				}else{
					dueDate = task.getDueDate().getDate();
				}
			}else{
				dueDate = end;
			}

		}catch(Exception e){
			//e.printStackTrace();
		}

		if(status.equals("Skipped") || status.equals("CANCELLED") || status.equals("Stopped") || status.equals("Timeout"))
			end = dueDate;

		if(end==-1) end = todayDate;
		else if(end<start) end = lastDateOfMonth;

		int drawingEnd = (dueDate > end ? dueDate:end);

		String processInstanceLabel;


		if(orderby.equals("instance")){


    		if(oldProcessInstance.equals(""+task.getInstId())){
    			processInstanceLabel = "";
    		}else{
    			processInstanceLabel = task.get("name") + " ("+task.getInstId()+")";
    			oldProcessInstance = ""+task.getInstId();
%>
			<tr>
				<td colspan=<%=(lastDateOfMonth + 2)%> bgcolor="#FFFFFF" style="padding-left:5px; height:28px;"><span class="sectiontitle" >
				<a href="javascript:openProcess('<%=task.getInstId()%>')"><b style="color:#2E4074"><%=processInstanceLabel%></b></a></span>
				</td>
			</tr>
<%
    		}

    		String userName = task.getResName();
/*		    try{
		    	userName = (String)task.get("EXT1");
		    }catch(Exception e){}*/
%>
			<tr>
<%
		    if(bShowProcess){
%>
				<td bgcolor=#F4F4F4 width=250 ><a href="javascript:open('../processmanager/viewProcessInformation.jsp?instanceId=<%=task.getInstId()%>', 'name','width=650,height=500,toolbar=no,resizable=yes,scrollbars=yes')"><%=processInstanceLabel%></a></td>
<%
		    }
%>
				<td bgcolor=#F4F4F4 style="padding-left:5px;"><%=task.getTitle()%></td>
<%
    		for(int d=1; d<start; d++){
    			if(d!=todayDate){
%>
				<td bgcolor=white></td>
<%
			    }else{
%>
				<td bgcolor=#e9efff></td>
<%			    }
    		}

    		String color = "Black";
    //		String statusColor = org.uengine.kernel.viewer.DefaultActivityViewer.getStatusColor(status);
    		String statusColor = statusColors.getProperty(status, "RED");
//    		for(int d=start; d<=drawingEnd; d++){
//    			color = statusColor;
//    			if(d > end) color = "#aaaaff";
//    			else if(d > dueDate) color = "Orange";
    			GanttChartUtil ganttChartUtil = new GanttChartUtil();
    			String chartBar = ganttChartUtil.getGanttChartBarHtml(start,drawingEnd, end, dueDate, status);
%>
				<%=chartBar %><!--td bgcolor=<%=color%>></td-->
<%
//    		}

    		if(drawingEnd<lastDateOfMonth) {
    			if (start > dueDate) {
    				drawingEnd++;
    			}
    			/*
    			else if (start + dueDate > lastDateOfMonth) {
    				lastDateOfMonth--;
    			}
    			*/
    			for(int d=drawingEnd+1; d<=lastDateOfMonth; d++){
    				if(d!=todayDate){
%>
					<td bgcolor=white></td>
<%
			    	}else{
%>
					<td bgcolor=#e9efff></td>
<%			    	}
		    	}
    		}
%>
				<!--td bgcolor=white><%=task.getStatus()%></td-->
				<td bgcolor=#F4F4F4 align=center><%=userName%></td>
			</tr>
<%
        }else{
            String userName = task.getResName();

            if(oldResName.equals(""+userName)){
    			userName = "";
    		}else{
    			oldResName = ""+userName;
%>
			<tr>
				<td colspan=<%=(lastDateOfMonth + 2)%> bgcolor="#ffffff" style="padding-left:5px; height:28px;"><span class="sectiontitle">
				<a href="javascript:openProcess('<%=task.getInstId()%>')"><b style="color:#2E4074"><%=userName%></b></a></span>
				</td>
			</tr>
<%
    		}


    		processInstanceLabel = task.get("name") + " ("+task.getInstId()+")";

/*		    try{
		    	userName = (String)task.get("EXT1");
		    }catch(Exception e){}*/
%>
			<tr>
<%
		    if(bShowProcess){
%>
				<td bgcolor=#F4F4F4><a href="javascript:open('../processmanager/viewProcessInformation.jsp?instanceId=<%=task.getInstId()%>', 'name','width=650,height=500,toolbar=no,resizable=yes,scrollbars=yes')"><%=processInstanceLabel%></a></td>
<%
		    }
%>
				<td bgcolor=#F4F4F4 style="padding-left:5px;"><%=task.getTitle()%></td>
<%
    		for(int d=1; d<start; d++){
    			if(d!=todayDate){
%>
				<td bgcolor=white></td>
<%
			    }else{
%>
				<td bgcolor=#e9efff></td>
<%			    }
    		}

    		String color = "Black";
    //		String statusColor = org.uengine.kernel.viewer.DefaultActivityViewer.getStatusColor(status);
    		String statusColor = statusColors.getProperty(status, "RED");
//    		for(int d=start; d<=drawingEnd; d++){
//    			color = statusColor;
//    			if(d > end) color = "#aaaaff";
//    			else if(d > dueDate) color = "Orange";
    			GanttChartUtil ganttChartUtil = new GanttChartUtil();
    			String chartBar = ganttChartUtil.getGanttChartBarHtml(start,drawingEnd, end, dueDate, status);
%>
				<%=chartBar %><!--td bgcolor=<%=color%>></td-->
<%
//    		}

    		if(drawingEnd<lastDateOfMonth) {
    			if (start > dueDate)
    				drawingEnd++;
    			
    			for(int d=drawingEnd+1; d<=lastDateOfMonth; d++){
    				if(d!=todayDate){
%>
					<td bgcolor=white></td>
<%
			   	 }else{
%>
					<td bgcolor=#e9efff></td>
<%			    	}
		   	 	}
    		}
%>
				<!--td bgcolor=white><%=task.getStatus()%></td-->
				<td bgcolor=#F4F4F4 align=left><a href="javascript:openProcess('<%=task.getInstId()%>')"><b style="color:#2E4074"><%=processInstanceLabel%></b></a></td>
			</tr>
<%       }





		}
	}
	
	task.releaseResource();
%>
		</table>
	</td>
</table>

<br />

<table WIDTH="100%" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td align="right">
			<table>
				<tr>
					<td width=10 height=10><img src="../processmanager/images/ganttbar_greenBall.gif"></td>
					<td style="font-size:11px;"> <%=GlobalContext.getLocalizedMessageForWeb("Now_Working", loggedUserLocale, "Now Working") %> &nbsp;</td>
					<td width=10 height=10 ><img src="../processmanager/images/ganttbar_grayBall.gif"></td>
					<td style="font-size:11px;"> <%=GlobalContext.getLocalizedMessageForWeb("Work_Done", loggedUserLocale, "Work Done") %> &nbsp;</td>
					<td width=10 height=10 ><img src="../processmanager/images/ganttbar_orangeBall.gif"></td>
					<td style="font-size:11px;"> <%=GlobalContext.getLocalizedMessageForWeb("Delayed_Still_Working", loggedUserLocale, "Delayed/Still Working") %> &nbsp;</td>
					<td width=10 height=10 ><img src="../processmanager/images/ganttbar_blueBall.gif"></td>
					<td style="font-size:11px;"><%=GlobalContext.getLocalizedMessageForWeb("Time_left_to_due_date", loggedUserLocale, "Time left to due date")%></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<br />

<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr align="center">
		<td>
			<bpm:page link="" totalcount="<%=totalCount%>" pagecount="<%=intPageCnt%>" pagelimit="<%=nPagesetSize%>"
			currentpage="<%=currentPage%>" locale="<%=loggedUserLocale%>" />
		</td>
	</tr>
</table>

<br /><br /><br />


<form name="refreshForm" method="GET" action="ganttChart.jsp" target="_self">
	<input type="hidden" name="processDefinition" value="<%=pd%>"/>
	<input type="hidden" name="mondif" value="<%=s_mondif%>"/>
	<input type="hidden" name="orderby" value="<%=orderby%>"/>
	<input type="hidden" name="endpoint" value="<%=endpoint%>"/>
	<input type="hidden" name="CURRENTPAGE" value="<%=currentPage %>" />
	<input type="hidden" name="strategyId" value="<%=strategyId %>" />
</form>


</body>
</html>