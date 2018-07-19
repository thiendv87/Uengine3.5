<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	String taskid = request.getParameter("taskId");
	String instid = request.getParameter("instanceId");
	String trctag = request.getParameter("tracingTag");
	String docStandardNumber = "";
%>
<%
    //request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");
%>

<%@page import="org.uengine.contexts.HtmlFormContext" %>
<%@page import="org.uengine.contexts.MappingContext" %>
<%@page import="org.uengine.formmanager.FormUtil" %>
<%@page import="org.uengine.util.*" %>

<%@include file="../wihDefaultTemplate/header.jsp"%>
<%@include file="../wihDefaultTemplate/initialize.jsp"%>
<style media="print">
.noprint     { display: none }
</style>
<LINK rel="stylesheet" href="../../style/docForm.css" type="text/css"/>
<script language="javascript">
<%@include file="../../scripts/formActivity.js.jsp"%>
function createRequest(){		
	try {
		request = new XMLHttpRequest();
	} catch (trymicrosoft) {
		try {
			request = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (othermicrosoft) {
			try {
			  request = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (failed) {
			  request = false;
			}
		}
	}	
	if(!request)
		alert("Error initializing");
}

function updatePage(){
	if (request.readyState == 4){
	  if (request.status == 404){
			alert("Request URL does not exist");
		}else{
			alert("Error: status code is " + request.status);
		}
	}
}		

function setPrintedLog() {
	createRequest();
	//alert("<%=GlobalContext.WEB_CONTEXT_ROOT %>/common/printlog.jsp?taskid=<%=taskid%>&instid=<%=instid%>&trctag=<%=trctag%>");		
	request.open("GET","<%=GlobalContext.WEB_CONTEXT_ROOT %>/common/print/printlog.jsp?taskid=<%=taskid%>&instid=<%=instid%>&trctag=<%=trctag%>" ,true);
	//request.onreadystatechange = updatePage;
	request.send(null);
}
	
function setDefault() {
   factory.printing.header = "FXK INTERNAL USE ONLY"
   factory.printing.footer = docStandardNumber;		//문서 번호
   factory.printing.portrait = true              //true 세로 , false 가로
   factory.printing.leftMargin = 5
   factory.printing.topMargin = 5
   factory.printing.rightMargin = 5
   factory.printing.bottomMargin = 5
}
 
function Print(prompt, frame) {
  // Print 첫번째 파라메터는 프린트 대화상자를 표시할 것인지 여부 설정한다. 
  //       - false로 되어있는 경우기본 프린터로 바로 출력한다. 
  //       두번째 파라메터는 전체 HTML 페이지를 인쇄할 것인지  특정 프레임만 출력할 것인지를 설정한다
 SpoolStatus(true);
 factory.printing.Print(prompt, frame);
 SpoolStatus(false);
 setPrintedLog();
}

function pageSetup() {
 factory.printing.PageSetup();
}
function Preview()
{
//  PutSettings();
  factory.printing.Preview();
}
function SpoolStatus(start) {
  // provide some visual feedback on spooling status
  if ( start ) {
    // update status bar
    window.status = idWait.innerText;
    // pop up hidden DIV with spooling status
    var width = document.body.clientWidth/3;
    var height = document.body.clientHeight/4;
    idWait.style.pixelWidth = width;
    idWait.style.pixelHeight = height/2;
    idWait.style.pixelLeft = document.body.scrollLeft + width;
    idWait.style.pixelTop = document.body.scrollTop + height/2;
    idWait.style.visibility = "visible";
  }
  else {
    window.status = "Spooling is complete";
    idWait.style.visibility = "hidden";
  }
}
</script>
<script type="text/javascript" src="../../scripts/lib.validate.js"></script>
<script type="text/javascript" src="../../scripts/Calendar_iFrame.js"></script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="setDefault();">
<object id="factory" viewastext  style="display:none"
  classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"
  codebase="<%=GlobalContext.WEB_CONTEXT_ROOT %>/common/print/smsx.cab#Version=6,3,435,20">
</object>
<span id="idControls" class="noprint">
<table width="100%" cellpadding=0 cellspacing=0 border=0>
<tr><td>
<img src="../../images/btn/btn4_07.gif" onClick="pageSetup();" border=0 style="cursor:hand">
<img src="../../images/btn/btn2_11.gif" onClick="Print(false, window);" border=0 style="cursor:hand">
<img src="../../images/btn/btn4_06.gif" onClick="Preview();" border=0 style="cursor:hand">
</td></tr>
</table>
</span>
<form name="mainForm" action="submit.jsp" method="POST" onsubmit="return checkForm(this);">

<%
	//------------- declaration & initialize -------------------//

	try{
	isMine = initiate || "yes".equals(request.getParameter("isMine"));
	ProcessInstance instance = piRemote;
	
	ProcessDefinition procDef = null;
	if(initiate) procDef = (ProcessDefinition)pm.getProcessDefinition(initiationProcessDefinition);
	else procDef = piRemote.getProcessDefinition();
	
	FormActivity formActivity = (FormActivity)procDef.getActivity(tracingTag);
	boolean isCompleted  ="Completed".equals( formActivity.getStatus(instance));
	NavienFormApprovalActivity approvalActivity = (NavienFormApprovalActivity)procDef.getActivity(tracingTag);
	
	
	HtmlFormContext formContext = initiate ? (HtmlFormContext)(formActivity.getVariableForHtmlFormContext().getDefaultValue()) : (HtmlFormContext)(formActivity.getVariableForHtmlFormContext().get(instance, ""));
	String formDefId = formContext.getFormDefId();
	
	if(instance!=null)
		request.setAttribute("instance", instance);
	if(pm!=null)
		request.setAttribute("pm", pm);
	if(formActivity!=null)
		request.setAttribute("formActivity", formActivity);
	if(loggedRoleMapping!=null)
		request.setAttribute("loggedRoleMapping", loggedRoleMapping);
	
	final Map mappedResult = formActivity.getMappedResult(instance);
	System.out.println("mappedResult="+mappedResult);
	request.setAttribute("mappingResult", mappedResult);
	
	String isCopyInitiate = decode(request.getParameter("isCopyInitiate"));
	String fckEditorContents = decode(request.getParameter("fckEditorContents"));
	
	if("yes".equals(isCopyInitiate)){
		mappedResult.put("fckeditor1",fckEditorContents);
	}
	
	String[] defIdAndVersionId = formDefId.split("@");
	String currProductionFormDefId = pm.getProcessDefinitionProductionVersion(defIdAndVersionId[0]);// + "_write.jsp"; 
	String formFileName = currProductionFormDefId;
	
//	System.out.println("getId : " + procDef.getId());
//	System.out.println("getBelongingDefinitionId : " + procDef.getBelongingDefinitionId());

	ActivityForLoop loopForWritingStatus = new ActivityForLoop(){
		public void logic(Activity act){
	if(act instanceof SwitchActivity ){
		setReturnValue((boolean)true);
	}
		}
	};
	
	loopForWritingStatus.run(procDef);
	Object isSwitchActivityExist = loopForWritingStatus.getReturnValue();
	if(isSwitchActivityExist==null){
		isSwitchActivityExist = false;
	}
	
//------------- pass values to submit.jsp -------------------//
%>	
<div id=idWait class=noprint style="visibility: hidden; position: absolute; left: 0px; top: 0px; width: 0px; height: 0px; background-color: lightyellow; color: darkred; font:bold 11pt Arial; border: thin inset threedface; padding: 40pt">
  <center><b><font size=4>인쇄중......</font></b></center>
</div>
<%@include file="../wihDefaultTemplate/passValues.jsp"%>
<%
	String approvalLineActivityTT = request.getParameter("approvalLineActivityTT");

NavienFormApprovalLineActivity formApprovalLineActivity = (NavienFormApprovalLineActivity)procDef.getActivity(approvalLineActivityTT);
NavienFormApprovalActivity draftActivity = formApprovalLineActivity.getDraftActivity();
boolean isLastApprove = false;
boolean isDraftActivity = tracingTag.equals(draftActivity.getTracingTag());
StringBuffer approverHtml = new StringBuffer();

Vector vChildActivities = null;
List approverList = new ArrayList();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String approveDate = null;
String rejectTracingTag = null;
//System.out.println("---------------------"+tracingTag);
//System.out.println("---------------------"+draftActivity.getTracingTag());
String requester = request.getParameter("requester") == null? "" :decode(request.getParameter("requester"));
String form_name = request.getParameter("form_name") == null? "" :decode(request.getParameter("form_name"));
%>

<!-- BODY START -->
<TABLE width="100%" cellpadding="0" cellspacing="0" border="0">
<TR>
<TD>
	<TABLE cellpadding="0" cellspacing="0" border="0" width="100%">
	<TR>
		<TD><div>
<%

	out.flush();
	
	boolean wasIsJBoss = "JBOSS".equals(GlobalContext.getPropertyString("was.type", "TOMCAT"));

	String cachedFormRoot = (wasIsJBoss ? GlobalContext.WEB_CONTEXT_ROOT : "") + "/wih/formHandler/cachedForms/";
	File contextDir = new File(request.getRealPath(cachedFormRoot));
	
	FormUtil.copyToContext(contextDir, formFileName);
	
	System.out.println("isCompleted="+isCompleted);
	System.out.println("isDraftActivity="+isDraftActivity);
	System.out.println("pm.getActivityStatus(instanceId, tracingTag)="+pm.getActivityStatus(instanceId, tracingTag));
	
	RequestDispatcher rdIncludeAction = request.getRequestDispatcher(cachedFormRoot+formFileName+"_formview.jsp");
	rdIncludeAction.include(request, response);
	
	out.println("<script>");
	out.println("try{");
	out.println("  setDisappearImages();");
	out.println("}catch(err){}");
	out.println("</script>");
	out.println("<style>div img {visibility:hidden;}</style>");
	
	
	out.flush();
%>
		</div></TD>
	</TR>
	</TABLE>
	<!-- Form Dispatch Part END -->
	
	</TD>
</TR>
<TR>
  <TD align="center">
	<TABLE cellpadding="0" cellspacing="0" border="0" width="100%">
		<TR>
			<TD>
				<%@include file="./inc_approvalLine.jsp"%>
			</TD>
		</TR>
	</TABLE>
  </TD>
</TR>
<tr><td height="5"></td></tr>
</TABLE>
<!-- BODY END -->

<%
	//문서 서식 번호 가져오기
	Connection conn = null;
	Statement stmt = null;
	StringBuffer sql = new StringBuffer();
	try{
		conn = instance.getProcessTransactionContext().getConnection();
		stmt 	=  conn.createStatement();

		sql.append(" select 'FXK-'||a.doc_type||'-'||b.category_no||b.subcategory_no||'-'||a.form_no	\n");
		sql.append(" from bpm_procdef a, doc_category b	\n");
		sql.append(" where a.prodverid="+ processDefinition +"	\n");
		sql.append(" and a.category_id=b.id	\n");
		
		ResultSet rs = stmt.executeQuery(sql.toString());
		
		if (rs.next()){
			docStandardNumber = rs.getString(1);
		}
		
		rs.close();
		
	}catch (Exception e){
		if ( stmt != null ) 	try { 	stmt.close();    } 				catch(Exception e1) {}
	}finally{
		if ( stmt != null ) 	try { 	stmt.close();    } 				catch(Exception e1) {}
	}
}finally{
	try{pm.cancelChanges();}catch(Exception ex){}
	try{pm.remove();}catch(Exception ex){}
}
%>
<script>
var docStandardNumber = "<%=docStandardNumber%>";
if(document.getElementById('FCKeditor1___Frame')){
	var val = document.getElementById('FCKeditor1').value;
	document.getElementById('FCKeditorView1').innerHTML=val;
	document.getElementById('FCKeditor1___Frame').style.display="none";
	if(document.body.scrollHeight<1080 && document.body.scrollWidth<850){
		document.getElementById("FCKeditorView1").style.height=1080-document.body.scrollHeight;
	}
}
</script>
