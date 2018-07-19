<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="_rdm" type="com.woorifis.srms.core.result.ResultDataManager" scope="request"/>
<%@page import="com.woorifis.srms.common.bean.DeptBean"%>
<%@page import="com.woorifis.srms.common.controller.CommonController"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.util.*, 
java.util.Comparator,
java.util.HashMap,
java.util.List,
java.util.Map,
java.util.TreeMap,
java.io.StringWriter,
java.io.PrintWriter"%>
<%@page import="com.woorifis.srms.util.StringUtil"%>
<%@page import="com.woorifis.srms.util.EncodeUtil"%>
<%@page import="com.woorifis.srms.util.DateUtil"%>
<%!
void childsTree(Hashtable childs, Hashtable versions, String parent, PrintWriter pw){
	try{
		boolean isRoot = false;
		if(childs.containsKey(parent)){
			Vector childprocesses = (Vector)childs.get(parent);
			pw.print(",children:["); 
			int i=0;
			for(Iterator iter = childprocesses.iterator(); iter.hasNext(); ){					
				String definitionId = (String)iter.next();	//first is definitionId
				DeptBean process = (DeptBean)iter.next();
				
				if(parent.equals(definitionId)) continue;
				if(i!=0) pw.print(","); 
					
				pw.print("{_reference:'"+definitionId+"'}"); 
				i++;
			}
			pw.print("]"); 
		} 
		
	}catch(Exception e){
		e.printStackTrace();
	}
}

void realElementTree(Hashtable childs, Hashtable versions, String parent,PrintWriter pw){
	try{
		boolean isRoot = false;
		//System.out.println("childs.get(parent) :: "+childs.get("getDeptUp"));
		//System.out.println("childs.containsKey(parent)  :: "+childs.containsKey(parent));
		if(childs.containsKey(parent)){
			
			Vector childprocesses = (Vector)childs.get(parent);
			for(Iterator iter = childprocesses.iterator(); iter.hasNext(); ){					
				String definitionId = (String)iter.next();	//first is definitionId	
				DeptBean process = (DeptBean)iter.next(); //second is the object
				//System.out.println("process.getLevels()  :: "+process.getLevels());
				
				if(!process.getLevels().equals("5")){
					versions.put(definitionId,process);
					realElementTree(childs, versions, definitionId , pw);
				}else{
					versions.put(definitionId,process);
				}
			}
		} else {
		}	

	}catch(Exception e){
		e.printStackTrace();
	}
}
%>
<%
	Hashtable childs = new Hashtable();	
	Hashtable versions = new Hashtable();

	List<DeptBean> lv1 = (List<DeptBean>)_rdm.getData("list1");
	int j=0;

	for(DeptBean data : lv1){
		String parent = data.getDeptUp()==null ? data.getDeptCd():data.getDeptUp();
		String definitionGroupId = data.getDeptCd();
		parent = parent.trim();
		
		if(!childs.containsKey(parent)){
			//System.out.println("parent  : ["+parent+"]");
			childs.put(parent, new Vector());
		}
		
		Vector v = (Vector)(childs.get(parent));
		if(!v.contains(definitionGroupId)){
			//System.out.println("data  : "+data);
			v.add(definitionGroupId);
			v.add(data);
		}
	}
	
	Map<String, String> data = new HashMap<String, String>();

	StringWriter sw = new StringWriter();
	PrintWriter spw = new PrintWriter(sw);
	realElementTree(childs, versions, "-1", spw);
	
	spw.println("{ identifier: 'id',");
	spw.println("  label: 'name',");
	spw.println("  items: [");
	
	Set clonedSet = new HashSet();
	clonedSet.addAll(versions.keySet());
	Iterator keyIter = clonedSet.iterator();
	int i=0;
	
	while(keyIter.hasNext()) {
		String key = (String)keyIter.next();
		DeptBean tree = (DeptBean)versions.get(key);
		//System.out.println("DeptBean "+tree.getDeptCd());
		
		String type = tree.getLevels().equals("1") ? "main":"folder";
		//String key = tree.getDeptCd();
		String deptNm = tree.getDeptNm();
		String parent = tree.getDeptUp();
		
		if(i!=0)	spw.println(",");
		
		spw.println("{ id:'"+key+"', name:'"+deptNm+"',type:'"+type+"',visible:'true',parent:'"+parent+"'");
			
		childsTree(childs, versions, key, spw);
		spw.print("}");
		i++;
	}
	spw.println("");
	spw.println("]}");
%>
 <%= sw.toString()%>