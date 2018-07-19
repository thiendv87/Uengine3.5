<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/html; charset=UTF-8");%>
<%--
  - Author(s): Sungsoo Park ( ghbpark@hanwha.co.kr )
  - Copyright Notice:
	Copyright 2001-2005 by HANWHA S&C Corp.,
	All rights reserved.

	This software is the confidential and proprietary information
	of HANWHA S&C Corp. ("Confidential Information").  You
	shall not disclose such Confidential Information and shall use
	it only in accordance with the terms of the license agreement
	you entered into with HANWHA S&C Corp.
  - @(#)
  - Description:
--%>
<%@include file="../../common/no_cache.jsp"%>
<%@include file="../../common/commons.jsp"%>
<%@page import="hanwha.commons.brainnet.commons.Constants"%>
<jsp:useBean id="formHeaderBean" scope="page" class="hanwha.bpm.form.FormHeader" />
<%@page import="org.uengine.persistence.dao.*"%>
<%@page import="hanwha.commons.dao.*"%>
<%@page import="java.io.*"%>
<%@page import="javax.sql.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="hanwha.bpm.commons.dao.*"%>
<%@page import="hanwha.bpm.form.attr.*"%>
<%@page import="hanwha.commons.util.*"%>
<%@page import="hanwha.bpm.form.business.FormBusinessFacade"%>
<%@page import="hanwha.bpm.form.dao.FormAttrDAO"%>

<%
	RequestContext reqCtx = new RequestContext(request);
	FormBusinessFacade formBF = new FormBusinessFacade(reqCtx);

	String hiddenFieldName = request.getParameter("hiddenFieldName");
	String attrId = request.getParameter("attrId");
	
	// 폼 속성 초기값 설정.
//    String query_bpm_form_attr = "select attrinitvalue from BPM_FORM_ATTR where attrId = ?attrId";
//    BPM_FORM_ATTR obj_bpm_form_attr = (BPM_FORM_ATTR) GenericDAO.createDAOImpl("java:/uEngineDS", query_bpm_form_attr, BPM_FORM_ATTR.class);
//    obj_bpm_form_attr.setAttrid(new BigDecimal(attrId));
//    obj_bpm_form_attr.select();
//    if ( obj_bpm_form_attr.size() > 0 ) {
//    	obj_bpm_form_attr.next();
//    	String attrinitvalue = obj_bpm_form_attr.getAttrinitvalue();
//    	if ( attrinitvalue != null && attrinitvalue.trim().length() > 0 && !attrinitvalue.trim().equals("null") ) {
//    		pageContext.setAttribute("initValue", attrinitvalue, PageContext.REQUEST_SCOPE);
//    	}
//    }
	
	String attrinitvalue = formBF.getFormAttrInitValue(Long.parseLong(attrId));
	if ( attrinitvalue != null && attrinitvalue.trim().length() > 0 && !attrinitvalue.trim().equals("null") ) {
		pageContext.setAttribute("initValue", attrinitvalue, PageContext.REQUEST_SCOPE);
	}
%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<LINK REL="stylesheet" type="text/css" href="<%=CSS%>/common.css">
<LINK REL="stylesheet" type="text/css" href="<%=CSS%>/groupware.css">
<LINK REL="stylesheet" type="text/css" href="<%=CSS%>/body.css"/>
<script type="text/javascript" src="<%=JS%>/css.js"></script>
<script>
	function save() {
		var initValue;
		var initValueOptions = document.all("initValue").options;
		for ( i=0; i< initValueOptions.length; i++) {
			//alert(initValueOptions[i].value);
			if ( i==0 ) {
				initValue = initValueOptions[i].value;
			} else {
				initValue += ('\\'+initValueOptions[i].value);
			}
		}
		var topWindow = top.dialogArguments;
		topWindow.applyAttachFile('<%=hiddenFieldName%>', initValue);
		window.close();
	}
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form name="attachFileForm">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td><img height="10" width="1" src="images/blank.png"></td></tr>
	<tr> 
		<td nowrap width="10">&nbsp;</td>
		<td valign="top">

			<table width="100%" border="0" cellpadding="5" cellspacing="0" class="box_line_2">
				<tr> 
					<td bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr> 
								<td height="22" class="gongji4" align="center" colspan="2">
									<strong>첨부파일 초기값 설정</strong> 
								</td>
							</tr>
							<tr>
								<td height="10" colspan="2"></td>
							</tr>
							<tr align="center">
								<td align="center">
<%=formHeaderBean.getFileUploadHTML("initValue", pageContext)%>
								</td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>
							<tr>
								<td height="5" colspan="2"></td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			
			<table width="100%" border="0" cellpadding="10" cellspacing="0">
				<tr align="center">
					<td align="cetner">
									&nbsp;<INPUT TYPE="button" TITLE="ALT+s" ACCESSKEY="a" CLASS="buttonOff" NAME="확인" VALUE="확인" ONFOCUS="this.blur();" ONMOUSEOVER="swapClass(this, 'buttonOver')" ONMOUSEOUT="swapClass(this, 'buttonOff')" ONCLICK="save();"/>
									&nbsp;<INPUT TYPE="button" TITLE="ALT+c" ACCESSKEY="c" CLASS="buttonOff" NAME="취소" VALUE="취소" ONFOCUS="this.blur();" ONMOUSEOVER="swapClass(this, 'buttonOver')" ONMOUSEOUT="swapClass(this, 'buttonOff')" ONCLICK="window.close();"/>
					</td>
				</tr>
			</table>

		</td>
		<td nowrap width="10">&nbsp;</td>
	</tr>
</table>			

</form>

</body>
</html>