<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String deptCd = request.getParameter("deptCd");
%>

<link rel="stylesheet" href="<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT %>/scripts/windowfiles/dhtmlwindow.css" type="text/css" />
<link rel="stylesheet" href="<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT %>/scripts/modalfiles/modal.css" type="text/css" />
<script type="text/javascript" src="<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT %>/scripts/windowfiles/dhtmlwindow.js"></script>
<script type="text/javascript" src="<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT %>/scripts/modalfiles/modal.js"></script>
<script type="text/javascript">
function userSerch(deptcd){
	window.parent.searchUserDept(deptcd);
}
</script>
<link rel="stylesheet" href="/style/formdefault.css" />
<link rel="stylesheet" href="/style/popup.css" />
<script type="text/javascript" src="/dojo/dojo/dojo.js" djConfig="isDebug:false, parseOnLoad: true"></script>
<script type="text/javascript" src="/dojo/dijit/tests/_testCommon.js"></script>
<script type="text/javascript">
		dojo.require("dojo.data.ItemFileReadStore");
		dojo.require("dijit.Tree");
var continentStore = new dojo.data.ItemFileReadStore({url:'deptTree?deptCd=<%=deptCd%>'});
</script> 
<div dojoType="dijit.Tree" store="continentStore" query="{type:'main'}"
	labelAttr="name" typeAttr="type" openOnClick="true" label=""  style="overflow:auto;">
<script type="dojo/method" event="onClick" args="item">
userSerch(item.id);

</script>
</div>