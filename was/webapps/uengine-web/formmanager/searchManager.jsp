<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/html; charset=UTF-8");%>
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
		var form = document.formUserListForm;
		if ( form.formUserListName.value == '' ) {
			alert('이름은 필수입력 필드입니다');
			form.formUserListName.focus();
			return false;
		}
		window.dialogArguments.setSearchManagerParam(form.formUserListName.value);
		window.close();
	}
	
</script>
</head>


<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="formUserListForm" method="post">

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
												<b>이름</b> :
											</td>
											<td height="10" class="gongji3" align="left">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="formUserListName" value="" size="25" maxlength="150" style="width:150px" onblur="this.className='frm'" onfocus="this.className='frm-on'" />
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