<%@ page pageEncoding="UTF-8" language="java"
	contentType="text/html; charset=UTF-8"%>

<%@page
	import="java.sql.*,javax.sql.*,javax.naming.*,org.uengine.util.dao.*"%>
<%@page import="javax.transaction.*"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="org.uengine.contexts.HtmlFormContext"%>
<%@page import="org.uengine.persistence.dao.*"%>
<%@page import="com.defaultcompany.wih.approvalhandler.ApprovalCommentService"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setHeader("Cache-Control", "no-cache");
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BPM Message</title>
<style>
body {
	scrollbar-face-color: #ffffff;
	scrollbar-shadow-color: #d8d8d8;
	scrollbar-highlight-color: #ffffff;
	scrollbar-3dlight-color: #d8d8d8;
	scrollbar-darkshadow-color: #ffffff;
	scrollbar-track-color: #f6f6f6;
	scrollbar-arrow-color: #79A8BF;
	margin: 0px
}

td {
	font-size: 12px;
	font-family: 굴림;
	color: #333333;
	line-heigh: 150%;
}

td.btn2_s {
	
}

.btn2_s A:link {
	color: #333333;
	height: 21px;
	padding: 5 5 0 5;
	letter-spacing: -1px;
	text-decoration: none;
	text-align: center
}

.btn2_s A:visited {
	color: #333333;
	height: 21px;
	padding: 5 5 0 5;
	letter-spacing: -1px;
	text-decoration: none;
	text-align: center
}

.btn2_s A:active {
	color: #333333;
	height: 21px;
	padding: 5 5 0 5;
	letter-spacing: -1px;
	text-decoration: none;
	text-align: center
}

.btn2_s A:hover {
	color: #333333;
	height: 21px;
	padding: 5 5 0 5;
	letter-spacing: -1px;
	text-decoration: none;
	text-align: center
}

.ok_title {
	background: #E3F3D9;
	color: 04840A;
	padding: 5 7 3 10;
	font-weight: bold;
}

.btn_space {
	padding: 0 3 0 3
}
</style>

<%@include file="../../wihDefaultTemplate/header.jsp"%>

</head>
<body>
<%!final String fileUploadEncoding = "UTF-8";

	public String getParameter(Map parameterMap, String key) {
		String[] paramPair = (String[]) parameterMap.get(key);
		if (paramPair != null && paramPair.length > 0)
			return paramPair[0];
		else
			return null;
	}

	public String[] getParameters(Map parameterMap, String key) {
		String[] paramPair = (String[]) parameterMap.get(key);
		if (paramPair != null && paramPair.length > 0)
			return paramPair;
		else
			return null;
	}

	public String outterdecoder(String orgVal) {
		try {
			return decode(orgVal);
		} catch (Exception e) {
			return null;
		}
	}%>
