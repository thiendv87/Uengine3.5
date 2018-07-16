<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%response.setContentType("text/html; charset=UTF-8");%>

<%@include file="../../../common/header.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<HTML>
<HEAD>
<TITLE>.:: 결재선지정 ::.</TITLE>
	<link rel="stylesheet" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/global.css" type="text/css">
	<link rel="stylesheet" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/default.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/classic/css/main.css" />
	<link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/formdefault.css" />
    
	<script language="JavaScript">
	<!--//
		function GotoClose(url)
		{
		  opener.location.href = url;
		  window.close();
		}

		function keypressed() {
			if(event.keyCode == "13"){
				ListSubmit();
			}else{
				return;
			}
		}

		function edit_confirm() {
			var selectedCount = 0;
			var selectedOrganizationList = new Array();

			if(btn.document.insert_form.data_code.length > 1){
				var initype = btn.document.insert_form.initype.value;
				var len = btn.document.insert_form.data_code.length;

				var activityStatusFlag = false;
				for(var i=0; i<len; i++ ){
					// add
					var activityStatus = btn.document.insert_form.activityStatus[i].value;

					if(initype == "true"){
						if(i==0){
							if(activityStatus=="Completed") continue;
						}else {
							if(activityStatus=="Completed" || activityStatus=="Running")continue;
						}	
					}
					
					
					var user = new tree.SelectedInfo();

					user.empno 			= btn.document.insert_form.data_code[i].value;
					user.koreanname 	= btn.document.insert_form.data_name[i].value;
					user.deptfullname	= btn.document.insert_form.data_dept[i].value;
					user.remark 		= btn.document.insert_form.data_jik[i].value;
					user.jikname 		= btn.document.insert_form.data_jik[i].value;
					user.type 			= btn.document.insert_form.data_type[i].value;
					
					if(i==(len-1)){
						user.preConfirm = 'no';
					}else{
						user.preConfirm	= btn.document.insert_form.data_type1[i].value;
					}
				
					user.status			= btn.document.insert_form.data_type2[i].value;
					selectedOrganizationList [selectedCount++] = user;
				}
			}
			else {
				var user = new tree.SelectedInfo();
					user.empno 			= btn.document.insert_form.data_code.value;
					user.koreanname 	= btn.document.insert_form.data_name.value;
					user.deptfullname	= btn.document.insert_form.data_dept.value;
					user.remark 		= btn.document.insert_form.data_jik.value;
					user.jikname 		= btn.document.insert_form.data_jik.value;
					user.type 			= btn.document.insert_form.data_type.value;
					user.preconfirm		= btn.document.insert_form.data_type1.value;
					user.status			= btn.document.insert_form.data_type2.value;
					
				selectedOrganizationList [selectedCount++] = user;
			}

			if (selectedOrganizationList.length > 0) {
				parent.onOk(selectedOrganizationList);
				alert("결제선 편집이 완료되었습니다.");
				parent.close();
			} else if(btn.document.insert_form.data_code.length > 1){
				parent.onOk(selectedOrganizationList);
				alert("결제선 편집이 완료되었습니다.");
				parent.close();
			} else{
				alert("선택된 유저가 없습니다.");
			}
		}

		function help() {
			var argsArray = new Array(7);
			argsArray[0] = window;
			argsArray[1] = definitionId;
			var url = "flow_help_frame.jsp?definitionId="+definitionId;
			var StrOption;
			StrOption  = "dialogWidth:520px;dialogHeight:660px;";
			StrOption += "center:on;scroll:auto;status:off;resizable:off";
			showModalDialog (url , argsArray, StrOption);
		}

	    function styletogle() {
			struct.style.display=(struct.style.display==""?"NONE":"");
			userwf.style.display=(userwf.style.display==""?"NONE":"");
	    }

		function showApprovalButton() {
			if(document.all.btn){
                btn.showApprovalButton();
            }else{
                setTimeout("showApprovalButton()",30);
            }
		}

		function showPersonalButton() {
			if(document.all.btn){
                btn.showPersonalButton();
            }else{
                setTimeout("showPersonalButton()",30);
            }
		}

		// 해당하는 모든 페이지가 로딩되기전 클릭되는 것을 막기 위해 설정한 변수
		// body 태그의 onclick이 이 변수값으로 되어있음을 유의하십시오
		// iframe등에서 최종페이지가 호출될 때 clickEnableApproval를 true로 설정해줘야
		// 링크가 정상적으로 돌아옵니다
		// (여기서는 flow_edit_new_grid.jsp가 최종 onload될 때 true로 바꿔줌)
		// by Sunny 2006.2.23
		var clickEnableApproval = false;

		var request = false;
		
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

		function updatePage(){
			 if (request.readyState == 4){
					if (request.status == 200){
						var response = request.responseText;
						document.all.userTable.innerHTML = response;

					}else if (request.status == 404){
						alert("Request URL does not exist");
					}else{
						alert("Error: status code is " + request.status);
					}
			  }
			  
		}
		
		function getSearchWord() {
			searchWord = document.all.searchWord.value;
			
			if(searchWord == null || searchWord == ""){
				alert("검색할 글자를 입력하세요");
				document.getElementById('searchWord').focus();
				return
			}

			createRequest();		
			request.open("GET","/common/searchChartUserTable.jsp?searchWord=" + encodeURIComponent(searchWord) ,true);
			request.onreadystatechange = updatePage;		
			request.send(null);
		}
	//-->
	</script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/tabs.js"></script>
