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
<%@page import="hanwha.commons.util.*"%>
<%@page import="hanwha.bpm.form.model.AttrModel"%>
<%@page import="hanwha.bpm.form.business.FormBusinessFacade"%>
<%@page import="hanwha.bpm.form.dao.FormAttrDAO"%>

<%
	RequestContext reqCtx = new RequestContext(request);
	FormBusinessFacade formBF = new FormBusinessFacade(reqCtx);

	String action = request.getParameter("action");	
	System.out.println("action : " + action);

////////////////////////////////////////////////////////////////////////////////
//	String formId = request.getParameter("formId");
	String formVerId = request.getParameter("formVerId");
	
	if ( action != null && action.equals("save") ) {
		Map map = new HashMap();


		for(Enumeration e = request.getParameterNames(); e.hasMoreElements(); ) {
			String name = (String)e.nextElement();

			if (name.equals("formVerId") || name.equals("action")) {
				continue;
			}

			AttrModel attrModel = null;
			int index = name.indexOf("_") + 1;
			String attrId = name.substring(index, name.length());
			
			if (!map.containsKey(attrId)) {
				attrModel = new AttrModel();
				attrModel.setFormVerid(new BigDecimal(formVerId));
				map.put(attrId, attrModel);
			}

			if (name.startsWith("attrId")) {
				attrModel = (AttrModel) map.get(attrId);
				attrModel.setAttrid(new BigDecimal(request.getParameter(name)));
			}
			else if (name.startsWith("attrName")) {
				attrModel = (AttrModel) map.get(attrId);
				attrModel.setAttrname(GWUtil.toEncode(request.getParameter(name)));
			}
			else if (name.startsWith("attrDesc")) {
				attrModel = (AttrModel) map.get(attrId);
				attrModel.setAttrdesc(GWUtil.toEncode(request.getParameter(name)));
			}
			else if (name.startsWith("attrInitValue")) {
				attrModel = (AttrModel) map.get(attrId);
				attrModel.setAttrinitvalue(GWUtil.toEncode(request.getParameter(name)));
			}
			else if (name.startsWith("serializer")) {
				attrModel = (AttrModel) map.get(attrId);
				attrModel.setSerializer(request.getParameter(name));
			}
			else if (name.startsWith("isBinding")) {
				attrModel = (AttrModel) map.get(attrId);
				boolean isBinding = (request.getParameter(name).equals("on")) ? true : false;
				attrModel.setIsbinding(isBinding);
			}
			else if (name.startsWith("isReadOnly")) {
				attrModel = (AttrModel) map.get(attrId);
				boolean isReadOnly = (request.getParameter(name).equals("on")) ? true : false;
				attrModel.setIsreadonly(isReadOnly);
			}
		}
		System.out.println("Enumeration end...");
		
//		AttrDAO attrDao = new AttrDAO();
		
		for (Iterator i = map.values().iterator(); i.hasNext();)
		{
			AttrModel attrModel = (AttrModel) i.next();
			
			System.out.println(attrModel);

			formBF.updateFormAttr(attrModel);
		}

	}
	
	// 폼 변수 리스트.
//	String query_bpm_form_attr = "select * from BPM_FORM_ATTR where formId = ?formId and isdelete = 0";
//    BPM_FORM_ATTR obj_bpm_form_attr = (BPM_FORM_ATTR) GenericDAO.createDAOImpl("java:/uEngineDS", query_bpm_form_attr, BPM_FORM_ATTR.class);
//    obj_bpm_form_attr.setFormid(new BigDecimal(formId));
//    obj_bpm_form_attr.select();
	FormAttrDAO obj_bpm_form_attr = formBF.getFormAttrList(Long.parseLong(formVerId));
%>
<html>
<head>
<title>필드설정</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="<%=CSS%>/admin_common.css.jsp">
<link rel="stylesheet" type="text/css" href="<%=CSS%>/admin.css.jsp">
<link rel="stylesheet" type="text/css" href="<%=CSS%>/admin_page.css.jsp">
<link rel="stylesheet" type="text/css" href="<%=CSS%>/global.css.jsp">
<LINK REL="stylesheet" type="text/css" href="<%=CSS%>/groupware.css">
<LINK REL="stylesheet" type="text/css" href="<%=CSS%>/body.css"/>
<script type="text/javascript" src="<%=JS%>/css.js"></script>

