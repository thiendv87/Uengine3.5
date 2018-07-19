<%@include file="../common/header.jsp"%>
<%@page import="org.uengine.util.dao.*"%>

<%
	String DEFID= request.getParameter("column_DEFID_value");
	String ACCESSIBILITYTemp= request.getParameter("column_ACCESSIBILITY_value");
	String GROUPID= request.getParameter("column_GROUPID_value");
	String ROLEID= request.getParameter("column_ROLEID_value");
	String USERID= request.getParameter("column_USERID_value");
	String functionType= request.getParameter("functionType");
	
	System.out.println("ACCESSIBILITYTemp:"+ACCESSIBILITYTemp);
	StringTokenizer st = new StringTokenizer(ACCESSIBILITYTemp,"/");
	String[] ACCESSIBILITY = new String[st.countTokens()];
	int nCount=0;
	while ( st.hasMoreTokens() ) {
		ACCESSIBILITY[nCount++]= st.nextToken();
	}
	boolean check=true;
	String sql="";
	
	//check
	if(nCount==0){
		check=false;
	}
	if("".equals(GROUPID)&&"".equals(ROLEID)&&"".equals(USERID)){
		check=false;
	}
	
	if(check){
		if("add".equals(functionType)){
			for(int i=0; i< nCount;i++){
				sql ="insert into BPM_EX_ACL(DEFID,ACCESSIBILITY,GROUPID,ROLEID,USERID) ";
				sql+="values(?DEFID,?ACCESSIBILITY,?GROUPID,?ROLEID,?USERID)";
				
				IDAO dao = GenericDAO.createDAOImpl( 
					DefaultConnectionFactory.create(),			
			        sql,
					IDAO.class
				);
				
				dao.set("DEFID", DEFID);
				dao.set("ACCESSIBILITY", ACCESSIBILITY[i]);
				dao.set("GROUPID", GROUPID);
				dao.set("ROLEID", ROLEID);
				dao.set("USERID", USERID);
				dao.insert(); 
			}
		}else if("update".equals(functionType)){
			String old_DEFID= request.getParameter("old_Column_DEFID");
			String old_ACCESSIBILITY= request.getParameter("old_Column_ACCESSIBILITY");
			String old_GROUPID= request.getParameter("old_Column_GROUPID");
			String old_ROLEID= request.getParameter("old_Column_ROLEID");
			String old_USERID= request.getParameter("old_Column_USERID");
		
			sql ="update BPM_EX_ACL set DEFID=?DEFID,ACCESSIBILITY=?ACCESSIBILITY,GROUPID=?GROUPID,ROLEID=?ROLEID,USERID=?USERID ";
			sql+="where DEFID=?oDEFID and ACCESSIBILITY=?oACCESSIBILITY and GROUPID=?oGROUPID and ROLEID=?oROLEID and USERID=?oUSERID";
			
			IDAO dao = GenericDAO.createDAOImpl( 
				DefaultConnectionFactory.create(),			
			       sql,
				IDAO.class
			);
				
			dao.set("DEFID", DEFID);
			dao.set("ACCESSIBILITY", ACCESSIBILITY[0]);
			dao.set("GROUPID", GROUPID);
			dao.set("ROLEID", ROLEID);
			dao.set("USERID", USERID);
			
			dao.set("oDEFID", old_DEFID);
			dao.set("oACCESSIBILITY", old_ACCESSIBILITY);
			dao.set("oGROUPID", old_GROUPID);
			dao.set("oROLEID", old_ROLEID);
			dao.set("oUSERID", old_USERID);
			
			dao.update(); 
		}
	}
%>

<html>
<head>
<script type/text="javascript">
	function sendRedirectPage() {
		setTimeout("sendUrl()", 2000);
	}

	function sendUrl() {
		window.close();
 		opener.location.reload()		
	}
</script>
</head>
<body>
<div id="center">
	<div class="boxtext">
<%
	if(check){
%>
	Object has been successfully saved ...
<%
	}else{
%>
	It failed a work, Data fields are NULL.
<%
	}
%>
	</div>
</div>
</body>
</html>

<script type/text="javascript">
sendRedirectPage();
</script>