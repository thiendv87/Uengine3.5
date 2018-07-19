<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/html; charset=UTF-8");%>
<%@include file="../../common/no_cache.jsp"%>
<%@include file="../../common/commons.jsp"%>
<%@ taglib prefix="bpm" uri="http://hsnc.hanwha.co.kr/taglibs/bpm" %>

<%@page import="hanwha.bpm.form.business.FormBusinessFacade"%>
<%@page import="hanwha.bpm.form.dao.FormDAO"%>
<%@page import="hanwha.bpm.form.dao.JobManualDAO"%>
<%@page import="hanwha.bpm.taglibs.input.InputConstants"%>

<%
	RequestContext reqCtx = new RequestContext(request);
	FormBusinessFacade formBF = new FormBusinessFacade(reqCtx);

	String formid = request.getParameter("formid");

	
	FormDAO formDAO = formBF.getJobFormList(Long.parseLong(formid));
	JobManualDAO manualDAO = formBF.getJobManualList(Long.parseLong(formid));
	
	String jobmanualid = "";
	
	if(manualDAO.size() > 0){
		jobmanualid = String.valueOf(manualDAO.getJobManualId());
	}


%>	
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<LINK REL="stylesheet" type="text/css" href="<%=CSS%>/common.css">
<LINK REL="stylesheet" type="text/css" href="<%=CSS%>/body.css"/>
<link rel="stylesheet" type="text/css" href="<%=CSS%>/bpm.css">
<script type="text/javascript" src="<%=JS%>/css.js"></script>
<script type="text/javascript" src="<%=JS%>/popup.js"></script>

<script language="JavaScript">
	var jobmanualid = "<%=jobmanualid%>";
	function add() {
		var f = document.form;

		if(jobmanualid != ''){
			f.action.value = 'MOD';
		}else{
			f.action.value = 'ADD';
		}

		f.submit();
	}
	
</script>
</head>


<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="form" method="post" action="job_manual_result.jsp">
<input type="hidden" name="action" value="">
<input type="hidden" name="jobmanualid" value="<%=jobmanualid %>">
<input type="hidden" name="formid" value="<%=formid%>">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td><img height="10" width="1" src="<%=IMG%>/blank.png"></td></tr>
	<tr> 
		<td nowrap width="10">&nbsp;</td>
		<td valign="top">		
			<table width="100%" border="0" cellpadding="5" cellspacing="0" class="box_line_2">
				<tr> 
					<td bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr id="use_jndi" align="center">
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100" height="10" class="gongji3" align="right">
												<b>양식명</b> :
											</td>
											<td height="10" class="gongji3" align="left">
												&nbsp;&nbsp;&nbsp;
												<%=formDAO.getFormName()%>
											</td>
										</tr>
										<tr><td class='tbc_h2' height="1" colspan="2"><img src="<%=IMG%>/space.gif" width="1" height="1"></td></tr>
										<tr>
											<td width="100" height="10" class="gongji3" align="right">
												<b>매뉴얼설명</b> :
											</td>
											<td height="10" class="gongji3" align="left">
												&nbsp;&nbsp;&nbsp;
												<%
													String description = formDAO.getJobManualDescription();
													if(description == null) description = "";
												%>
												<input class="frm" type="text" name="description" value="<%=description %>" maxlength="100" style="width:450px" onblur="this.className='frm'" onfocus="this.className='frm-on'" />
											</td>
										</tr>
										<tr><td class='tbc_h2' height="1" colspan="2"><img src="<%=IMG%>/space.gif" width="1" height="1"></td></tr>
										<tr>
											<td width="100" height="10" class="gongji3" align="right">
												<b>작성자</b> :
											</td>
											<td height="10" class="gongji3" align="left">
												&nbsp;&nbsp;&nbsp;
												<%=formDAO.getCreatorUserName()%>
											</td>
										</tr>
										<tr><td class='tbc_h2' height="1" colspan="2"><img src="<%=IMG%>/space.gif" width="1" height="1"></td></tr>
										<tr>
											<td width="100" height="10" class="gongji3" align="right">
												<b>매뉴얼파일</b> :
											</td>
											<td height="10" class="gongji3" align="left">
											<%
												String jobManualPath = "";
												if(manualDAO.size() > 0) jobManualPath = manualDAO.getJobManualPath();
												
												pageContext.setAttribute("approvalAttachFile", jobManualPath, PageContext.REQUEST_SCOPE);
											%>
											<bpm:fileUpload name="approvalAttachFile" viewMode="<%=InputConstants.WRITE%>" width="400px" height="79px" style="tbl_had_corl" />
											</td>
										</tr>
										<tr>
											<td height="5" colspan="2"></td>
										</tr>					
									</table>
								</td>
							</tr>
							<tr>
								<td height="5" colspan="2"></td>
							</tr>
							<tr>
								<td height="10" class="gongji3" align="center" colspan="2">
									&nbsp;<INPUT TYPE="button" TITLE="ALT+a" ACCESSKEY="a" CLASS="buttonOff" NAME="추가" VALUE="추가" ONFOCUS="this.blur();" ONMOUSEOVER="swapClass(this, 'buttonOver')" ONMOUSEOUT="swapClass(this, 'buttonOff')" ONCLICK="add();"/>
									&nbsp;<INPUT TYPE="button" TITLE="ALT+c" ACCESSKEY="c" CLASS="buttonOff" NAME="취소" VALUE="취소" ONFOCUS="this.blur();" ONMOUSEOVER="swapClass(this, 'buttonOver')" ONMOUSEOUT="swapClass(this, 'buttonOff')" ONCLICK="window.close();"/>
								</td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>
						</table>
						
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