<script language="JavaScript">
	function save() {
		var form = document.elementForm;
		form.submit();
	}
	function openAttachDlg(hiddenFieldName, attrId) {
		//alert(hiddenFieldName);
		var url = "attachfile_frame.jsp?hiddenFieldName="+hiddenFieldName+"&attrId="+attrId;
		var StrOption ;
		StrOption  = "dialogWidth:400px;dialogHeight:270px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:off";	
		showModalDialog (url , window, StrOption);
		//window.open(url);
	}
	function applyAttachFile(hiddenFieldName, initValue) {
		if ( initValue == null ) initValue = "";
		var hiddenField = document.getElementById(hiddenFieldName);
		//alert(hiddenFieldName + " : " + hiddenField.value);
		hiddenField.value = initValue;
		//alert(hiddenFieldName + " : " + hiddenField.value);
		save();
	}
	
	var checkAllClicked = false;
	function checkAll( prefix ) {
		var inputTags = document.all.tags("input");
		try {
			for (var i=0; i < inputTags.length; i++) {
				if( inputTags[i].type == "checkbox" && inputTags[i].name.substr(0, prefix.length) == prefix){
					inputTags[i].checked = (!checkAllClicked);
				}
			}
		} catch( error ) { 
			//alert( error.name + ': ' + error.message ); 
		}
		checkAllClicked = (!checkAllClicked);
	}	
</script>
</head>

<body bgcolor="#F7F7F7">                      
<form name="elementForm" method="post" action="select_binding_element.jsp?action=save">                                                                                           
<table width="100%" border="0" cellspacing="0" cellpadding="0">                                                                          
  <tr>                                                                                                                                   
    <td>                                                                                                                                 
      <!--팝업타이틀 시작-->                                                                                                             
      <table width="100%" border="0" cellspacing="0" cellpadding="0">                                                                    
        <tr><td class="popup_line"></td></tr>                                                                                            
        <tr>                                                                                                                             
          <td class="popup_title">필드설정</td>                                                                                          
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
            <table width="100%" border="0" cellspacing="0" cellpadding="0">                                                              
              <tr>                                                                                                                       
                <td class="list_tit_line_s"></td>                                                                                        
              </tr>                                                                                                                      
            </table>                                                                                                                     
            <table width="100%" border="0" cellspacing="1" cellpadding="0" class="tbl">                                                  
              <tr>                                                                                                                       
                <td  class="td_tit_gray_center" height="23"> 이름</td>                                                                   
                <td  class="td_tit_gray_center" height="23">설명</td>                                                                    
                <td  class="td_tit_gray_center" width="50" height="23">연동<input type="checkbox" value="" ID="Checkbox1" NAME="Checkbox1" onclick="checkAll('isBinding_');"></td>                                                     
                <td  class="td_tit_gray_center" width="50" height="23">읽기<input type="checkbox" value="" ID="Checkbox2" NAME="Checkbox2" onclick="checkAll('isReadOnly_');"></td>                                                        
                <td  class="td_tit_gray_center" height="23">형태</td>  
                <td  class="td_tit_gray_center" height="23" width="150">초기값</td>                                                      
              </tr>  
