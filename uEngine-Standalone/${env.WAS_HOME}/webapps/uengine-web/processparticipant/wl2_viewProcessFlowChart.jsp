<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<%@page import="org.uengine.liferayintegration.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.uengine.util.dao.*,org.uengine.persistence.dao.WorkListDAO, org.uengine.persistence.processinstance.*"%>
<%@page import="org.uengine.persistence.processinstance.ProcessInstanceDAO"%>
<%@page import="org.uengine.ui.list.datamodel.DataMap"%>
<%@page import="org.uengine.ui.list.datamodel.DataList"%>
<%@page import="org.uengine.ui.list.datamodel.QueryCondition"%>
<%@page import="org.uengine.ui.list.util.HttpUtils"%>
<%@page import="org.uengine.ui.list.util.DAOListCursorUtil"%>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@ taglib uri="http://www.uengine.org/taglibs/bpm" prefix="bpm" %>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
ProcessManagerRemote pm = processManagerFactory.getProcessManagerForReadOnly();
try{
	
	DefaultConnectionFactory defaultConnectionFactory = DefaultConnectionFactory.create();

	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server

	/***********************************************************************/
	/*                            Define                                   */
	/***********************************************************************/

	QueryCondition condition = new QueryCondition();
	DataList dl = null;

	// Work List BF.
//	WorkListBusinessFacade workListBF = null;

	int intPageCnt = 10; 	
	int nPagesetSize = 10;	
	int currentPage = reqMap.getInt("CURRENTPAGE", 1);
	int totalCount = 0;
	int totalPageCount = 0;

	String strTarget = reqMap.getString("TARGETCOND", "procins.instancename");
	String strKeyword = reqMap.getString("KEYWORDCOND", "");
	String strDateKeyStart=reqMap.getString("INIT_START_DATE", "");
	String strDateKeyEnd=reqMap.getString("INIT_END_DATE", "");
	String strDefCategoryId = reqMap.getString("DEFCATEGORYID", "");
	String strDefTypeId = reqMap.getString("DEFTYPEID", "");

	
	String strSortColumn = reqMap.getString("SORT_COLUMN", "");
	String strSortCond = reqMap.getString("SORT_COND", "");
	String menuItemId=reqMap.getString("MENU_ITEMID","item_bpm");

	/***********************************************************************/
	/*                            Check & Set Parameter                    */
	/***********************************************************************/


	condition.setMap(reqMap);
	condition.setOnePageCount(intPageCnt);
	condition.setPageNo(currentPage);
%>	

<body bgproperties="fixed" bgcolor=white onload="resetZoom();loopDraw_originObj = oZoom;drawLoopLines()">

<%
//	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	
	String pd = reqMap.getString("processDefinition", "");
	String viewOption = reqMap.getString("viewOption", "vertical");
	System.out.println("viewOption:"+viewOption);
	String belongingPd = pd;
	
	//replace with production version
	String pdver = null;
	if(!"".equals(pd)){
		pdver = pm.getProcessDefinitionProductionVersion(pd);
	}
	
	String folder = reqMap.getString("folder", "");
	String pi = reqMap.getString("instanceId", "");
//	if(!UEngineUtil.isNotEmpty(pi)) pi = null;

	String chart ="no chart is available";
	ProcessDefinitionRemote pdr;	
	if(!"".equals(pi))
		pdr = pm.getProcessDefinitionRemoteWithInstanceId(pi);
	else
		pdr = pm.getProcessDefinitionRemote(pdver);
	
	Hashtable options = new Hashtable();
	options.put("decorated", new Boolean(true));
	options.put("nowrap", new Boolean(true));
	options.put("imagePathRoot", "../../processmanager/");
	options.put("locale", loggedUserLocale);
	options.put("subProcessDrillingDown_By_PopingUp", new Boolean(true));
    options.put("showSubProcessOutline", new Boolean(true));

  	if("swimlane".equals(viewOption))
  		options.put("swimlane", new Boolean(true));
	else if("ganttchart".equals(viewOption))
  		options.put("ganttchart", new Boolean(true));
	else if("horizontal".equals(viewOption))
  		options.put("horizontal", new Boolean(true));
  	else 
  		options.put("vertical", new Boolean(true));
  		
	if(!"".equals(pi)){
		chart = pm.viewProcessInstanceFlowChart(pi, options);
%>

<h3><%=pdr.getName().getText(loggedUserLocale)%> (Instance ID: <%=pi%>)</h3>

<%
	}
	else
	if(pdver != null){
		%><h3><%=pdr.getName().getText(loggedUserLocale)%></h3>
		<ul><%=(pdr.getDescription()==null ? "[no description]":notNull(pdr.getDescription().getText(loggedUserLocale)))%></ul> 
		<%
		
		chart = pm.viewProcessDefinitionFlowChart(pdver, options);
		
	}
	chart ="<br><br><br>"+chart;
%>		  
      
<div id="zoomSlider" style="position:absolute;left:450;top:100px;filter:progid:DXImageTransform.Microsoft.Alpha(opacity=80);">
			    <table 	align = "left" width="130"  cellpadding-"0" cellspacing="0" border="0" >
				  <tr>
				  	<td align=center>
				  	  <font color=gray>
					  <a href="javascript:swapView('<%=folder%>','<%=pi%>','<%=pd%>','process','vertical')"><img src="../../processmanager/images/view_option_vertical.gif" border=0></a> | 
					  <a href="javascript:swapView('<%=folder%>','<%=pi%>','<%=pd%>','process','horizontal')"><img src="../../processmanager/images/view_option_horizontal.gif" border=0></a> | 
					  <a href="javascript:swapView('<%=folder%>','<%=pi%>','<%=pd%>','process','swimlane')"><img src="../../processmanager/images/view_option_swimlane.gif" border=0></a> |
					  <a href="javascript:swapView('<%=folder%>','<%=pi%>','<%=pd%>','process','ganttchart')"><img src="../../processmanager/images/view_option_ganttchart.gif" border=0></a>
					</td>
				  </tr>
				</table>
</div>

<div id="oZoom">
     <center> <%=chart%> </center>
</div>
<%
	if (!"".equals(pi)){
		ProcessInstance instance = pm.getProcessInstance(pi);
%>	

<p>
<h3> <%=GlobalContext.getLocalizedMessageForWeb("possible_actions", loggedUserLocale, "Possible Actions") %>: </h3>
	<script>
		function onEventButtonClicked(eventName){
			document.eventHandlingForm.eventName.value = eventName;
			document.eventHandlingForm.submit();
		}
	</script>
	<form action="worklist/eventHandler.jsp" name="eventHandlingForm">
		<input type=hidden name=eventName>
		<input type=hidden name=instanceId value="<%=pi%>">
	</form>

<%
		EventHandler[] eventHandlersInAction = pm.getEventHandlersInAction(pi);
		
		if(eventHandlersInAction.length > 0){
			for(int i=0; i<eventHandlersInAction.length; i++){
				EventHandler theEventHandler = eventHandlersInAction[i];
				if(theEventHandler.getTriggeringMethod() == org.uengine.kernel.EventHandler.TRIGGERING_BY_EVENTBUTTON 
						/*&& theEventHandler.getHandlerActivity() instanceof SubProcessActivity*/){
					if(theEventHandler.getOpenRoles()!=null && !theEventHandler.getOpenRoles().containsMapping(instance, loggedRoleMapping)) continue;
					%>
					<input type=button value="<%=theEventHandler.getDisplayName().getText(loggedUserLocale)%>" onclick="onEventButtonClicked('<%=theEventHandler.getName()%>')">
					<%
				}
			}
		}else{
			%>There's no actions currently activated.<%
		}
	
%>

<h3><%=GlobalContext.getLocalizedMessageForWeb("roles", loggedUserLocale, "Roles") %></h3>

<table border=0 cellspacing=4>
	<tr><td>Role</td><td>Endpoint</td></tr>
	<tr><td height=1 colspan=2 bgcolor=black></td></tr>

<%
	Role[] roles = pdr.getRoles();
	
	if(roles!=null)
	for(int i=0; i<roles.length; i++){
		Role role = roles[i];
		
		%><tr><td><%=role.getName()%></td><td><%
		if(pi!=null){
			String endpoint = pm.getRoleMapping(pi, role.getName());
			%><%=notNull(endpoint)%> 
			<%
		}
		%></td></tr><%
	}
	
%>
</table>

<p>
<h3> <%=GlobalContext.getLocalizedMessageForWeb("work_history", loggedUserLocale, "Work History") %></h3>

<table border=0 cellspacing=4>
	<tr><td>Type</td><td>Title</td><td>Start date</td><td>End date</td><td>Status</td><td>Worker</td><td>See detail</td></tr>
	<tr><td height=1 colspan=7 bgcolor=black></td></tr>

<%
	
	ProcessInstanceDAO eventHandlerSPs = (ProcessInstanceDAO)GenericDAO.createDAOImpl(defaultConnectionFactory, "select * from bpm_procinst where maininstid=?maininstid and isDeleted=0", ProcessInstanceDAO.class);
	eventHandlerSPs.setMainInstId(new Long(pi));
	eventHandlerSPs.select();
	
	while(eventHandlerSPs.next()){
		%>
		<tr>
		<td><%=(eventHandlerSPs.getIsEventHandler() ? "Event":"Sub Process") %></td>
		<td><%=notNull(eventHandlerSPs.getName())%></td>
		<td><%=notNull(eventHandlerSPs.getStartedDate())%></td>
		<td><%=notNull(eventHandlerSPs.getFinishedDate())%></td>
		<td><%=notNull(eventHandlerSPs.getStatus())%></td>
		<td>-</td>
		<td><a href="viewProcessFlowChart.jsp?instanceId=<%=eventHandlerSPs.getInstId() %>">See</a></td>
		</tr>
		<%
	}
	
	WorkListDAO wl = (WorkListDAO)GenericDAO.createDAOImpl(defaultConnectionFactory, "select * from bpm_worklist where rootinstid=?rootinstid", WorkListDAO.class);
	wl.setRootInstId(new Long(pi));
	wl.select();
	
	while(wl.next()){
		%>
		<tr>
		<td>Workitem</td>
		<td><%=notNull(wl.getTitle())%></td>
		<td><%=notNull(wl.getStartDate())%></td>
		<td><%=notNull(wl.getEndDate())%></td>
		<td><%=notNull(wl.getStatus())%></td>
		<td><%=notNull(wl.getResName())%></td>
		<td><%if(true || "COMPLETED".equals(wl.getStatus())){ %><a href="../formInstances/<%=wl.getInstId()%>/<%=wl.getTrcTag()%>/">See</a><%}%></td>
		</tr>
		<%
	}
	
%>
</table>

<%
	if(instance.isParticipant(loggedRoleMapping)){
%>
<p>
<h3> <%=GlobalContext.getLocalizedMessageForWeb("variables", loggedUserLocale, "Variables") %></h3>
<table border=0 cellspacing=4>
	<tr><td>Name</td><td>Value</td></tr>
	<tr><td height=1 colspan=2 bgcolor=black></td></tr>

<%
		ProcessVariable[] pvdrs = pdr.getProcessVariableDescriptors();
		if (pvdrs!=null) {
			for(int i=0; i<pvdrs.length; i++) {
				ProcessVariable pvd = pvdrs[i];
				Serializable data = pm.getProcessVariable(pi, "", pvd.getName());
				if(data instanceof Calendar && data !=null)
					data = ((Calendar)data).getTime();
					
				if(data == null) data = ".";
%>
					<tr>
						<td align=center>
							<%=pvd.getDisplayName().getText(loggedUserLocale)%>
						</td>
						<td align=left>
							<%=notNull(data)%>
						</td>
					</tr>
<%
			}
		}
	}

%>
		</table>

<%
}
%>

<%if (pdver!=null){%>

<table width=100%><td align=right>
<form name="initForm" action="../initiateForm.jsp">
<%
	HashMap h = AclManager.getInstance().getPermission(pd,loggedUserId);
	if(h.containsKey("r")){
%>
	<input type=submit value="<%=GlobalContext.getLocalizedMessageForWeb("initiate_this_process", loggedUserLocale, "Initiate this process...") %>">
<%
	}
%>
	<input type=hidden name=processDefinition value='<%=pdver%>'>
</form>
</td></table>

<br><br><br>
<font size=2><b><%=GlobalContext.getLocalizedMessageForWeb("instance_list", loggedUserLocale, "Instance List")%></b>
<%=GlobalContext.getLocalizedMessageForWeb("instance_list_desc", loggedUserLocale, "(where you're initiated or you're currently participating in.)")%></font>
<%
	HashMap colors = new HashMap(10);
	colors.put("Failed", "red");
	colors.put("Suspended", "yellow");
	colors.put("Skipped", "blue");
	colors.put("Ready", "green");
	colors.put("Running", "green");

	ProcessDefinition pdObj = pm.getProcessDefinition(pdver);
	ListField[] listFields = null;
	
	// Default fields.
	ListField[] defListFields = new ListField[6];
	defListFields[0] = new ListField(GlobalContext.getLocalizedMessageForWeb("instance_name", loggedUserLocale, "Instance Name"), new InstanceTableListFieldType("name"));
	defListFields[1] = new ListField(GlobalContext.getLocalizedMessageForWeb("definition_name", loggedUserLocale, "Definition Name"), new InstanceTableListFieldType("defname"));
	defListFields[2] = new ListField(GlobalContext.getLocalizedMessageForWeb("start_date", loggedUserLocale, "Start Date"), new InstanceTableListFieldType("startedDate"));
	defListFields[3] = new ListField(GlobalContext.getLocalizedMessageForWeb("due_date", loggedUserLocale, "Due Date"), new InstanceTableListFieldType("dueDate"));
	defListFields[4] = new ListField(GlobalContext.getLocalizedMessageForWeb("end_date", loggedUserLocale, "End Date"), new InstanceTableListFieldType("finisheddate"));
	defListFields[5] = new ListField(GlobalContext.getLocalizedMessageForWeb("information", loggedUserLocale, "Information"), new InstanceTableListFieldType("info"));
	
	String sql;
	if(pdObj.getInstanceListFields()!=null && pdObj.getInstanceListFields().length > 0){
		listFields = pdObj.getInstanceListFields();

		HashMap joiningTables = new HashMap();
		joiningTables.put("BPM_PROCINST", "inst");

		ArrayList whereClauses = new ArrayList();
		ArrayList selectItems = new ArrayList();
		StringBuffer selectClause = new StringBuffer();
		StringBuffer fromClause = new StringBuffer();
		StringBuffer whereClause = new StringBuffer();
		
		int tableCnt = 0;
		
		selectItems.add("inst.INSTID");
		selectItems.add("inst.STATUS");
		selectItems.add("inst.startedDate");
		for(int i=0; i<listFields.length; i++){
			ListFieldType listFieldType = listFields[i].getListFieldType();
			if(listFieldType instanceof VariablePointingListFieldType){
				ProcessVariable pv = ((VariablePointingListFieldType)listFieldType).getVariable();
				org.uengine.contexts.DatabaseSynchronizationOption dso = pv.getDatabaseSynchronizationOption();
				
				String tableAlias;
				if(!joiningTables.containsKey(dso.getTableName().toUpperCase())){
					tableAlias = "t"+(++tableCnt);
					joiningTables.put(dso.getTableName().toUpperCase(), tableAlias);
					fromClause.append(" LEFT OUTER JOIN " + dso.getTableName().toUpperCase() + " " + tableAlias);
					fromClause.append(" ON inst." + dso.getCorrelatedFieldName() + "=" + tableAlias + "." + dso.getCorrelationFieldName());
				}else{
					tableAlias = (String)joiningTables.get(dso.getTableName().toUpperCase());
				}
				
				selectItems.add(tableAlias + "." + dso.getFieldName());
			}else if(listFieldType instanceof InstanceTableListFieldType){
				String strFieldName = ((InstanceTableListFieldType)listFieldType).getFieldName();
				//if( !"INSTID".equals(strFieldName) && !"STATUS".equals(strFieldName) ){
				if( !"startedDate".equalsIgnoreCase(strFieldName) ){
					selectItems.add("inst." + strFieldName);
				}
			}
		}
		whereClauses.add("inst.defid=" + pdObj.getBelongingDefinitionId() );
		whereClauses.add("inst.instid = inst.rootinstid" );
		
		String sep = "";
		for(int i=0; i<selectItems.size(); i++){
			selectClause.append(sep + selectItems.get(i));
			sep = ", ";
		}

		sep = "";
		for(int i=0; i<whereClauses.size(); i++){
			whereClause.append(sep + whereClauses.get(i));
			sep = " and ";
		}
		
		sql = "select " + selectClause + " from bpm_procinst inst" + fromClause + " where " + whereClause;
	}else{
		listFields = defListFields;
//		sql = "select * from bpm_procinst ";
		sql = "select * from bpm_procinst inst" 
			+ " where inst.defid=" + pdObj.getBelongingDefinitionId() 
			+ " and inst.instid = inst.rootinstid"
			+ " order by starteddate desc";
	}
%>
<table width=95>
  <tr>
    <td bgcolor=#B6CBEB>
	  <table border="0" cellpadding="4" cellspacing="0" width="100%">
		<tr class="beta">
<%
	// Make Header.
	if( listFields != null ){
		
		for(int i=0; i<listFields.length; i++){
%>
		  <td nowrap>
            <font class="beta"><b><%=listFields[i].getDisplayName().getText(loggedUserLocale)%></b></font>
		  </td>
<%
		}		
%>
		</tr>
<%
		System.out.println("sql=["+sql.toString()+"]");
//		ProcessInstanceDAO piDAO = (ProcessInstanceDAO)GenericDAO.createDAOImpl("java:/uEngineDS", sql, ProcessInstanceDAO.class);
//		piDAO.select();
		
		java.sql.Connection con = defaultConnectionFactory.getConnection();
		try{
			dl = DAOListCursorUtil.executeList(sql, condition, new ArrayList(), con);
			totalCount = (int)dl.getTotalCount();
			totalPageCount = dl.getTotalPageNo();
		}catch(Exception e){
			throw e;
		}finally{
			if( con != null ){con.close();}
		}
		
		String style="bg";
		
//		while(piDAO.next()){
		if(totalCount > 0) {
				for( int j=0; j<dl.size(); j++ ){
					DataMap tmpMap = (DataMap)dl.get(j);					
//					Long instId = piDAO.getInstId();
					String instId = tmpMap.getString("INSTID", "-");
//					String bold = ( "NEW".equals(piDAO.getStatus()) ? "<b>":"");
					String bold = ( "NEW".equals(tmpMap.getString("STATUS", "-")) ? "<b>":"");
%>
	    <tr class="<%=style%>" onclick="viewProcInfo('<%=instId%>')" style="cursor:hand;">
<%
				for(int i=0; i<listFields.length; i++){
//					Object fieldValue = listFields[i].getFieldValue(piDAO, null);
					Object fieldValue = tmpMap.getObj(listFields[i].getListFieldType().getFieldName(), "-");
%>
		  <td nowrap>
		    <font class="<%=style%>"><%=bold%><%=fieldValue == null? "-":fieldValue%></font>
		  </td>
<%	
				}
%>
		</tr>
<%
				if(style.equals("bg")){
					style = "gamma";
				}else{
					style="bg";
				}
			}	// while(piDAO.next()){
		} 	// if(totalCount > 0) {
	}	// if( listFields != null ){
%>

      </table>
    </td>
  </tr>
  <tr>
    <td align=center>
<%
	if(totalCount>0){
%>	
	<!--	#####	Navigation start		#####	-->

	<br style="line-height:15px;">
	<bpm:page link="" totalcount="<%=totalCount%>" pagecount="<%=intPageCnt%>" pagelimit="<%=nPagesetSize%>" currentpage="<%=currentPage%>" />
	<br>
<%
	}
%>
    </td>
  </tr>
</table>
<p>
<form name="listForm" action="?">
	<!-- Paging -->
	<input type="hidden" name="currentPage" value="<%=currentPage%>">
	<!-- Sort -->
	<input type="hidden" name="sort_column" value="<%=strSortColumn%>">
	<input type="hidden" name="sort_cond" value="<%=strSortCond%>">

	<input type="hidden" name="listURL" value="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/viewProcessFlowChart.jsp">
	<!-- ?? -->
	<input type="hidden" name="TARGETCOND" value="<%=strTarget%>">
	
	<input type=hidden name=processDefinition value='<%=pd%>'>
	<input type="hidden" name="folder" value="<%=folder%>">
</form>
<%}

}finally{
	try{pm.remove();}catch(Exception e){}
}
%>

