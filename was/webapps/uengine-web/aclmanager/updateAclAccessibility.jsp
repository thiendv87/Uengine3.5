<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<%@page import="org.uengine.util.dao.*"%>
<script><%@include file="aclMethods.jsp"%></script>

<LINK rel="stylesheet" href="../style/uengine.css" type=text/css>
<LINK rel="stylesheet" href="../style/portlet.css" type="text/css"/>	
<LINK rel="stylesheet" href="../style/portal.css" type="text/css"/>	
<LINK rel="stylesheet" href="../style/groupware.css" type="text/css"/>

<%
	String DEFID= request.getParameter("DEFID");
	String ACCESSIBILITY= request.getParameter("ACCESSIBILITY");
	String GROUPID= request.getParameter("GROUPID");
	String ROLEID= request.getParameter("ROLEID");
	String USERID= request.getParameter("USERID");

	String sql ="select * from BPM_EX_ACL ";
	sql+="where DEFID=?DEFID and ACCESSIBILITY=?ACCESSIBILITY and GROUPID=?GROUPID and ROLEID=?ROLEID and USERID=?USERID";
			
	IDAO dao = GenericDAO.createDAOImpl( 
	    		DefaultConnectionFactory.create(),			
		        sql,
				IDAO.class
	);
			
	dao.set("DEFID", DEFID);
	dao.set("ACCESSIBILITY", ACCESSIBILITY);
	dao.set("GROUPID", GROUPID);
	dao.set("ROLEID", ROLEID);
	dao.set("USERID", USERID);
	dao.select(); 
	
	while(dao.next()){
		DEFID = dao.getString("DEFID");
		ACCESSIBILITY = dao.getString("ACCESSIBILITY");
		GROUPID= dao.getString("GROUPID");
		ROLEID= dao.getString("ROLEID");
		USERID= dao.getString("USERID");
	}
	String userName="";
	String roleName="";
	String groupName="";
	if(!"".equals(USERID)){
		com.liferay.portal.model.User user = UserLocalServiceUtil.getUserById(loggedUser.getCompanyId(),USERID);
		userName = user.getFullName();
	}
	if(!"".equals(ROLEID)){
		com.liferay.portal.model.Role role = RoleLocalServiceUtil.getRole(ROLEID);
		roleName =role.getName();
	}
	if(!"".equals(GROUPID)){
		com.liferay.portal.model.UserGroup userGroup = UserGroupLocalServiceUtil.getUserGroup(GROUPID);
		groupName =userGroup.getName();
	}
%>

<form action=executeQuery.jsp method=POST name=actionForm>
<script>
function radioClick(obj){

	if(document.actionForm.selectInputID[0].checked==true){
		//disable
		document.actionForm.column_GROUPID_value_display.disabled =false;
		document.actionForm.column_GROUPID.disabled =false;
		
		document.actionForm.column_ROLEID_value_display.disabled =false;
		document.actionForm.column_ROLEID.disabled =false;
		
		document.actionForm.column_USERID_value_display.disabled =true;
		document.actionForm.column_USERID.disabled =true;
		
		//value
		document.actionForm.column_USERID_value_display.value ="";
		document.actionForm.column_USERID_value.value ="";

		document.actionForm.column_GROUPID_value_display.value =document.actionForm.old_Column_GROUPID_display.value;
		document.actionForm.column_GROUPID_value.value =document.actionForm.old_Column_GROUPID.value;
		

		document.actionForm.column_ROLEID_value_display.value =document.actionForm.old_Column_ROLEID_display.value;
		document.actionForm.column_ROLEID_value.value =document.actionForm.old_Column_ROLEID.value;
		
		var group=document.getElementById('group');
		group.innerHTML="<font color=black>To Group</font>";
		
		var role=document.getElementById('role');
		role.innerHTML="<font color=black>And Role</font>";
		
		var user=document.getElementById('user');
		user.innerHTML="<font color=gray>To User</font>";		

	}else{
	    //disable
		document.actionForm.column_GROUPID_value_display.disabled =true;
		document.actionForm.column_GROUPID.disabled =true;
		
		document.actionForm.column_ROLEID_value_display.disabled =true;
		document.actionForm.column_ROLEID.disabled =true;
		
		document.actionForm.column_USERID_value_display.disabled =false;
		document.actionForm.column_USERID.disabled =false;
		
		//value
		document.actionForm.column_USERID_value_display.value =document.actionForm.old_Column_USERID_display.value;
		document.actionForm.column_USERID_value.value =document.actionForm.old_Column_USERID.value;

		document.actionForm.column_GROUPID_value_display.value ="";
		document.actionForm.column_GROUPID_value.value ="";
		
		document.actionForm.column_ROLEID_value_display.value ="";
		document.actionForm.column_ROLEID_value.value ="";
		
		var group=document.getElementById('group');
		group.innerHTML="<font color=gray>To Group</font>";
		
		var role=document.getElementById('role');
		role.innerHTML="<font color=gray>And Role</font>";
		
		var user=document.getElementById('user');
		user.innerHTML="<font color=black>To User</font>";
	}
}
</script>

