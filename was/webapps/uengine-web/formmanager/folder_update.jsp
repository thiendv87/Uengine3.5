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
<%@include file="../../common/commons.jsp"%>
<%
	String parentGroupId = request.getParameter("parentGroupId");
	String ownCompany = request.getParameter("ownCompany");
	String action = request.getParameter("action");	
	String actionType = request.getParameter("actionType");	
	if ( actionType == null ) actionType = "folder";
	
	System.out.println("parentGroupId : " + parentGroupId);
	System.out.println("ownCompany : " + ownCompany);
	System.out.println("action : " + action);
	System.out.println("actionType : " + actionType);
	
	String actionName = (action.equals("add")) ? "추가" : "수정";
	
%>
<html>
<head>
<title>폴더<%=actionName%></title>
<link rel="stylesheet" type="text/css" href="<%=CSS%>/admin_common.css.jsp">
<link rel="stylesheet" type="text/css" href="<%=CSS%>/admin.css.jsp">
<link rel="stylesheet" type="text/css" href="<%=CSS%>/admin_page.css.jsp">
<link rel="stylesheet" type="text/css" href="<%=CSS%>/global.css.jsp">

<script type="text/javascript" src="<%=JS%>/css.js"></script>
<script language="JavaScript">
	function add() {
		//alert(document.groupForm.parentGroupId.value);
		//alert(document.groupForm.ownCompany.value);
		document.groupForm.submit();
	}

	function selectCategory(obj) {
		category = obj.value;
		switchCategory(category);
	}
	
	function switchCategory(category) {
		if ( category == "folder" ) {
			id.style.display = 'none';
			id1.style.display = 'none';			
			document.groupForm.actionType[0].checked=true;
		} else if ( category == "form" ) {
			id.style.display = 'inline';
			id1.style.display = 'inline';			
			document.groupForm.actionType[1].checked=true;
		} else {
			alert("알 수 없는 카테고리");
		}
	}	
</script>
</head>

<body bgcolor="#F7F7F7">
<form name="groupForm" method="post" action="folder_update_result.jsp">
<input type="hidden" name="parentGroupId" value="<%=parentGroupId%>">
<input type="hidden" name="ownCompany" value="<%=ownCompany%>">
<input type="hidden" name="action" value="<%=action%>">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <!--팝업타이틀 시작-->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr><td class="popup_line"></td></tr>
        <tr>
          <td class="popup_title">폼 디자인 추가 다이얼로그</td>
        </tr>
        <tr><td class="popup_line"></td></tr>
      </table>
      <!--팝업타이틀 끝-->
    </td>
  </tr>
    <tr>
    <td class="popup_body"> 
      <!--팝업 본문 시작 -->
      <!--팝업회색라인 테이블 시작 -->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td class="margin_s"></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td class="popup_box"> 
            <!--테이블 위 라인시작 -->
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="list_tit_line_s"></td>
              </tr>
              <tr> 
                <td class="list_btn_line_e"></td>
              </tr>
            </table>
            <!--테이블 위 라인끝-->
            <!--폴더가 선택될경우 테이블시작 -->
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="td_tit">구분<font color="#FF3300"><b></b></font></td>
                <td class="td_left" colspan="3">
                  <input type=radio name="actionType" value="folder" onclick="selectCategory(this)">폴더<%=actionName%> 
                  <input type=radio name="actionType" value="form" onclick="selectCategory(this)">양식<%=actionName%>
                </td>
              </tr>
              <tr> 
                <td class="td_line" colspan="4"></td>
              </tr>
              <tr id="name"> 
                <td class="td_tit">이름</td>
                <td class="td_left" colspan="3">
                  <input type="text" name="name" size="25" maxlength="150" style="width:150px" onblur="this.className='frm'" onfocus="this.className='frm-on'" />
                </td>
              </tr>
              <tr id="id1"> 
                <td class="td_line" colspan="4"></td>
              </tr>              
              <tr id="id"> 
                <td class="td_tit">양식종류</td>
                <td class="td_left" colspan="3">
					<select size="1" name="formType" class="frm" onblur="this.className='frm'" onfocus="this.className='frm-on'">
						<option value="form" selected="true">기본(자유) 양식 </option>
						<option value="approval">전자결재 (기본)</option>
						<option value="approval1">전자결재 (대내 시행)</option>
						<option value="approval11">전자결재 (대외 시행)</option>
						<option value="approval2">전자결재 (기안)</option>
						<option value="approval3">전자결재 (보고)</option>
						<option value="approval4">전자결재 (회람)</option>
<!--					<option value="approval5">전자결재 (대외발신문서)</option> -->
						<option value="approval6">전자결재 (None Title)</option>
						<option value="approval7">OneStop (기안문)</option>
						<option value="approval8">전자결재 (시행문 내부결재)</option>
						<option value="approval12">전자결재 (시행결과보고)</option>
						<option value="approval9">전자결재 (지출품의)</option>
						<option value="approval10">전자결재 (대외문서 내부결재)</option>
						<option value="approval13">전자결재 (법인카드)</option>
						<option value="approval14">전자결재 (신청)</option>
					</select>									
                </td>
              </tr>              
            <!--폴더가 선택될경우 테이블끝-->
            <!--테이블사이 아래 흐린 라인 시작-->
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="list_btn_line_e"></td>
              </tr>
              <tr> 
                <td class="list_line_light"></td>
              </tr>
            </table>
            <!--테이블사이 아래 흐린 라인 끝-->          
          </td>
        </tr>
      </table>     
      <!--팝업회색라인 테이블 끝 -->

      <!--버튼위 여백 시작-->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td class="margin_p_btn"></td>
        </tr>
      </table>
      <!--버튼위 여백 끝-->
      <!--버튼시작-->
      <table border="0" cellspacing="0" cellpadding="0" align="center" class="btn_space">
        <tr> 
          <td> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="<%=IMG%>/themes/common/images/btn_01.gif"></td>
                <td background="<%=IMG%>/themes/common/images/btn_02.gif" class="btn1" nowrap><a href="#" ONFOCUS="this.blur();" ONMOUSEOVER="swapClass(this, 'buttonOver')" ONMOUSEOUT="swapClass(this, 'buttonOff')" ONCLICK="add();">추가</a></td>
                <td><img src="<%=IMG%>/themes/common/images/btn_03.gif"></td>
              </tr>
            </table>
          </td>
          <td> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="<%=IMG%>/themes/common/images/btn_01.gif"></td>
                <td background="<%=IMG%>/themes/common/images/btn_02.gif" class="btn1" nowrap><a href="#" onclick="window.close()">취소</a></td>
                <td><img src="<%=IMG%>/themes/common/images/btn_03.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <!--버튼끝-->
      <!--팝업 본문 끝-->
    </td>
  </tr>
</table>

<script>switchCategory('<%=actionType%>');</script>

</form>
</body>

</html>