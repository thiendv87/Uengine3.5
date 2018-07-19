<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr height="1">
		<td align="center" height="1" class="bgcolor_head_upperline"></td>
	</tr>
	<tr height="5">
		<td align="center" height="5" class="bgcolor_head"></td>
	</tr>
	<tr height="1">
		<td align="center" height="1" class="bgcolor_head_underline"></td>
	</tr>
</table>

<%	
//	String keyword = request.getParameter(KeyedParameter.KEYWORD);
/*	String actName = (String)pm.getActivityProperty(initiationProcessDefinition, tracingTag, "name");
	keyword = keyword + " " + actName;*/

	keyword = initiationActivity.getKeyword().getText();	
	

	if(keyword==null || keyword.trim().length()==0){	
		keyword = initiationActivity.getName().getText();
	}

	//keyword = keyword.replace(' ', '');	
	//keyword = new String(keyword.getBytes("8859_1"), "KSC5601");
	String keywords = keyword;//This variable need for showRelatedKnowledgeFromLiferaySearch.jsp
	keyword = java.net.URLEncoder.encode(keyword, "UTF-8");
%>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
			
	<tr height="30" >
		<td width="*" align=left>
			<iframe frameborder=0 width=100% src="http://www.google.co.kr/search?hl=ko&q=<%=keyword%>&frm=t1" scroll="no"></iframe>
			<!--%@include file="showRelatedKnowledgeFromLiferaySearch.jsp"%-->
							
		</td>
	</tr>
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>
</table>