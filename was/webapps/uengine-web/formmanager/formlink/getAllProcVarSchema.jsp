<?xml version="1.0" encoding="UTF-8"?>
<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/xml; charset=UTF-8");%>
<%@include file="../../../common/no_cache.jsp"%>
<%@include file="../../../common/commons.jsp"%>
<%@page import="hanwha.bpm.form.schema.ProcessVariableSchemaGenerator"%>
<%
	String definitionId = request.getParameter("definitionId");

	DefaultTransactionContext dtc = new DefaultTransactionContext();
	try {
		dtc.setConnectective(true);
		ProcessVariableSchemaGenerator gen = ProcessVariableSchemaGenerator.getInstance(dtc);
		String procVarSchema = gen.getAllXMLSchema(definitionId);
		out.println(procVarSchema);
		System.out.println("-------------------- : " + procVarSchema);
	} catch (Exception e) {
		throw e;
	} finally {
		dtc.close();
	}
%>
