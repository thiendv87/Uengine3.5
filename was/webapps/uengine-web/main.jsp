<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@include file="common/header.jsp"%>
<%@include file="common/getLoggedUser.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<link href="style/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	var WEB_CONTEXT_ROOT = "<%=GlobalContext.WEB_CONTEXT_ROOT%>";
	var endpoint = "<%=loggedUserId%>";
	var notExistOpenWork = "<%=GlobalContext.getMessageForWeb("Workitem does not exist", loggedUserLocale)%>";
	var notExistRunningProcess = "<%=GlobalContext.getMessageForWeb("Running the Process does not exist", loggedUserLocale)%>";
	var notExistCompletedProcess =  "<%=GlobalContext.getMessageForWeb("Completed the Process does not exist", loggedUserLocale)%>";
</script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/crossBrowser/elementControl.js" ></script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/ajax/dashboard.js" ></script>
</head>
<body onLoad="init();">
<div class="wrap">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="245" valign="top"><div id="leftsec">
                    <table width="225" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="3" height="3"><img src="images/main/GrayBoxMo01.gif" width="3" height="3" /></td>
                            <td background="images/main/GrayBoxLine01.gif"></td>
                            <td width="3" height="3"><img src="images/main/GrayBoxMo02.gif" width="3" height="3" /></td>
                        </tr>
                        <tr>
                            <td background="images/main/GrayBoxLine04.gif"></td>
                            <td width="225" style="padding:0px 3px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td height="18"><img src="images/main/LogonInfo_<%=loggedUserLocale%>.gif" width="74" height="15" /></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="e9e9e9" height="1"></td>
                                    </tr>
                                    <tr>
                                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin:4px 0px; overflow:">
                                                <tr>
                                                    <%
														String imgPath="images/portrait/"+loggedUserId+".gif";
                                                    	
														java.io.File imgFile = new java.io.File(request.getRealPath(imgPath));
														if (!imgFile.exists()) imgPath="images/main/NoIMG.gif";
													%>
                                                    <td width="95" rowspan="7" valign="middle"><a href="<%=imgPath %>" target="blank"><img src="<%=imgPath %>" width="89" height="100" style="border:1px #CCCCCC solid;"/></a></td>
                                                    <td  style="font-size:11px; letter-spacing:-0.1em;"><img src="images/main/i_blue3.gif" alt="" width="4" height="4"  /> <%=GlobalContext.getMessageForWeb("ID", loggedUserLocale)%> : <strong><%=loggedUserId%></strong></td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size:11px; letter-spacing:-0.1em;"><img src="images/main/i_blue3.gif" alt="" width="4" height="4"/> <%=GlobalContext.getMessageForWeb("Name", loggedUserLocale)%> : <%=loggedUserFullName%></td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size:11px; letter-spacing:-0.1em;"><img src="images/main/i_blue3.gif" alt="" width="4" height="4"/> <%=GlobalContext.getMessageForWeb("msg.Title", loggedUserLocale)%> : <%=loggedUserJikName%></td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size:11px; letter-spacing:-0.1em;"><img src="images/main/i_blue3.gif" alt="" width="4" height="4"/> <%=GlobalContext.getMessageForWeb("Department", loggedUserLocale)%> : <%=loggedUserPartName%></td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                </tr>  
                                            </table></td>
                                    </tr>
                                </table></td>
                            <td background="images/main/GrayBoxLine02.gif"></td>
                        </tr>
                        <tr>
                            <td width="3" height="3"><img src="images/main/GrayBoxMo04.gif" width="3" height="3" /></td>
                            <td background="images/main/GrayBoxLine03.gif"></td>
                            <td width="3" height="3"><img src="images/main/GrayBoxMo03.gif" width="3" height="3" /></td>
                        </tr>
                    </table>
                    <br />
                    <table width="225" height="195" border="0" cellpadding="0" cellspacing="0" background="images/main/BusinessBox_<%=loggedUserLocale%>.jpg">
                        <tr>
                            <td height="34"></td>
                        </tr>
                        <tr>
                            <td valign="top"><table>
                            <tbody id="dashboardCount"></tbody>
                                </table></td>
                        </tr>
                    </table>
                    <br />
                </div></td>
            <td width="100%" valign="top"><div id="centersec">
                    <!-- 처리할 업무함 -->
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="9" height="9"><img src="images/main/dsNewworkMo01.gif" width="9" height="9"></td>
                            <td  width="100%" background="images/main/dsNewworkLineT.gif"></td>
                            <td width="9" height="9"><img src="images/main/dsNewworkMo02.gif" width="9" height="9"></td>
                        </tr>
                        <tr>
                            <td><img src="images/main/dsNewworkLineTbl.gif" width="9" height="27"></td>
                            <td background="images/main/dsNewworkLineTB.gif" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td valign="top"><img src="images/main/process01_<%=loggedUserLocale%>.gif"></td>
                                        <td align="right" style="padding-right:33px;"><a href="processparticipant/worklist/index.jsp?type=worklist&filtering=0" target="_parent"><img src="images/main/b_more02.gif"></a></td>
                                    </tr>
                                </table></td>
                            <td><img src="images/main/dsNewworkLineTbR.gif" width="9" height="27"></td>
                        </tr>
                        <tr>
                            <td background="images/main/dsNewworkLineL.gif"></td>
                            <td class="padding10"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <td height="25" width="40%" align="left" class="999font"><strong><%=GlobalContext.getMessageForWeb("Work Name", loggedUserLocale)%></strong></td>
                                            <td align="left" width="50%" class="999font"><strong><%=GlobalContext.getMessageForWeb("Instance Name", loggedUserLocale)%></strong></td>
                                            <td align="center" width="80" class="999font"><strong><%=GlobalContext.getMessageForWeb("Start Date", loggedUserLocale)%></strong></td>
                                        </tr>
                                        <tr>
                                            <td height="1" colspan="3" bgcolor="e5e5e5"></td>
                                        </tr>
                                    </thead>
                                    <tbody id="openWorkList">
                                    </tbody>
                                </table></td>
                            <td background="images/main/dsNewworkLineR.gif"></td>
                        </tr>
                        <tr>
                            <td height="9"><img src="images/main/dsNewworkMo04.gif" width="9" height="9"></td>
                            <td background="images/main/dsNewworkLineB.gif"></td>
                            <td><img src="images/main/dsNewworkMo03.gif" width="9" height="9"></td>
                        </tr>
                        <tr>
                            <td colspan="3"><img src="images/main/Shadow.gif" width="100%" height="18"></td>
                        </tr>
                    </table>
                    <!-- 진행중인 프로세스 -->
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="padding19"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <td width="40%" height="25" valign="top" align="left" ><img src="images/main/process02_<%=loggedUserLocale%>.gif"></td>
                                            <td width="50%" align="left" >&nbsp;</td>
                                            <td width="80" align="right" valign="top" style="padding:5px 0 0 0;"><a href="processparticipant/participationProcess/index.jsp?type=instancelist&filtering=0" target="_parent"><img src="images/main/b_more.gif" width="41" height="14"></a></td>
                                        </tr>
                                        <tr>
                                            <td height="2" colspan="3" bgcolor="bbbbbb"></td>
                                        </tr>
                                        <tr>
                                            <td height="25" align="left" class="999font"><strong><%=GlobalContext.getMessageForWeb("Instance Name", loggedUserLocale)%></strong></td>
                                            <td align="left" class="999font"><strong><%=GlobalContext.getMessageForWeb("Definition Name", loggedUserLocale)%></strong></td>
                                            <td align="center" class="999font"><strong><%=GlobalContext.getMessageForWeb("Start Date", loggedUserLocale)%></strong></td>
                                        </tr>
                                        <tr>
                                            <td height="1" colspan="3" bgcolor="e5e5e5"></td>
                                        </tr>
                                    </thead>
                                    <tbody id="runningProcessList">
                                    </tbody>
                                </table></td>
                        </tr>
                    </table>
                    <!-- 완료된 프로세스 출력 -->
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="padding19"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <td width="40%" height="25" valign="top" align="left" ><img src="images/main/process03_<%=loggedUserLocale%>.gif"></td>
                                            <td width="50%" align="left" >&nbsp;</td>
                                            <td width="80" align="right" valign="top" style="padding:5px 0 0 0;"><a href="processparticipant/participationProcess/index.jsp?type=instancelist&filtering=1" target="_parent"><img src="images/main/b_more.gif" width="41" height="14"></a></td>
                                        </tr>
                                        <tr>
                                            <td height="2" colspan="3" bgcolor="bbbbbb"></td>
                                        </tr>
                                        <tr>
                                            <td height="25" align="left" class="999font"><strong><%=GlobalContext.getMessageForWeb("Instance Name", loggedUserLocale)%></strong></td>
                                            <td align="left" class="999font"><strong><%=GlobalContext.getMessageForWeb("Definition Name", loggedUserLocale)%></strong></td>
                                            <td align="center" class="999font"><strong><%=GlobalContext.getMessageForWeb("Start Date", loggedUserLocale)%></strong></td>
                                        </tr>
                                        <tr>
                                            <td height="1" colspan="3" bgcolor="e5e5e5"></td>
                                        </tr>
                                    </thead>
                                    <tbody id="completedProcessList">
                                    </tbody>
                                </table></td>
                        </tr>
                    </table>
                </div></td>
            <td width="245" valign="top"><div id="rightsec">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #CCCCCC; ">
                        <tr>
                            <td><img src="images/main/5app_<%=loggedUserLocale%>.gif" width="137" height="15"></td>
                        </tr>
                        <tr>
                            <td align="center"><table width="187" border="0" cellspacing="0" cellpadding="0" background="images/main/GRbg.gif">
                                    <tr align="center" valign="bottom">
                                        <td width="37" height="123" ><table width="12" border="0" cellspacing="0" cellpadding="0">
                                                <tr align="center">
                                                    <td>1230</td>
                                                </tr>
                                                <tr align="center">
                                                    <td><img src="images/main/GRbar.gif" id="chart0" height="0" width="12" align="middle"></td>
                                                </tr>
                                            </table></td>
                                        <td width="37"><table width="12" border="0" cellspacing="0" cellpadding="0">
                                                <tr align="center">
                                                    <td>125</td>
                                                </tr>
                                                <tr align="center">
                                                    <td><img src="images/main/GRbar.gif" id="chart1" height="0" width="12" align="middle"></td>
                                                </tr>
                                            </table></td>
                                        <td width="37"><table width="12" border="0" cellspacing="0" cellpadding="0">
                                                <tr align="center">
                                                    <td>256</td>
                                                </tr>
                                                <tr align="center">
                                                    <td><img src="images/main/GRbar.gif" id="chart2" height="0" width="12" align="middle"></td>
                                                </tr>
                                            </table></td>
                                        <td width="34"><table width="12" border="0" cellspacing="0" cellpadding="0">
                                                <tr align="center">
                                                    <td>984</td>
                                                </tr>
                                                <tr align="center">
                                                    <td><img src="images/main/GRbar.gif" id="chart3" height="0" width="12" align="middle"></td>
                                                </tr>
                                            </table></td>
                                        <td width="42"><table width="12" border="0" cellspacing="0" cellpadding="0">
                                                <tr align="center">
                                                    <td>85</td>
                                                </tr>
                                                <tr align="center">
                                                    <td><img src="images/main/GRbar.gif" id="chart4" height="0" width="12" align="middle"></td>
                                                </tr>
                                            </table></td>
                                    </tr>
                                    <tr align="center">
                                        <td height="33" class="monthfont">11 Mon</td>
                                        <td class="monthfont">12 Mon</td>
                                        <td class="monthfont">1 Mon</td>
                                        <td class="monthfont">2 Mon</td>
                                        <td class="monthfont">3 &nbsp;Mon</td>
                                    </tr>
                                    <tr align="center">
                                        <td height="10" colspan="5"></td>
                                    </tr>
                                </table></td>
                        </tr>
                    </table>
                    <br>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #CCCCCC; ">
                        <tr>
                            <td><img src="images/main/5app2_<%=loggedUserLocale%>.gif" width="140" height="15"></td>
                        </tr>
                        <tr>
                            <td align="center"><table width="187" border="0" cellspacing="0" cellpadding="0" background="images/main/GRbg.gif">
                                    <tr align="center" valign="bottom">
                                        <td width="37" height="123" ><table width="12" border="0" cellspacing="0" cellpadding="0">
                                                <tr align="center">
                                                    <td>1223</td>
                                                </tr>
                                                <tr align="center">
                                                    <td><img src="images/main/wrGRbar.gif" id="wrchart0" height="0" width="12" align="middle"></td>
                                                </tr>
                                            </table></td>
                                        <td width="37"><table width="12" border="0" cellspacing="0" cellpadding="0">
                                                <tr align="center">
                                                    <td>1021</td>
                                                </tr>
                                                <tr align="center">
                                                    <td><img src="images/main/wrGRbar.gif" id="wrchart1" height="0" width="12" align="middle"></td>
                                                </tr>
                                            </table></td>
                                        <td width="37"><table width="12" border="0" cellspacing="0" cellpadding="0">
                                                <tr align="center">
                                                    <td>568</td>
                                                </tr>
                                                <tr align="center">
                                                    <td><img src="images/main/wrGRbar.gif" id="wrchart2" height="0" width="12" align="middle"></td>
                                                </tr>
                                            </table></td>
                                        <td width="34"><table width="12" border="0" cellspacing="0" cellpadding="0">
                                                <tr align="center">
                                                    <td>120</td>
                                                </tr>
                                                <tr align="center">
                                                    <td><img src="images/main/wrGRbar.gif" id="wrchart3" height="0" width="12" align="middle"></td>
                                                </tr>
                                            </table></td>
                                        <td width="42"><table width="12" border="0" cellspacing="0" cellpadding="0">
                                                <tr align="center">
                                                    <td>685</td>
                                                </tr>
                                                <tr align="center">
                                                    <td><img src="images/main/wrGRbar.gif" id="wrchart4" height="0" width="12" align="middle"></td>
                                                </tr>
                                            </table></td>
                                    </tr>
                                    <tr align="center">
                                        <td height="33" class="monthfont">11 Mon</td>
                                        <td class="monthfont">12 Mon</td>
                                        <td class="monthfont">1 Mon</td>
                                        <td class="monthfont">2 Mon</td>
                                        <td class="monthfont">3 &nbsp;Mon</td>
                                    </tr>
                                    <tr align="center">
                                        <td height="10" colspan="5"></td>
                                    </tr>
                                </table></td>
                        </tr>
                    </table>
                    <script language=javascript> 
                        <!--
                        var data=new Array(100,32,59,98,13); 
                        
                        for(i=0;i<5;i++){ 
                            if(eval("chart" + i + ".height") < data[i]){ 
                                gph("chart" + i,data[i]); 
                            } 
                        } 
                        
                        function gph(what,limit){ 
                            if(eval(what + ".height") < limit){ 
                            if(eval(what + ".height")+5 > limit) 
                                eval(what +".height=" + limit); 
                            else 
                                eval(what +".height=" + what + ".height + 5"); 
                                setTimeout("gph('"+ what + "'," + limit + ")",0); 
                            } 
                        }
                        //-->
						
						 <!--
                        var data=new Array(100,82,40,10,57); 
                        
                        for(i=0;i<5;i++){ 
                            if(eval("wrchart" + i + ".height") < data[i]){ 
                                gph2("wrchart" + i,data[i]); 
                            } 
                        } 
                        
                        function gph2(what,limit){ 
                            if(eval(what + ".height") < limit){ 
                            if(eval(what + ".height")+5 > limit) 
                                eval(what +".height=" + limit); 
                            else 
                                eval(what +".height=" + what + ".height + 5"); 
                                setTimeout("gph2('"+ what + "'," + limit + ")",0); 
                            } 
                        }
                        //-->
                        </script>
                </div></td>
        </tr>
    </table>
</div>
</body>
</html>