<%@ page contentType="text/html;charset=UTF-8"%>

<%@ page import="java.io.File"%>
<%@ page import="java.net.URI"%>
<%@ page import="java.net.URISyntaxException"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.StringTokenizer"%>

<%!
static class ClassLoaderInfo
{
    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");

    public Map getLoadingClassInfo(String className)
    {
        Map result = new HashMap();
        List cl = null;
        try
        {
            cl = getClassLoadersOfClass(className);
        }
        catch(Throwable e)
        {
            result.put("X_ERROR", e);
            return result;
        }
        if(cl != null) result.put("X_CLASSLOADERS", cl);
        String resourceName = classNameToResourceName(className);
        URL url = getClass().getResource(resourceName);
        try
        {
            result.put("X_FILE_NAME", url.toURI().toString());
            File file = getFileFromURI(url.toURI());
            if(file.exists())
            {
                result.put("X_FILE_DATE", sdf.format(new Date(file.lastModified())));
            }
        }
        catch(URISyntaxException e) { }
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

    public List getClassLoaderInfos(String className)
    {
        List result = new ArrayList();
        for(ClassLoader cl = getClass().getClassLoader(); cl != null; cl = cl.getParent())
            result.add(cl.getClass().getName());

        result.add("Bootstrap classloader");
        return result;
    }

    public List getBootClassInfos()
    {
        return separatePath(System.getProperty("sun.boot.class.path"));
    }

    public List getExtClassInfos()
    {
        return getJars(System.getProperty("java.ext.dirs"));
    }

    public List getAppClassInfos()
    {
        return separatePath(System.getProperty("java.class.path"));
    }

    private List separatePath(String classpath)
    {
        StringTokenizer st = new StringTokenizer(classpath, File.pathSeparator);
        List result = new ArrayList();
        for(; st.hasMoreTokens(); result.add(st.nextToken()));
        return result;
    }

    private List getClassLoadersOfClass(String className) throws Throwable
    {
        Class c = Class.forName(className.trim());
        List result = new ArrayList();
        for(ClassLoader cl = c.getClassLoader(); cl != null; cl = cl.getParent())
            result.add(cl.getClass().getName());

        result.add("Bootstrap classloader");
        return result;
    }

    private String classNameToResourceName(String className)
    {
        String resourceName = className;
        if(!resourceName.startsWith("/"))
            resourceName = (new StringBuilder()).append("/").append(resourceName).toString();
        resourceName = resourceName.replace('.', '/');
        resourceName = (new StringBuilder()).append(resourceName).append(".class").toString();
        return resourceName;
    }

    private List getJars(String directoryName)
    {
        File directory = new File(directoryName);
        if(!directory.exists())
            return new ArrayList();
        List result = new ArrayList();
        String allFiles[] = directory.list();
        if(allFiles != null)
        {
            for(int i = 0; i < allFiles.length; i++)
                if(allFiles[i].endsWith(".jar"))
                {
                    File f = new File(directory, allFiles[i]);
                    result.add(f.getPath());
                }

        }
        return result;
    }

}
%>
<%
 ClassLoaderInfo cl = new ClassLoaderInfo();
 String className = request.getParameter("className");
 
 Map classInfo = null;
 if (className != null && className.trim().length() > 0) {
    classInfo = cl.getLoadingClassInfo(className);
 }
 
 List bootClasses = cl.getBootClassInfos();
 List extClasses = cl.getExtClassInfos();
 List appClasses = cl.getAppClassInfos();
%>

<html>
<head>
<title>Nextree Classloader Information</title>
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
<p class="c_title">Nextree Classloader Information</p>

<form>
Class Name: <input type="text" name="className" size="100"/>
</form>
<% if (classInfo != null && classInfo.get("X_ERROR") != null) { 
  Throwable t = (Throwable) classInfo.get("X_ERROR");
%>
<p>No such class : <%=t.getClass().getName()%> (<%=t.getMessage()%>)</p>
<% } else if (classInfo != null) { %>

<p>
<table>
<tr>
<th class="th_classinfo">Class Name</th>
<td class="td_classinfo"><%=className%></td>
</tr>
<tr><th class="th_classinfo">Classloaders</th>
<td class="td_classinfo">
<%
    List classLoaders = (List) classInfo.get("X_CLASSLOADERS");
    for(int i = 0; i < classLoaders.size(); i++) {
        String classLoader = (String) classLoaders.get(i);
%>
<%=classLoader%><br>
<% } %>
</td>
</tr>
<tr><th class="th_classinfo">File Name</th><td class="td_classinfo"><%=classInfo.get("X_FILE_NAME")%></td></tr>
<tr><th class="th_classinfo">Modified Date</th><td class="td_classinfo"><%=classInfo.get("X_FILE_DATE")%></td></tr>
</table>
</p>
<% } %>

<p>
<table>
<tr><th class="th_classloader">Boot Classes (from sun.boot.class.path)</th></tr>
<%
    for(int i = 0; i < bootClasses.size(); i++) {
        String path = (String) bootClasses.get(i);
%>
<tr><td><%=path%></td></tr>
<% } %>
</table>
</p>


<p>
<table>
<tr><th class="th_classloader">Extension Classes (from java.ext.dirs)</th></tr>
<%
    for(int i = 0; i < extClasses.size(); i++) {
        String path = (String) extClasses.get(i);
%>
<tr><td><%=path%></td></tr>
<% } %>
</table>
</p>

<p>
<table>
<tr><th class="th_classloader">Application Classes  (from java.class.path)</th></tr>
<%
    for(int i = 0; i < appClasses.size(); i++) {
        String path = (String) appClasses.get(i);
%>
<tr><td><%=path%></td></tr>
<% } %>
</table>
</p>

</body>
</html>
