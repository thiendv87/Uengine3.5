<%@ page pageEncoding="UTF-8" language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.util.Calendar" %>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="javax.naming.*" %>
<%@page import="org.uengine.kernel.Activity" %>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory" %>
<%@page import="org.uengine.persistence.dao.WorkListDAO"%>
<%@page import="com.defaultcompany.wih.approvalhandler.*"%>
<%String draftActivityName = ""; %>
<%
	String loggedPosiName = loggedUserJikName; 
%>

<!--input type=button value="결재선 편집" onclick="addApprovalLine()"-->

<%@page import="org.uengine.kernel.HumanApprovalLineActivity"%>
<%@page import="org.uengine.kernel.RoleMapping"%>
<%@page import="org.uengine.kernel.GlobalContext"%>
<%@page import="org.uengine.kernel.HumanApprovalActivity"%>
<script language="javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/util.js"></script>
<script>

function addItems(selectedPeople){
	var sep = ';';
	var box = document.forms[0].approvalLine;
	
	box.length=0;
	//selectAll(box);
	//removeItem(box,box.value);

	for(i=0; i<selectedPeople.length; i++){
		//alert(selectedPeople[i].koreanname+selectedPeople[i].type);
		var text = selectedPeople[i].koreanname+","+selectedPeople[i].type+","+selectedPeople[i].preConfirm; 
		var value = selectedPeople[i].empno + sep 
				 + selectedPeople[i].koreanname + sep
				 + selectedPeople[i].deptfullname + sep
				 + selectedPeople[i].remark + sep
				 + selectedPeople[i].type + sep
				 + selectedPeople[i].preConfirm + sep
				 + selectedPeople[i].status + sep
				 + selectedPeople[i].comname + sep
				 + selectedPeople[i].phone + sep;

		if(selectedPeople[i].status =="대기" || selectedPeople[i].status =="진행중"){
			addItem(box, text, value, false);
		}
	}
}

function onApprovalLineSelected(data){

	addPassValues(data);
    delRow("myTable",data);
    addRows("myTable",data);
	addItems(data);	
}

