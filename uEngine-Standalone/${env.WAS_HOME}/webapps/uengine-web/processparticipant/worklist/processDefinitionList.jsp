<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>

<%!
	void printTree(Hashtable childs, Hashtable versions, String parent, PrintWriter pw){
		try{	
			String css = "";
				
			if(childs.containsKey(parent)){
				Vector childprocesses = (Vector)childs.get(parent);
				for(Iterator iter = childprocesses.iterator(); iter.hasNext(); ){
				
					String id = (String)iter.next();	//first is id
					ProcessDefinitionRemote process = (ProcessDefinitionRemote)iter.next(); //second is the object
					
					if(process.isFolder()){
						if(parent.equals("-1")){
							css = "item1";
							pw.println("<td>");
						}else
							css = "item2 arrow";
					
						pw.print("<a class='" + css + "' href=''> " + process.getName());
						
						if(!parent.equals("-1")){
							pw.print("<img src='../images/arrow1.gif' width='10' height='12' alt='' />");
						}
						
						pw.println("</a>");
						
						pw.println("<div class='section'>");
						printTree(childs, versions, id, pw);
						pw.println("</div>");

						if(parent.equals("-1"))
							pw.println("</td>");
					}else{
						if(parent.equals("-1")){
							css = "item1";
							pw.println("<td>");
						}else
							css = "item2";

						pw.print("<a class='" + css + "' href='javascript:view(\"" + id + "\", \"" + parent + "\")'>" + process.getName() + "</a> ");

						if(parent.equals("-1")){
							pw.println("</td>");
						}
					}
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
%>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	if(!"yes".equals(request.getParameter("omitHeader"))){
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Process Participant</title>
    <style type="text/css">
    body {
        font: 11px Tahoma;
        background: #ffffff;
        margin: 0;
        padding: 10px;
    }    
    </style>
    <link rel="stylesheet" type="text/css" href="../../style/example.css" />
    <script type="text/javascript" src="../../scripts/ie5.js"></script>
    <script type="text/javascript" src="../../scripts/DropDownMenuX.js"></script>
	<script>
		function view(name, folder){
			document.forms[0].processDefinition.value=name;
			document.forms[0].folder.value=folder;		
			document.forms[0].submit();
		}
	</script>
</head>
<body>

<table cellspacing="0" cellpadding="0" id="menu1" class="ddmx">
    <tr>

<%	
	ProcessDefinitionRemote[] pds;
	try{
		pds = pm.listProcessDefinitionRemotesLight();
		pm.applyChanges();
	}catch(Exception e){
		pm.cancelChanges();
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
		throw e;
	}
	Hashtable childs = new Hashtable();	
	Hashtable versions = new Hashtable();
	
	for(int i=0; i<pds.length; i++){
		ProcessDefinitionRemote definitionRemote = pds[i];
		String definitionId = definitionRemote.getId();
		String parent = definitionRemote.getParentFolder();

		//indexing the names for searching versions
		
		String definitionGroupId = definitionRemote.getBelongingDefinitionId();
		if(definitionGroupId==null)
			definitionGroupId = definitionRemote.getId();
		
		//indexing the names for making tree
		if(!childs.containsKey(parent)){
			childs.put(parent, new Vector());
		}
		
		Vector v;
		if(definitionRemote.isProduction() || definitionRemote.isFolder()){
			v = (Vector)(childs.get(parent));
			v.add(definitionGroupId);
			v.add(definitionRemote);
		}
		//
	}

	PrintWriter pw = response.getWriter();

	StringWriter sw = new StringWriter();
	PrintWriter spw = new PrintWriter(sw);

	printTree(childs, versions, "-1", spw);
	
%>	
<%=sw.toString()%>


    </tr>
</table>
		        
<form action="instancelist.jsp" meth od="POST" tar get=innerworkarea>
	<input type=hidden name="processDefinition">
	<input type=hidden name="folder">
</form>

<script type="text/javascript">
    var ddmx = new DropDownMenuX('menu1');
    ddmx.delay.show = 0;
    ddmx.delay.hide = 400;
    ddmx.position.levelX.left = 2;
    ddmx.init();
</script>

<%
}
%>