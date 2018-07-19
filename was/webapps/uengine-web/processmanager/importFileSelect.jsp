<%@include file="../common/header.jsp"%>
 <link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/bbs.css">
  <script language="JavaScript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/bbs.js"></script>
<LINK href="../style/uengine.css" type=text/css rel=stylesheet>
<link href="../style/default.css" rel="stylesheet" type="text/css">

<style TYPE="TEXT/CSS">
BODY {background:url(../../processmanager/images/empty.gif) #ffffff }
</style>

<br />
<form action="importDefinition.jsp" enctype="multipart/form-data" method="POST">
 <table border="0" cellpadding="0" cellspacing="0" width="95%">
    
    <tr>
      <td><span class="sectiontitle">import</span></td>
    </tr>
    <tr>
        <td colspan="2" class="formheadline"></td>
    </tr>
    <tr>
        <td class="formtitle" class="formtitle">Import Package</td>
        <td class="formcon"><input type=file name="importDefinitionPath">
	</td>
       
    </tr>
    
    <tr>
        <td colspan="2" class="formheadline"></td>
    </tr>
    <tr>
    	<td colspan="2" height="20"></td>
    </tr>
    <tr>
    	<td colspan="2" align="center"><input type=submit value="Import"><input type=hidden name="definitionId" value=<%=request.getParameter("definitionId")%>></td>
    </tr>
</table>
                            
                            


	
	
</form>