function SelectedInfo() {
	var empno		="";
	var koreanname	="";
	var remark		="";
	var type		="";
	var preConfirm	="";
	var status		="";
	var comname		="";
	var phone		="";
	var stepName	="";
	var deptfullname="";
}
//submit으로 데이타를 보내기 위해 hidden값 생성
function addPassValues(selectedPeople){
	var userCode="";
	var userName="";
	var userJobPosition="";
	var approveType="";
	var preConfirm="";
	var status="";
	var comname="";
	var phone="";
	var stepName="";
	var approveDate="";
	var deptfullname="";

<%
if(true){
	int activitySize = 0;
	int completedOrRunningSize = 0;
	boolean isDraft = false;
	draftActivityName = humanApprovalLineActivity.getDraftActivity().getName().getText();
	Vector changeAppLine = new Vector();
	if(humanApprovalLineActivity != null){
		vChildActivities = humanApprovalLineActivity.getChildActivities();
		activitySize = vChildActivities.size();
	}
	
	if(humanActivity.getTracingTag().equals(humanApprovalLineActivity.getDraftActivity().getTracingTag())){
		isDraft = true;
	}
%>
	var actSize = <%=activitySize%>;	
	if(actSize == 1 || <%=isDraft%>){
		var drafter = new SelectedInfo();
		drafter.empno = "<%=loggedUserId%>";
		drafter.koreanname = "<%=loggedUserFullName%>";
		drafter.remark = "<%=loggedPosiName%>";
		drafter.type = "상신";
		drafter.status = "진행중";
		//selectedPeople.splice(0,0,drafter);
	}else{
<%
	for(int i=0;i<vChildActivities.size();i++){
		if( vChildActivities.get(i) instanceof HumanApprovalActivity ){
			HumanApprovalActivity approveStep = (HumanApprovalActivity)vChildActivities.get(i);
			Calendar calendar = approveStep.getEndTime(instance);
			approveDate = null;
			if(calendar != null && (Activity.STATUS_COMPLETED).equals(approveStep.getStatus(instance))) 
				approveDate = sdf.format(calendar.getTime());

			String apprStat = approveStep.getApprovalStatus(instance);
			
			String apprType = "결재";
			if(approveStep.isNotificationWorkitem()){
				apprType = "후결";
			}else if(approveStep.getTracingTag().equals(humanApprovalLineActivity.getDraftActivity().getTracingTag())){
				apprType = "상신";
			}
			
			//전결 가능 여부
			Boolean isArbitraryApprovable = approveStep.isArbitraryApprovable();
			String approveType = "no";
			if(isArbitraryApprovable){
				approveType = "yes";
			}		
			
			if(
					Activity.STATUS_RUNNING.equals(approveStep.getStatus(instance)) 
					|| Activity.STATUS_COMPLETED.equals(approveStep.getStatus(instance))
					|| Activity.STATUS_TIMEOUT.equals(approveStep.getStatus(instance))
			){
				completedOrRunningSize++;
			}
			
			String apprStatus = null;
             if((Activity.STATUS_RUNNING).equals(approveStep.getStatus(instance)) || (Activity.STATUS_TIMEOUT).equals(approveStep.getStatus(instance))){
       	         apprStatus = "진행중";
             }else if(HumanApprovalActivity.SIGN_DRAFT.equals(apprStat) && (Activity.STATUS_COMPLETED).equals(approveStep.getStatus(instance))) {
                 apprStatus = "완료";
             }else if(HumanApprovalActivity.SIGN_APPROVED.equals(apprStat)) {
                 apprStatus = "승인";
             }else if(HumanApprovalActivity.SIGN_REJECT.equals(apprStat)) {
                 apprStatus = "반송";
             }else{
            	 apprStatus = "대기";
             }

             RoleMapping approver = null;
 			
 			if(humanApprovalLineActivity.getDraftActivity().getTracingTag().equals(approveStep.getTracingTag()) && isRacing){				
 				approver = (RoleMapping)loggedRoleMapping;
 				approver.fill(instance);
 			}else{
 				approver = (RoleMapping)approveStep.getRole().getMapping(instance);
 			}

			if( approver != null ){
				approver.fill(instance);			
				HashMap userMap = new HashMap();
				userMap.put("empno", approver.getEndpoint());
				userMap.put("resourceName", approver.getResourceName());
				//userMap.put("remark", approver.getPosi_nm());
				userMap.put("remark", approver.getTitle());
				userMap.put("type", apprType);
				//userMap.put("deptfullname", approver.getDept_nm());
				userMap.put("deptfullname", approver.getGroupName());
				userMap.put("preConfirm", approveType);
				userMap.put("status", apprStatus);
				//userMap.put("comname", approver.getCuscom_nm());
				userMap.put("comname", approver.getCompanyId());
				userMap.put("phone", approver.getEmailAddress());// TODO : change this. tel number does not exist. 						
				if(HumanApprovalActivity.SIGN_DRAFT.equals(apprStat) || approveStep.getTracingTag().equals(humanApprovalLineActivity.getDraftActivity().getTracingTag())){
					userMap.put("stepName", approver.getResourceName() + " (상신)");
				}else{
					userMap.put("stepName", approveStep.getName());
				}						
				userMap.put("approveDate", notNull(approveDate));
				changeAppLine.add(userMap);					
			}
		}		
	}

	String empno 		= ""; 
	String koreanname 	= "";
	String remark 		= "";
	String retype 		= "";
	String preConfirm	= "";
	String status		= "";
	String comname		= "";
	String phone		= "";
	String stepName		= "";
	String approvedDate	= "";
	String deptfullname = "";
	
	for(int i=0; i < changeAppLine.size() ; i++){
		HashMap userMap = (HashMap)changeAppLine.get(i);
		empno+= userMap.get("empno") + ";";
		koreanname+= userMap.get("resourceName")+ ";";
		remark+= userMap.get("remark")+ ";";
		retype+= userMap.get("type")+ ";";
		preConfirm+= userMap.get("preConfirm")+ ";";
		status+= userMap.get("status")+ ";";
		comname+= userMap.get("comname")+ ";";
		phone+= userMap.get("phone")+ ";";
		stepName+= userMap.get("stepName") + ";";
		approvedDate += userMap.get("approveDate") + ";";
		deptfullname += userMap.get("deptfullname") + ";";
	}
%>	
	var userCodeSD 			="<%=empno%>";
	var userNameSD			="<%=koreanname%>";
	var userJobPositionSD	="<%=remark%>";
	var approveTypeSD		="<%=retype%>";
	var preConfirmSD		="<%=preConfirm%>";
	var statusSD			="<%=status%>";
	var comnameSD			="<%=comname%>";
	var phoneSD				="<%=phone%>";
	var stepNameSD			="<%=stepName%>";
	var approveDateSD		="<%=approvedDate%>";
	var deptfullnameSD		="<%=deptfullname%>";
	
	var userCodeS			=userCodeSD.split(";");
	var userNameS			=userNameSD.split(";");
	var userJobPositionS	=userJobPositionSD.split(";");
	var approveTypeS		=approveTypeSD.split(";");
	var preConfirmS			=preConfirmSD.split(";");
	var statusS				=statusSD.split(";");
	var comnameS			=comnameSD.split(";");
	var phoneS				=phoneSD.split(";");
	var stepNameS			=stepNameSD.split(";");
	var approveDateS		=approveDateSD.split(";");
	var deptfullnameS		=deptfullnameSD.split(";");
	
	for (i=0;i < <%=completedOrRunningSize%> ; i++) {
		userCode += userCodeS[i] + ";";
		userName += userNameS[i] + ";";
		userJobPosition += userJobPositionS[i] + ";";
		approveType += approveTypeS[i]+ ";";
		preConfirm += preConfirmS[i]+ ";";
		status += statusS[i]+ ";";		
		comname += comnameS[i]+ ";";	
		phone += phoneS[i]+ ";";
		stepName += stepNameS[i] + ";";	
		approveDate += approveDateS + ";";
		deptfullname += deptfullnameS + ";";
				
		var user = new SelectedInfo();
		user.empno			=userCodeS[i];
		user.koreanname		=userNameS[i];
		user.remark			=userJobPositionS[i];
		user.type			=approveTypeS[i];
		user.preConfirm		=preConfirmS[i];
		user.status			=statusS[i];
		user.comname		=comnameS[i];	
		user.phone			=phoneS[i];
		user.stepName		=stepNameS[i];
		user.approveDate	=approveDateS[i];
		user.deptfullname 	=deptfullnameS[i];
		selectedPeople.splice(i,0,user);
	}	
	document.getElementById('changedApprovalLine').value="yes";
}	
	for (i = 0 ; i < selectedPeople.length; i++) {
		userCode += selectedPeople[i].empno+";";
		userName += selectedPeople[i].koreanname+";";
		userJobPosition += selectedPeople[i].remark+";";
		approveType += selectedPeople[i].type+";";
		preConfirm += selectedPeople[i].preConfirm+";";
		status += selectedPeople[i].status+";";
		comname += selectedPeople[i].comname+";";
		phone += selectedPeople[i].phone+";";
		
		//alert(userCode + " /// " + userName + " /// " + userJobPosition + " /// " + approveType + " /// " + preConfirm + " /// " + status + " /// " + comname + " /// " + phone);
	}

	var elems = document.forms[0].elements;
	elems['userName'].value = userName;
	elems['userCode'].value = userCode;
	elems['userJobPosition'].value = userJobPosition;
	elems['approveType'].value = approveType;
	elems['preConfirm'].value = preConfirm;
	elems['status'].value = status;
	elems['comname'].value = comname;
	elems['phone'].value = phone;

	if(selectedPeople.length > 0){
		elems['loadApprovealActivities'].value="yes";
	}else{
		elems['loadApprovealActivities'].value="no";
	}
<%}%>
}

