<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>
<html>
<head>
<style TYPE="TEXT/CSS">
BODY {background:url(../../processmanager/images/empty.gif) #ffffff }
</style>

</head>
<body>
<ul class="tabs">
<li id="workitem_view">
<a href="wl2_workList.jsp" target=_parent>
<%=GlobalContext.getLocalizedMessageForWeb("my_work", loggedUserLocale, "My Work") %></a>
</li>

<li class="current" id="instance_view">
<a href="wl2_processInitiationFrame.jsp" target=_parent>
<%=GlobalContext.getLocalizedMessageForWeb("initiate_process", loggedUserLocale, "Initiate Process") %>
</a>
</li>
</ul>
</body>
</html>