<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<%@page import="org.uengine.util.dao.*"%>
<%@page import="org.uengine.persistence.dao.*"%>
<%@page import="org.uengine.webservices.worklist.*"%>
<%@page import="org.uengine.ui.list.datamodel.DataMap"%>
<%@page import="org.uengine.ui.list.datamodel.DataList"%>
<%@page import="org.uengine.ui.list.datamodel.QueryCondition"%>
<%@page import="org.uengine.ui.list.util.HttpUtils"%>
<%@page import="org.uengine.kernel.viewer.gantt.GanttChartUtil" %>
<%@page import="com.defaultcompany.web.gantt.dao.GanttChartWebDAO" %>
<%--@page import="com.defaultcompany.web.strategy.StrategyService"--%>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<%
    String viewerType = reqMap.getString("viewerType", "day");
    String pdId = reqMap.getString("processDefinitionId", "");
    String pdName = reqMap.getString("processDefinitionName", "");
    String orderby = reqMap.getString("orderby", "instance");
    String endpoint = new String(reqMap.getString("endpoint", "").getBytes("ISO-8859-1"),"UTF-8");
    String endpoint_display= new String(reqMap.getString("endpoint_display", "").getBytes("ISO-8859-1"),"UTF-8");
    
    String strategyId = null;//reqMap.getString("strategyId", "-1");
    String isOnlyStrategyInstance = ServletRequestUtils.getStringParameter(request, "isOnlyStrategyInstance", "");
    
    // filter add start
    String status = reqMap.getString("status", "");
    String partCode = reqMap.getString("partCode", "");
    String roleCode = reqMap.getString("roleCode", "");
    //String tag = new String(reqMap.getString("tag", "").getBytes("ISO-8859-1"),"UTF-8");
    String tag = reqMap.getString("tag", "");
    String filter = reqMap.getString("filter", "");
    String filterName = reqMap.getString("filterName", "");
    // filter add end
    
    ProcessManagerRemote pm = processManagerFactory.getProcessManager();//ForReadOnly();
    if(isOnlyStrategyInstance.equals("on")){
        pdId = pm.getProcessDefinitionIdByAlias("delStrategy")+";"
           + pm.getProcessDefinitionIdByAlias("addStrategy")+";"
           + pm.getProcessDefinitionIdByAlias("editStrategy");
    }
    
    int intPageCnt = 10;
    int nPagesetSize = 10;
    int currentPage = reqMap.getInt("CURRENTPAGE", 1);
    int totalCount = 0; 
    
    int s_mondif = reqMap.getInt("mondif", -1);
    
    try{
        GanttChartWebDAO ganttChartWebDao = new GanttChartWebDAO(DefaultConnectionFactory.create());
        ganttChartWebDao.setStatus(status);
        ganttChartWebDao.setPartCode(partCode);
        ganttChartWebDao.setRoleCode(roleCode);
        ganttChartWebDao.setTag(tag);
        ganttChartWebDao.init(s_mondif, endpoint, pdId, loggedUserGlobalCom, orderby, loggedUserIsMaster,strategyId);
        totalCount = ganttChartWebDao.getGanttChartCount();
    }catch(Exception e){
        e.printStackTrace();
    }
    
    Calendar now = Calendar.getInstance();
    now.add(Calendar.YEAR, s_mondif+1); 
