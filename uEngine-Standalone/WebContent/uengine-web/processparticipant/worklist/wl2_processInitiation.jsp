<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>

<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/slider.js"></script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/range.js"></script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/timer.js"></script>
<script language="JavaScript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/bbs.js"></script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/wz_jsgraphics.js"></script>	
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/loopDraw.js.jsp"></script> 

<LINK rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/bluecurve/bluecurve.css" />
<LINK rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/uengine.css"  >
<link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/en_US.css">
<link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/bbs.css">


<%
	String pdId = request.getParameter("processDefinition");
	String defType = request.getParameter("defType");
	String folderId = request.getParameter("folder");
	String pi = request.getParameter("instanceId");
	String viewOption = request.getParameter("viewOption");
%>
<html>
<head>
<script>
	var request = false;
	var divName="initPageArea";
	
	function createRequest(){		
		try {
		  request = new XMLHttpRequest();
		} catch (trymicrosoft) {
		  try {
		    request = new ActiveXObject("Msxml2.XMLHTTP");
		  } catch (othermicrosoft) {
		    try {
		      request = new ActiveXObject("Microsoft.XMLHTTP");
		    } catch (failed) {
		      request = false;
		    }
		  }
		}	
		if(!request)
		alert("Error initializing");
	}
	
	function showPage(){
		if (request.readyState == 4){
       		if (request.status == 200){
       			var response = request.responseText;
       			
       			var index=0;
       			var str="";
       			while(true){
       				location1 = response.indexOf("<script>",index);
       				if(location1==-1)
       					break;
       				location2 = response.indexOf("script>",location1+7);
       				str = response.substring(location1+8,location2-2);
       				index = location2;
       				
       				//alert(str);
       				var scriptStr=document.createElement('script');
					scriptStr.text =str;
					
					document.getElementsByTagName("head").item(0).appendChild(scriptStr);
       			}
       			
       			var contentDiv = document.all[divName];
				contentDiv.innerHTML = response;				
         	}
       		else if (request.status == 404){
         		alert("Request URL does not exist");
         	}
       		else{
         		alert("Error: status code is " + request.status);
         	}
         }
         
         var zoomSize=document.getElementById('oZoom').offsetWidth;
         var divSize=document.body.clientWidth-420;

		
		 if(zoomSize > divSize){
         	var percent = divSize/document.getElementById('oZoom').offsetWidth;
         	oZoom.style.zoom = percent;
         	loopDraw_zoom = percent * 100;
         	loopDraw_originObj = document.getElementById('oZoom');
         	
         }
 		 drawLoopLines();
 		 
 		 var canvasForLoopLinesTemp = document.getElementById('canvasForLoopLines');
 		 canvasForLoopLinesTemp.style.width=1200;

	}
	
	function showInitPage(defType,pdId,folderId,viewOption){
		createRequest();
		if(defType=="process"){
			request.open("GET","../wl2_viewProcessFlowChart.jsp?processdefinition="+pdId+"&folder="+folderId+"&viewOption="+viewOption,true);
		}else{
			request.open("GET","../wl2_processInitFirtstPage.jsp",true);		
		}
		request.onreadystatechange = showPage;
		request.send(null);
	}
	
	function swapView(folder,pi,pd,defType,viewOption){
		location="wl2_processInitiation.jsp?folder="+folder+"&instanceId="+pi+"&processDefinition="+pd+"&viewOption="+viewOption+"&defType="+defType;
	}
	
	function showActivityDetails(instanceID, tracingTag){
		window.open('../viewActivityDetails.jsp?instanceID=' + instanceID + '&tracingTag=' + tracingTag,'activitydetails','width=500,height=400,scrollbars=yes,resizable=yes');
	}
	function viewProcInfo( instanceid ){
		var option = "width=500,height=400,scrollbars=yes,resizable=yes";
		var url = "../viewProcessInformation.jsp?omitHeader=yes&instanceId="+instanceid;
		window.open(url,"",option);
	}
</script>

</head>
<body bgcolor=white alink="black" vlink="black" onLoad="showInitPage('<%=defType%>','<%=pdId%>','<%=folderId%>','<%=viewOption%>');" >

<table border=0 width=100% height=100% CELLPADDING==0 CELLSPACING=0>
<tr>
	<td width=140 VALIGN="top"><%@include file="wl2_menu.jsp"%><img src="dd" height=1 width=140></td>
	<td width=1 bgcolor=#dddddd ></td>
	<td width=280 VALIGN="top"><%@include file="wl2_selectProcessDefinition.jsp"%><img src="dd" height=1 width=280></td>
	<td width=1 bgcolor=#dddddd ></td>
  	<td VALIGN="top" ><div id="initPageArea"></div></td>
</tr>
</table>
</body>
</html>
