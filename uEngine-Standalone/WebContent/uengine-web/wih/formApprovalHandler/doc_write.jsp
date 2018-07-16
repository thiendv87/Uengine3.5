<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="../../../common/header.jsp"%>
<%
    response.setHeader("Cache-Control", "no-cache");

	String instanceId = "1";
	String trcTag     = "1";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
<TITLE>.:: 인트라넷 ::.</TITLE>
<link rel="stylesheet" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/global.css" type="text/css">
<script language="javascript">
<%@include file="../../scripts/formActivity.js.jsp"%>
</script>
</HEAD>

<BODY leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<TABLE width="100%" cellpadding="0" cellspacing="0" border="0">
	<TR>
		<TD width="826" align="center" valign="top">
			<!--SPACE START-->		
			<TABLE width="95%" cellpadding="0" cellspacing="0" border="0">
				<TR><TD height="5"></TD></TR>
			</TABLE>
			<!--SPACE END-->	

			<!--SUB TITLE START-->					
			<TABLE width="95%" cellpadding="0" cellspacing="0" border="0">
				<TR>
					<TD width="2%"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/body/p01.gif"></TD>
					<TD class="sub_title">기안문서작성</TD>
				</TR>							
			</TABLE>
			<!--SUB TITLE END-->

			<!--INFO START-->			
			<TABLE width="95%" cellpadding="0" cellspacing="0" border="0">
				<TR>
					<TD width="5"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/body/box01_01.gif"></TD>
					<TD width="5" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/body/box01_02.gif"></TD>
					<TD width="5"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/body/box01_03.gif"></TD>								
				</TR>
				<TR>
					<TD width="5" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/body/box01_04.gif"></TD>
					<TD width="99%" bgcolor="F2F2F2" >
						<TABLE cellpadding="0" cellspacing="0" border="0" width="100%">
							<TR>
								<TD width="50%" >
									<TABLE cellpadding="0" cellspacing="0" border="0">
										<TR>
											<TD class="space_left_right2"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/btn/btn2_31.gif"></TD>
										</TR>
									</TABLE>		
								</TD>
								<TD width="50%" align="right">
									<TABLE cellpadding="0" cellspacing="0" border="0" >
										<TR>
											<!-- 결재보턴으로 변경할 수 있도록 처리할 것 -->
											<TD class="space_left_right2">
												<img onclick="getOpenModalPopup('popupCommentWrite.jsp?instanceId=<%=instanceId%>&trcTag=<%=trcTag%>','650','520')" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/btn/btn2_15.gif" style="cursor:hand; ">
											</TD>
											<TD class="space_left_right2">
												<img onclick="getOpenModalPopup('popupCommentView.jsp?instanceId=<%=instanceId%>','800','300')" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/btn/btn4_17.gif" style="cursor:hand; ">
											</TD>
											<TD class="space_left_right2">
												<img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/btn/btn4_02.gif">
											</TD>
											<TD class="space_left_right2">
												<img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/btn/btn5_01.gif">
											</TD>
										</TR>
									</TABLE>			
								</TD>
								
							</TR>
						</TABLE>	
					</TD>
					<TD width="5" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/body/box01_06.gif"></TD>								
				</TR>
				<TR>
					<TD width="5"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/body/box01_07.gif"></TD>
					<TD width="5" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/body/box01_08.gif"></TD>
					<TD width="5"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/body/box01_09.gif"></TD>								
				</TR>							
			</TABLE>
			<!--INFO END-->

			<!--SPACE START-->		
			<TABLE width="95%" cellpadding="0" cellspacing="0" border="0">
				<TR><TD height="5"></TD></TR>
			</TABLE>
			<!--SPACE END-->							

						
			<iframe src="doc_include.jsp" width="784" height="390"  frameborder="0" class="iframe_body"></iframe>		
			
			
			<!--TABLE START-->

			<TABLE width="95%" cellpadding="0" cellspacing="1" border="0">
				<TR>
					<TD width="20%" class="td03_title">파일첨부</TD>
					<TD width="80%" class="td03_data">
						<TABLE cellpadding="0" cellspacing="0" border="0">
							<TR>
								<TD rowspan="3" ><textarea cols="30" rows="5"></textarea></TD>
								<TD  class="space_left_right"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/ico_btn/btn4_19.gif"></TD>
							</TR>
							<TR>
								<TD  class="space_left_right"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/ico_btn/btn4_21.gif"></TD>
							</TR>
							<TR>
								<TD  class="space_left_right"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/ico_btn/btn4_20.gif"></TD>
							</TR>
						</TABLE>
					</TD>
															
				</TR>
				<TR><TD class="td_line" colspan="10"></TD></TR>
			</TABLE>
			<!--TABLE END-->

			<!--SPACE START-->		
			<TABLE width="95%" cellpadding="0" cellspacing="0" border="0">
				<TR><TD height="5"></TD></TR>
			</TABLE>
			<!--SPACE END-->
		</TD>
	</TR>
</TABLE>
</BODY>
</HTML>
