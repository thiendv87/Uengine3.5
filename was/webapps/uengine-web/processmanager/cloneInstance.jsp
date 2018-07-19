<%@include file="../common/header.jsp"%>
<%@page import="org.uengine.util.dao.*"%>
<%@page import="org.uengine.persistence.dao.*"%>
<%@page import="org.uengine.processmanager.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.uengine.admin.portlet.processmanager.ProcessInstanceControl"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%!
  public Vector getSubprocessIds(String spId) throws Exception{
    String[] spIds = null;
    if(spId!=null && spId.trim().length() > 0)
      spIds = spId.split(",");
    else
      spIds = null;
    
    Vector vtSpIds = new Vector();
    if(spIds!=null)
    for(int i=0; i<spIds.length; i++){
      vtSpIds.add(spIds[i]);
    }
    
    return vtSpIds;
  }

  protected String setSubprocessIds(Vector spIds) throws Exception{
    String sep = ""; String spId="";
    for(int i=0; i<spIds.size(); i++){
      spId = spId + sep + spIds.elementAt(i);
      sep = ",";
    }
    return spId;
  }

  public void setInitSeq(String tableName,IDAO idao,SimpleTransactionContext stc)throws Exception{
	String seqName="";
	if("BPM_WORKLIST".equals(tableName)){
		seqName = "SEQ_BPM_WORKITEM";
	}else{
		seqName = "SEQ_"+tableName;
	}
		
	idao = ConnectiveDAO.createDAOImpl(stc, "drop sequence "+seqName, IDAO.class);
	idao.update();

	String idName="";
	if("BPM_PROCINST".equals(tableName)){
		idName = "instid";
	}else if("BPM_PROCVAR".equals(tableName)){
		idName = "varid";
	}else if("BPM_ROLEMAPPING".equals(tableName)){
		idName = "rolemappingid";
	}else if("BPM_WORKLIST".equals(tableName)){
		idName = "taskid";
	}
		
	idao = ConnectiveDAO.createDAOImpl(stc, "select MAX("+idName+") as maxid from "+tableName, IDAO.class);
	idao.select();
	idao.next();
	Number maxid= (Number)idao.get("maxid");
		
	idao = ConnectiveDAO.createDAOImpl(stc, "create sequence "+seqName+" START WITH "+(maxid.longValue()+1), IDAO.class);
	idao.update();
  }
