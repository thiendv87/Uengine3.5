<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../../common/header.jsp"%>
<%@include file="../../../common/getLoggedUser.jsp"%>
<%@ page import="org.uengine.ui.list.datamodel.DataMap"%>
<%@ page import="org.uengine.ui.list.datamodel.DataList"%>
<%@page import="com.defaultcompany.web.tag.TagDAO"%>
<%@ taglib uri="http://www.uengine.org/taglibs/bpm" prefix="bpm" %>
<%
int intPageCnt = 50;
int nPagesetSize = 10;
int currentPage = reqMap.getInt("CURRENTPAGE", 1);

TagDAO dao = new TagDAO();
DataList dl = dao.getTagList(currentPage, intPageCnt, loggedUserGlobalCom);
int totalCount = (int)dl.getTotalCount();
StringBuffer row = new StringBuffer();

if(totalCount > 0) {
    DataMap tmpMap = null;
    row.append("<div class=\"tagcloud\">");
    for ( int i=0; i<dl.size(); i++ ) {
        tmpMap = (DataMap)dl.get(i);

        row.append("<a href=\"#\" onclick=\"parent.addTag('").append( tmpMap.getString("name", "") ).append("');\">");
        
        if (tmpMap.getInt("cnt", 0) > 100) {
            row.append("<strong><em>");
        } else if (tmpMap.getInt("cnt", 0) > 50) {
            row.append("<strong>");
        } else if (tmpMap.getInt("cnt", 0) > 10) {
            row.append("<em>");
        }
        
        row.append(tmpMap.getString("name", ""));
        
        if (tmpMap.getInt("cnt", 0) > 100) {
            row.append("</em></strong>");
        } else if (tmpMap.getInt("cnt", 0) > 50) {
            row.append("</strong>");
        } else if (tmpMap.getInt("cnt", 0) > 10) {
            row.append("</em>");
        }
        row.append("</a>");
        
        row.append(" | ");
    }
    row.append("</div>");
    row.append("<br />");
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../../../lib/jquery/importJquery.jsp" %>
<%@include file="../../../common/styleHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT%>/style/tag.css" />
<title>Tag List</title>
<script type="text/javascript">
function goPage(page){
    refreshForm.CURRENTPAGE.value = page;
    refreshForm.submit();
}
</script>
</head>
<body>
<%
if (totalCount > 0) {
	out.println(row.toString());
	out.println("<br />");
%>
<!--    #####   Navigation start        #####   -->
<table width="100%">
    <tr>
        <td align="center">
            <br style="line-height: 15px;" />
            <bpm:page link="" totalcount="<%=totalCount%>" pagecount="<%=intPageCnt%>" pagelimit="<%=nPagesetSize%>"
            currentpage="<%=currentPage%>" locale="<%=loggedUserLocale%>" />
            <br />
        </td>
    </tr>
</table>
<form name="refreshForm" method="post" action="tagList.jsp" target="">
    <input type="hidden" name="CURRENTPAGE" value="<%=currentPage %>" />
</form>
<%
}
%>
</body>
</html>