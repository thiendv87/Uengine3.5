<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>
<%!
	void printTree(Hashtable childs, Hashtable versions, String parent, PrintWriter pw){
		try{	
			if(childs.containsKey(parent)){
				Vector childprocesses = (Vector)childs.get(parent);
				for(Iterator iter = childprocesses.iterator(); iter.hasNext(); ){
				
					String definitionId = (String)iter.next();	//first is definitionId
					ProcessDefinitionRemote process = (ProcessDefinitionRemote)iter.next(); //second is the object
					
					if(process.isFolder()){
						pw.println("<span class='folder'>" + process.getName().getText());
						printTree(childs, versions, definitionId, pw);
						
//						pw.println("<div class='doc'><a href='removeProcessDefinition.jsp?processDefinition=" + definitionId + "'>remove</a></div>");
						pw.println("</span>");
					}else{
						
						//Vector versions_ = (Vector)versions.get(definitionId);
						
						//pw.print("<span class='folder'>" + process.getName().getText());
	
						//for(Iterator iter2 = versions_.iterator(); iter2.hasNext(); ){
							//ProcessDefinitionRemote version = (ProcessDefinitionRemote)iter2.next();
							//String pd = version.getId();
							//int versionValue = version.getVersion();
							//pw.print("<div class='doc'><a href=\"javascript:select('" + pd + "', '" + process.getName().getText() + "')\">v" + versionValue +"</a></div> ");
							pw.print("<div class='doc'><a href=\"javascript:select('" + definitionId + "', '" + process.getName().getText() + "', '" + process.getAlias() + "')\">" + process.getName().getText() +"</a></div> ");
							//pw.print("<span class='doc' onclick=\"alert('ggx');select('" + pd + "', '" + process.getName().getText() + "');\">v" + versionValue +"</span> ");
						//}
						
						//pw.println("</span>");			
					}
				}
			}
			
//			pw.println("<div class='doc'><a href='ProcessDesigner.jnlp?folderId=" + parent + "' alt='New definition'>add process</a></div>"); 
//			pw.println("<div class='doc'><a href=\"javascript:addFolder('" + parent + "')\" alt='New folder'>add folder</a></div>"); 
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
%>
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<XML>
<%
	ProcessManagerRemote pm = processManagerFactory.getProcessManagerForReadOnly();

	ProcessDefinitionRemote[] pds = null;
	try{
		pds= pm.listProcessDefinitionRemotesLight();
	}finally{
		pm.remove();
	}
	
	Hashtable childs = new Hashtable();	
	Hashtable versions = new Hashtable();
	
	%><processdefinitions>
	<%
	for(int i=0; i<pds.length; i++){
		//if(pds[i].isAdhoc()) continue;
	
		%>	<definition name="<%=pds[i]%>">
		<%				
		ProcessDefinitionRemote definitionRemote = pds[i];
		String definitionId = definitionRemote.getId();
		String parent = definitionRemote.getParentFolder();
		
/*		
		if(version==null){
			nameOnly = definitionName.trim();
			version = "1";
		}
*/
		
		//indexing the names for searching versions
		
		String definitionGroupId = definitionRemote.getBelongingDefinitionId();

		if (definitionGroupId==null) {
			definitionGroupId = definitionRemote.getId();
		}
		
		if (!versions.containsKey(definitionGroupId)) {
			versions.put(definitionGroupId, new Vector());
		}
		
		Vector v = (Vector)(versions.get(definitionGroupId));
		v.add(definitionRemote);
		//

		//indexing the names for making tree
//		if(parent==null) parent = "root";
		
		if (!childs.containsKey(parent)) {
			childs.put(parent, new Vector());
		}
		
		v = (Vector)(childs.get(parent));
		if(!v.contains(definitionGroupId)){
			v.add(definitionGroupId);
			v.add(definitionRemote);
		}
		//

	}

	StringWriter sw = new StringWriter();
	PrintWriter spw = new PrintWriter(sw);
	printTree(childs, versions, "-1", spw);
	
%>		        
</processdefinitions>
</XML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Process Definitions</title>
    <link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/DynamicTree.css" />
    <script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/ie5.js"></script>
    <script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/DynamicTree.js"></script>
    <style type="text/css">
    p { font-family: georgia, sans-serif; font-size: 11px; }
    </style>
	<script>
		function select(id, name, alias){
			var arrResult = new Array(2);
			arrResult[0] = id;
			arrResult[1] = name;
			arrResult[2] = alias;
			window.returnValue = arrResult;
			parent.close();
		}
	</script>
</head>
<body>
<img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/icon_root.gif" align="middle" width="10" height="11" border="0"> 
<font size=-1 face='Tahoma'><b>Process Definitions</b>[
<a href="javascript:document.location.reload()"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/refresh.gif" alt="Refresh" border=0></a>
]</font>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr height="1">
		<td align="center" colspan="3" height="1" bgcolor=#dddddd></td>
	</tr>			
</table>

<div class="DynamicTree">
	<!--div class="top">Process Definitions</div-->
        <div class="wrap" id="tree">
			<%=sw.toString()%>
		</div>
	<!--/div-->
</div>
<script type="text/javascript">
    var tree = new DynamicTree("tree", "<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/tree/");
    tree.init();
</script>
</body>
</html>
