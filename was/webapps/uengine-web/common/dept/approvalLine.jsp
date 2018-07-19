<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="_rdm" type="com.woorifis.srms.core.result.ResultDataManager" scope="request"/>
<%@page import="com.woorifis.srms.common.bean.ApprovalLineBean"%>
<%@page import="java.util.*, 
java.util.Comparator,
java.util.HashMap,
java.util.List,
java.util.Map,
java.util.TreeMap,
java.io.StringWriter,
java.io.PrintWriter"%>
<%@page import="com.woorifis.srms.util.StringUtil"%>
<%@page import="com.woorifis.srms.util.EncodeUtil"%>
<%@page import="com.woorifis.srms.util.DateUtil"%>
<%!
	public List makeHtml(List<ApprovalLineBean> dl){
		String div = "^";
		String values = "";
		String gseq="";
		String vTexts="";
		String title="";
		List valueList = new ArrayList();
		int i=1;
		int lsize = dl.size();
		int index=0;
		for(ApprovalLineBean data : dl){

			//System.out.println(gseq+" ||| "+data.getGseq());
			if((i!=1&&!gseq.equals(data.getGseq()))){
				valueList.add(title+"="+values+"="+vTexts);
				values="";
				vTexts="";
				title = "";
				index++;
			}
			
			if(i==1||gseq.equals(data.getGseq())||data.getDseq().equals("1")){
				values += data.getGseq()+div+data.getDseq()+div+data.getApvId()+div+data.getApvNm()
						+div+data.getPosiNm()+div+data.getDeptNm()+div+data.getDeptCd()+div+data.getPosiCd()
						+div+data.getUserId()+div+data.getDeptLv1()+div+data.getTelNo()+"#";
				vTexts += data.getDeptNm()+"  "+data.getApvNm()+"("+data.getPosiNm()+")<BR>";
				title = data.getGrpNm();
			}
			
			if(i==lsize){
				//values = values+data.getGseq()+div+data.getDseq()+div+data.getApvId()+div+data.getApvNm()+div+data.getPosiNm()+div+data.getDeptNm()+"#";
				valueList.add(title+"="+values+"="+vTexts);
			}
			gseq = data.getGseq();
			i++;
		}
		
		return valueList;
	}
%>
<%
List<ApprovalLineBean> list = (List<ApprovalLineBean>) _rdm.getData("list");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/style/formdefault.css" />
<link rel="stylesheet" href="/style/popup.css" />
<script type="text/javascript">

function approvalLineSet(values,grpNm){

	var splits;
	
	var grpno;
	var seq;
	var empno;
	var uName;
	var postion;
	var dept;
	var deptCds;
	var posiCds;
	var userIds;
	var deptLv1Cd;
	var deptLv1Nm;
	var telNo;
	var approvalLine = new Array();
	var splits = values.split("#");
	var splits2;
	if(deleted()){
		for(i=0;i<(splits.length-1);i++){
			splits2 = splits[i].split("^");
			grpno = splits2[0];
			seq = splits2[1];
			empno = splits2[2];
			uName = splits2[3];
			postion = splits2[4];
			dept = splits2[5];
			deptCds = splits2[6];
			posiCds = splits2[7];
			userIds = splits2[8];
			deptLv1Cd = splits2[9];
			deptLv1Nm = splits2[10];
			telNo = splits2[11];
			//alert(grpno+"\n"+seq+"\n"+empno+"\n"+uName+"\n"+postion+"\n"+dept);
			window.parent.addRow(uName,postion,dept,empno,grpno,deptCds,posiCds,deptLv1Cd,deptLv1Nm,telNo);	
		}
	}
	window.parent.grpNo(grpno);
	window.parent.setGseq(grpno);
	//addRow(uName,uPotion,uDept,uEmpno);
}
function deleted(){
	window.parent.allDelRow();
	return true;
}
</script>
</head>
<body style="margin-top:0px; margin-left:0px;">

<form name="form">
<table cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
	<tr>
       <td width="30" height="24" align="center" class="tbllisttitle">선택</td>
       <td class="tbllistbg"></td>
       <td width="80" align="center" class="tbllisttitle">명칭</td>
       <td class="tbllistbg"></td>
       <td align="center" class="tbllisttitle">결재선</td>
	</tr>
	<tr>
	    <td colspan="5" class=" tblline"></td>
	</tr>
	<tr>
	    <td colspan="5" height="2" bgcolor="#eaeaea"></td>
	</tr>
<%
	List lists = makeHtml(list);
	String vlaues = "";
	String vText="";
	String vGrpNm="";
	String bgcolor="#F5F5F5";
 for(int i=0;i< lists.size();i++){
	 StringBuffer htmlSb = new StringBuffer();
	 String vVal =(String)lists.get(i);
	 System.out.println(vVal);
	 String[] vSpilt = vVal.split("=");
	 
	 vGrpNm = vSpilt[0];
	 vlaues = vSpilt[1];
	 vText = vSpilt[2];
	 
	 htmlSb.append("<tr bgcolor='"+ ((i%2==0) ? bgcolor:"") +"'> \n");
	 htmlSb.append("<td class=\"tbllistcon\" align=\"center\" height=\"24\"><label> \n");
	 //htmlSb.append("<input type='hidden' name='grpNm' value='"+vGrpNm+"'> \n");
	 htmlSb.append("<input type=\"radio\" name=\"approvalLine\" value=\""+vlaues+"\" onClick=\"javascript:approvalLineSet(this.value,'"+vGrpNm+"')\"> \n");
	 htmlSb.append("</label></td> \n");
	 htmlSb.append("<td></td> \n");
	 htmlSb.append("<td class=\"tbllistcon\" align=\"center\">"+vGrpNm+"</td> \n");
	 htmlSb.append("<td></td> \n");
	 htmlSb.append("<td  class=\"tbllistcon\" style=\"padding:5 0\">"+vText+"</td> \n");
	 htmlSb.append("</tr> \n");
	 htmlSb.append("<tr> \n");
	 htmlSb.append("<td colspan=\"5\" class=\" tbllinedot\"></td> \n");
	 htmlSb.append("</tr> \n");
	 out.print(htmlSb.toString());
 }
%>            
</table>

</form>	
</body>
</html>