<img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/icon_root.gif" align="middle" width="10" height="11" border="0">
<b>Update Accessbility</b>
<table width=100% border=0 cellspacing=0 cellpadding=0>
  <tr height=1>
   <td align=center colspan=3 height=1 bgcolor=#dddddd></td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="10"></td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="5"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr height="1">
		<td align="center" height="1" class="bgcolor_head_upperline"></td>
	</tr>
	<tr height="5">
		<td align="center" height="5" class="bgcolor_head"></td>
	</tr>
	<tr height="1">
		<td align="center" height="1" class="bgcolor_head_underline"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>			
	
	<tr height="30" >
		<td width="100" align=left bgcolor="f4f4f4">
			&nbsp;<b>Set Fields</b>
		</td>
		<td width="10"></td>
		<td width="*" align=left>
		
<table border=0>
 <tr>
  <td>Give</td>
  <td><select size=3 name="select_ACCESSIBILITY" onchange="selectItem()">
  		<option value="v" <%= "v".equals(ACCESSIBILITY) ? " selected":""%>>View</option>
  		<option value="r" <%= "r".equals(ACCESSIBILITY) ? " selected":""%>>Running</option>
  		<option value="e" <%= "e".equals(ACCESSIBILITY) ? " selected":""%>>Edit</option>
  	  </select>
  </td>
  <td>ACCESSIBILITY</td>
 </tr>
 <tr height=1>
    <td align=center colspan=3 height=1 bgcolor=#dddddd></td>
    </tr>
 <tr>
  <tr>
  <td rowspan=2><input type="radio" name="selectInputID" onclick="radioClick(this)" ></td>
  <td><div id=group><font color=gray>To Group</font></div></td>
  <td><input type="text" name="column_GROUPID_value_display" value="<%=groupName%>" disabled/><input type="hidden" name="column_GROUPID_value" value="" /><input type=button name="column_GROUPID" size=20 onClick="searchPeople(this,'Group')" value="..." disabled></td>
 </tr>
 <tr>
  <td><div id=role><font color=gray>and Role</font></div></td>
  <td><input type="text" name="column_ROLEID_value_display" value="<%=roleName%>" disabled/><input type="hidden" name="column_ROLEID_value" value="" /><input type=button name="column_ROLEID" size=20 onClick="searchPeople(this,'Role')" value="..." disabled></td>
 </tr>
 <tr height=1>
    <td align=center colspan=3 height=1 bgcolor=#dddddd></td>
    </tr>
 <tr>
 <tr>
  <td><input type="radio" name="selectInputID" onclick="radioClick(this)"></td>
  <td><div id=user><font color=gray>To User</font></div></td>
  <td><input type="text" name="column_USERID_value_display" value="<%=userName%>" disabled/><input type="hidden" name="column_USERID_value" value="" /><input type=button name="column_USERID" size=20 onClick="searchPeople(this,'User')" value="..." disabled></td>
 </tr>
</table>


		</td>
	</tr>
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>				

	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>			
</table>
<br>
<script>
function selectItem(){
	var accessibility="";
	
	for(i=0;i<3;i++){
		if(document.actionForm.select_ACCESSIBILITY.options[i].selected==true){
			accessibility += document.actionForm.select_ACCESSIBILITY.options[i].value +"/";
		}
	}
	document.actionForm.column_ACCESSIBILITY_value.value=accessibility;
}
</script>

<input type="hidden" name="column_ACCESSIBILITY_value" value="<%=ACCESSIBILITY%>" />
<input type="hidden" name="column_DEFID_value"  value="<%=DEFID%>" />
<input type="hidden" name="old_Column_ACCESSIBILITY" value="<%=ACCESSIBILITY%>" />
<input type="hidden" name="old_Column_DEFID"  value="<%=DEFID%>" />

<input type="hidden" name="old_Column_GROUPID" value="<%=GROUPID%>" />
<input type="hidden" name="old_Column_ROLEID" value="<%=ROLEID%>" />
<input type="hidden" name="old_Column_USERID" value="<%=USERID%>" />

<input type="hidden" name="old_Column_GROUPID_display" value="<%=groupName%>" />
<input type="hidden" name="old_Column_ROLEID_display" value="<%=roleName%>" />
<input type="hidden" name="old_Column_USERID_display" value="<%=userName%>" />

<input type="hidden" name="functionType" value="update" />
<input type="submit"  value="Update" />
</form>  
 