</HEAD>

<BODY leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<script type="text/javascript">
	var tmp = new Array(
			"결재선 지정"
	);
	createTabs(tmp);
</script>
<form name="search" method="post" onKeyPress="return false">

<TABLE width="770" cellpadding="0" cellspacing="0" border="0">
	<TR>
		<TD width="10"></TD>
		<TD align="center">
		
			<!--SPACE START-->		
			<TABLE width="95%" cellpadding="0" cellspacing="0" border="0">
				<TR><TD height="5"></TD></TR>
			</TABLE>
			<!--SPACE END-->
		
			
			<!--INFO START-->			
			<TABLE width="100%" cellpadding="0" cellspacing="0" border="0">
				<TR>
					<TD width="5" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/body/box06_04.gif"></TD>
					<TD width="99%" align="center">

						<TABLE width="100%" cellpadding="0" cellspacing="0" border="0">
						<TR>
							<TD width="43%">
								<!--LEFT TABLE START-->		
									<TABLE width="100%" cellpadding="0" cellspacing="0" border="0">
									<TR>
										<TD>
											<TABLE cellpadding="0" cellspacing="0" border="0">
												<TR>
													<TD><span class="sectiontitle">조직도</span></TD>
													<TD width="3"></TD>
													<!--
													<TD class="tab_2">개인결재선</TD>
													-->
												</TR>
											</TABLE>
										</TD>									
									</TR>
									
									<TR>
										<TD>
											<TABLE width="100%"  cellpadding="0" cellspacing="0" border="0">
											<!--TR>
												<TD width="33%" class="td01_title">
													이름
												</TD>
												<TD width="42%" class="td01_data_left1">
													<input size="17" name="searchWord" onkeypress="javascript:if(event.keyCode==13){getSearchWord();}">
												</TD>
												<TD width="25%" class="td01_data_left1">
													<img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/btn/btn2_03.gif" style="cursor:hand;" onclick="javascript:getSearchWord();">
												</TD>
											</TR-->
											</TABLE>
										</TD>	
									</TR>
									<TR>
										<TD>
											<iframe class="iframe" name="tree" scrolling="no" height=345 NORESIZE frameborder="0" vspace="0" hspace="0" 
											src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/common/organizationChart.jsp?multiple=false&approval=true"></iframe>
										</TD>									
									</TR>
									<TR>
										<TD height="2"></TD>									
									</TR>
									<TR>
										<TD>
											<TABLE width="100%" cellpadding="0" cellspacing="0" border="0">
												<TR>
													<td valign="top" height="100%">
														<!--div class="iframe" id="userTable" style="OVERFLOW-Y: scroll; WIDTH: 314; HEIGHT: 160px"/ -->
													</TD>
												</TR>
											</TABLE>
										</TD>									
									</TR>
									</TABLE>
								<!--LEFT TABLE END-->	
							</TD>
							<TD width="445" valign="top">
								<!--RIGHT TABLE START-->
								<table>
									<tr>
										<td>
											<iframe name="btn" marginwidth="0" marginheight="0" frameborder="0" NORESIZE frameborder="0" width="445" height="367" scrolling="no" vspace="0" hspace="0" 
											src="flow_edit_new_grid.jsp?multiSelect=N&userSelect=Y&isChangeApprovalLine=<%= request.getParameter("isChangeApprovalLine") %>&empno=<%= request.getParameter("empno") %>&activityStatus=<%= request.getParameter("activityStatus") %>&appvtype=<%= request.getParameter("appvtype") %>&initype=<%= request.getParameter("initype") %>"></iframe>
										</td>
									</tr>
								</table>
								<!--RIGHT TABLE END-->	
							</TD>
						</TR>
						</TABLE>
					</TD>
					<TD width="5" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/body/box06_06.gif"></TD>								
				</TR>
			</TABLE>
		<!--INFO END-->			

		</TD>
		<TD width="10"></TD>
	</TR>
    <tr>
    	<td colspan="3">
            <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
                <tr>
                    <td  class="formheadline"></td>
                </tr>
            </table>
        </td>
	<TR>
		<TD colspan="3" class="bottom" >
        	<div align="center">&nbsp;
            <table>
                <tr>
                    <td class="gBtn">
                        <a href="javascript: edit_confirm();">
                        <span>ok</span></a>
                        <a href="javascript: parent.close();">
                        <span>cancel</span></a>
                    </td>
                </tr>
            </table>
            </div>
		</TD>	
	</TR>
</TABLE>


</form>
</BODY>
</HTML>
