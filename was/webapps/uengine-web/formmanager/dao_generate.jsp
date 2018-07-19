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
<%@page import="org.uengine.persistence.dao.*"%>
<%@page import="hanwha.commons.dao.*"%>
<%@page import="java.io.*"%>
<%@page import="javax.sql.*"%>
<%@page import="java.sql.*"%>
<%
	IDAO tables = GenericDAO.createDAOImpl(hanwha.bpm.BPMConstants.DATA_SOURCE_NAME, "select table_name as TNAME from user_tab_columns group by table_name", IDAO.class);
	tables.select();
%>

<%
	String parentGroupId = request.getParameter("parentGroupId");
	String ownCompany = request.getParameter("ownCompany");
	String action = request.getParameter("action");	
	
	System.out.println("parentGroupId : " + parentGroupId);
	System.out.println("ownCompany : " + ownCompany);
	System.out.println("action : " + action);
%>
<html>
<head>
<title>데이터베이스 컴포넌트 위저드</title>
<LINK REL="stylesheet" type="text/css" href="<%=CSS%>/common.css">
<LINK REL="stylesheet" type="text/css" href="<%=CSS%>/body.css"/>
<script type="text/javascript" src="<%=JS%>/css.js"></script>
<script language="JavaScript">
	function add() {
		var form = document.daoForm;
		if ( form.dbUseDataSource[0].checked == true ) {
			form.dbUseDataSource.value = "true";
		} else {
			form.dbUseDataSource.value = "false";
		}
		//alert(form.dbUseDataSource.value);
		window.dialogArguments.setDbParameter(form.dbUseDataSource.value, 
								form.dbDataSource.value,
								form.dbDriver.value,
								form.dbUrl.value,
								form.dbId.value,
								form.dbPassword.value,
								form.dbClassName.value,
								form.dbQuery.value);
		window.close();
	}
	
	function selectCategory(obj) {
		category = obj.value;
		switchCategory(category);
	}
	
	function switchCategory(category) {
		if ( category == "true" ) {
			use_jndi.style.display = 'inline';
			not_use_jndi.style.display = 'none';
			document.daoForm.dbUseDataSource[0].checked=true;
		} else if ( category == "false" ) {
			use_jndi.style.display = 'none';
			not_use_jndi.style.display = 'inline';
			document.daoForm.dbUseDataSource[1].checked=true;
		} else {
			alert("알 수 없는 카테고리");
		}
	}	
	
	function tableSelected() {
		var form = document.daoForm;
		var selectedIdx = form.dbTableName.selectedIndex;
		var selectedValue = form.dbTableName.options[selectedIdx].value;
		form.dbClassName.value = selectedValue;
		form.dbQuery.value = "SELECT * FROM " + selectedValue;
	}
</script>
</head>


<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="daoForm" method="post" action="group_update_result.jsp">
<input type="hidden" name="parentGroupId" value="<%=parentGroupId%>">
<input type="hidden" name="ownCompany" value="<%=ownCompany%>">

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
									<strong>데이타소스(JNDI) 사용여부</strong> (
									<input type=radio name="dbUseDataSource" value="true" onclick="selectCategory(this)">&nbsp; <strong>사용</strong>
									<input type=radio name="dbUseDataSource" value="false" onclick="selectCategory(this)">&nbsp; <strong>사용안함</strong>
									)
								</td>
							</tr>
							<tr>
								<td height="10" colspan="2"></td>
							</tr>
							<tr id="use_jndi" align="center">
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td style="width:100px" height="10" class="gongji3" align="right">
												<b>데이타소스명</b> :
											</td>
											<td height="10" class="gongji3" align="left">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="dbDataSource" value="<%=hanwha.bpm.BPMConstants.DATA_SOURCE_NAME%>" size="25" maxlength="150" style="width:150px" onblur="this.className='frm'" onfocus="this.className='frm-on'" />
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
											<td width="100" height="10" class="gongji3" align="right">
												<b>Driver Class</b> :
											</td>
											<td height="10" class="gongji3">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="dbDriver" value="oracle.jdbc.driver.OracleDriver" size="200" maxlength="200" style="width:200px" onblur="this.className='frm'" onfocus="this.className='frm-on'" />
											</td>
										</tr>
										<tr>
											<td height="5" colspan="2"></td>
										</tr>									
										<tr>
											<td width="100" height="10" class="gongji3" align="right">
												<b>DB URL</b> :
											</td>
											<td height="10" class="gongji3">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="dbUrl" value="jdbc:oracle:thin:@172.16.222.204:1521:hsncora" size="100" maxlength="150" style="width:300px" onblur="this.className='frm'" onfocus="this.className='frm-on'" />
											</td>
										</tr>
										<tr>
											<td height="5" colspan="2"></td>
										</tr>									
										<tr>
											<td width="100" height="10" class="gongji3" align="right">
												<b>DB 아이디</b> :
											</td>
											<td height="10" class="gongji3">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="dbId" value="renewal" size="25" maxlength="150" style="width:150px" onblur="this.className='frm'" onfocus="this.className='frm-on'" />
											</td>
										</tr>
										<tr>
											<td height="5" colspan="2"></td>
										</tr>									
										<tr>
											<td width="100" height="10" class="gongji3" align="right">
												<b>DB 패스워드</b> :
											</td>
											<td height="10" class="gongji3">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="dbPassword" value="renewal" size="25" maxlength="150" style="width:150px" onblur="this.className='frm'" onfocus="this.className='frm-on'" />
											</td>
										</tr>
										<tr>
											<td height="5" colspan="2"></td>
										</tr>									
									</table>
								</td>
							</tr>	
							<tr id="common">
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td style="width:100px"  height="10" class="gongji3" align="right">
												클래스명 :
											</td>
											<td height="10" class="gongji3" align="left">
												&nbsp;&nbsp;&nbsp;
												<input class="frm" type="text" name="dbClassName" value="" size="20" maxlength="150" style="width:150px" onblur="this.className='frm'" onfocus="this.className='frm-on'"/>
												
												<select class="frm" name="dbTableName" onchange="tableSelected()" onblur="this.className='frm'" onfocus="this.className='frm-on'">
													<option value="NOT_SELECTED"> :::::::::: 테이블 직접지정 :::::::::: </option>
<%
	while(tables.next()) {
		String tableName = (String)tables.get("TNAME");
%>
													<option value="<%=tableName%>"><%=tableName%></option>
<%
	}
%>
</select>
											</td>
										</tr>
										<tr>
											<td height="5" colspan="2"></td>
										</tr>	
										<tr>
											<td style="width:100px"  height="10" class="gongji3" align="right">
												쿼리(SQL) :
											</td>
											<td class="gongji3" align="left">
												&nbsp;&nbsp;&nbsp;
												<textarea class="frm" name="dbQuery" rows="8" cols="55" onblur="this.className='frm'" onfocus="this.className='frm-on'" ></textarea>
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

<script>switchCategory('true');</script>

</form>
</body>

</html>