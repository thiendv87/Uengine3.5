<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,javax.sql.*,javax.naming.*,org.uengine.util.dao.DefaultConnectionFactory"  %>

<html>
<head>
    <title>Organization Chart</title>
    <link rel="stylesheet" type="text/css" href="DynamicTree.css" />
    <script type="text/javascript" src="ie5.js"></script>
    <script type="text/javascript" src="DynamicTree.js"></script>
    <style type="text/css">
    p { font-family: georgia, sans-serif; font-size: 11px; }
    </style>

 <script type="text/javascript">
 
 function SelectedInfo() {
		var type = '';
		var id = '';
		var name = '';
		var title = '';
		var birthday;
		var isMale = true;
	}


function getSelectedUsers() {
	var selectList = document.all.selectUserList;
	var j=0;
	selectedOrganizationList = new Array();
	for(i=0; i<selectList.length; i++){
		
		if(selectList.options[i].selected==true){
		
			var user = new SelectedInfo();
			var userInfo = selectList.options[i].value;
			var userName = selectList.options[i].text;

			var userInfoArray = userInfo.split(';');		
			var userId = userInfoArray[0].split('=');
			var title = userInfoArray[4].split('=');
						
			user.type 		= "";
			user.name 		= userName.replace('_',' ');
			user.id 		= userId[1];
			user.title 		= title[1];
			user.isMale		= "1";
			user.birthday	= "";
			selectedOrganizationList [j++] = user;
		}
	}
	
	return selectedOrganizationList;
}

function view() {
	//alert(selectedOrganizationInfo.type + "," + selectedOrganizationInfo.id + "," + selectedOrganizationInfo.name + "," + selectedOrganizationInfo.loginName + "," + selectedOrganizationInfo.title);
}

function adduser(){
	var checkbox = document.all.empchecker;
	var realTargetTag = document.getElementById("selectUserList");

	for(i=0; i < checkbox.length ; i++){
		if(checkbox[i].checked){
			var userInfo = checkbox[i].value.split(';');		
			var newOption = document.createElement("option");
			//var userId = userInfo[0].split('=');
			var userName = userInfo[1].split('=');
			
			newOption.value = checkbox[i].value;
			newOption.text = userName[1];
			
			realTargetTag.add(newOption);	
		}
	}
}

var selectedOrganizationList = new Array();
var inpuName = "";

</script>


<div class="DynamicTree" style="overflow:auto;height:220px">
  <div class="top">uEngine</div>
  <div class="wrap" id="tree">

<%
//String DB_URL = "jdbc:microsoft:sqlserver://127.0.0.1:1433;DatabaseName=erpdb";
//String DB_USER = "sa";
//String DB_PASSWORD= "karisma";

Connection conn;

conn = DefaultConnectionFactory.create().getConnection();
Statement stmt = conn.createStatement();


try
{
	StringBuffer sql = new StringBuffer();
	sql.append(" select E.EMPCODE,                                                           ");
	sql.append("        E.EMPNAME,                                                           ");
	sql.append("        E.JIKNAME,                                                           ");
	sql.append(" 	    E.PARTCODE,                                                          ");
	sql.append(" 	    E.EMAIL,  ");
	sql.append(" 	    E.GLobalCom,                                                         ");
	sql.append(" 	    P.PARTNAME                                                           ");
	sql.append(" from PArtTable P,                                                           ");
	sql.append("      EMPTABLE E                                                            ");
	sql.append(" where  P.PARTCODE  = E.PARTCODE                                              ");
	sql.append(" and   P.GlobalCom = E.GLobalCom                                             ");
	sql.append(" order by P.PARTCODE,E.EMPNAME                                               ");
	
	ResultSet rs = stmt.executeQuery(sql.toString());

	//String curDivCode = "";
	String curPartCode = "";
	out.println("    <div class='folder'>Departments" );
	while (rs.next())
	{
		String dbPartCode  = rs.getString("PARTCODE");
		String dbPartName  = rs.getString("PARTNAME");
		String dbEmpCode   = rs.getString("EMPCODE");
		String dbEmpName   = rs.getString("EMPNAME");
		dbEmpName = dbEmpName.replace(' ', '_');
		
		String dbJikName   = rs.getString("JIKNAME");

	    if(!curPartCode.equals(dbPartCode)){
            if(curPartCode.equals("")){
				out.println("        <div class='folder'>" + dbPartName );
			}else{
				out.println("        </div>");
				out.println("        <div class='folder'>" + dbPartName );
			}
			curPartCode = dbPartCode;
		}
        out.println("			<div class='doc'><a href='javascript:getSelectedUsers();'><input type=checkbox id=empchecker value='id="+dbEmpCode+";name="+dbEmpName+";isMale=T;birthday=0;title="+dbJikName+"' >"+ dbEmpName + "</a></div>");
	}
}
finally
{
	if ( stmt != null ) try { stmt.close(); } catch (Exception e) {}
	if ( conn != null ) try { conn.close(); } catch (Exception e) {}
}

%>


        </div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
var tree = new DynamicTree("tree");
tree.init();
</script>
<b>SELETED USER LIST</b><br>
<hr>
<table width=100%>
	<tr>
		<td align=right>
			<select multiple name=selectUserList size=5>
				<option >-------- user List -------</option>
			</select>
		</td>
		<td align=left valign=top>
			<input type=button  value='add user' onclick='adduser()'>
		</td>
	</tr>
</table>
<hr>