function addRows(id,selectedPeople) {

	//document.getElementById(id).width = 100 * selectedPeople.length;
    var tbody = document.getElementById(id).getElementsByTagName("TBODY")[0];

    for (var i = 0; i < selectedPeople.length; i++) {
    	
    	if (i != 0) {
        	line = document.createElement("TR");
    		
    		td0 = document.createElement("TD");
    		td0.setAttribute("background",WEB_CONTEXT_ROOT + "/images/Common/GrayBoxLine04.gif");
    		td0.width = "3";

    		//종류
            td1 = document.createElement("TD");
            td1.align = "center";
            td1.height = "1"
            td1.width = "144";
            td1.className = "tbllinedot";
            
            td1_1 = document.createElement("TD");
            td1_1.className = "tbllistbg";
            
            
            //결재자
            td2 = document.createElement("TD");
            td2.align = "center";
            td2.height = "1"
            td2.width = "144";
            td2.className = "tbllinedot";
            
            td2_1 = document.createElement("TD");
            td2_1.className = "tbllistbg";
            
            
            //결재일
            td3 = document.createElement("TD");
            td3.align = "center";
            td3.height = "1"
            td3.width = "144";
            td3.className = "tbllinedot";
            
            td3_1 = document.createElement("TD");
            td3_1.className = "tbllistbg";

    		//결과
            td4 = document.createElement("TD");
    		td4.align = "center";
            td4.height = "1"
            td4.width = "144";
            td4.className = "tbllinedot";
            
            td4_1 = document.createElement("TD");
            td4_1.className = "tbllistbg";
    		
    		//결재의견
    		td5 = document.createElement("TD");
            td5.appendChild(document.createTextNode(""));
            td5.align = "center";
            td5.height = "1"
            td5.width = "144";
            td5.className = "tbllinedot";

            td6 = document.createElement("TD");
            td6.background = WEB_CONTEXT_ROOT + "/images/Common/GrayBoxLine04.gif";
            td6.height = "1"
            td6.width = "3";

            line.appendChild(td0);
            line.appendChild(td1);
            line.appendChild(td1_1);
            line.appendChild(td2);
            line.appendChild(td2_1);
            line.appendChild(td3);
            line.appendChild(td3_1);
            line.appendChild(td4);
            line.appendChild(td4_1);
            line.appendChild(td5);
            line.appendChild(td6);
     		
    	    tbody.appendChild(line);
    	}		
    	
    	line = document.createElement("TR");
		
		td0 = document.createElement("TD");
		td0.setAttribute("background",WEB_CONTEXT_ROOT + "/images/Common/GrayBoxLine04.gif");
		td0.width = "3";

		//종류
        td1 = document.createElement("TD");        
        if(selectedPeople[i].stepName != null){
        	td1.appendChild(document.createTextNode(selectedPeople[i].stepName));
        }else{
        	td1.appendChild(document.createTextNode("<%=draftActivityName%> " + selectedPeople[i].remark + " " + selectedPeople[i].koreanname + " (" +selectedPeople[i].type + ")"));
        }
        
        td1.align = "center";
        td1.width = "144";
        td1.height = "24";
        td1.className = "graybg1";
        
        td1_1 = document.createElement("TD");
        td1_1.className = "tbllistbg";
        
        
        //결재자
        td2 = document.createElement("TD");
        td2.appendChild(document.createTextNode(selectedPeople[i].remark + " " + selectedPeople[i].koreanname));
        td2.align = "center";
        td2.width = "144";
        td2.height = "24";
        td2.className = "tbllistcon";
        
        td2_1 = document.createElement("TD");
        td2_1.className = "tbllistbg";
        
        
        //결재일
        td3 = document.createElement("TD");
        if(selectedPeople[i].approveDate != null){
        	td3.appendChild(document.createTextNode(selectedPeople[i].approveDate));
        }else{
        	td3.appendChild(document.createTextNode("-"));
        }
        
        td3.align = "center";
        td3.width = "144";
        td3.height = "24";
        td3.className = "tbllistcon";
        
        td3_1 = document.createElement("TD");
        td3_1.className = "tbllistbg";

		//결과
        td4 = document.createElement("TD");
        //if(i==0) td4.appendChild(document.createTextNode(" signed "));
		//else td4.appendChild(document.createTextNode("-"));
		td4.appendChild(document.createTextNode("[" + selectedPeople[i].status + "]"));
		td4.align = "center";
        td4.width = "144";
        td4.height = "24";
        td4.className = "tbllistcon";
        
        td4_1 = document.createElement("TD");
        td4_1.className = "tbllistbg";
		
		//결재의견
		td5 = document.createElement("TD");
        td5.appendChild(document.createTextNode(""));
        td5.align = "center";
        td5.height = "24";
        td5.width = "144";
        td5.className = "tbllistcon";

        td6 = document.createElement("TD");
        td6.background = WEB_CONTEXT_ROOT + "/images/Common/GrayBoxLine04.gif";
        td6.width = "3";

        line.appendChild(td0);
        line.appendChild(td1);
        line.appendChild(td1_1);
        line.appendChild(td2);
        line.appendChild(td2_1);
        line.appendChild(td3);
        line.appendChild(td3_1);
        line.appendChild(td4);
        line.appendChild(td4_1);
        line.appendChild(td5);
        line.appendChild(td6);
 		
	    tbody.appendChild(line);
    }

    function createNewCell() {
        var cell = document.createElement("td");
        cell.setAttribute("background", WEB_CONTEXT_ROOT + "/images/Common/GrayBoxLine01.gif");
        cell.height = "3";
        return cell;
    }
    
     var line2 = document.createElement("TR");
 
	    td0 = document.createElement("TD");
	    td0.width = "3";
	    td0.height = "3";
	    
	    td0Image = document.createElement("img");
	    td0Image.setAttribute("src", WEB_CONTEXT_ROOT + "/images/Common/GrayBoxMo04.gif");
	    td0Image.width = "3";
	    td0Image.height = "3";
	    
	    td0.appendChild(td0Image);
	    
	    td1 = createNewCell();
	    td2 = createNewCell();
	    td3 = createNewCell();
	    td4 = createNewCell();
	    td5 = createNewCell();
	    td6 = createNewCell();
	    td7 = createNewCell();
	    td8 = createNewCell();
	    td9 = createNewCell();

	    td10 = document.createElement("TD");
	    td10.width = "3";
   
	    td10Image = document.createElement("img");
	    td10Image.setAttribute("src", WEB_CONTEXT_ROOT + "/images/Common/GrayBoxMo03.gif");
	    td10Image.width = "3";
	    td10Image.height = "3";
	    
	    td10.appendChild(td10Image);

	    line2.appendChild(td0);
	    line2.appendChild(td1);
	    line2.appendChild(td2);
	    line2.appendChild(td3);
	    line2.appendChild(td4);
	    line2.appendChild(td5);
	    line2.appendChild(td6);
	    line2.appendChild(td7);
	    line2.appendChild(td8);
	    line2.appendChild(td9);
	    line2.appendChild(td10);
	    
	    tbody.appendChild(line2);
}

