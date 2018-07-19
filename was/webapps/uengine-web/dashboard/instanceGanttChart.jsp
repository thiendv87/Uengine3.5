<%@page import="org.uengine.util.dao.*"%>
<%@page import="org.uengine.persistence.dao.*"%>
<%@page import="org.uengine.webservices.worklist.*"%>
<%@page import="org.uengine.ui.list.datamodel.DataMap"%>
<%@page import="org.uengine.ui.list.datamodel.DataList"%>
<%@page import="org.uengine.ui.list.datamodel.QueryCondition"%>
<%@page import="org.uengine.ui.list.util.HttpUtils"%>
<%@page import="org.uengine.kernel.viewer.gantt.GanttChartUtil" %>
<%//@page pageEncoding="KSC5601"%>
<%//@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<LINK href="../style/uengine.css" type=text/css rel=stylesheet>

<%
	DataMap dataReqMap = HttpUtils.getDataMap(request, true);


	/*************************************************************************/
	/*                             Get Parameter                             */
	/*************************************************************************/
	
	//ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	//String instanceId = dataReqMap.getString("instanceId", "");
	String processDef = "";
	String pdFolder = "";//dataReqMap.getString("folder", "");
	String filtering = "-1";//dataReqMap.getString("filtering", "-1");
	String dispPdNameNId = "";
	String orderby = "0";//dataReqMap.getString("orderby", "0");
	if( !"".equals(pdFolder) ){
		dispPdNameNId += pdFolder;
	}
	if( !"".equals(processDef) ){
		dispPdNameNId += "("+processDef+")";
	}
	/*************************************************************************/
	/*                             Set production version                    */
	/*************************************************************************/
	//ProcessDefinitionRemote pdr = null;
	//replace with production version
	String processDefVer = null;
	String processName = "";
	if(!"".equals(processDef)){
		processDefVer = pm.getProcessDefinitionProductionVersion(processDef);
		pdr = pm.getProcessDefinitionRemote(processDefVer);
		processName = pdr.getName().getText();
	}

	int s_mondif = -1;
    try {
        s_mondif = Integer.parseInt(request.getParameter("mondif"));
    }
    catch(Exception e) {}

%>
<%
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

	String invisibleField = request.getParameter("invisibleField");

%>

<script>
	function openProcess(instanceId){
		open('../../processparticipant/viewProcessInformation.jsp?instanceId=' + instanceId, 'name','width=650,height=500,toolbar=no,resizable=yes,scrollbars=yes');
	}
	function refresh( filtering ){
		var f = document.refreshForm;
		f.filtering.value=filtering;
		f.action = "?";
		f.target = "_self";
		f.submit();
	}

	function viewTaskInfo( taskid ){
		var option = "width=500,height=400,scrollbars=yes,resizable=yes";
		var url = "workitemHandler.jsp?taskId="+taskid;
		window.open(url, "wihspace", option)
	}

	function selectProcess(){
		var url = "../processparticipant/worklist/selectProcessDefinition_frame.jsp";
		var StrOption ;
		StrOption  = "dialogWidth:500px;dialogHeight:300px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:no";
		var arrResult = new Array(2);
		arrResult = showModalDialog (url , window, StrOption);
		//arrResult = window.open (url , "", StrOption);
		if( arrResult != null && arrResult[0] != null ){
			var f = document.refreshForm;
			f.processDefinition.value=arrResult[0];
			f.folder.value=arrResult[1];
			document.all.processDefName.innerText = arrResult[1] + "(" + arrResult[0] + ")";
			document.all.folder.value = arrResult[1];
			refresh('<%=filtering%>');
		}
	}

	function searchGo( i ){
		var f = document.refreshForm;
		f.mondif.value='<%=(s_mondif)%>'*1 + i;
		refresh('<%=filtering%>');
	}

	function changeOrder(){
		var f = document.refreshForm;
		if(document.all.Grouping[0].checked) {
		    f.orderby.value='0';
		}else{
		    f.orderby.value='1';
		}
		refresh('<%=filtering%>');
	}



