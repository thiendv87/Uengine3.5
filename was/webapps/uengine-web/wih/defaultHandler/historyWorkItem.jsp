<%@page import="java.io.BufferedReader"%>
<%@page import="org.uengine.kernel.HumanActivity"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.uengine.kernel.GlobalContext"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStreamReader"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../../lib/jquery/importJquery.jsp"%>
<script type="text/javascript">
    $(window).load(function() {
        //tags 
        $('#tags').css({
            "margin-top":"10px"
        });
        
        var taglist = $('#tags').text();
        $('#tags').html("<strong>Tag: </strong>"+taglist);
        
        parent.resizeFrame($(document).height(),'<%=request.getParameter("tag")%>');
    });
</script>
</head>
<body style="overflow:hidden">
<%
	String filePath = request.getParameter("htmlPath");
	File file = new File(HumanActivity.SNAPSHOT_DIRECTORY + filePath);
	
	if(file.exists()){
		BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file), GlobalContext.ENCODING));
		while(br.ready()) {
			out.println(br.readLine());
		}
		
		br.close();
	}else{
%><table style="width:100%;height:150px;"><tr><td style="text-align:center;vertical-align:middle;">업무이력 스냅샷이 존재하지 않습니다.</td></tr></table><%
	}
%>
</body>
</html>