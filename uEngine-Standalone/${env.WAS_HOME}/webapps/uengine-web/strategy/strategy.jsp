<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

			<ul id="myMenu" class="contextMenu"> 
				<li class="separator"><B>Strategy</B></li>
				<li class="processStart"><a href="#processStart">Process Start</a></li>
				<li class="refresh"><a href="#refresh">Refresh</a></li>	
				<li class="cut"><a href="#cut">Cut</a></li>
				<li class="paste"><a href="#paste">Paste</a></li>
				<li class="addStrategy"><a href="#addStrategy">Add Strategy</a></li>
				<li class="edit"><a href="#edit">Edit</a></li>
				<li class="delete"><a href="#delete">Delete</a></li>
				<!-- li class="addParent"><a href="#addParent">Add parent</a></li -->


			</ul>
		<div dojoType="dojox.layout.ExpandoPane" 
					splitter="true" 
					duration="125"
					region="left" 
					title="<%=GlobalContext.getMessageForWeb("STRATEGY MAP(beta)", loggedUserLocale)%>" 
					id="leftPane" 
					maxWidth="275" 
					style="width: 40%; background: #fafafa;">
	<!-- Strategy View -->

			
			<div id="selectParentStrategy" style="position: absolute;z-index: 11;display: none;background-color:  #F7F7F7;width:100%;height: 30px;">
				select a strategy from the strategy-map to add the parent of this node.
			</div>
			<div id='searchLink' style='position: absolute;z-index: 11; width:100%;height: 15px;'>
				<table border="0" width="100%" border="0" cellspacing="0" cellpadding="0">
				    
					<tr height="15"><td align="center"><a href="javascript:viewSearchForm(true)"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/strategyViewOpt.gif" /></a></td></tr>
					
				</table>	
			</div>
			<div id='searchForm' style='display: none;'>
			<table border="0" width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr height="30">
                        <td width="120" align="left" bgcolor="f4f4f4">&nbsp;<b>Name</b></td>
                        <td width="10"></td>
                        <td width="*" align="left" bgcolor="#FFFFFF">
							<input type=text id="nameSearch" name="nameSearch" style="width:200px;" Onkeydown="searchName(this)" > <input type="button" value="Search" onclick="searchName()">
						</td>
                    </tr>      
                    <tr>
                        <td class="dotline" colspan="3"></td>
                    </tr>
                    <tr height="30">
                        <td width="115" align="left" bgcolor="f4f4f4">&nbsp;<b>Group in charge</b></td>
                        <td width="10"></td>
                        <td width="*" align="left" bgcolor="#FFFFFF"><div >
							<select name="partSelect" id="partSelect" onchange="search()">
								<option value="">ALL</option>
							<%
							IDAO partList = null;
							try {
								partList = GenericDAO.createDAOImpl(
									DefaultConnectionFactory.create(), 
									"select PARTCODE,PARTNAME from PARTTABLE where GLOBALCOM=?GLOBALCOM",
									IDAO.class
								);
								partList.set("GLOBALCOM", loggedUserGlobalCom);
								partList.select();
							
								while(partList.next()){
									String	partCode = partList.getString("partCode")==null?"":partList.getString("partCode");
									String	partName = partList.getString("partName")==null?"":partList.getString("partName");
							%>
								    <option value="<%=partCode%>"><%=partName%></option>
							<%
								}
							} catch(Exception e){
								e.printStackTrace();
							} finally {
								if (partList != null) {
									partList.releaseResource();
								}
							}
							%>
							</select>
						</div>	</td>
                    </tr>
                    <tr>
                        <td class="dotline" colspan="3"></td>
                    </tr>
                    <tr height="30">
                        <td width="115" align="left" bgcolor="f4f4f4">&nbsp;<b>Period</b></td>
                        <td width="10"></td>
                        <td width="*" align="left" bgcolor="#FFFFFF">
                        	<table>
                        		<tr>
                        			<td>
										<input type="radio" id="period_NONE" name="period" checked="checked" value="" onclick="search()"/>
									</td>
									<td>
						    			<label for="period_NONE">ALL</label>
						    		</td>
						    		<td>
										<input type="radio" id="WEEK" name="period" value="period_week" onclick="search()"/>
									</td>
									<td>
						    			<label for="WEEK">This week</label>
						    		</td>
						    		<td>&nbsp;
						    			<select id='period_select1' style='display:none;' onchange="search(true)">
						    <%
								Calendar now = Calendar.getInstance();
							
								int actualMaximum =now.getActualMaximum(Calendar.WEEK_OF_MONTH);
								for (int i=1 ; i < actualMaximum+1 ;i++){
									int thisWeek =now.get(Calendar.WEEK_OF_MONTH);
						    %>
						    				<option <%=(i==thisWeek)? "selected='seleted'":""%> value='<%=i%>'><%=(i==thisWeek)? i+"*":i%></option> 
						    <%
								}
						    %>
						    			</select>
						    		</td>
						    		<td>
						    			<input type="radio" id="MONTH" name="period"  value="period_month" onclick="search()"/>
									</td>
									<td>
						    			<label for="MONTH">This month </label>
						    		</td>
						    		<td>&nbsp;
						    			<select id='period_select2' style='display:none;' onchange="search(true)">
						    <%
								for (int i=1 ; i <= 12 ;i++){
									int month =now.get(Calendar.MONDAY)+1;
						    %>
						    				<option <%=(i==month)? "selected='seleted'":""%> value='<%=i%>'><%=(i==month)? i+"*":i%></option> 
						    <%
								}
						    %>
						    			</select>
						    		</td>
						    		<td>
									    <input type="radio" id="QUARTER" name="period" value="period_quarter" onclick="search()"/>
									</td>
									<td>
						    			<label for="QUARTER">This quarter</label>
						    		</td>
						    		<td>&nbsp;
						    			<select id='period_select3' style='display:none;' onchange="search(true)">
						    <%
								for (int i=1 ; i <= 4 ;i++){
									int month =now.get(Calendar.MONDAY)+1;
									int quarter = 1;
											
									if(month <= 3){
										quarter=1;
									}else if(month >= 4 && month <= 6){
										quarter=2;				
									}else if(month >= 7 && month <= 9){
										quarter=3;					
									}else if(month >= 10 ){
										quarter=4;				
									}
									
						    %>
						    				<option <%=(i==quarter)? "selected='seleted'":""%> value='<%=i%>'><%=(i==quarter)? i+"*":i%></option> 
						    <%
								}
						    %>
						    			</select>
						    		</td>
						    		<td>
										<input type="radio" id="YEAR" name="period" value="period_year" onclick="search()"/>
									</td>
									<td>
						    			<label for="YEAR">This year</label>
						    		</td>
						    		<td>&nbsp;
						    			<select id='period_select4' style='display:none;' onchange="search(true)">
						    <%
						    	int year =now.get(Calendar.YEAR);
								for (int i=year-2 ; i <= year+2 ;i++){
						    %>
						    				<option <%=(i==year)? "selected='seleted'":""%> value='<%=i%>'><%=(i==year)? i+"*":i%></option> 
						    <%
								}
						    %>
						    			</select>
						    		</td>
						    	</tr>				    								    		
						    </table>

						</td>
                    </tr>
                    <tr>
                        <td class="dotline" colspan="3"></td>
                    </tr>
                    <tr height="30">
                        <td width="120" align="left" bgcolor="f4f4f4">&nbsp;<b>Align</b></td>
                        <td width="10"></td>
                        <td width="*" align="left" bgcolor="#FFFFFF">
	                        <div>
								<input type="radio" id="r-left" name="orientation"  value="left" onclick="setViewMode()"/>
							    <label for="r-left">left </label>
							    
							    <input type="radio" id="r-top" name="orientation" checked="checked" value="top" onclick="setViewMode()"/>
							    <label for="r-top">top </label>
							    
							    <input type="radio" id="r-bottom" name="orientation" value="bottom" onclick="setViewMode()"/>
							    <label for="r-bottom">bottom </label>
							    
							    <input type="radio" id="r-right" name="orientation" value="right" onclick="setViewMode()"/>
							    <label for="r-right">right </label>
						    </div>
						</td>
                    </tr>      
                    <tr>
                        <td class="dotline" colspan="3"></td>
                    </tr>
                    <tr height="30">
                        <td width="120" align="left" bgcolor="f4f4f4">&nbsp;<b>Extra options</b></td>
                        <td width="10"></td>
                        <td width="*" align="left" bgcolor="#FFFFFF">
                        	<div class="formdiv">
								<input type=checkbox name="OnlyStrategyInstance" >Show strategy instance only<br>
								<input type=checkbox name="includingNotCompleted" disabled onclick="search()"> Including not completed
							</div>
						</td>
                    </tr>  
                    <tr>
                        <td style="background:#CCC;" height="1" colspan="3"></td>
                    </tr>
                    <tr>
                        <td height="20" colspan="3" align="center"><b><a href="javascript:initialize()"> Initialize</a> | <a href="javascript:expand()"> Expand</a></b></td>
                    </tr>
                    <tr>
                        <td style="background:#CCC;" height="1" colspan="3"></td>
                    </tr>
                    <tr height="12">
                        <td colspan="3" align='center' style="background:#FFF;">
							 <a href="javascript:viewSearchForm(false)"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/strategyHideOpt.gif" /></a>
						</td>
                    </tr>             
                </table>
            </div>
			<div id="infovis" oncontextmenu="return false" onMousedown="start();" style="cursor:move; border:none;"></div>
			<iframe id="iframeViewTotalResult" src="" scrolling="auto" frameborder="0" width="800" height="500" style="display: none;"></iframe>
			<form id="strategyForm" action="index.jsp" method="get" style="display:none ;" >
				<input type="hidden" name="strategyId" />
				<input type="hidden" name="strategyName" />
			</form>
		</div>
		
	<!-- GanttChart Location -->
		<div dojoType="dijit.layout.ContentPane" region="center" id="centerPane" style="overflow: hidden;">
        	<%@include file="../common/topFrame/titleBarNone.jsp" %>
			<iframe id="iframeGanttChart" src="" onload="changeTitle(this);" onresize="resizeFrame(this);" style="width: 100%; height: 100%; padding-bottom: 30px;" frameborder="0"></iframe>
		</div>