function delRow(id,data)
{
    var tbody = document.getElementById(id).getElementsByTagName("TBODY")[0];

    for(var i=tbody.rows.length; i>0; i--){
    	tbody.deleteRow(i-1);
    }
    //if(tbody.rows.length>0){
    //    tbody.deleteRow(tbody.rows.length-1);
    //    tbody.deleteRow(tbody.rows.length-1);
    //    tbody.deleteRow(tbody.rows.length-1);
    //}
}

function completeApprove(apprStat){
	var confirmMessage = "";
	if( apprStat == "draft" ){
		confirmMessage = "draft?";
		selectAll(document.apprForm.approvalLine);
		if( !isSelected(document.apprForm.approvalLine) ){
			// alert('draftAlert');
			return;
		}
	}else if( apprStat == "approve" ){
		confirmMessage = "Approve?";
	}else if( apprStat == "arbitraryApprove" ){
		confirmMessage = "arbitraryApprove?";
	}else if( apprStat == "reject" ){
		confirmMessage = "reject?";
	}
	
	if(confirm(confirmMessage)){
		document.apprForm.apprStat.value = apprStat;
		document.apprForm.target = "_self";
		document.apprForm.submit();
	}else{
		//alert("Cancled");
	}
	
	return;
}
</script>



<!-- Approval Line View -->
<!-- div align="left" style="position:absolute;"-->