<jsp:useBean id="processManagerFactory" scope="application"
	class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<%
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	try {
		InitialContext context = new InitialContext();
		boolean nextUserIsCurrentUser = false;
		String nextTaskId = "";

		ObjectType.addInputterPackage("org.uengine.processdesigner.inputters");

		Map parameterMap;

		WebUtil.setWebStringDecoder(new WebStringDecoder() {
			public String decode(String src) {
				return outterdecoder(src);
			} 
		});

		parameterMap = FormActivity.createParameterMapFromRequest(request); //

		String processDefinition = getParameter(parameterMap, "processDefinition");
		String initiationProcessDefinition = getParameter(parameterMap, "initiationProcessDefinition");
		String processInstance = decode(getParameter(parameterMap, "instanceId"));
		String tracingTag = decode(getParameter(parameterMap, "tracingTag"));
		String taskId = decode(getParameter(parameterMap, "taskId"));
		String apprStat = getParameter(parameterMap, "apprStat");
		boolean initiate = "yes".equals(getParameter(parameterMap, "initiate"));
		boolean isExtInitiate = "yes".equals(getParameter(parameterMap, "isExtInitiate"));
		boolean saveOnly = "yes".equals(getParameter(parameterMap, "saveOnly"));
		boolean isEventHandler = "yes".equals(getParameter(parameterMap, "isEventHandler"));
		boolean isSwitchActivityExist = "true".equals(getParameter(parameterMap, "isSwitchActivityExist"));
		boolean isViewMode = "yes".equals(getParameter(parameterMap, "isViewMode"));
		Vector result = new Vector();
		//String comment = "";

		List tmpLastWorkerList = new ArrayList();
		String lastEndpoint = "";
		String startEndpoint = "";

		ProcessInstance instance = (org.uengine.util.UEngineUtil.isNotEmpty(processInstance) ? pm.getProcessInstance(processInstance) : null);
		ProcessDefinition procDef = null;

		if (initiate)
			procDef = (ProcessDefinition) pm.getProcessDefinition(initiationProcessDefinition);
		else {
			procDef = instance.getProcessDefinition();
			//initiationProcessDefinition = procDef.getDefinitionVersionId(instance,procDef.getId(), ProcessDefinition.VERSIONSELECTOPTION_CURRENT_PROD_VER, procDef);
		}
		boolean isValid = true;
%>
<%
	ResultPayload resultPayload = new org.uengine.kernel.ResultPayload();
		KeyedParameter[] processVariableChanges = new KeyedParameter[result.size()];
		result.toArray(processVariableChanges);
		resultPayload.setProcessVariableChanges(processVariableChanges);
		resultPayload.setExtendedValues(new KeyedParameter[] { new KeyedParameter("TASKID", taskId) });

		Map genericContext = new HashMap();
		genericContext.put(HumanActivity.GENERICCONTEXT_CURR_LOGGED_ROLEMAPPING, loggedRoleMapping);
		genericContext.put("parameterMap", parameterMap);
		genericContext.put("response", response);
		genericContext.put("servlet", this);
		genericContext.put("request", request);
		pm.setGenericContext(genericContext);
		ApprovalCommentService acs = new ApprovalCommentService();
		
		if (isEventHandler) {
			String eventName = getParameter(parameterMap, "eventName");
			pm.executeEventByWorkitem(processInstance, eventName, resultPayload);
		} else if (initiate || saveOnly) {//The case that this workitem handler should initiate the process
			if (initiate) {
				if (processInstance != null && (processInstance.trim().equals("null") || processInstance.trim().length() == 0))
					processInstance = null;

				processInstance = pm.initializeProcess(processDefinition, processInstance);

				pm.executeProcess(processInstance);

				instance = pm.getProcessInstance(processInstance);

				Vector vector = instance.getCurrentRunningActivitiesDeeply();
				ActivityInstanceContext aic = (ActivityInstanceContext) vector.get(vector.size() - 1);
				tracingTag = aic.getActivity().getTracingTag();
				processInstance = aic.getInstance().getInstanceId();
			}

			instance = pm.getProcessInstance(processInstance);

			ProcessDefinitionRemote pdr = pm.getProcessDefinitionRemote(processDefinition);

			Role[] roles = pdr.getRoles();
			WebInputter inputterForRoleMapping = (WebInputter) ObjectType.getDefaultInputter(RoleMapping.class);

			for (int i = 0; i < roles.length; i++) {
				String key = roles[i].getName().replace(' ', '_');
				RoleMapping roleMapping = (RoleMapping) inputterForRoleMapping.createValueFromHTTPRequest(parameterMap, "rolemappings", key, null);

				if (roleMapping != null && roleMapping.getEndpoint() != null) {
					roleMapping.setName(roles[i].getName());
					pm.putRoleMapping(processInstance, roleMapping);
				}
			}

			String approvalLineActivityTT = getParameter(parameterMap, "approvalLineActivityTT");
			ProcessDefinition processDefinitionObject = pm.getProcessDefinition(initiationProcessDefinition);
			HumanApprovalLineActivity approvalLineActivity = (HumanApprovalLineActivity) processDefinitionObject.getActivity(approvalLineActivityTT);

			//				 approval				
			if (!isSwitchActivityExist) {

				boolean loadApprovealActivities = "yes".equals(getParameter(parameterMap, "loadApprovealActivities"));
				String approvalLineUserCodes = getParameter(parameterMap, "userCode");
				String approvalLineUserNames = getParameter(parameterMap, "userName");
				String approvalLineUserJobPosition = getParameter(parameterMap, "userJobPosition");
				String approvalLineType = getParameter(parameterMap, "approveType");
				String approvalLinePreConfirm = getParameter(parameterMap, "preConfirm");

				String[] approvalInfoCodes = approvalLineUserCodes.split(";");
				String[] approvalInfoNames = approvalLineUserNames.split(";");
				String[] approvalInfoJobPosition = approvalLineUserJobPosition.split(";");
				String[] approvalInfoTypes = approvalLineType.split(";");
				String[] approvalInfoPreConfirm = approvalLinePreConfirm.split(";");

				//				결제 엑티비티가 로딩이 된 상태라면 기존에 approvalActivity를 초기화 시킨다.
				if (loadApprovealActivities) {
					List appActList = approvalLineActivity.getChildActivities();
					List removeTargetActivity = new ArrayList();
					//String draftActivityTT  = ""+(Integer.parseInt(approvalLineActivityTT)+1);
					String draftActivityTT = approvalLineActivity.getDraftActivity().getTracingTag();
					int j = 0;
					for (int i = 0; i < appActList.size(); i++) {
						Activity act = (Activity) appActList.get(i);

						if (!act.getTracingTag().equals(draftActivityTT)) {
							//approvalLineActivity.removeChildActivity(act);
							removeTargetActivity.add(j, act.getTracingTag());
							j++;
						}
					}

					for (int k = 0; k < removeTargetActivity.size(); k++) {
						approvalLineActivity.removeChildActivity(processDefinitionObject.getActivity((String) removeTargetActivity.get(k)));
					}
				}

				String preType = null;
				HumanApprovalActivity draftActivity = approvalLineActivity.getDraftActivity();
				ComplexActivity parent = approvalLineActivity;

				for (int i = 1; i < approvalInfoCodes.length; i++) {
					String userName = approvalInfoNames[i];
					String endpoint = approvalInfoCodes[i];
					String userJobPosition = approvalInfoJobPosition[i];
					String approveType = approvalInfoTypes[i];
					String approvePreConfirm = approvalInfoPreConfirm[i];

					HumanApprovalActivity approvalActivity = (HumanApprovalActivity) approvalLineActivity.getDraftActivity().clone();
					//approvalActivity.setName(draftActivity.getName() + "(Approve" + (i+1) + ")");
					//approvalActivity.setName(approveType + "(" + userJobPosition + ")" );
					approvalActivity.setName(userJobPosition + " " + userName + " (" + approveType + ")");
					approvalActivity.setTracingTag(null); //let it auto-generated
					approvalActivity.setRole(null);
					approvalActivity.setViewMode(true);
					//후결 설정
					if ("후결".equals(approveType)) {
						approvalActivity.setNotificationWorkitem(true);
					} else {
						approvalActivity.setNotificationWorkitem(false);
					}

					//전결 설정
					if ("yes".equals(approvePreConfirm)) {
						approvalActivity.setArbitraryApprovable(true);
					} else {
						approvalActivity.setArbitraryApprovable(false);
					}
					//approvalActivity.setArbitraryApprovable();
					if (approvalActivity.getParameters() != null) {
						for (int j = 0; j < approvalActivity.getParameters().length; j++) {
							approvalActivity.getParameters()[j].setDirection(ParameterContext.DIRECTION_IN);
						}
					}
					RoleMapping approver = RoleMapping.create();
					approver.setEndpoint(endpoint);
					approver.fill(instance);

					if (!"동의".equals(preType) && "동의".equals(approveType)) {
						AllActivity allAct = new AllActivity();
						parent.addChildActivity(allAct);
						parent = allAct;
					} else if ("동의".equals(preType) && !"동의".equals(approveType)) {
						parent = approvalLineActivity;
					}

					parent.addChildActivity(approvalActivity);
					approvalActivity.setApprover(instance, approver);

					preType = approveType;
				}

				if (loadApprovealActivities)
					pm.changeProcessDefinition(processInstance, processDefinitionObject);
			} else {
				//simulate
				//ProcessManagerBean pmbForSimulation = new ProcessManagerBean();
				//Simulatebean simulateBean = new Simulatebean();
				//HashMap dataMap = simulateBean.getSimulatedDefintion(pm ,pmbForSimulation ,loggedRoleMapping , parameterMap,genericContext );
				//((FXKApprovalLineActivity)approvalLineActivity).setSimulationResult((ProcessDefinition)dataMap.get("definition"));
				pm.changeProcessDefinition(processInstance, processDefinitionObject);
			}

			if (saveOnly) {
				pm.saveWorkitem(processInstance, tracingTag, taskId, resultPayload);


			} else {
				pm.completeWorkitem(processInstance, tracingTag, null, resultPayload);
				acs.saveComments(instance,"-","draft",tracingTag,loggedRoleMapping);
			}
			
			HumanApprovalActivity currentRunningActivity = (HumanApprovalActivity) instance.getCurrentRunningActivity().getActivity();
			String[] taskIds = currentRunningActivity.getTaskIds(instance);
			taskId = taskIds[0];
		} else {
			ProcessDefinition processDefinitionObject = procDef; //pm.getProcessDefinition(processDefinition);

			String approvalLineActivityTT = getParameter(parameterMap, "approvalLineActivityTT");
			HumanApprovalLineActivity approvalLineActivity = (HumanApprovalLineActivity) processDefinitionObject.getActivity(approvalLineActivityTT);

			if (apprStat == null || "".equals(apprStat))
				apprStat = "approve";
			if ("draft".equals(apprStat)) {

				processDefinitionObject = pm.getProcessDefinition(initiationProcessDefinition);

				if (!initiate) {
					processDefinitionObject = (ProcessDefinition) instance.getProcessDefinition().clone();
				}

				approvalLineActivityTT = getParameter(parameterMap, "approvalLineActivityTT");
				approvalLineActivity = (HumanApprovalLineActivity) processDefinitionObject.getActivity(approvalLineActivityTT);

				boolean loadApprovealActivities = "yes".equals(getParameter(parameterMap, "loadApprovealActivities"));

				WorkListDAO wl = (WorkListDAO) GenericDAO.createDAOImpl(instance.getProcessTransactionContext().getConnectionFactory(),
						"select * from bpm_worklist where instid=?instid and trctag=?trctag", WorkListDAO.class);
				wl.setInstId(new Long(instance.getInstanceId()));
				wl.setTrcTag(approvalLineActivity.getDraftActivity().getTracingTag());
				wl.select();

				String currentRunningActStatus = "";

				while (wl.next()) {
					currentRunningActStatus = wl.getStatus();
				}

				if (!isSwitchActivityExist && loadApprovealActivities) {

					//processDefinitionObject = (ProcessDefinition)pm.getProcessDefinition(initiationProcessDefinition);
					//approvalLineActivity = (HumanApprovalLineActivity)processDefinitionObject.getActivity(approvalLineActivityTT);

					String approvalLineUserCodes = getParameter(parameterMap, "userCode");
					String approvalLineUserNames = getParameter(parameterMap, "userName");
					String approvalLineUserJobPosition = getParameter(parameterMap, "userJobPosition");
					String approvalLineType = getParameter(parameterMap, "approveType");
					String approvalLinePreConfirm = getParameter(parameterMap, "preConfirm");

					String[] approvalInfoCodes = approvalLineUserCodes.split(";");
					String[] approvalInfoNames = approvalLineUserNames.split(";");
					String[] approvalInfoJobPosition = approvalLineUserJobPosition.split(";");
					String[] approvalInfoTypes = approvalLineType.split(";");
					String[] approvalInfoPreConfirm = approvalLinePreConfirm.split(";");

					//				결제 엑티비티가 로딩이 된 상태라면 기존에 approvalActivity를 초기화 시킨다.
					if (loadApprovealActivities) {

						List appActList = approvalLineActivity.getChildActivities();
						List removeTargetActivity = new ArrayList();
						//String draftActivityTT  = ""+(Integer.parseInt(approvalLineActivityTT)+1);
						String draftActivityTT = approvalLineActivity.getDraftActivity().getTracingTag();
						int j = 0;
						for (int i = 0; i < appActList.size(); i++) {
							Activity act = (Activity) appActList.get(i);
							if (!act.getTracingTag().equals(draftActivityTT)) {
								//approvalLineActivity.removeChildActivity(act);
								removeTargetActivity.add(j, act.getTracingTag());
								j++;
							}
						}

						for (int k = 0; k < removeTargetActivity.size(); k++) {
							approvalLineActivity.removeChildActivity(processDefinitionObject.getActivity((String) removeTargetActivity.get(k)));
						}
					}

					String preType = null;
					ComplexActivity parent = approvalLineActivity;

					// 결재선의 Loop 옵션이 true이고 반송되어서 draft 단계로 액티비티가 진행되었다면
					// 기안(상신)을 추가 시키지 않아야 하기에 i는 1부터 시작하도록한다.
					// 이에 따라 결재선 지정할 때 1명 이상 벨리데이션 처리를 해야한다.
					for (int i = 1; i < approvalInfoCodes.length; i++) {
						String userName = approvalInfoNames[i];
						String endpoint = approvalInfoCodes[i];
						String userJobPosition = approvalInfoJobPosition[i];
						String approveType = approvalInfoTypes[i];
						String approvePreConfirm = approvalInfoPreConfirm[i];

						//							if("상신".equals(approveType)){
						//								continue;
						//							}

						HumanApprovalActivity approvalActivity = (HumanApprovalActivity) approvalLineActivity.getDraftActivity().clone();
						//							approvalActivity.setName(approveType + "(" + userJobPosition + ")" );
						approvalActivity.setName(approvalLineActivity.getDraftActivity().getName().getText() + " " + userJobPosition + " " + userName
								+ " (" + approveType + ")");
						approvalActivity.setTracingTag(null); //let it auto-generated
						approvalActivity.setRole(null);
						approvalActivity.setViewMode(true);

						//후결 설정
						approvalActivity.setNotificationWorkitem("후결".equals(approveType));
						//						if ("후결".equals(approveType)) {
						//							approvalActivity.setNotificationWorkitem(true);
						//						} else {
						//							approvalActivity.setNotificationWorkitem(false);
						//						}

						//전결 설정
						approvalActivity.setArbitraryApprovable("yes".equals(approvePreConfirm));
						//						if ("yes".equals(approvePreConfirm)) {
						//							approvalActivity.setArbitraryApprovable(true);
						//						} else {
						//							approvalActivity.setArbitraryApprovable(false);
						//						}

						//approvalActivity.setArbitraryApprovable();
						if (approvalActivity.getParameters() != null) {
							for (int j = 0; j < approvalActivity.getParameters().length; j++) {
								approvalActivity.getParameters()[j].setDirection(ParameterContext.DIRECTION_IN);
							}
						}
						RoleMapping approver = RoleMapping.create();
						approver.setEndpoint(endpoint);
						approver.fill(instance);

						if (!"동의".equals(preType) && "동의".equals(approveType)) {
							AllActivity allAct = new AllActivity();
							parent.addChildActivity(allAct);
							parent = allAct;
						} else if ("동의".equals(preType) && !"동의".equals(approveType)) {
							parent = approvalLineActivity;
						}

						parent.addChildActivity(approvalActivity);
						approvalActivity.setApprover(instance, approver);

						preType = approveType;
					}

					if (loadApprovealActivities)
						pm.changeProcessDefinition(processInstance, processDefinitionObject);

				} else if (!"DRAFT".equals(currentRunningActStatus)) {

					//상신단계라면 결재선을 초기화
					ProcessDefinition pdTemp = (ProcessDefinition) instance.getProcessDefinition().clone();
					HumanApprovalLineActivity alaTemp = (HumanApprovalLineActivity) pdTemp.getActivity(approvalLineActivityTT);
					Vector child = alaTemp.getChildActivities();

					if (child.size() > 1) {
						List removeTargetActivity = new ArrayList();
						for (int i = 1; i < child.size(); i++) {
							Activity act = (Activity) child.get(i);
							removeTargetActivity.add(act);
						}

						for (int i = 0; i < removeTargetActivity.size(); i++) {
							Activity act = (Activity) removeTargetActivity.get(i);
							alaTemp.removeChildActivity(act);
						}

						for (int i = 0; i < removeTargetActivity.size(); i++) {
							HumanApprovalActivity act = (HumanApprovalActivity) removeTargetActivity.get(i);
							HumanApprovalActivity clonedAct = (HumanApprovalActivity) act.clone();
							clonedAct.setTracingTag(null);
							clonedAct.setRole(null);
							RoleMapping approver = RoleMapping.create();
							approver.setEndpoint(act.getApprover(instance).getEndpoint());
							approver.fill(instance);
							alaTemp.addChildActivity(clonedAct);
							clonedAct.setApprover(instance, approver);
						}

						pm.changeProcessDefinition(processInstance, pdTemp);
					}
				}

				DAOFactory daoFactory = DAOFactory.getInstance(instance.getProcessTransactionContext());
				Calendar now = daoFactory.getNow();
				((org.uengine.kernel.EJBProcessInstance) instance).getProcessInstanceDAO().set("STARTEDDATE", new Timestamp(now.getTimeInMillis()));

				pm.completeWorkitem(processInstance, tracingTag, taskId, resultPayload);
				acs.saveComments(instance,"-","draft",tracingTag,loggedRoleMapping);

			} else if ("approve".equals(apprStat)) {

				//processDefinitionObject = pm.getProcessDefinition(initiationProcessDefinition);

				approvalLineActivityTT = getParameter(parameterMap, "approvalLineActivityTT");
				approvalLineActivity = (HumanApprovalLineActivity) processDefinitionObject.getActivity(approvalLineActivityTT);

				boolean changedApprovalLine = "yes".equals(getParameter(parameterMap, "changedApprovalLine"));

				if (changedApprovalLine) {
					ProcessDefinition clonedProcessDefinitionObject = (ProcessDefinition) processDefinitionObject.clone();

					approvalLineActivityTT = getParameter(parameterMap, "approvalLineActivityTT");
					approvalLineActivity = (HumanApprovalLineActivity) clonedProcessDefinitionObject.getActivity(approvalLineActivityTT);
					//processDefinitionObject = pm.getProcessDefinition(initiationProcessDefinition);
					String approvalLineUserCodes = getParameter(parameterMap, "userCode");
					String approvalLineUserNames = getParameter(parameterMap, "userName");
					String approvalLineUserJobPosition = getParameter(parameterMap, "userJobPosition");
					String approvalLineType = getParameter(parameterMap, "approveType");
					String approvalLinePreConfirm = getParameter(parameterMap, "preConfirm");

					String[] approvalInfoCodes = approvalLineUserCodes.split(";");
					String[] approvalInfoNames = approvalLineUserNames.split(";");
					String[] approvalInfoJobPosition = approvalLineUserJobPosition.split(";");
					String[] approvalInfoTypes = approvalLineType.split(";");
					String[] approvalInfoPreConfirm = approvalLinePreConfirm.split(";");

					List appActList = approvalLineActivity.getChildActivities();
					List removeTargetActivity = new ArrayList();
					String draftActivityTT = approvalLineActivity.getDraftActivity().getTracingTag();
					int j = 0;
					for (int i = 0; i < appActList.size(); i++) {
						if ( appActList.get(i) instanceof HumanApprovalActivity ){
							HumanApprovalActivity act = (HumanApprovalActivity) appActList.get(i);
							if (!Activity.STATUS_RUNNING.equals(act.getStatus(instance)) && !Activity.STATUS_COMPLETED.equals(act.getStatus(instance))) {
								removeTargetActivity.add(j, act.getTracingTag());
								j++;
							}
						} else if ( appActList.get(i) instanceof AllActivity ) {
							AllActivity act = (AllActivity) appActList.get(i);
							if (!Activity.STATUS_RUNNING.equals(act.getStatus(instance)) && !Activity.STATUS_COMPLETED.equals(act.getStatus(instance))) {
								removeTargetActivity.add(j, act.getTracingTag());
								j++;
							}
						}
					}

					for (int k = 0; k < removeTargetActivity.size(); k++) {
						approvalLineActivity.removeChildActivity(clonedProcessDefinitionObject.getActivity((String) removeTargetActivity.get(k)));
					}

					int addActSize = approvalInfoCodes.length - appActList.size();
					int currentSize = appActList.size();
					String preType = null;
					AllActivity preParent = null;
					
					for (int addIdx = 0; addIdx < addActSize; addIdx++) {
						
						int arrayIndex = currentSize + addIdx;

						ComplexActivity parent = approvalLineActivity;
						HumanApprovalActivity approvalActivity = (HumanApprovalActivity) approvalLineActivity.getDraftActivity().clone();
						approvalActivity.setName(approvalLineActivity.getDraftActivity().getName().getText() + " "
								+ approvalInfoJobPosition[arrayIndex] + " " + approvalInfoNames[arrayIndex] + " (" + approvalInfoTypes[arrayIndex]
								+ ")");
						approvalActivity.setTracingTag(null); //let it auto-generated
						approvalActivity.setRole(null);
						approvalActivity.setViewMode(true);

						//후결 설정
						if ("후결".equals(approvalInfoTypes[arrayIndex])) {
							approvalActivity.setNotificationWorkitem(true);
						} else {
							approvalActivity.setNotificationWorkitem(false);
						}

						//전결 설정
						approvalActivity.setArbitraryApprovable(false);

						if (approvalActivity.getParameters() != null) {
							for (int p = 0; p < approvalActivity.getParameters().length; p++) {
								approvalActivity.getParameters()[p].setDirection(ParameterContext.DIRECTION_IN);
							}
						}
						RoleMapping approver = RoleMapping.create();
						approver.setEndpoint(approvalInfoCodes[arrayIndex]);
						approver.fill(instance);
						
						String approveType = approvalInfoTypes[arrayIndex];
						
						if (!"동의".equals(preType) && "동의".equals(approveType)) {
							AllActivity allAct = new AllActivity();
							parent.addChildActivity(allAct);
							parent = allAct;
							preParent = allAct;
//System.out.println("============ [1]parent : " + parent.toString());
						} else if ("동의".equals(preType) && !"동의".equals(approveType)) {
							parent = approvalLineActivity;
//System.out.println("============ [2]parent : " + parent.toString());
						} else if ("동의".equals(preType) && "동의".equals(approveType)) {
							parent = preParent;
//System.out.println("============ [3]parent : " + parent.toString());
						}
						
//System.out.println("============ [4]parent : " + parent.toString());
						parent.addChildActivity(approvalActivity);
						approvalActivity.setApprover(instance, approver);
						
						preType = approveType;
					}
					pm.changeProcessDefinition(processInstance, clonedProcessDefinitionObject);
				}

				((HumanApprovalActivity) processDefinitionObject.getActivity(tracingTag)).setApprovalStatus(pm.getProcessInstance(processInstance),
						ApprovalActivity.SIGN_APPROVED);
				pm.completeWorkitem(processInstance, tracingTag, taskId, resultPayload);

				//System.out.println("------------- 승인완료 후 의견 저장기능 --------------");

				String comment = request.getParameter("approvalComment");

				if (UEngineUtil.isNotEmpty(comment)) {
					acs.saveComments(instance,comment,"approved",tracingTag,loggedRoleMapping);
				}
			} else if ("arbitraryApprove".equals(apprStat)) {
				((HumanApprovalActivity) processDefinitionObject.getActivity(tracingTag)).arbitraryApprove(pm.getProcessInstance(processInstance));
			} else if ("reject".equals(apprStat)) {
				((HumanApprovalActivity) processDefinitionObject.getActivity(tracingTag)).rejectApprove(pm.getProcessInstance(processInstance));
				String comment = request.getParameter("approvalComment");

				if (UEngineUtil.isNotEmpty(comment)) {
					acs.saveComments(instance,comment,apprStat,tracingTag,loggedRoleMapping);
				}
			}
		}
		
		if (GlobalContext.logLevelIsDebug && pm instanceof ProcessManagerBean) {
			ProcessManagerBean pmb = (ProcessManagerBean) pm;
			StringBuilder debugInfo = pmb.getTransactionContext().getDebugInfo();
%>

<textarea rows="80" cols="150"><%=debugInfo%></textarea>
<br />
<br />

<%
	}
%>
<form name="submitResultFrm" target="_top" method="post" action="<%=GlobalContext.WEB_CONTEXT_ROOT %>/wih/approvalHandlers/submitResult.jsp">
<input type="hidden" name="saveOnly" value="<%=saveOnly%>" /> 
<input type="hidden" name="processInstance" value="<%=processInstance%>" /> 
<input type="hidden" name="taskId" value="<%=taskId%>" />
<input type="hidden" name="tracingTag" value="<%=tracingTag%>" /> 
<input type="hidden" name="nextAct" value="<%//=nextAct%>" /> 
<input type="hidden" name="nextWorkerRM" value="<%//=nextWorkerRM%>" />
</form>

<script>
	function sendResultPage(){
		document.submitResultFrm.submit();
	}
	
<%if (!isExtInitiate) {%>
	function leftSetCount(){
		try{
			top.frames['left'].getCount();
		}catch(err){}
	}
	leftSetCount();
	sendResultPage();
<%} else {%>
	alert("업무가 정상 처리 되었습니다.\n 보고 계시는 창을 닫습니다.")
	self.opener=self;
	self.close();

<%}%>
</script>
<%
	// 2009-08-07 add start
		String InstanceName = decode(getParameter(parameterMap, "name"));
		//add end

		//2009-08-10 set Instance Name
		if (InstanceName != null && InstanceName.trim().length() > 0)
			instance.setName(InstanceName);

		pm.applyChanges();
	} catch (Throwable e) {
		e.printStackTrace();
		try {
			pm.cancelChanges();
			pm.remove();
		} catch (Exception ex) {
		}

		throw e;
	} finally {
		try {
			pm.remove();
		} catch (Exception excep) {
		}
	}
%>

</body>
</html>