%>
<%
	String rootinstid = request.getParameter("rootinstid");
	if (UEngineUtil.isNotEmpty(rootinstid)) {
		ProcessInstanceControl pic = new ProcessInstanceControl();
		Number newInstId = pic.copyProcessInstance(Long.parseLong(rootinstid));	
	%>
		 Successfully cloned with instance id : <%=newInstId%>
	<%
	} else {
	%>
		 Fail cloned. Instance id : <%=rootinstid%>
	<%
	}

	
	//Long rootinstid = new Long(request.getParameter("rootinstid"));

	//SimpleTransactionContext stc = new SimpleTransactionContext();

	try{
		/*
		java.sql.Connection conn = stc.getConnection();
		conn.setAutoCommit(false);
		
		//for instance cloaning 
		IDAO idao = ConnectiveDAO.createDAOImpl(stc, "insert into bpm_procinst_ (select * from bpm_procinst where rootinstid=?rootinstid)", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.update();

		idao = ConnectiveDAO.createDAOImpl(stc, "select MAX(instid)+1 as newInstId from bpm_procinst", IDAO.class);
		idao.select();
		idao.next();
		Number newInstId = (Number)idao.get("newInstId");
		
		System.out.println("newInstid="+newInstId);
		
		long gap = newInstId.longValue() - rootinstid.longValue();
		
		idao = ConnectiveDAO.createDAOImpl(stc, "update bpm_procinst_ set instid = instid + ?gap where rootinstid=?rootinstid", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.set("gap", new Long(gap));
		idao.update();

		idao = ConnectiveDAO.createDAOImpl(stc, "update bpm_procinst_ set rootinstid = rootinstid + ?gap where rootinstid=?rootinstid", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.set("gap", new Long(gap));
		idao.update();

		idao = ConnectiveDAO.createDAOImpl(stc, "insert into bpm_procinst (select * from bpm_procinst_ where rootinstid=?rootinstid + ?gap)", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.set("gap", new Long(gap));
		idao.update();

		setInitSeq("BPM_PROCINST",idao,stc);
		
		//for variable cloaning 

		idao = ConnectiveDAO.createDAOImpl(stc, "insert into bpm_procvar_ (select * from bpm_procvar where instid in (select instid from bpm_procinst where rootinstid=?rootinstid))", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.update();

		idao = ConnectiveDAO.createDAOImpl(stc, "update bpm_procvar_ set instid = instid + ?gap where instid in (select instid from bpm_procinst where rootinstid=?rootinstid)", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.set("gap", new Long(gap));
		idao.update();

		idao = ConnectiveDAO.createDAOImpl(stc, "update bpm_procvar_ set varid = seq_bpm_procvar.nextval where instid in (select instid from bpm_procinst_ where rootinstid=?rootinstid + ?gap)", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.set("gap", new Long(gap));
		idao.update();

//		idao = ConnectiveDAO.createDAOImpl(stc, "update bpm_procvar_ set varstring = tochar(tonumber(varstring) + ?gap) where (keyname='instanceIdOfSubProcess' or keyname='completedInstanceIdOfSPs') and instid in (select instid from bpm_procinst_ where rootinstid=?rootinstid + ?gap)", IDAO.class);
//		idao.set("rootinstid", rootinstid);
//		idao.set("gap", new Long(gap));
//		idao.update();
//
		idao = ConnectiveDAO.createDAOImpl(stc, "insert into bpm_procvar (select * from bpm_procvar_ where instid in (select instid from bpm_procinst_ where rootinstid=?rootinstid + ?gap))", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.set("gap", new Long(gap));
		idao.update();

		setInitSeq("BPM_PROCVAR",idao,stc);
		
		//change subprocess instance id links
		
		idao = ConnectiveDAO.createDAOImpl(stc, "select varid, valuestring from bpm_procvar_ where (keyname='instanceIdOfSubProcess' or keyname='completedInstanceIdOfSPs') and instid in (select instid from bpm_procinst_ where rootinstid=?rootinstid + ?gap)", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.set("gap", new Long(gap));
		idao.select();
		while(idao.next()){
			Number varid = idao.getLong("varid");
			String spIds = idao.getString("valuestring");
			
			Vector vt = getSubprocessIds(spIds);
			for(int i=0; i<vt.size(); i++){
				Long spId = new Long((String)vt.get(i));
				Long newSpId = spId.longValue() + gap;
				vt.set(i, newSpId);
			}
			
			spIds = setSubprocessIds(vt);
			
			IDAO idao2 = ConnectiveDAO.createDAOImpl(stc, "update bpm_procvar_ set valuestring=?valuestring where varid=?varid", IDAO.class);
			idao2.set("varid", varid);
			idao2.set("valuestring", (spIds));
			idao2.update();
			
		}
				
		//for rolemapping cloaning 

		idao = ConnectiveDAO.createDAOImpl(stc, "insert into bpm_rolemapping_ (select * from bpm_rolemapping where instid in (select instid from bpm_procinst where rootinstid=?rootinstid))", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.update();

		idao = ConnectiveDAO.createDAOImpl(stc, "update bpm_rolemapping_ set instid = instid + ?gap where instid in (select instid from bpm_procinst where rootinstid=?rootinstid)", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.set("gap", new Long(gap));
		idao.update();

		idao = ConnectiveDAO.createDAOImpl(stc, "update bpm_rolemapping_ set ROLEMAPPINGID = SEQ_BPM_ROLEMAPPING.nextval where instid in (select instid from bpm_procinst_ where rootinstid=?rootinstid + ?gap)", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.set("gap", new Long(gap));
		idao.update();

		idao = ConnectiveDAO.createDAOImpl(stc, "insert into bpm_rolemapping (select * from bpm_rolemapping_ where instid in (select instid from bpm_procinst_ where rootinstid=?rootinstid + ?gap))", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.set("gap", new Long(gap));
		idao.update();

		setInitSeq("BPM_ROLEMAPPING",idao,stc);
		
		//for worklist cloaning 

		idao = ConnectiveDAO.createDAOImpl(stc, "insert into bpm_worklist_ (select * from bpm_worklist where instid in (select instid from bpm_worklist where rootinstid=?rootinstid))", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.update();

		idao = ConnectiveDAO.createDAOImpl(stc, "update bpm_worklist_ set instid = instid + ?gap where instid in (select instid from bpm_worklist where rootinstid=?rootinstid)", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.set("gap", new Long(gap));
		idao.update();

		idao = ConnectiveDAO.createDAOImpl(stc, "update bpm_worklist_ set TASKID = seq_bpm_workitem.nextval where instid in (select instid from bpm_procinst_ where rootinstid=?rootinstid + ?gap)", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.set("gap", new Long(gap));
		idao.update();

		idao = ConnectiveDAO.createDAOImpl(stc, "insert into bpm_worklist (select * from bpm_worklist_ where instid in (select instid from bpm_procinst_ where rootinstid=?rootinstid + ?gap))", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.set("gap", new Long(gap));
		idao.update();

		setInitSeq("BPM_WORKLIST",idao,stc);
		
		//clear the workspace
		idao = ConnectiveDAO.createDAOImpl(stc, "delete bpm_worklist_ where instid in (select instid from bpm_procinst_ where rootinstid=?rootinstid + ?gap)", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.set("gap", new Long(gap));
		idao.update();

		idao = ConnectiveDAO.createDAOImpl(stc, "delete bpm_rolemapping_ where instid in (select instid from bpm_procinst_ where rootinstid=?rootinstid + ?gap)", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.set("gap", new Long(gap));
		idao.update();

		idao = ConnectiveDAO.createDAOImpl(stc, "delete bpm_procvar_ where instid in (select instid from bpm_procinst_ where rootinstid=?rootinstid + ?gap)", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.set("gap", new Long(gap));
		idao.update();

		idao = ConnectiveDAO.createDAOImpl(stc, "delete bpm_procinst_ where instid in (select instid from bpm_procinst_ where rootinstid=?rootinstid + ?gap)", IDAO.class);
		idao.set("rootinstid", rootinstid);
		idao.set("gap", new Long(gap));
		idao.update();


		stc.commit();
		
		*/
		%> Successfully cloned with instance id : <%//=newInstId%> <%
		
	} catch(Exception e) {
		//stc.rollback();
	
		throw e;
	}

%>



</body>
</html>