<%
	while(obj_bpm_form_attr.next()) {
		String attrId = ((BigDecimal)obj_bpm_form_attr.getAttrId()).toString();
		String attrName = (String) obj_bpm_form_attr.getAttrName();
		String attrDesc = (String) obj_bpm_form_attr.getAttrDesc();
		String attrInitValue = (String) obj_bpm_form_attr.getAttrInitValue();
		formVerId = ((BigDecimal) obj_bpm_form_attr.getFormVersionId()).toString();
		String serializer = (String) obj_bpm_form_attr.getSerializer();

		boolean isBinding = obj_bpm_form_attr.getIsBinding().booleanValue();
		String bind = (isBinding) ? "checked" : "";
		
		boolean isReadOnly = obj_bpm_form_attr.getIsReadOnly().booleanValue();
		String readonly = (isReadOnly) ? "checked" : "";
%>
              <tr>                            
                <td class="td_left">                                                                                                   
					<input type="hidden" name="attrId_<%=attrId%>" value="<%=attrId%>">
					<input type="text" class="input" style="width:100%;" name="attrName_<%=attrId%>" value="<%=attrName%>" readonly>
				</td>
				<td  class="td_left">
					<input type="text" class="input" style="width:100%;" name="attrDesc_<%=attrId%>" value="<%=attrDesc%>">
					<input type="hidden" name="formVerId" value="<%=formVerId%>">
				</td>
				<td class="td_center">
					<input type="checkbox" name="isBinding_<%=attrId%>" <%=bind%>>
				</td>
				<td class="td_center">
					<input type="checkbox" name="isReadOnly_<%=attrId%>" <%=readonly%>>
				</td>
				<td class="td_center">
<%--
		String serializerName = "문자형";
		if ( serializer != null ) {
			if ( serializer.endsWith("FormUserSerializer") ) {
				serializerName = "사용자선택";
			} else if ( serializer.endsWith("AttachFileSerializer") ) {
				serializerName = "첨부파일";
			} else if ( serializer.endsWith("ArraySerializer") ) {
				serializerName = "배열";
			}
		}
--%>
					<select size="1" name="serializer_<%=attrId%>" class="input">
<%--													<option value="<%=serializer%>"><%=serializerName%></option>--%>
						<option value="string" <%=("string".equals(serializer) ? "selected" : "")%>>문자형</option>
						<option value="hanwha.bpm.form.attr.FormUserSerializer" <%=("hanwha.bpm.form.attr.FormUserSerializer".equals(serializer) ? "selected" : "")%>>사용자선택</option>
						<option value="hanwha.bpm.form.attr.DynamicTableSerializer" <%=("hanwha.bpm.form.attr.DynamicTableSerializer".equals(serializer) ? "selected" : "")%>>동적테이블</option>
						<option value="hanwha.bpm.form.attr.AttachFileSerializer" <%=("hanwha.bpm.form.attr.AttachFileSerializer".equals(serializer) ? "selected" : "")%>>첨부파일</option>
						<option value="hanwha.bpm.form.attr.ArraySerializer" <%=("hanwha.bpm.form.attr.ArraySerializer".equals(serializer) ? "selected" : "")%>>배열</option>
						<option value="hanwha.bpm.form.attr.FreeContentsSerializer" <%=("hanwha.bpm.form.attr.FreeContentsSerializer".equals(serializer) ? "selected" : "")%>>자유편집</option>
					</select>
				</td>
				<td class="td_center">
<%
		String attrInitValueStr = "";
		if ( attrInitValue != null && !attrInitValue.trim().equals("null") ) {
			attrInitValueStr = attrInitValue;
		}
		if ( serializer.endsWith("ArraySerializer") || serializer.endsWith("AttachFileSerializer") ) {
			String attributeValue = attrId+"_value";
			pageContext.setAttribute(attributeValue, attrInitValueStr, PageContext.REQUEST_SCOPE);
%>												
						<input type="hidden" id="attrInitValue_<%=attrId%>" name="attrInitValue_<%=attrId%>" value="<%=attrInitValueStr%>">
						<%=formHeaderBean.getFileUploadHTML(attributeValue, pageContext, true)%>
						<INPUT TYPE="button" TITLE="첨부하기" NAME="첨부하기" VALUE="첨부하기" onclick="openAttachDlg('attrInitValue_<%=attrId%>', '<%=attrId%>')"/>
<%
		} else {
%>
						<input type="text" name="attrInitValue_<%=attrId%>" value="<%=attrInitValueStr%>" class="input" style="width:100%;" >
<%
		}
%>													
				</td>
			</tr>
<%
	}
%>
		</table>

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
                <td background="<%=IMG%>/themes/common/images/btn_02.gif" class="btn1" nowrap><a href="#" TITLE="ALT+s" ONFOCUS="this.blur();" ONMOUSEOVER="swapClass(this, 'buttonOver')" ONMOUSEOUT="swapClass(this, 'buttonOff')" ONCLICK="save();">저장</a></td>                  
                <td><img src="<%=IMG%>/themes/common/images/btn_03.gif"></td>                                                            
              </tr>                                                                                                                      
            </table>                                                                                                                     
          </td>                                                                                                                          
          <td>                                                                                                                           
            <table border="0" cellspacing="0" cellpadding="0">                                                                           
              <tr>                                                                                                                       
                <td><img src="<%=IMG%>/themes/common/images/btn_01.gif"></td>                                                            
                <td background="<%=IMG%>/themes/common/images/btn_02.gif" class="btn1" nowrap><a href="#" TITLE="ALT+c" ONFOCUS="this.blur();" ONMOUSEOVER="swapClass(this, 'buttonOver')" ONMOUSEOUT="swapClass(this, 'buttonOff')" ONCLICK="window.close();">취소</a></td>                  
                <td><img src="<%=IMG%>/themes/common/images/btn_03.gif"></td>                                                            
              </tr>                                                                                                                      
            </table>                                                                                                                     
          </td>                                                                                                                          
        </tr>                                                                                                                            
      </table>                                                                                                                           
      <!--버튼끝-->  
    </td>                                                                                                                                
  </tr>                                                                                                                                  
</table>   
</form>
</body>
</html>