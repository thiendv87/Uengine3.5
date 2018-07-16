<%@ page contentType="text/html;charset=UTF-8"%>

<%@ page import="java.io.File"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.net.URI"%>
<%@ page import="java.net.URISyntaxException"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>


<%!
static class ResourceInfo
{

    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");

    public Map getLoadingResourceInfo(String resourceName)
    {
        Map result = new HashMap();
        
        ClassLoader classLoader = getClass().getClassLoader();
        URL url = classLoader.getResource(resourceName);
        Enumeration urls = null;
        try {
			urls = getClass().getClassLoader().getResources(resourceName);
		} catch (IOException e) {
		}
        
        if (url != null) {
        	try {
				result.put("X_LOADING_RESOURCE_FILE", url.toURI().toString());
				File file = getFileFromURI(url.toURI());
				if (file.exists()) {
					result.put("X_LOADING_RESOURCE_DATE", sdf.format(new Date(file.lastModified())));
				}
			} catch (URISyntaxException e) {
			}
        }
        
        if (urls != null) {
        	ArrayList resources = new ArrayList();
        	while(urls.hasMoreElements()) {
        		URL u = (URL) urls.nextElement();
        		try {
					resources.add(u.toURI().toString());
				} catch (URISyntaxException e) {
					resources.add(e.getMessage());
				}
        	}
        	result.put("X_RESOURCES", resources);
        } else {
        	result.put("X_RESOURCES", new ArrayList());
        }
        
        return result;
    }

    public File getFileFromURI(URI uri)
    {
        File result = null;
        String schema = uri.getScheme();
        if("file".equals(schema))
            result = new File(uri);
        else
        if("zip".equals(schema))
        {
            String uriStr = uri.getSchemeSpecificPart();
            String file = uriStr.substring(0, uriStr.indexOf('!'));
            result = new File(file);
        } else
        if("jar".equals(schema))
        {
            String uriStr = uri.getSchemeSpecificPart();
            String file = uriStr.substring(6, uriStr.indexOf('!'));
            result = new File(file);
        }
        return result;
    }

}
%>
<%
 ResourceInfo ri = new ResourceInfo();
 String resourceName = request.getParameter("resourceName");
 
 Map resourceInfo = null;
 if (resourceName != null && resourceName.trim().length() > 0) {
    resourceInfo = ri.getLoadingResourceInfo(resourceName);
 }

%>

<html>
<head>
<title>Nextree Resource Information</title>
<style type="text/css">
.c_title{
    font-size:20px;
}

.th_classinfo{
    text-align:left;
    color:#fff;
    background-color:#000;
}
.td_classinfo{
    text-align:left;
    background-color:#ccc;
}

.th_classloader{
    width:700px;
    text-align:left;
    color:#fff;
    background-color:#000;
}
</style>
</head>

<body>
<p class="c_title">Nextree Resource Information</p>

<form>
Resource Name: <input type="text" name="resourceName" size="100"/>
</form>
<% if (resourceInfo != null && resourceInfo.get("X_ERROR") != null) { %>
<p><%=resourceInfo.get("X_ERROR")%></p>
<% } else if (resourceInfo != null) { %>
<p>
<table>
<tr>
<th class="th_classinfo">Resource Name</th>
<td class="td_classinfo"><%=resourceName%></td>
</tr>
<tr><th class="th_classinfo">File Name</th><td class="td_classinfo"><%=resourceInfo.get("X_LOADING_RESOURCE_FILE")%></td></tr>
<tr><th class="th_classinfo">Modified Date</th><td class="td_classinfo"><%=resourceInfo.get("X_LOADING_RESOURCE_DATE")%></td></tr>
</table>
</p>

<p>
<table>
<tr><th class="th_classloader">Available Resources</th></tr>
<%
    List resources = (List) resourceInfo.get("X_RESOURCES");
    for(int i = 0; i < resources.size(); i++) {
        String path = (String) resources.get(i);
%>
<tr><td><%=path%></td></tr>
<% } %>
</table>
</p>

<% } %>

</body>
</html>
