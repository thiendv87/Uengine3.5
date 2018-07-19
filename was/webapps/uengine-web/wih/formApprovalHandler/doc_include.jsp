<%@page import="org.uengine.kernel.GlobalContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="../../../common/header.jsp"%>
<%
    response.setHeader("Cache-Control", "no-cache");
%>
<link rel="stylesheet" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/global.css" type="text/css">

<table cellspacing="0" cellpadding="0" width="700" border="0">
    <tbody>
        <tr>
            <td>
            <table cellspacing="0" cellpadding="0" width="100%" border="1">
                <tbody>
                    <tr>
                        <td align="center" width="100">종류</td>
                        <td align="center" width="100">구분</td>
                        <td align="center" rowspan="2">기<br />
                        입<br />
                        항<br />
                        목</td>
                        <td rowspan="2">
                        <table border="0">
                            <tbody>
                                <tr>
                                    <td rowspan="4">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="2">1.기안사유 &rarr; 2.현상 및 문제점 &rarr; 3.대책 및 실시</td>
                                </tr>
                                <tr>
                                    <td width="80%">&nbsp;</td>
                                    <td>&darr;</td>
                                </tr>
                                <tr>
                                    <td colspan="2">6.실시후조처 &larr; 5.예상효과 &larr; 4.소요경비(예산대비)</td>
                                </tr>
                            </tbody>
                        </table>
                        </td>
                        <td align="center" rowspan="2">결<br />
                        <br />
                        재</td>
                        <td width="100">No.</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td align="right">월 일</td>
                    </tr>
                </tbody>
            </table>
            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td width="25%">
                        <table cellspacing="0" cellpadding="0" width="100%" border="1">
                            <tbody>
                                <tr>
                                    <td>관리구분</td>
                                    <td>일상</td>
                                    <td>중점</td>
                                </tr>
                                <tr>
                                    <td>항목 No.</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>취급</td>
                                    <td>일상</td>
                                    <td>비</td>
                                </tr>
                            </tbody>
                        </table>
                        </td>
                        <td>
                        <table cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tbody>
                                <tr height="25">
                                    <td align="center"><font size="3">SX 기 안 용 지 (의안서)</font></td>
                                </tr>
                                <tr height="25">
                                    <td>건 명 : 
  
 <input type="text" name="doc_title" size="40" attrid="TEMP_ATTR_ID" value="" /></td>
                                </tr>
                            </tbody>
                        </table>
                        </td>
                        <td width="30%">
                        <table cellspacing="0" cellpadding="0" width="100%" border="1">
                            <tbody>
                                <tr>
                                    <td>기안일자</td>
                                    <td>년 월 일</td>
                                </tr>
                                <tr>
                                    <td>기안부서</td>
                                    <td>&nbsp;
  
 <input type="hidden" name="receiver__WHICH_IS_XML_VALUE" editable="false" size="1" attrid="TEMP_ATTR_ID" value="" />
  
 <input type="text" name="receiver_value_display" readonly="readonly" attrid="TEMP_ATTR_ID" value="" /><input onclick="getOpenModalPopup('receiver',780,510)" type="button" name="receiver" value="" /></td>
                                </tr>
                                <tr>
                                    <td>기안번호</td>
                                    <td>&nbsp;</td>
                                </tr>
                            </tbody>
                        </table>
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- 내용 editor -->
            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                <tbody>
                    <tr>
                        <td height="500">
                        <div>
  
 <textarea id="CKeditor1" name="CKeditor1" ></textarea>
<script type="text/javascript">
//<![CDATA[
	CKEDITOR.replace('CKeditor1',
	{
		skin : '<%=GlobalContext.getPropertyString("ckeditor.skin", "kama")%>', 
		height : "500px"
	});
	CKEDITOR.config.protectedSource.push( /<\%[\s\S]*?\%>/g );
//]]>
</script>
                        </td>
                    </tr>
                </tbody>
            </table>
            <table cellspacing="0" cellpadding="0" width="100%" border="1">
                <tbody>
                    <tr>
                        <td width="100">발주선</td>
                        <td>&nbsp;</td>
                        <td width="100">금액</td>
                        <td>&nbsp;</td>
                        <td width="100">납기</td>
                        <td>&nbsp;</td>
                    </tr>
                </tbody>
            </table>
            <!-- 첨부 파일 -->
            <table cellspacing="0" cellpadding="0" width="100%" border="1">
                <tbody>
                    <tr>
                        <td height="100">첨부파일</td>
                    </tr>
                </tbody>
            </table>
            </td>
        </tr>
    </tbody>
</table>