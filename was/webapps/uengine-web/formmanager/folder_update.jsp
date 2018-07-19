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
	
	String actionName = (action.equals("add")) ? "�߰�" : "����";
	
%>
<html>
<head>
<title>����<%=actionName%></title>
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
			alert("�� �� ���� ī�װ�");
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
      <!--�˾�Ÿ��Ʋ ����-->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr><td class="popup_line"></td></tr>
        <tr>
          <td class="popup_title">�� ������ �߰� ���̾�α�</td>
        </tr>
        <tr><td class="popup_line"></td></tr>
      </table>
      <!--�˾�Ÿ��Ʋ ��-->
    </td>
  </tr>
    <tr>
    <td class="popup_body"> 
      <!--�˾� ���� ���� -->
      <!--�˾�ȸ������ ���̺� ���� -->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td class="margin_s"></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td class="popup_box"> 
            <!--���̺� �� ���ν��� -->
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="list_tit_line_s"></td>
              </tr>
              <tr> 
                <td class="list_btn_line_e"></td>
              </tr>
            </table>
            <!--���̺� �� ���γ�-->
            <!--������ ���õɰ�� ���̺���� -->
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="td_tit">����<font color="#FF3300"><b></b></font></td>
                <td class="td_left" colspan="3">
                  <input type=radio name="actionType" value="folder" onclick="selectCategory(this)">����<%=actionName%> 
                  <input type=radio name="actionType" value="form" onclick="selectCategory(this)">���<%=actionName%>
                </td>
              </tr>
              <tr> 
                <td class="td_line" colspan="4"></td>
              </tr>
              <tr id="name"> 
                <td class="td_tit">�̸�</td>
                <td class="td_left" colspan="3">
                  <input type="text" name="name" size="25" maxlength="150" style="width:150px" onblur="this.className='frm'" onfocus="this.className='frm-on'" />
                </td>
              </tr>
              <tr id="id1"> 
                <td class="td_line" colspan="4"></td>
              </tr>              
              <tr id="id"> 
                <td class="td_tit">�������</td>
                <td class="td_left" colspan="3">
					<select size="1" name="formType" class="frm" onblur="this.className='frm'" onfocus="this.className='frm-on'">
						<option value="form" selected="true">�⺻(����) ��� </option>
						<option value="approval">���ڰ��� (�⺻)</option>
						<option value="approval1">���ڰ��� (�볻 ����)</option>
						<option value="approval11">���ڰ��� (��� ����)</option>
						<option value="approval2">���ڰ��� (���)</option>
						<option value="approval3">���ڰ��� (����)</option>
						<option value="approval4">���ڰ��� (ȸ��)</option>
<!--					<option value="approval5">���ڰ��� (��ܹ߽Ź���)</option> -->
						<option value="approval6">���ڰ��� (None Title)</option>
						<option value="approval7">OneStop (��ȹ�)</option>
						<option value="approval8">���ڰ��� (���๮ ���ΰ���)</option>
						<option value="approval12">���ڰ��� (����������)</option>
						<option value="approval9">���ڰ��� (����ǰ��)</option>
						<option value="approval10">���ڰ��� (��ܹ��� ���ΰ���)</option>
						<option value="approval13">���ڰ��� (����ī��)</option>
						<option value="approval14">���ڰ��� (��û)</option>
					</select>									
                </td>
              </tr>              
            <!--������ ���õɰ�� ���̺�-->
            <!--���̺���� �Ʒ� �帰 ���� ����-->
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="list_btn_line_e"></td>
              </tr>
              <tr> 
                <td class="list_line_light"></td>
              </tr>
            </table>
            <!--���̺���� �Ʒ� �帰 ���� ��-->          
          </td>
        </tr>
      </table>     
      <!--�˾�ȸ������ ���̺� �� -->

      <!--��ư�� ���� ����-->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td class="margin_p_btn"></td>
        </tr>
      </table>
      <!--��ư�� ���� ��-->
      <!--��ư����-->
      <table border="0" cellspacing="0" cellpadding="0" align="center" class="btn_space">
        <tr> 
          <td> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="<%=IMG%>/themes/common/images/btn_01.gif"></td>
                <td background="<%=IMG%>/themes/common/images/btn_02.gif" class="btn1" nowrap><a href="#" ONFOCUS="this.blur();" ONMOUSEOVER="swapClass(this, 'buttonOver')" ONMOUSEOUT="swapClass(this, 'buttonOff')" ONCLICK="add();">�߰�</a></td>
                <td><img src="<%=IMG%>/themes/common/images/btn_03.gif"></td>
              </tr>
            </table>
          </td>
          <td> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="<%=IMG%>/themes/common/images/btn_01.gif"></td>
                <td background="<%=IMG%>/themes/common/images/btn_02.gif" class="btn1" nowrap><a href="#" onclick="window.close()">���</a></td>
                <td><img src="<%=IMG%>/themes/common/images/btn_03.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <!--��ư��-->
      <!--�˾� ���� ��-->
    </td>
  </tr>
</table>

<script>switchCategory('<%=actionType%>');</script>

</form>
</body>

</html>