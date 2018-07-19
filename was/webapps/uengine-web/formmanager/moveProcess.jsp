<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/html; charset=UTF-8");%>
<%@include file="../../common/no_cache.jsp"%>
<%@include file="../../common/commons.jsp"%>
<%@page import="hanwha.bpm.form.business.FormBusinessFacade"%>

<link rel="stylesheet" type="text/css" href="<%=CSS%>/uengine.css">

<%
	RequestContext reqCtx = new RequestContext(request);
	FormBusinessFacade formBF = new FormBusinessFacade(reqCtx);

	String process_id = request.getParameter("process_id");
	String folder = request.getParameter("folder");
	String type = request.getParameter("type");

	if(type.equals("moveProc")){
		try {
			formBF.moveForm(Long.parseLong(folder), Long.parseLong(process_id));
		} catch (Exception e) {
			e.printStackTrace(); 
		}
//		sql = " update BPM_FORM set formbox="+folder+" where formid="+process_id;
	}else if(type.equals("moveGroup")){
		try {
			formBF.moveFolder(Long.parseLong(folder), Long.parseLong(process_id));
		} catch (Exception e) {
			e.printStackTrace(); 
		}
//		sql = " update bpm_form_box set parentformboxid="+folder+" where formboxid="+process_id;
	}
%>
<%=process_id%>/<%=folder%>
<script>
	parent.document.moveProcessForm.type.value = "";
	parent.document.location.reload();
</script>