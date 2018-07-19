<?xml version="1.0" encoding="UTF-8"?>
<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/xml; charset=UTF-8");%>
<%@include file="../../../common/no_cache.jsp"%>
<%@include file="../../../common/commons.jsp"%>
<%@page import="hanwha.bpm.form.schema.FormSchemaGenerator"%>
<%
	String formVerId = request.getParameter("formVerId");

	DefaultTransactionContext dtc = new DefaultTransactionContext();
	try {
		dtc.setConnectective(true);
		FormSchemaGenerator gen = FormSchemaGenerator.getInstance(dtc);
		String formSchema = gen.getXMLSchema(formVerId);
		out.println(formSchema);
		System.out.println("formSchema>>>: " + formSchema);
	} catch (Exception e) {
		throw e;
	} finally {
		dtc.close();
	}	
%>
