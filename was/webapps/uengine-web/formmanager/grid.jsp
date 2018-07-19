<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/html; charset=UTF-8");%>
<%--
  - Author(s): Sunny NK ( cidea429@hanwha.co.kr )
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
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<LINK REL="stylesheet" type="text/css" href="<%=CSS%>/common.css">
<LINK REL="stylesheet" type="text/css" href="<%=CSS%>/body.css"/>
<script type="text/javascript" src="<%=JS%>/css.js"></script>
<script language="JavaScript">
	function add() {
		var form = document.gridForm;

		if ( form.grid_name.value == '' ) {
			alert('이름은 필수입력 필드입니다');
			form.grid_name.focus();
			return false;
		}
		if ( form.grid_baseUrl.value == '' ) {
			alert('서비스 URL은 필수입력 필드입니다');
			form.grid_baseUrl.focus();
			return false;
		}
		if ( form.grid_width.value == '' ) {
			alert('가로 크기는 필수입력 필드입니다');
			form.grid_width.focus();
			return false;
		}
		if ( form.grid_height.value == '' ) {
			alert('세로 크기는 필수입력 필드입니다');
			form.grid_height.focus();
			return false;
		}
		if ( form.grid_headerNames.value == '' ) {
			alert('헤더 이름 설정은 필수입력 필드입니다');
			form.grid_headerNames.focus();
			return false;
		}

		window.dialogArguments.setGridParam(
			form.grid_name.value,
			form.grid_baseUrl.value,
			form.grid_width.value,
			form.grid_height.value,
			form.grid_headerNames.value,
			form.grid_headerWidths.value,
			form.grid_headerAligns.value,
			form.grid_columnAligns.value,
			form.grid_columnNumbers.value,
			form.grid_headerSort.value,
			form.grid_paging.value,
			form.grid_pageItemSize.value,
			form.grid_pageLineSize.value);

		window.close();
	}
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="gridForm" method="post">

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
											<td width="150" height="10" class="gongji3" align="right">
												<b>* 이름</b> :
											</td>
											<td height="10" class="gongji3" align="left">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="grid_name" value="" size="25" maxlength="150" style="width:150px" onblur="this.className='frm'" onfocus="this.className='frm-on'" />
											</td>
										</tr>
										<tr>
											<td height="5" colspan="2"></td>
										</tr>					
									</table>
								</td>
							</tr>
							<tr id="not_use_jndi" align="center">
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="150" height="10" class="gongji3" align="right">
												<b>* 서비스 URL</b> :
											</td>
											<td height="10" class="gongji3">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="grid_baseUrl" value="" size="150" maxlength="150" style="width:450px" onblur="this.className='frm'" onfocus="this.className='frm-on'" />
											</td>
										</tr>
										<tr>
											<td height="5" colspan="2"></td>
										</tr>
										<tr>
											<td width="150" height="10" class="gongji3" align="right">
												<b>* 가로 크기</b> :
											</td>
											<td height="10" class="gongji3">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="grid_width" value="400" size="150" maxlength="150" style="width:150px" onblur="this.className='frm'" onfocus="this.className='frm-on'" /> px
											</td>
										</tr>
										<tr>
											<td height="5" colspan="2"></td>
										</tr>
										<tr>
											<td width="150" height="10" class="gongji3" align="right">
												<b>* 세로 크기</b> :
											</td>
											<td height="10" class="gongji3">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="grid_height" value="300" size="150" maxlength="150" style="width:150px" onblur="this.className='frm'" onfocus="this.className='frm-on'" /> px
											</td>
										</tr>
										<tr>
											<td height="5" colspan="2"></td>
										</tr>
										<tr>
											<td width="150" height="10" class="gongji3" align="right">
												<b>* 헤더 이름 설정</b> :
											</td>
											<td height="10" class="gongji3">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="grid_headerNames" value="" size="150" maxlength="150" style="width:150px" onblur="this.className='frm'" onfocus="this.className='frm-on'" /> (ex: '직급,부서,이름', multi-'직급,정보,정보|직급,부서,이름')
											</td>
										</tr>
										<tr>
											<td height="5" colspan="2"></td>
										</tr>
										<tr>
											<td width="150" height="10" class="gongji3" align="right">
												<b>헤더 가로 크기</b> :
											</td>
											<td height="10" class="gongji3">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="grid_headerWidths" value="" size="150" maxlength="150" style="width:150px" onblur="this.className='frm'" onfocus="this.className='frm-on'" /> (ex: '70,60,50')
											</td>
										</tr>
										<tr>
											<td height="5" colspan="2"></td>
										</tr>
										<tr>
											<td width="150" height="10" class="gongji3" align="right">
												<b>헤더 Align 설정</b> :
											</td>
											<td height="10" class="gongji3">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="grid_headerAligns" value="" size="150" maxlength="150" style="width:150px" onblur="this.className='frm'" onfocus="this.className='frm-on'" /> (ex: '4,4,4', 1-left, 4-center, 7-right)
											</td>
										</tr>
										<tr>
											<td height="5" colspan="2"></td>
										</tr>
										<tr>
											<td width="150" height="10" class="gongji3" align="right">
												<b>컬럼 Align 설정</b> :
											</td>
											<td height="10" class="gongji3">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="grid_columnAligns" value="" size="150" maxlength="150" style="width:150px" onblur="this.className='frm'" onfocus="this.className='frm-on'" /> (ex: '4,4,4', 1-left, 4-center, 7-right)
											</td>
										</tr>
										<tr>
											<td height="5" colspan="2"></td>
										</tr>
										<tr>
											<td width="150" height="10" class="gongji3" align="right">
												<b>컬럼 숫자 표시 여부</b> :
											</td>
											<td height="10" class="gongji3">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="grid_columnNumbers" value="" size="150" maxlength="150" style="width:150px" onblur="this.className='frm'" onfocus="this.className='frm-on'" /> (ex: 'N,Y,Y', 'Y'일 경우 숫자를 ###,###,### 형태로 표시)
											</td>
										</tr>
										<tr>
											<td height="5" colspan="2"></td>
										</tr>
										<tr>
											<td width="150" height="10" class="gongji3" align="right">
												<b>헤더 소트 가능 여부</b> :
											</td>
											<td height="10" class="gongji3">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="grid_headerSort" value="false" size="150" maxlength="150" style="width:150px" onblur="this.className='frm'" onfocus="this.className='frm-on'" /> (true or false)
											</td>
										</tr>
										<tr>
											<td height="5" colspan="2"></td>
										</tr>
										<tr>
											<td width="150" height="10" class="gongji3" align="right">
												<b>페이징 여부</b> :
											</td>
											<td height="10" class="gongji3">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="grid_paging" value="false" size="150" maxlength="150" style="width:150px" onblur="this.className='frm'" onfocus="this.className='frm-on'" /> (true or false)
											</td>
										</tr>
										<tr>
											<td height="5" colspan="2"></td>
										</tr>
										<tr>
											<td width="150" height="10" class="gongji3" align="right">
												<b>페이지 줄 수</b> :
											</td>
											<td height="10" class="gongji3">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="grid_pageItemSize" value="" size="150" maxlength="150" style="width:150px" onblur="this.className='frm'" onfocus="this.className='frm-on'" />
											</td>
										</tr>
										<tr>
											<td height="5" colspan="2"></td>
										</tr>
										<tr>
											<td width="150" height="10" class="gongji3" align="right">
												<b>페이지 표시 개수</b> :
											</td>
											<td height="10" class="gongji3">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="grid_pageLineSize" value="" size="150" maxlength="150" style="width:150px" onblur="this.className='frm'" onfocus="this.className='frm-on'" />
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
