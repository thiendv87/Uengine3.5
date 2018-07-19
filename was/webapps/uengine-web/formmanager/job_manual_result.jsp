<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/html; charset=UTF-8");%>
<%@include file="../../common/no_cache.jsp"%>
<%@include file="../../common/commons.jsp"%>
<%@ taglib prefix="bpm" uri="http://hsnc.hanwha.co.kr/taglibs/bpm" %>
<%@page import="hanwha.bpm.form.business.FormBusinessFacade"%>
<%

	String action = request.getParameter("action");
	String formid = request.getParameter("formid");
	
	String jobmanualid = request.getParameter("jobmanualid");
	String[] jobmanualpath = request.getParameterValues("approvalAttachFile");
	String description = GWUtil.toEncode(request.getParameter("description"));
	
	String cnt = "0";
	if(jobmanualpath != null && jobmanualpath.length > 0 ){
		cnt = "1";
	}
		
	try {
		RequestContext reqCtx = new RequestContext(request);
		FormBusinessFacade formBF = new FormBusinessFacade(reqCtx);
		
		if ( action != null ) {
			
			if ( action.equals("ADD") ) {
				formBF.addJobManual(jobmanualpath, Long.parseLong(formid), description);
			} else if ( action.equals("MOD") ) {
				formBF.updateJobManual(Long.parseLong(jobmanualid), jobmanualpath, Long.parseLong(formid), description);
			}
		}
	} catch (Exception e) {
		e.printStackTrace(); 
//		resultMsg = "업데이트에 실패하였습니다.";
	}	

%>	
<html>
<head>
<script language="JavaScript">
	function resultMsg(){
		var cnt = "<%=cnt %>";
		window.dialogArguments.setJobManualProcess(cnt);
		window.close();
	}
</script>
</head>
<body onload="resultMsg();">
</body>
</html>