<div align="left" style="position:absolute;">
  <select name="approvalLine" size="10" multiple="true"  style="visibility:hidden;">
  <!--select name="approvalLine" size="3" multiple="true"-->
<%
	HumanApprovalLineService fahs= new HumanApprovalLineService();

	approverList = fahs.getApproverList(instance,humanApprovalLineActivity,(HumanApprovalActivity)humanActivity,loggedRoleMapping,isRacing);
	
	out.print(fahs.getApproverListHTMLString());
%>
	</select>
</div>
<center>
<div class="size90per">
    <div id="srctiontab">
        <ul>
            <li><span>결재선  정보</span></li>
        </ul>
    </div>
    <table  cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
	    <tr>
		    <td width="3" height="3"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxMo01.gif" width="3" height="3"></td>
		    <td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine01.gif"></td>
		    <td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine01.gif"></td>
		    <td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine01.gif"></td>
		    <td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine01.gif"></td>
		    <td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine01.gif"></td>
		    <td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine01.gif"></td>
		    <td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine01.gif"></td>
		    <td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine01.gif"></td>
		    <td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine01.gif"></td>
		    <td width="3"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxMo02.gif" width="3" height="3"></td>
		</tr>
	    <tr>
	    	<td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine04.gif"></td>
    	    <td class="tbllisttitle" height="24" width="144" align="center">종류</td><td class="tbllistbg"></td>
            <td class="tbllisttitle" height="24" width="144" align="center">결재자</td><td class="tbllistbg"></td>
            <td class="tbllisttitle" height="24" width="144" align="center">결재일</td><td class="tbllistbg"></td>
            <td class="tbllisttitle" height="24" width="144" align="center">결과</td><td class="tbllistbg"></td>
            <td class="tbllisttitle" height="24" width="144" align="center">결재의견</td>
            <td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine04.gif"></td>
        </tr>
    </table>
    <table id="myTable"  cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
    <tbody>              	
                <%
                    HashMap approverMap = null;
                    for(int i=0; i<approverList.size(); i++) {
                        approverMap = (HashMap)approverList.get(i);

                        out.println("<tr>");
                        out.println("<td background=\"" + GlobalContext.WEB_CONTEXT_ROOT + "/images/Common/GrayBoxLine04.gif\"></td>");
                        out.println("<td class=\"graybg1\" height=\"24\" width=\"144\" align=center>");
                        out.println(approverMap.get("stepName"));
                        out.println("</td><td class=\"tbllistbg\"></td>");
                        out.println("<td class=\"tbllistcon\" height=\"24\" width=\"144\" align=center>");
                        out.println((String)approverMap.get("jikCheck") + " " + (String)approverMap.get("resourceName"));
                        out.println("</td><td class=\"tbllistbg\"></td>");
                        out.println("<td class=\"tbllistcon\" height=\"24\" width=\"144\" align=center>");
                        out.println((String)approverMap.get("approveDate"));
                        out.println("</td><td class=\"tbllistbg\"></td>");
                        out.println("<td class=\"tbllistcon\" height=\"24\" width=\"144\" align=center>");
                        
                        boolean isCompletedActivityStatus = (Activity.STATUS_COMPLETED).equals((String)approverMap.get("activityStatus"));
                        boolean changedApprovalLine = "yes".equals(request.getParameter("changedApprovalLine"));

                        if((Activity.STATUS_RUNNING).equals((String)approverMap.get("activityStatus")) || (Activity.STATUS_TIMEOUT).equals((String)approverMap.get("activityStatus"))){
                   	 		out.println("[진행중]");
                        }else if(HumanApprovalActivity.SIGN_DRAFT.equals((String)approverMap.get("approveStep")) && isCompletedActivityStatus ) {
                            out.println("[완료]");
                        }else if(HumanApprovalActivity.SIGN_APPROVED.equals((String)approverMap.get("approveStep")) && isCompletedActivityStatus) {
                            out.println("[승인]");
                        }else if(HumanApprovalActivity.SIGN_ARBITRARY_APPROVED.equals((String)approverMap.get("approveStep"))&& isCompletedActivityStatus) {
                            out.println("[전결]");
                        }else if(HumanApprovalActivity.SIGN_REJECT.equals((String)approverMap.get("approveStep")) && isCompletedActivityStatus ) {
                        		out.println("[반송]");
                        }else{
                       	 	out.println("[대기]");
                        }
                
                        out.println("</td><td class='tbllistbg'></td>");
                        out.println("<td class='tbllistcon' height='24' width='144' align='center'>");

						if(( !HumanApprovalActivity.SIGN_DRAFT.equals((String)approverMap.get("approveStep")) &&isCompletedActivityStatus ) 
							//&& !isDraftActivity 
							//&& !Activity.STATUS_RUNNING.equals((String)approverMap.get("activityStatus"))
							//&& !Activity.STATUS_READY.equals((String)approverMap.get("activityStatus"))
							) {

							//String taskId = (String)instance.getProperty((String)approverMap.get("activityTracingTag"), "_task id");
							//System.out.println("=======ess========");
							out.println("<a href=\"javascript:viewComment('" + instanceId + "','" + (String)approverMap.get("activityTracingTag") + "','" + (String)approverMap.get("taskId") + "')\"><img src='" + GlobalContext.WEB_CONTEXT_ROOT + "/images/Common/b_btm_opinion.gif'></a>");
						}else{
							out.println("");
						}
						
                        out.println("</td>");
                        out.println("<td background='" + GlobalContext.WEB_CONTEXT_ROOT + "/images/Common/GrayBoxLine04.gif'></td>");
                        out.println("</tr>");
                        
                        if(i != approverList.size() -1 ){
                        	out.println("<tr>");
                        	out.println("<td colspan='11' class='tbllinedot'></td>");
                        	out.println("<tr>");
                        }                       
                    }                        
				%>
				<tr>
                   <td width='3' height='3'><img src='<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxMo04.gif' width='3' height='3'></td>
                   <td background='<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine01.gif'></td>
                   <td background='<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine01.gif'></td>
                   <td background='<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine01.gif'></td>
                   <td background='<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine01.gif'></td>
                   <td background='<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine01.gif'></td>
                   <td background='<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine01.gif'></td>
                   <td background='<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine01.gif'></td>
                   <td background='<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine01.gif'></td>
                   <td background='<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxLine01.gif'></td>
                   <td width='3'><img src='<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/GrayBoxMo03.gif' width='3' height='3'></td>
				</tr>
            </tbody>
        </table>
<!-- Approval Line View -->
</div>
<%
	if(approverList != null && approverList.size() > 0) {
		//System.out.println();
		//int tableWidth = 100 * approverList.size();
%>

<!-- 결재라인 그리기 부분 -->
<table id="myTable" cellpadding="0" cellspacing="0" border="1" width="100%">
  <tbody>
  </tbody>
</table>
<%
	}
%>

</center>

<script>
	function simulateApprovalLine(){
		try{startWaitMsg();}catch(err){}
		document.mainForm.action = "simulate.jsp";
		document.mainForm.target = "hiddenframe";
		document.mainForm.submit();
	}
</script>

<!-- input type=button value="refresh app line" onclick="simulateApprovalLine()"-->