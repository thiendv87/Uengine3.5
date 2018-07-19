<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/html; charset=UTF-8");%>
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
			else if (name.startsWith("contents")) {
				attrModel = (AttrModel) map.get(attrId);
				attrModel.setValidationContents(GWUtil.toEncode(request.getParameter(name)));
			}
			else if (name.startsWith("isValid")) {
				attrModel = (AttrModel) map.get(attrId);
				boolean isValid = (request.getParameter(name).equals("on")) ? true : false;
				attrModel.setValidationYN(isValid);
			}
		}
		System.out.println("Enumeration end...");
		
//		AttrDAO attrDao = new AttrDAO();
		
		for (Iterator i = map.values().iterator(); i.hasNext();)
		{
			AttrModel attrModel = (AttrModel) i.next();
			
			System.out.println(attrModel);

//			formBF.updateFormAttr(attrModel);
			formBF.updateMandatoryFormAttrValidById(attrModel.getAttrid(), attrModel.getValidationContents(), attrModel.isValidationYN());
		}

	}
	
	// 폼 변수 리스트.
//	String query_bpm_form_attr = "select * from BPM_FORM_ATTR where formId = ?formId and isdelete = 0";
//    BPM_FORM_ATTR obj_bpm_form_attr = (BPM_FORM_ATTR) GenericDAO.createDAOImpl("java:/uEngineDS", query_bpm_form_attr, BPM_FORM_ATTR.class);
//    obj_bpm_form_attr.setFormid(new BigDecimal(formId));
//    obj_bpm_form_attr.select();
	FormAttrDAO obj_bpm_form_attr = formBF.getFormAttrList(Long.parseLong(formVerId));
	
	
	
	System.out.println("ya~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
%>
<html>
<head>
<title>필수 입력 항목 설정</title>
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
	
	var currContField;

	function selectRow(contentsName){
	//alert(contentsName);
		var contentsField = document.getElementById(contentsName);
		if( currContField ){
//			currContField.style.width = "0px";
//			currContField.style.height = "0px";
			currContField.style.display = "none";
		}
//		contentsField.style.width = "100%";
//		contentsField.style.height = "350px";
//		contentsField.style.height = "293px";
		contentsField.style.display = "block";
		currContField = contentsField;
	}
</script>
</head>

<body bgcolor="#F7F7F7"  style="padding:7 10 10 10">
<form name="elementForm" method="post" action="?action=save">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr><td class="popup_line"></td></tr>
  <tr>
    <td class="popup_title">필수 입력 항목 설정</td>
  </tr>
  <tr><td class="popup_line"></td> </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr> 
  <td class="margin_p_btn"></td>   
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top"> 
      <!-- 오른쪽테이블 시작 --------------------------------------------->
      <table width="300" border="0" cellspacing="0" cellpadding="0" style="padding-top:2px;">
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
              <tr> 
                <td nowrap height="16" valign="top" background="<%=IMG%>/themes/common/images/tab-back06.gif"><img src="<%=IMG%>/themes/common/images/tab-back01.gif"  align="absmiddle"></td>
                <td class="tab_p_on" nowrap height="16"> 필수 입력 항목 설정</td>
                <td nowrap height="16" valign="top" background="<%=IMG%>/themes/common/images/tab-back06-1.gif"><img src="<%=IMG%>/themes/common/images/tab-back02.gif"  align="absmiddle" width="4" height="24"></td>
              </tr>
              <tr> 
                <td width="4" background="<%=IMG%>/themes/common/images/tab-back06.gif"></td>
                <td class="org_body" valign="top"> 
                  <table width="100%" height="100%" class="org_box">
                    <tr> 
                      <td valign="top" height="100%">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
						   <tr><td class="org_line_s"></td></tr><tr>
						</table>
					    <div id="table01" style="overflow:auto;height: 270;" >					
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						  <tr> 
						    <td class="org_tit_bar_s" width="50%"> 이름</td>
						    <td class="org_tit_bar" width="50%" >설명</td>
						    <td class="org_tit_bar" nowrap width="40" >필수</td>
						  </tr>
						  
<%
	while(obj_bpm_form_attr.next()) {
		String attrId = ((BigDecimal)obj_bpm_form_attr.getAttrId()).toString();
		String attrName = (String) obj_bpm_form_attr.getAttrName();
		String attrDesc = (String) obj_bpm_form_attr.getAttrDesc();
		String attrInitValue = (String) obj_bpm_form_attr.getAttrInitValue();
		formVerId = ((BigDecimal) obj_bpm_form_attr.getFormVersionId()).toString();
		String serializer = (String) obj_bpm_form_attr.getSerializer();

//		boolean isBinding = obj_bpm_form_attr.getIsBinding().booleanValue();
		boolean isValid = obj_bpm_form_attr.getValidationYN().booleanValue();
		String strChecked = (isValid) ? "checked" : "";
%>
							<tr>
								<td class="list_left"><A HREF="javascript:selectRow('contents_<%=attrId%>');"><%=attrName%></A>
									<input type="hidden" name="attrId_<%=attrId%>" value="<%=attrId%>">
								</td>
								<td class="list_left"><A HREF="javascript:selectRow('contents_<%=attrId%>');"><%=attrDesc%></A>
									<input type="hidden" name="formVerId" value="<%=formVerId%>">
								</td>
								<td class="list_center">
									<p align="center" onclick="selectRow('contents_<%=attrId%>');">&nbsp;<input type="checkbox" name="isValid_<%=attrId%>" <%=strChecked%>>&nbsp;</p>
								</td>
								<!-- <td align="center">
									<textarea id="contents_<%=attrId%>" name="contents_<%=attrId%>" style="width:90%;height:20px;">aaa</textarea>
								</td> -->
							</tr>
<%
	}
%>
						</table>	
				       </div>						
                      </td>
                    </tr>
                  </table>
                </td>
                <td width="4" background="<%=IMG%>/themes/common/images/tab-back06-1.gif">&nbsp;</td>
              </tr>
              <tr> 
                <td width="4"><img src="<%=IMG%>/themes/common/images/tab-back07.gif"></td>
                <td height="5" background="<%=IMG%>/themes/common/images/tab-back08.gif"></td>
                <td width="4"><img src="<%=IMG%>/themes/common/images/tab-back09.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <!-- 오른쪽테이블 끝 ----------------------------------------------->
    </td>
    <td align="right">
      <!-- 왼쪽테이블 시작 --------------------------------------------->
      <table width="380" height="320" border="0" cellspacing="0" cellpadding="0" style="padding-top:2px;">
        <tr> 
          <td> 
            <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
              <tr> 
                <td nowrap height="16" valign="top" background="<%=IMG%>/themes/common/images/tab-back06.gif"><img src="<%=IMG%>/themes/common/images/tab-back01.gif"  align="absmiddle"></td>
                <td class="tab_p_on" nowrap height="16"> 스크립트 편집</td>
                <td nowrap height="16" valign="top" background="<%=IMG%>/themes/common/images/tab-back06-1.gif"><img src="<%=IMG%>/themes/common/images/tab-back02.gif"  align="absmiddle" width="4" height="24"></td>
              </tr>
              <tr> 
                <td width="4" background="<%=IMG%>/themes/common/images/tab-back06.gif"></td>
                <td class="org_body" valign="top"> 
                  <table width="100%" height="100%" class="org_box">
                    <tr> 
                      <td valign="top" height="100%">
<%
	obj_bpm_form_attr.beforeFirst();
	while(obj_bpm_form_attr.next()) {
		String attrId = ((BigDecimal)obj_bpm_form_attr.getAttrId()).toString();
		String validationCont = (String) obj_bpm_form_attr.getValidationContents();
		if( validationCont == null ){
			validationCont = "";
		}
%>
						<div id="contents_<%=attrId%>" style="display:none;position:absolute; left:350; top:100" >
						<table width="370" height="100">
							<tr>
								<td>
									<textarea name="contents_<%=attrId%>" style="width:350px;height:250px;wordWrap:break-word;"><%=validationCont%></textarea>								
								</td>
							</tr>
						</table>
						</div>
							
<%
	}
%>

                      </td>
                    </tr>
                  </table>
                </td>
                <td width="4" background="<%=IMG%>/themes/common/images/tab-back06-1.gif">&nbsp;</td>
              </tr>
              <tr> 
                <td width="4"><img src="<%=IMG%>/themes/common/images/tab-back07.gif"></td>
                <td height="5" background="<%=IMG%>/themes/common/images/tab-back08.gif"></td>
                <td width="4"><img src="<%=IMG%>/themes/common/images/tab-back09.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <!-- 왼쪽테이블 끝 ----------------------------------------------->    
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">                                                              
  <tr><td background="<%=IMG%>/themes/common/images/back-dash.gif" height="1"></td></tr>                                                                                                                   
</table>     
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr> 
  <td class="margin_p_btn"></td>
</tr>
</table>
<!--버튼시작-->                                                                                                                    
<table border="0" cellspacing="0" cellpadding="0" align="center" class="btn_space">                                                
<tr>                                                                                                                             
  <td>                                                                                                                           
    <table border="0" cellspacing="0" cellpadding="0">                                                                           
      <tr>                                                                                                                       
        <td><img src="<%=IMG%>/themes/common/images/btn_01.gif"></td>                                                            
        <td background="<%=IMG%>/themes/common/images/btn_02.gif" class="btn1" nowrap><a href="#" TITLE="ALT+s" ACCESSKEY="a" CLASS="buttonOff" NAME="저장" VALUE="저장" ONFOCUS="this.blur();" ONMOUSEOVER="swapClass(this, 'buttonOver')" ONMOUSEOUT="swapClass(this, 'buttonOff')" ONCLICK="save();">저장</a></td>                  
        <td><img src="<%=IMG%>/themes/common/images/btn_03.gif"></td>                                                            
      </tr>                                                                                                                      
    </table>                                                                                                                     
  </td>                                                                                                                          
  <td>                                                                                                                           
    <table border="0" cellspacing="0" cellpadding="0">                                                                           
      <tr>                                                                                                                       
        <td><img src="<%=IMG%>/themes/common/images/btn_01.gif"></td>                                                            
        <td background="<%=IMG%>/themes/common/images/btn_02.gif" class="btn1" nowrap><a href="#" TITLE="ALT+c" ACCESSKEY="c" CLASS="buttonOff" NAME="취소" VALUE="취소" ONFOCUS="this.blur();" ONMOUSEOVER="swapClass(this, 'buttonOver')" ONMOUSEOUT="swapClass(this, 'buttonOff')" ONCLICK="window.close();">취소</a></td>                  
        <td><img src="<%=IMG%>/themes/common/images/btn_03.gif"></td>                                                            
      </tr>                                                                                                                      
    </table>                                                                                                                     
  </td>                                                                                                                          
</tr>                                                                                                                            
</table>                                                                                                                           
<!--버튼끝-->                                        
</form>
</body>
</html>