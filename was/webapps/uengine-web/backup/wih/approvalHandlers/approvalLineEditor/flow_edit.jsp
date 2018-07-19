<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%response.setContentType("text/html; charset=UTF-8");%>

<%@include file="../../../common/header.jsp"%>
<%@include file="../../../common/getLoggedUser.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>.:: 결재선지정 ::.</title>
	<%@ include file="../../../common/styleHeader.jsp"%>
	<%@ include file="../../../scripts/importCommonScripts.jsp"%>
	<%@ include file="../../../lib/jquery/importJquery.jsp"%>
    
	<script language="JavaScript" type="text/javascript">
	<!--//
		function GotoClose(url)
		{
		  opener.location.href = url;
		  window.close();
		}

		function keypressed()
		{
			if(event.keyCode == "13"){
				ListSubmit();
			}else{
				return;
			}
		}

		function edit_confirm()
		{
			var selectedCount = 0;
			var selectedOrganizationList = new Array();

			if(btn.document.insert_form.data_code.length > 1){
				var len = btn.document.insert_form.data_code.length;

				for(var i=len-1; i>=0; i-- ){
					var user = new tree.SelectedInfo();

					user.empno 			= btn.document.insert_form.data_code[i].value;
					user.koreanname 	= btn.document.insert_form.data_name[i].value;
					user.deptfullname	= btn.document.insert_form.data_dept[i].value;
					user.remark 		= btn.document.insert_form.data_jik[i].value;
					//user.jikname 		= btn.document.insert_form.data_jik[i].value;
					user.type 			= btn.document.insert_form.data_type[i].value;
					//alert(user.type);
					if(i==(len-1)){
						user.preConfirm = 'no';
					
					}else{
						user.preConfirm	= btn.document.insert_form.data_type1[i].value;
					}
				
					
					user.status			= btn.document.insert_form.data_type2[i].value;
					selectedOrganizationList [selectedCount++] = user;
				}
			}
			else
			{
				var user = new tree.SelectedInfo();
					user.empno 			= btn.document.insert_form.data_code.value;
					user.koreanname 	= btn.document.insert_form.data_name.value;
					user.deptfullname	= btn.document.insert_form.data_dept.value;
					user.remark 		= btn.document.insert_form.data_jik.value;
					//user.jikname 		= btn.document.insert_form.data_jik.value;
					user.type 			= btn.document.insert_form.data_type.value;
					user.preconfirm		= btn.document.insert_form.data_type1.value;
					user.status			= btn.document.insert_form.data_type2.value;
					
				selectedOrganizationList [selectedCount++] = user;
			}

			if (selectedOrganizationList.length > 0)
			{
				parent.onOk(selectedOrganizationList);
				alert("결제선 편집이 완료되었습니다.");
				parent.close();
			} else {
				alert("선택된 유저가 없습니다.");
			}
		}

		function help()
		{
			var argsArray = new Array(7);
			argsArray[0] = window;
			argsArray[1] = definitionId;
			var url = "flow_help_frame.jsp?definitionId="+definitionId;
			var StrOption;
			StrOption  = "dialogWidth:520px;dialogHeight:660px;";
			StrOption += "center:on;scroll:auto;status:off;resizable:off";
			showModalDialog (url , argsArray, StrOption);
		}

	    function styletogle()
	    {
			struct.style.display=(struct.style.display==""?"NONE":"");
			userwf.style.display=(userwf.style.display==""?"NONE":"");
	    }

		function showApprovalButton()
		{
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

		function updatePage()
		{
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
		
		function getSearchWord()
		{
			searchWord = document.all.searchWord.value;
			
			if(searchWord == null || searchWord == ""){
				alert("검색할 글자를 입력하세요");
				document.getElementById('searchWord').focus();
				return
			} else {
				createRequest();		
				request.open("GET","/common/searchChartUserTable.jsp?searchWord=" + encodeURIComponent(searchWord) ,true);
				request.onreadystatechange = updatePage;		
				request.send(null);
			}

		}
	//-->
	</script>
	<style type="text/css">
		iframe {
			width: 100%;
			height: 560px;
			border: none;
		}
		
		.button {
			padding: 4px;
		}
	</style>
</head>

<body style="padding: 5px;">
<form name="search" method="post" onKeyPress="return false">
<div id="divContainer">
	<div class="ui-widget ui-widget-header ui-corner-all" style="padding: 5px; margin-bottom: 5px;">Set approval line</div>
	<div>
		<div style="float: left; width: 400px;">
			<iframe class="iframe" name="tree" marginwidth="0" marginheight="0" frameborder="0" frameborder="0" scrolling="no" vspace="0" hspace="0" 
			src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/common/userSelecter.jsp?multiple=false&approval=true"></iframe>
		</div>
		<div style="float: none; margin-left: 400px;">
			<iframe class="iframe"  name="btn" marginwidth="0" marginheight="0" frameborder="0" frameborder="0" scrolling="no" vspace="0" hspace="0" 
			src="flow_edit_new_grid.jsp?multiSelect=N&userSelect=Y&isChangeApprovalLine=<%= request.getParameter("isChangeApprovalLine") %>"></iframe>
		</div>
	</div>
</div>
<div style="padding: 5px; text-align: right; display: block; float: none;">
	<button onmouseover="$(this).addClass('ui-state-hover');" onmouseout="$(this).removeClass('ui-state-hover')" onclick="javascript: edit_confirm();" class="ui-state-default ui-corner-all button"><%=GlobalContext.getMessageForWeb("Ok", loggedUserLocale) %></button>
	<button onmouseover="$(this).addClass('ui-state-hover');" onmouseout="$(this).removeClass('ui-state-hover')" onclick="window.top.close();" class="ui-state-default ui-corner-all button"><%=GlobalContext.getMessageForWeb("Cancel", loggedUserLocale) %></button>
</div>

</form>
</body>
</html>
