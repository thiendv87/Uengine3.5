<!-- cancle Action -->
<%@include file="findBackableActivities.jsp" %>
<%
	try{
		int backSize = backableActivity.size();
		StringBuffer backOption = null;
		if(backSize > 0){
			backOption = new StringBuffer();
			for(int i=backSize-1; i>-1; i--){
				HumanActivity bAct = (HumanActivity)backableActivity.get(i);
				backOption.append("<option value=\""+bAct.getTracingTag()+"\">"+bAct.getName().getText()+"</option>");
			}
			%>
			<!-- Backable Activity start -->
			
			<script type="text/javascript">
				function showhideBackDiv(state){
					//set state
					
					var backDiv = document.getElementById("back");
					if(state=="hide")
						backDiv.style.visibility = "hidden";
					else if(state=="show"){
						backDiv.style.visibility = "visible";
					}
				}
			</script>
			<div id="back" style="visibility: hidden; position: relative; ">
				<table bgcolor="#efefef" cellspacing="3" align="right">
				<tr>
					<td colspan="2" align="right">
						<a href="javascript:showhideBackDiv('hide');"><span>x</span></a>
					</td>
					<td>
					<select id="tracingtag">
						<%=backOption%>
					</select>
					</td>
					<td>
					<a onclick="javascript:back(document.getElementById('tracingtag').value);"/>
						<span><%=GlobalContext.getMessageForWeb("Back", loggedUserLocale)%></span></a>
					</td>
				</tr>
				</table>
			</div>
			<!-- Backable Activity end -->
			<%
		}
	}catch(Exception e){}
%>