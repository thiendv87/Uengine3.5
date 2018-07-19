<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/html; charset=UTF-8");%>
<%@include file="../../common/no_cache.jsp"%>
<%@include file="../../common/commons.jsp"%>
<%@page import="hanwha.bpm.form.business.FormBusinessFacade"%>
<%
	RequestContext reqCtx = new RequestContext(request);
	FormBusinessFacade formBF = new FormBusinessFacade(reqCtx);

	String processDefinition = request.getParameter("processDefinition");	
	String processDefinitionName = GWUtil.toEncode(request.getParameter("processDefinitionName"));	
	String formId = request.getParameter("formId");	
	System.out.println("setProcessDefinition start============");
	System.out.println("processDefinition : " + processDefinition);
	System.out.println("processDefinitionName : " + processDefinitionName);
	System.out.println("formId : " + formId);

	String resultMsg = "���������� ���� �Ǿ����ϴ�.";
	
	if ( formId == null ) {
		resultMsg = "���ῡ �����Ͽ����ϴ�.";
	} else {
		try {
			// ���μ��� ���� ���� ����.
			formBF.updateFormProcdefid(Long.parseLong(processDefinition),Long.parseLong(formId));
		} catch(Exception e) {
			e.printStackTrace();
			resultMsg = "���ῡ �����Ͽ����ϴ�.";
		}
	}
	System.out.println("resultMsg=["+resultMsg+"]");
	System.out.println("setProcessDefinition end============");
%>
<html>
<head>
<script language="JavaScript">
	function resultMsg(){
		//alert("<%=resultMsg%>");
		window.dialogArguments.setProcessDefinition('<%=processDefinitionName%>', '<%=processDefinition%>');
		window.close();
	}
</script>
</head>
<body onload="resultMsg();">
</body>
</html>