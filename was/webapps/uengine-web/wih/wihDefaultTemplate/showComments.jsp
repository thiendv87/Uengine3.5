<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
<%@include file="../../lib/jquery/importJquery.jsp" %>
</head>
<script>
		function actionComment(type, idx){
			$.ajax({
				url:"<%=GlobalContext.WEB_CONTEXT_ROOT%>/commentService" , //js, aspx, php, jsp
				data: {
					 	 "bpm_comment" : $("textarea[name=bpm_comment]").val()
						,"instid"      : "<%=reqMap.getString("instanceId", "") %>"
						,"idx"		   : idx
						,"type"		   : type
					  },
				type:"POST",
				dataType: "json",
				success: function(data){
					commentListTable(data, "<%=loggedUserId %>");
				},
				error:function(){
					alert("Fail load Fire Action");
				}
			});
		}
		
		function commentListTable(result, uid){
			var tableHtml = "";

			if(result.length>0){
				tableHtml += "<table border='1'>";
				tableHtml += "	<tr>";
				tableHtml += "		<td>instid</td>";
				tableHtml += "		<td>endpoint</td>";
				tableHtml += "		<td>comment</td>";
				tableHtml += "		<td>ctime</td>";
				tableHtml += "		<td>delete_chk</td>";
				tableHtml += "	</tr>";
				for(i=0; i<result.length; i++){
					tableHtml += "	<tr>";
					tableHtml += "		<td>"+result[i].instid+"</td>";
					tableHtml += "		<td>"+result[i].endpoint+"</td>";
					tableHtml += "		<td>"+result[i].comment+"</td>";
					tableHtml += "		<td>"+result[i].created_date+"</td>";
					if(result[i].endpoint == uid)
						tableHtml += "		<td><input type='button' onclick=\"actionComment('delete', "+result[i].idx+");\" value='delete'></td>";
					else
						tableHtml += "		<td>&nbsp;</td>";
					tableHtml += "	</tr>";
				}
				tableHtml += "</table>";
				
				document.getElementById("bComment").innerHTML = tableHtml;
			}else{
				document.getElementById("bComment").innerHTML = "";
			}
		}
	</script>
	
	<textarea rows="5" cols="100" name="bpm_comment"></textarea><input type="button" value="add" onclick="actionComment('insert')">
	<br>