</script>
	
<table WIDTH="100%" cellspacing=0 cellpadding=0 border=0>
	<td height=1 bgcolor=#6699CC>
		<table border=0 cellspacing=1 cellpadding=1 WIDTH="100%" STYLE="table-layout:fixed;">
			<tr>

			
<%	boolean bShowProcess = false;//( invisibleField == null || (invisibleField != null  && !invisibleField.equals("process") ));
		if(bShowProcess){
%>			<th bgcolor=#F4F4F4 nowrap><center><%=GlobalContext.getLocalizedMessageForWeb("process", loggedUserLocale, "Process") %></th>
<%	}
%>			<th bgcolor=#F4F4F4 nowrap><center><%=GlobalContext.getLocalizedMessageForWeb("Task", loggedUserLocale, "Task") %></th>
<%
	for(int i=1; i<=lastDateOfMonth; i++) {//workday base
%>
			<th bgcolor=#F4F4F4 width=15><font size=-2>
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
%>
			<th bgcolor=#F4F4F4></th></tr>

<%	
	if(filtering!=null && !filtering.equals("-1")) {
		filtering = " and " + filtering.trim() + "='"+ decode(request.getParameter("value")) + "'";
	} else {
		filtering = "";
	}

	boolean useOracle = DAOFactory.getInstance(null).getDBMSProductName().startsWith("Oracle");
	boolean useMySQL = DAOFactory.getInstance(null).getDBMSProductName().startsWith("MySQL");
	String sql = "select bpm_worklist.*, bpm_procinst.name as instNm from bpm_worklist, bpm_procinst where bpm_procinst.isdeleted=0 and "+ (processDef.equals("") ? "":"bpm_procinst.defid = ?pd and") +" bpm_worklist.instId  = bpm_procinst.instId and bpm_worklist.status<>'CANCELLED' and bpm_worklist.startdate <= ?LAST_DAY_OF_THIS_MONTH and (  bpm_worklist.enddate >=  ?FIRST_DAY_OF_THIS_MONTH  or bpm_worklist.enddate is null)" + filtering + " order by "+ (orderby.equals("0") ? " bpm_worklist.instId, bpm_worklist.resname,":"bpm_worklist.resname, bpm_worklist.instId,") +" bpm_worklist.taskid";
	WorkListDAO task = (WorkListDAO)GenericDAO.createDAOImpl(DefaultConnectionFactory.create(), sql, WorkListDAO.class);

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
	task.set("pd", processDef);
	task.select();

	Calendar today = Calendar.getInstance();
	int todayDate = today.get(Calendar.DATE);
	String oldProcessInstance = "";
	String oldResName = "";


	while(task.next()){
		int	start=1, end=-1, dueDate=-1;
		String status = task.getStatus();

		if(UEngineUtil.isNotEmpty(instanceId)){
			if(!instanceId.equals(""+task.getInstId()))
				continue;
		}else{
			continue;
		}
		
		if("null".equals(instanceId)) continue;

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

				if(dueDateCalendar.before(firstDate))
					dueDate = 1;
				else if(dueDateCalendar.after(lastDate))
					dueDate = lastDateOfMonth;//implicitly make it out of bound
				else
					dueDate = task.getDueDate().getDate();
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


		if(orderby.equals("0")){


    		if(oldProcessInstance.equals(""+task.getInstId())){
    			processInstanceLabel = "";
    		}else{
    			processInstanceLabel = task.get("instNm") + " ("+task.getInstId()+")";
    			oldProcessInstance = ""+task.getInstId();

    		}

    		String userName = task.getResName();
/*		    try{
		    	userName = (String)task.get("EXT1");
		    }catch(Exception e){}*/
%>
			<!-- start -->
			<tr>
<%
		    if(bShowProcess){
%>
				<td nowrap bgcolor=#F4F4F4 width=250><a href="javascript:open('../processmanager/viewProcessInformation.jsp?instanceId=<%=task.getInstId()%>', 'name','width=650,height=500,toolbar=no,resizable=yes,scrollbars=yes')"><%=processInstanceLabel%></a></td>
<%
		    }
%>
				<td bgcolor=#F4F4F4  ><%=task.getTitle()%></td>
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
//    			color = "../processmanager/images/ganttbar_blue.gif";
//    			if(d > end) color = "../processmanager/images/ganttbar_blue.gif";//"bgcolor=#aaaaff";
//    			else if(d > dueDate) color ="../processmanager/images/ganttbar_blue.gif";
			GanttChartUtil ganttChartUtil = new GanttChartUtil();
			String chartBar = ganttChartUtil.getGanttChartBarHtml(start,drawingEnd, end, dueDate, status);

%>
				<!-- td bgcolor=white><img src=<%=color%> ></td-->
				<%=chartBar %>
<%
//    		}

    		if(drawingEnd<lastDateOfMonth)

    		for(int d=drawingEnd+1; d<=lastDateOfMonth; d++){
    			if(d!=todayDate){
%>
				<td bgcolor=white></td>
<%
			    }else{
%>
				<td bgcolor=#e9efff></td>
<%			    }
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
				<td colspan=<%=(lastDateOfMonth + 2)%> bgcolor=#B6CBEB>
				<b><font color=black><%=userName%></font></a>
				</td>
			</tr>
<%
    		}


    		processInstanceLabel = task.get("instNm") + " ("+task.getInstId()+")";

/*		    try{
		    	userName = (String)task.get("EXT1");
		    }catch(Exception e){}*/
%>
			<tr>
<%
		    if(bShowProcess){
%>
				<td bgcolor=#F4F4F4 width=250><a href="javascript:open('../processmanager/viewProcessInformation.jsp?instanceId=<%=task.getInstId()%>', 'name','width=650,height=500,toolbar=no,resizable=yes,scrollbars=yes')"><%=processInstanceLabel%></a></td>
<%
		    }
%>
				<td bgcolor=#F4F4F4 width=100><%=task.getTitle()%></td>
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

    		if(drawingEnd<lastDateOfMonth)
  
    		for(int d=drawingEnd+1; d<=lastDateOfMonth; d++){
    			if(d!=todayDate){
%>
				<td bgcolor=white></td>
<%
			    }else{
%>
				<td bgcolor=#e9efff></td>
<%			    }
		    }
%>
				<!--td bgcolor=white><%=task.getStatus()%></td-->
				<td bgcolor=#F4F4F4 width=250><a href="javascript:openProcess('<%=task.getInstId()%>')"><b><font color=black><%=processInstanceLabel%></font></a></td>
			</tr>
<%       }






	}
%>
		</table>
	<td>
</table>


<table WIDTH="100%" cellspacing=0 cellpadding=0 border=0>
<tr><td align=right>
<table >
	<td width=10 height=10><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/ganttbar_greenBall.gif"></td>
	<td> <%=GlobalContext.getLocalizedMessageForWeb("Now_Working", loggedUserLocale, "Now Working") %> &nbsp;</td>

	<td width=10 height=10 ><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/ganttbar_grayBall.gif"></td>
	<td> <%=GlobalContext.getLocalizedMessageForWeb("Work_Done", loggedUserLocale, "Work Done") %> &nbsp;</td>

	<td width=10 height=10 ><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/ganttbar_orangeBall.gif"></td>
	<td> <%=GlobalContext.getLocalizedMessageForWeb("Delayed_Still_Working", loggedUserLocale, "Delayed/Still Working") %> &nbsp;</td>

	<td width=10 height=10 ><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/ganttbar_blueBall.gif"></td>
	<td> <%=GlobalContext.getLocalizedMessageForWeb("Time_left_to_due_date", loggedUserLocale, "Time left to due date")%></td>
</table>
</td><tr></table>