%>
<%@ taglib uri="http://www.uengine.org/taglibs/bpm" prefix="bpm" %>
<html>
<head>
<title><%=GlobalContext.getMessageForWeb("View the progress of the Instance", loggedUserLocale) %></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../lib/jquery/importJquery.jsp" %>
<%@include file="../common/styleHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/ganttchart.css" />
<style type="text/css" rel="stylesheet">
    a:link {color:#000;}
    html body {
        margin: 10px;
    }
</style>
<!-- CSS Files -->
<jsp:include page="../scripts/formActivity.js.jsp" flush="false">
    <jsp:param name="rmClsName" value="<%=rmClsName%>" />
</jsp:include>

<script type="text/javascript">
$(document).ready(function() {
	getGanttCharTitleList("<%=pdId%>","<%=s_mondif%>","<%=orderby%>","<%=endpoint%>","<%=currentPage %>","<%=strategyId %>","<%=intPageCnt %>", "<%=status%>", "<%=partCode%>", "<%=roleCode%>", "<%=tag%>");
	listViewer("<%=viewerType%>");
});

function searchGo( i ) {
	document.refreshForm.mondif.value='<%=(s_mondif)%>'*1 + i;
	document.refreshForm.CURRENTPAGE.value=1;
	document.refreshForm.submit();
}

function selectProcess() {
	var url = "../processparticipant/commonfilter/selectProcessDefinition_frame.jsp";
	var strOption = "width=500,height=300";
	strOption += "center:on;scroll:no;status:off;resizable:no";
	var arrResult = new Array(2);
	arrResult = window.open(url , "", strOption);
}
	
function setProcess(processDefinition, processDefName) {
	$("input[name=processDefValue]").val(processDefinition);
	$("input[name=processDefName]").val(processDefName);
}
	
function search() {
	var processDefValue = document.getElementsByName("processDefValue")[0];
	var displayEndpoints_display = document.getElementsByName("displayEndpoints_display")[0];
	var endpoints=document.getElementsByName("displayEndpoints")[0];

	if (displayEndpoints_display.value != ""){
		document.refreshForm.endpoint.value = endpoints.value;
		document.refreshForm.endpoint_display.value=displayEndpoints_display.value;
	} else {
		document.refreshForm.endpoint.value = "";
        document.refreshForm.endpoint_display.value = "";
	}
	
	if (processDefValue.value != ""){
		document.refreshForm.processDefinitionId.value = $("input[name=processDefValue]").val();
		document.refreshForm.processDefinitionName.value = $("input[name=processDefName]").val();
	} else {
		document.refreshForm.processDefinitionId.value = "";
		document.refreshForm.processDefinitionName.value = "";
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


function animateDiv(target,widthStr){
    $(target).animate( { width:widthStr }, { queue:false, duration:200 } )
        .animate( { fontSize:"24px" }, 2000 )
        .animate( { borderRightWidth:"15px" }, 2000);
}

function listViewer(type){
	$("#viewerType").val(type);
	if(type=="day"){			
		document.getElementById("day").style.backgroundImage = "url(../images/Common/tabOn.gif)";
		document.getElementById("week").style.backgroundImage = "url(../images/Common/tabOff.gif)";
		document.getElementById("month").style.backgroundImage = "url(../images/Common/tabOff.gif)";
		getGanttCharList('<%=pdId%>','<%=s_mondif%>','<%=orderby%>','<%=endpoint%>','<%=currentPage %>','<%=strategyId%>','day','<%=intPageCnt %>', "<%=status%>", "<%=partCode%>", "<%=roleCode%>", "<%=tag%>");
		
	}else if(type=="week"){
		document.getElementById("day").style.backgroundImage = "url(../images/Common/tabOff.gif)";
		document.getElementById("week").style.backgroundImage = "url(../images/Common/tabOn.gif)";
		document.getElementById("month").style.backgroundImage = "url(../images/Common/tabOff.gif)";
		getGanttCharList('<%=pdId%>','<%=s_mondif%>','<%=orderby%>','<%=endpoint%>','<%=currentPage %>','<%=strategyId%>','week','<%=intPageCnt %>', "<%=status%>", "<%=partCode%>", "<%=roleCode%>", "<%=tag%>");
	}else{
		document.getElementById("day").style.backgroundImage = "url(../images/Common/tabOff.gif)";
		document.getElementById("week").style.backgroundImage = "url(../images/Common/tabOff.gif)";
		document.getElementById("month").style.backgroundImage = "url(../images/Common/tabOn.gif)";
		getGanttCharList('<%=pdId%>','<%=s_mondif%>','<%=orderby%>','<%=endpoint%>','<%=currentPage %>','<%=strategyId%>','month','<%=intPageCnt %>', "<%=status%>", "<%=partCode%>", "<%=roleCode%>", "<%=tag%>");
	}
}
	
function getGanttCharTitleList(
		tempProcessDefinition,
		tempMondif,
		tempOrderby,
		tempEndpoint,
		tempCURRENTPAGE,
		tempStrategyId,
		tempPageCount,
		tempStatus,
		tempPartCode,
		tempRoleCode,
		tempTag
) {
	$.post(
			"<%=GlobalContext.WEB_CONTEXT_ROOT%>/ganttChartService",
			{
				"ProcessDefinition" : tempProcessDefinition,
				"viewYear"          : tempMondif,
				"Orderby"           : tempOrderby,
				"Endpoint"          : tempEndpoint,
				"CURRENTPAGE"       : tempCURRENTPAGE,
				"strategyId"		: tempStrategyId,
				"type"              : "title",
				"intPageCnt"        : tempPageCount,
				"status"            : tempStatus,
				"partCode"          : tempPartCode,
				"roleCode"          : tempRoleCode,
				"tag"               : tempTag

			},
			function(resultString) {	
				//drawProcessFlowchart(resultString, tmpViewOption, tmpInstanceId, tmpProcessDefinition, tmpDefinitionVersionId);
				var divChartArea = document.getElementById("ganttChartTitleArea");
				divChartArea.innerHTML = resultString;
			}
	);
}
	
function getGanttCharList(
		tempProcessDefinition,
		tempMondif,
		tempOrderby,
		tempEndpoint,
		tempCURRENTPAGE,
		tempStrategyId,
		viewMode,
		tempPageCount,
		tempStatus,
        tempPartCode,
        tempRoleCode,
        tempTag
	) {
	$.post(
		"<%=GlobalContext.WEB_CONTEXT_ROOT%>/ganttChartService",
		{
			"ProcessDefinition" : tempProcessDefinition,
			"viewYear"          : tempMondif,
			"Orderby"           : tempOrderby,
			"Endpoint"          : tempEndpoint,
			"CURRENTPAGE"       : tempCURRENTPAGE,
			"strategyId"		: tempStrategyId,
			"type"              : "list",
			"viewMode"          : viewMode,
			"intPageCnt"        : tempPageCount,
			"status"            : tempStatus,
            "partCode"          : tempPartCode,
            "roleCode"          : tempRoleCode,
            "tag"               : tempTag
		},				
		function(resultString) {
			var widthTemp=document.getElementById("ganttListParent");					
			var divChartArea = document.getElementById("idsu_map");					
			divChartArea.innerHTML = resultString;							
			
			document.getElementById("curBarDiv").style.height=document.getElementById("ganttListParent").offsetHeight-1;
			
			if (viewMode != "month") {
				$("#ganttable").draggable({                                          
				    axis: "x",
				    containment:  [-6540, 0, 460, 0] // x1, y1, x2, y2 (1:start, 2:end)
				});
				$("#ganttChartTitleArea").css("margin-right:1px;");
			} else {
				$("#ganttChartTitleArea").css("");
			}
		}
	);
}
</script>
</head>

<body>
<form name="form" method="get" action="" target="">
<%
if (filter.equals("yes")) {
%>
    <span class="sectiontitle"><b>Filter Name : <%=filterName %></b></span>
    <table width="100%" border="0" cellpadding="0"  cellspacing="0" >
       <colgroup>
           <col width="9%"/>
           <col width="9%"/>
           <col width="9%"/>
           <col width="18%"/>
           <col width="9%"/>
           <col width="9%"/>
           <col width="9%"/>
           <col width="9%"/>
           <col width="9%"/>
           <col width="*"/>
       </colgroup>
        <tr>
             <td  colspan="10" bgcolor="#97aac6" height="2"></td>
        </tr>
        <tr>
            <td class="formtitle">Status</td>
            <td class="formcon">
                <%=status %>
            </td>
            <td class="formtitle">Definition</td>
            <td class="formcon">
                <%=pdName %>
            </td>
            <td class="formtitle">Part Code</td>
            <td class="formcon">
                <%=partCode %>
            </td>
            <td class="formtitle">Role Code</td>
            <td class="formcon">
                <%=roleCode %>
            </td>
            <td class="formtitle">Tag</td>
            <td class="formcon">
                <%=tag %>
            </td>
        </tr>
        <tr>
             <td  colspan="10" bgcolor="#97aac6" height="2"></td>
        </tr>
    </table>
<%
} else {
%>
	<table width="100%" border="0" cellpadding="0"  cellspacing="0" >
	   <colgroup>
		   <col width="15%"/>
		   <col width="30%"/>
		   <col width="15%"/>
		   <col width="30%"/>
		   <col width="*"/>
	   </colgroup>
	    <tr>
	         <td  colspan="5" bgcolor="#97aac6" height="2"></td>
	    </tr>
	    <tr>
	        <td class="formtitle"><%=GlobalContext.getMessageForWeb("gantt_select_user", loggedUserLocale) %></td>
	        <td class="formcon">
	            <input type="hidden" name="displayEndpoints__which_is_xml_value" id="displayEndpoints__which_is_xml_value" />
	            <input type="hidden" name="displayEndpoints" id="displayEndpoints" />
	        	<input type="text" name="displayEndpoints_display" id="displayEndpoints_display" value='<%=endpoint_display%>' style="border:#CCC 1px solid;background:#F3F3F3;" readonly="readonly"/>
				<img name="displayEndpoints" style="cursor:pointer;" align="middle"
					src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/Toolbar-toblock.gif" onclick="searchPeopleObj(this, true);" title="endpointer select" />
			</td>
	        <td class="formtitle" style="width:250px;"><%=GlobalContext.getMessageForWeb("gantt_select_definition", loggedUserLocale) %></td>
	        <td class="formcon">	
	            <input type="text" name="processDefName" id="processDefName" value='<%=pdName%>' style="border:#CCC 1px solid;background:#F3F3F3;" readonly="readonly"/>
				<input type="hidden" name="processDefValue" id="processDefValue" value='<%=pdId%>' />
				<img align="middle" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/images/Toolbar-toblock.gif" onclick="selectProcess();" style="cursor: pointer;" title="definition select" />
			</td>
			<td class="formcon" width="100" align="right">
	            <table>
	                <tr>
	                    <td class="gBtn">
	                        <a href="javascript:search()" >
	                        	<span><%=GlobalContext.getMessageForWeb("search", loggedUserLocale) %></span>
	                        </a>
	                    </td>
	                </tr>
	            </table>
	
			</td>
	    </tr>
	    <tr>
	         <td  colspan="5" bgcolor="#97aac6" height="2"></td>
	    </tr>
	</table>
<%
}
%>
</form>
	
<br />
	
<table width="100%" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td>
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                 <tr>
                     <td><span onClick="searchGo(-1);" style="cursor: pointer;"><img src="../images/Common/skip-back.gif" border="0"></span>
                        <span style="font-size:18px; font-weight:bold; line-height:16px; letter-spacing:-1;"><%=String.valueOf(now.get(Calendar.YEAR)) %></span>
                        <span onClick="searchGo(+1);" style="cursor: pointer;"><img src="../images/Common/skip.gif" border="0"></span></td>         
                 </tr>
            </table>
       	</td>
       	<td align="right">
       	    <table width="100%" cellspacing="0" cellpadding="0" border="0">
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
			                    <td width=10 height=10 ><img src="../processmanager/images/ganttbar_redBall.gif"></td>
                                <td style="font-size:11px;"><%=GlobalContext.getLocalizedMessageForWeb("Cancelled_Working", loggedUserLocale, "Cancelled Working")%></td>
			                </tr>
			            </table>
			        </td>
			    </tr>
			</table>
       	</td>
		<td align="right">
			<table>
				<tr>
					<td width="96" height="23" id="day" style="background:url(../images/Common/tabOff.gif) no-repeat;cursor:pointer;" onclick="listViewer('day');" align="center"><b>day</b></td>
					<td width="96" height="23" id="week" style="background:url(../images/Common/tabOn.gif) no-repeat;cursor:pointer;" onclick="listViewer('week');" align="center"><b>week</b></td>
					<td width="96" height="23" id="month" style="background:url(../images/Common/tabOff.gif) no-repeat;cursor:pointer;" onclick="listViewer('month');" align="center"><b>month</b></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
	
<!-- Gantt Chart Start -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <colgroup>
        <col width="450px"/>
        <col width="1200px"/>
    </colgroup>
	<tr>
		<td>				
			<div id="ganttChartTitleArea"></div>
		</td>
		<td valign="top" id="ganttListParent">
			<div style="position:relative; width:100%;">
				<div id="idsu_map" style="position:absolute;left:0px;overflow:hidden;cursor:move;width:100%;">
					<!-- div id="ganttChartArea"></div-->
				</div>
			</div>
		</td>
	</tr>
</table>
<!-- Gantt Chart End -->

<br />

<table width="100%" cellspacing="0" cellpadding="0" border="0">
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
					<td width=10 height=10 ><img src="../processmanager/images/ganttbar_redBall.gif"></td>
                    <td style="font-size:11px;"><%=GlobalContext.getLocalizedMessageForWeb("Cancelled_Working", loggedUserLocale, "Cancelled Working")%></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<br />
<!--    #####   Navigation start        #####   -->
<table width="100%">
	<tr>
		<td align="center">
		    <br style="line-height: 15px;" />
			<bpm:page link="" totalcount="<%=totalCount%>" pagecount="<%=intPageCnt%>" pagelimit="<%=nPagesetSize%>"
			currentpage="<%=currentPage%>" locale="<%=loggedUserLocale%>" />
			<br />
		</td>
	</tr>
</table>
<form name="refreshForm" method="post" action="./ganttChart.jsp" target="">
	<input type="hidden" name="processDefinitionId" value="<%=pdId%>"/>
	<input type="hidden" name="processDefinitionName" value="<%=pdName%>"/>
	<input type="hidden" name="mondif" value="<%=s_mondif%>"/>
	<input type="hidden" name="orderby" value="<%=orderby%>"/>
	<input type="hidden" name="endpoint" value="<%=endpoint%>"/>
	<input type="hidden" name="endpoint_display" value="<%=endpoint_display%>"/>
	<input type="hidden" name="CURRENTPAGE" value="<%=currentPage %>" />
	<input type="hidden" name="viewerType" id="viewerType" value="<%=viewerType %>" />
</form>
</body>
</html>