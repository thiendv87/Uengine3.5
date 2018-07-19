<%@include file="../common/header.jsp"%>
<%@page import="org.uengine.util.dao.*"%>
<%@page import="org.uengine.persistence.dao.*"%>
<%@page import="org.uengine.webservices.worklist.*"%>
<%@page pageEncoding="KSC5601"%>

<LINK href="../style/uengine.css" type=text/css rel=stylesheet>
	
<BODY bgcolor="#eeeeee">
<% int s_mondif = 100;
    try { s_mondif = Integer.parseInt(request.getParameter("mondif")); }  catch(Exception e) {s_mondif = 100 ;}
		
	Calendar now; int firstDayOfMonth =0; int lastDateOfMonth=0; Calendar firstDate; Calendar lastDate; int monthOfNow; int yearOfNow; {
		now = Calendar.getInstance();
		
		//now.add(Calendar.MONTH, s_mondif);  //�����̵� 
		//now.set(Calendar.YEAR, 2002);  //�����̵� 
		
		if (s_mondif != 100)   // ó������ ���� ���� ���� (100���� �ڿ��� ����)
		{
		  now.set(Calendar.MONTH, s_mondif);  //������
		}
	  else {
		  monthOfNow = now.get(Calendar.MONTH);	
		  s_mondif = monthOfNow ;
			now.set(Calendar.MONTH, s_mondif);
		}				

		firstDate = (Calendar)now.clone();	//���纻 �����
		firstDate.set(Calendar.DATE, 1);
		firstDayOfMonth = firstDate.get(Calendar.DAY_OF_WEEK) - 2;
		
		lastDate = (Calendar)now.clone();
		lastDate.set(Calendar.DATE, 27);
		
    monthOfNow = now.get(Calendar.MONTH);	
    yearOfNow = now.get(Calendar.YEAR);	  	
		while(lastDate.get(Calendar.MONTH)==monthOfNow){
			lastDateOfMonth = lastDate.get(Calendar.DATE);		
			lastDate.setTimeInMillis(lastDate.getTimeInMillis() + 86400000L);
		}
	 String invisibleField = request.getParameter("invisibleField");
   System.out.println(invisibleField);		
	}		
%>
<table>
	<td> <% out.println("<a href=workloads.jsp?mondif=" + (s_mondif-1) + ">&lt;</a>"); %></a></td>
	<td> <%= yearOfNow %>. <%= monthOfNow+1 %>.</td>
	<td> <% out.println("<a href=workloads.jsp?mondif=" + (s_mondif+1) + ">&gt;</a>"); %></a></td>
</table>

<table width="100%" >
<tr align="left">
<% // repository enterprise bean�� � 
// TASKID, TITLE, DESCRIPTION, ENDPOINT, STATUS, PRIORITY, STARTDATE, ENDDATE, DUEDATE, PROCESSINSTANCE, PROCESSDEFINITION, TRACINGTAG, TOOL, PARAMETER, DEPTID, EXT1, EXT2, EXT3
	String sql = "select max(resname) as resname, count(endpoint) as workload from bpm_worklist " + //�������� �Ѽ�
	             " where status<>'CANCELLED' and startdate <= ?LAST_DAY_OF_THIS_MONTH " +
							 " and (enddate >= ?FIRST_DAY_OF_THIS_MONTH or enddate is NULL) group by endpoint";

	IDAO workloads = GenericDAO.createDAOImpl("java:/uEngineDS", sql, IDAO.class);
	workloads.set("FIRST_DAY_OF_THIS_MONTH", firstDate.getTime());
	workloads.set("LAST_DAY_OF_THIS_MONTH", lastDate.getTime());
	workloads.select();
	
	long max=0;
	
	while(workloads.next()){
		long workload = ((Number)workloads.get("workload")).longValue();
		max = (workload > max ? workload:max); // 0�ΰ�츦 ���
	}

	workloads.beforeFirst();
// endpoint group�� ���� endpoint ������� ������ ���
	while(workloads.next()){
		long workload = ((Number)workloads.get("workload")).longValue();
		long size = workload*100/max;  
		String endpoint = (String)workloads.get("resname");
	%>
	<td valign=bottom align=center><b><%=workload%></b><br><img src="bar.jpg" width=30 height="<%=size%>"><br><div nowrap><%=endpoint%></div></td>
<%
	}
%>
</tr></table>
