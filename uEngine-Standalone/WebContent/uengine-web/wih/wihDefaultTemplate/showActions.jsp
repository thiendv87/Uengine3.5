<%
if(!isViewMode) {
%>
<script type="text/javascript">
	var msgCompleteWork = "<%=GlobalContext.getMessageForWeb("Do you want complete work?", loggedUserLocale) %>";
	var msgDelegateWork = "<%=GlobalContext.getMessageForWeb("Do you want to delegate?", loggedUserLocale) %>";
	var msgSaveWork = "<%=GlobalContext.getMessageForWeb("Do you want to save work?", loggedUserLocale) %>";
</script>
<div id="bottombtnline">
		<br/>
		<%
				if (isRacing) {
		%>			
					<table align="center">
                        <tr>
                            <td class="gBtn">
                                <a onclick="javascript:acceptWorkitem()" ><span><%=GlobalContext.getMessageForWeb("Accept", loggedUserLocale) %></span></a>
                            </td>
                        </tr>
                    </table>
					<!--<a href="javascript:acceptWorkitem()"><img src="../../images/Common/b_btm_acceptance.gif" /></a>&nbsp;-->
		<%		
				} else if (isMine) {
		%>			
					<table align="center" style="padding:30px;">
                        <tr>
                            <td class="gBtn"  style="padding:0 30px;" nowrap="nowrap">
                            	<a style="background:none" ><span style="background:none">&nbsp;&nbsp;&nbsp;</span></a>
                                <a onclick="javascript: submitMainForm();" ><span><%=GlobalContext.getMessageForWeb("Complete", loggedUserLocale) %></span></a>
                                <a onclick="javascript: window.parent.window.close();" ><span><%=GlobalContext.getMessageForWeb("Cancel", loggedUserLocale) %></span></a>
                                <a onclick="javascript: saveWorkitem();" ><span><%=GlobalContext.getMessageForWeb("Save", loggedUserLocale) %></span></a>
                             
                         
                            
		<%
					if (!initiate) {
		%>				        				
                                <a onclick="javascript:delegateWorkitem()" ><span><%=GlobalContext.getMessageForWeb("Delegate", loggedUserLocale) %></span></a> 
                                <input name="delegateEndpoint" id="delegateEndpoint" type="hidden">
                                <!-- <a onclick="javascript:showhideBackDiv('show');"/><span><%=GlobalContext.getMessageForWeb("Back", loggedUserLocale)%></span></a> -->

						
	    <%
					}
		%>
							 <a style="background:none" ><span style="background:none">&nbsp;&nbsp;&nbsp;</span></a>
					<%if(!initiate){ %>
					<%@include file="cancleAction.jsp" %>
					<%} %>
							 </td>
                        </tr>
                    </table>
		<%
		
		
		
		 			//if(backableActivity.size() > 0){ %
					//<br/><br/><select id="tracingtag">
					//	%
						  //for(int i=backableActivity.size()-1; i>-1; i--){
						//	Activity act = (Activity)backableActivity.get(i);
						//%
						 // 	<option value="<=act.getTracingTag()>"><=act.getName()></option>
						//%
						 // }
					//	%
					//</select>
					//<input type="button" value="forword" onclick="javascript:back(document.getElementById('tracingtag').value);"/>
					//% }
		 			
				
			}
		%>
<%@include file="possible_actions.jsp"%>	
</div>
<br>
<%
}
%>