<%@include file="../../common/headerWithoutTheme.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>

<%@page import="org.uengine.security.*"%>
<%@page import="java.util.HashMap"%>

<%!
	void printTree(Hashtable childs, Hashtable versions, String parent, PrintWriter pw){
		try{	
			if(childs.containsKey(parent)){
				Vector childprocesses = (Vector)childs.get(parent);
				for(Iterator iter = childprocesses.iterator(); iter.hasNext(); ){
				
					String definitionId = (String)iter.next();	//first is definitionId
					ProcessDefinitionRemote process = (ProcessDefinitionRemote)iter.next(); //second is the object
					String definitionType = process.getObjType();
					
					if(process.isFolder()){
						pw.println("<span class='folder'>" + process.getName().getText());
						printTree(childs, versions, definitionId, pw);
						
//						pw.println("<div class='doc'><a href='removeProcessDefinition.jsp?processDefinition=" + definitionId + "'>remove</a></div>");
						pw.println("</span>");
					}else{
						pw.print("<div class='doc'><a href=\"javascript:select('" + definitionId + "', '"+parent+"', '" + definitionType + "')\">" + process.getName().getText() +"</a></div> ");
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

    String objType = request.getParameter("objtype");
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
	//System.out.println("--=------");		
	for(int i=0; i<pds.length; i++){
		//if(pds[i].isAdhoc()) continue;
	
		%>	<definition name="<%=pds[i]%>">
		<%				
		ProcessDefinitionRemote definitionRemote = pds[i];
		String definitionId = definitionRemote.getId();
		String parent = definitionRemote.getParentFolder();
		String definitionGroupId = definitionRemote.getBelongingDefinitionId();

		if(!objType.equals(definitionRemote.getObjType())&& !definitionRemote.isFolder()) continue;
			
		//view filtering
		if(!definitionRemote.isVisible()) continue;
			
		//accessbility filtering
		HashMap h = AclManager.getInstance().getDefIds(loggedUserId);
		if(!h.containsKey(definitionGroupId))continue;


		
		if(definitionGroupId==null)
			definitionGroupId = definitionRemote.getId();
		
		if(!versions.containsKey(definitionGroupId)){
			versions.put(definitionGroupId, new Vector());
		}
		
		Vector v = (Vector)(versions.get(definitionGroupId));
		v.add(definitionRemote);


		//indexing the names for making tree
//		if(parent==null) parent = "root";
		
		if(!childs.containsKey(parent)){
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
    <title><%=GlobalContext.getLocalizedMessageForWeb("process_definitions", loggedUserLocale, "Process Definitions") %></title>
    <link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/DynamicTree.css" />
    <script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/ie5.js"></script>
    <script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/DynamicTree.js"></script>
    <style type="text/css">
    p { font-family: georgia, sans-serif; font-size: 11px; }
    </style>
	<script>
		function select(name, folder,definitionType){
			document.reload.processDefinition.value=name;
			document.reload.folder.value=folder;	
			document.reload.defType.value=definitionType;	
			document.reload.submit();
		}
	</script>
	
	<style TYPE="TEXT/CSS">
	BODY {background:url(../../processmanager/images/empty.gif) #ffffff }
	</style>

</head>
<body>


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
<form name="reload" action="../viewProcessFlowChart.jsp" method="POST" target=definitionList>
	<input type=hidden name="processDefinition">
	<input type=hidden name="defType">
	<input type=hidden name="folder">
	<input type=hidden name="viewOption" value="vertical">
</form>

