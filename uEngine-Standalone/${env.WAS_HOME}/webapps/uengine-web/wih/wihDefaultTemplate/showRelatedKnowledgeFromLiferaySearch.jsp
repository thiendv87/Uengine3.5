
<%@ page import="com.liferay.portal.kernel.search.OpenSearch" %>
<%@ page import="com.liferay.portal.kernel.search.SearchException" %>
<%@ page import="com.liferay.portal.kernel.util.InstancePool" %>
<%@ page import="com.liferay.portal.search.OpenSearchUtil" %>
<%@ page import="com.liferay.portal.util.SAXReaderFactory" %>
<%@ page import="com.liferay.portlet.documentlibrary.model.DLFileEntry" %>
<%@ page import="com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceUtil" %>

<%@ page import="org.dom4j.Document" %>
<%@ page import="org.dom4j.Element" %>
<%@ page import="org.dom4j.io.SAXReader" %>

<uengine-liferay:themeheader />

<%
	String primarySearch = "";

	LiferaySearch test = new LiferaySearch();
	List portlets = test.getSearchResult(request, pageContext, primarySearch);
%>

<head>
<style TYPE="TEXT/CSS">
BODY {background:url(../../processmanager/images/empty.gif) #ffffff }
th { font-size:10pt;}
</style>

	
</head>

<br/><font size=10>
<table>
<%
		for(int i=0; i < portlets.size() ; i++){
			Portlet portlet = (Portlet)portlets.get(i);
			
			OpenSearch openSearch = (OpenSearch)InstancePool.get(portlet.getOpenSearchClass());
			
			List headerNames = new ArrayList();

			headerNames.add("#");
			headerNames.add("summary");
			
			//SearchContainer searchContainer = new SearchContainer(null, null, null, SearchContainer.DEFAULT_CUR_PARAM + i, SearchContainer.DEFAULT_DELTA, null, headerNames, "no-results-were-found-that-matched-the-keywords-x");
			SearchContainer searchContainer = new SearchContainer(null, null, null, SearchContainer.DEFAULT_CUR_PARAM + i, SearchContainer.DEFAULT_DELTA, null, headerNames, LanguageUtil.format(pageContext, "no-results-were-found-that-matched-the-keywords-x", "<b>" + Html.escape(keywords) + "</b>"));
			
			if (i > 0) {
				searchContainer.setDelta(5);
			}
			
			String portletTitle = portlet.getDisplayName();
			
			List resultRows = new ArrayList();
			
			try {
				String xml = openSearch.search(request, keywords, searchContainer.getCurValue(), searchContainer.getDelta());
				
				SAXReader reader = SAXReaderFactory.getInstance();
				
				Document doc = reader.read(new StringReader(xml));

				Element root = doc.getRootElement();

				List entries = root.elements("entry");
				
				int total = GetterUtil.getInteger(root.elementText(OpenSearchUtil.getQName("totalResults", OpenSearchUtil.OS_NAMESPACE)));

				searchContainer.setTotal(total);

				resultRows = searchContainer.getResultRows();				
				
				for (int j = 0; j < entries.size(); j++) {
					Element el = (Element)entries.get(j);

					ResultRow row = new ResultRow(doc, String.valueOf(j), j);

					// Position

					row.addText(searchContainer.getStart() + j + 1 + StringPool.PERIOD);

					// Summary

					String entryTitle = el.elementText("title");
					String entryHref = el.element("link").attributeValue("href");
					String summary = el.elementText("summary");

					if (portlet.getPortletId().equals(PortletKeys.DOCUMENT_LIBRARY)) {
						long folderId = GetterUtil.getLong(Http.getParameter(entryHref, "_20_folderId", false));
						String name = GetterUtil.getString(Http.getParameter(entryHref, "_20_name", false));

						DLFileEntry fileEntry = DLFileEntryLocalServiceUtil.getFileEntry(folderId, name);

						entryTitle = fileEntry.getTitle();
					}

					StringMaker sm = new StringMaker();

					sm.append("<a href=\"");
					sm.append(entryHref);
					sm.append("\"");

					if (portlet.getPortletId().equals(PortletKeys.JOURNAL)) {
						sm.append(" target=\"_blank\"");
					}

					sm.append(">");
					sm.append("<span style=\"font-size: x-small; font-style: italic;\">");
					sm.append(entryTitle);
					sm.append("</span><br />");
					sm.append(summary);
					sm.append("</a>");

					row.addText(StringUtil.highlight(sm.toString(), keywords));

					// Score

					String score = el.elementText(OpenSearchUtil.getQName("score", OpenSearchUtil.RELEVANCE_NAMESPACE));

					//row.addText(score);

					// Add result row

					resultRows.add(row);
				}
			}
			catch (Exception e) {
				
			}
			
			%>

	<div style="padding-bottom: 5px;">
		<font size=3><b><%= portletTitle %></b></font>
	</div>		
		<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" paginate="<%= false %>" />
	<br/>
		<%	
		}
		
		%>
</table></font>