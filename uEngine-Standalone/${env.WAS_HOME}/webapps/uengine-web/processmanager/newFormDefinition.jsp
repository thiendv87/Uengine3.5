<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ include file="../common/header.jsp"%>
<%@ include file="../common/getLoggedUser.jsp"%>
<%@ include file="../scripts/importCommonScripts.jsp"%>
<%@ include file="../common/importOrganizationTree.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../style/uengine.css" />
<link rel="stylesheet" type="text/css" href="../style/portlet.css" />	
<link rel="stylesheet" type="text/css" href="../style/portal.css" />	
<link rel="stylesheet" type="text/css" href="../style/groupware.css" />
<link rel="stylesheet" type="text/css" href="../style/default.css" />
</head>

<body>
<form name="actionForm" action="saveFormDefinition.jsp" method="post">
 
<table border="0" cellpadding="0" cellspacing="0" width="100%" xmlns>
	<tr>
		<td height="28"><span class="sectiontitle">New Page Definition</span>
		</td>
	</tr>

</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="5"></td>
	</tr>
</table>

<script type="text/javascript" language="javascript">
	
	function autoInput(id,obj){
		if((navigator.appName == "Microsoft Internet Explorer")){
			//event.srcElement
			var code = event.keyCode;
			if(code > 64 && code < 91){
				document.getElementById(id).value += String.fromCharCode(code).toLowerCase(); 	
			}else if(code == 8){
				var target = document.getElementById(id);
				var len = target.value.length;
				target.value = target.value.substring(0,len-1);
			}
		}else{
			//obj.target
			var code = obj.which;
			if(code > 64 && code < 91){
				document.getElementById(id).value += String.fromCharCode(code).toLowerCase(); 	
			}else if(code == 8){
				var target = document.getElementById(id);
				var len = target.value.length;
				target.value = target.value.substring(0,len-1);
			}
		}
	}

	function onlyEng(obj) {
	  var onvalue = obj.value;

	  if(onvalue.length > 0){
		  if((onvalue.search(/[^a-z|^A-Z]/) != -1) || (onvalue == '')) {
			alert("<%=GlobalContext.getMessageForWeb("msg.only_english",loggedUserLocale)%>");
			obj.value = '';
			obj.focus();
			obj.style.backgroundColor = "yellow";
		 	return false;
		  }
		  else {
		  	obj.style.backgroundColor = "white";
			return true;
		  }
	  }
	}

</script>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr >
		<td align="center" colspan="3" class="formheadline"></td>
	</tr>		
	
	<tr height="30" >
		<td width="150" class="formtitle">
			Name
		</td>
		<td width="10"></td>
		<td width="*" align="left">
			<input name="definitionName" onKeyDown="javascript:autoInput('definitionAlias',event);">	
		</td>
	</tr>
	<tr >
		<td align="center" colspan="3" class="formline" height="1"></td>
	</tr>
	<tr height="30" >
		<td width="150"class="formtitle">
			Alias
		</td>
		<td width="10"></td>
		<td width="*" align="left" >
			<input name="definitionAlias" id="definitionAlias" onKeyDown="javascript:onlyEng(this);">
		</td>
	</tr>
	<tr >
		<td align="center" colspan="3" class="formline" height="1"></td>
	</tr>
	<tr height="30" >
		<td width="150" class="formtitle">
			Description
		</td>
		<td width="10"></td>
		<td width="*" align="left" >
			<input name="description" size="80" />
		</td>
	</tr>
	<tr>
		<td align="center" colspan="3" class="formheadline"></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="5"></td>
	</tr>
</table>
<!-- 폼 -->
<textarea id="CKeditor1" name="CKeditor1" ></textarea>
<script type="text/javascript">
//<![CDATA[
	CKEDITOR.replace('CKeditor1',
	{
		skin : '<%=GlobalContext.getPropertyString("ckeditor.skin", "kama")%>', 
		width : ($("iframe[name='innerworkarea']").attr("width") - 25) + "px", 
		height : ($(document).height() - 320) + "px"
	});
	CKEDITOR.config.protectedSource.push( /<\%[\s\S]*?\%>/g );
//]]>
</script>

<input type="button" value="Save Page" onClick="setObjectValue();" />

<script type="text/javascript" >
String.prototype.trim = function() {
	 return this.replace(/(^\s*)|(\s*$)/gi, "");
}

function checkValue() {
	var oForm = document.actionForm;
	var isTrue = false;
	if (oForm.definitionName.value.trim().length < 1) {
		alert("Please, Enter your form name");
		oForm.definitionName.focus();
	} else if (oForm.definitionAlias.value.trim().length < 1) {
		alert("Please, Enter your form alias");
		oForm.definitionAlias.focus();
	} else {
		isTrue = true
	}
	return isTrue;
	
}

function setObjectValue() {
	var pressValue = $("#definitionAlias").val();
	
	if(checkValue()) {
		$.ajax({
			url:"<%=GlobalContext.WEB_CONTEXT_ROOT%>/processmanager/checkAliasFormEditor.jsp" , //js, aspx, php, jsp
			data: {"alias" : pressValue},
			type:"POST",
			dataType: "json",
			success: function(data){
				var result = data;
				
				if(result == 1){
					$("#definitionAlias").css({background:"yellow"});
					alert("<%=GlobalContext.getMessageForWeb("msg.duplicated", loggedUserLocale)%>");
					$("#definitionAlias").val("");
					$("#definitionAlias").focus();
				}else{
					document.actionForm.submit();
				}
			},
			error:function(){
				alert("Fail load Fire Action");
				alert(this.url);
			}
		});
	}
}

</script>

<input type="hidden" name="version" 				value="1" />
<input type="hidden" name="isNew" 				value="1" />
<input type="hidden" name="objectType" 			value="form" />
<input type="hidden" name="mimeContents" 		value="" />
<input type="hidden" name="definition" 			value="" />
<input type="hidden" name="folderId" 			value="<%=request.getParameter("folderId")%>" />

</form>
</body> 
</html>