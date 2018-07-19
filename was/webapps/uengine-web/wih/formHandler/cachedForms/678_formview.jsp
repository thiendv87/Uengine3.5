<%@ page pageEncoding="UTF-8" %><%response.setContentType("text/html; charset=UTF-8");%>
<%@include file="../../../common/commons.jsp"%>

<ul>
    <li><font face="맑은 고딕" size="2"><strong>Selcet the Type of Issue Item</strong></font><br />
    
 <% 
 java.util.Hashtable issueType_1 = new java.util.Hashtable(); 
 
 %> <input:radio name="issueType" value="1" attributes="<%=issueType_1%>" default="" viewMode="<%=InputConstants.VIEW%>" />Draft Type A
 <% 
 java.util.Hashtable issueType_2 = new java.util.Hashtable(); 
 
 %> <input:radio name="issueType" value="2" attributes="<%=issueType_2%>" default="" viewMode="<%=InputConstants.VIEW%>" />Draft Type B&nbsp; 
 <% 
 java.util.Hashtable issueType_3 = new java.util.Hashtable(); 
 
 %> <input:radio name="issueType" value="3" attributes="<%=issueType_3%>" default="" viewMode="<%=InputConstants.VIEW%>" />Draft T&nbsp;&nbsp; 
 <% 
 java.util.Hashtable issueType_4 = new java.util.Hashtable(); 
 
 %> <input:radio name="issueType" value="4" attributes="<%=issueType_4%>" default="" viewMode="<%=InputConstants.VIEW%>" />Others&nbsp;</li>
</ul>
<ul>
    <li>Select a person in charge (who) solved..
    <table cellspacing="2" cellpadding="0" width="200" border="0">
        <tbody>
            <tr>
                <td><input:finduser name="rightPerson" value="finduser" viewmode="<%=InputConstants.VIEW%>"  multiple="true"></input:finduser></td>
                <td width="10"><img class="hiddenIcon" alt="" align="middle" src="/uengine-web/processmanager/images/Toolbar-toblock.gif" /></td>
            </tr>
        </tbody>
    </table>
    </li>
</ul>
<ul>
    <li>Input the (Issue) Title. <br />
    
 <% 
 java.util.Hashtable issueTitle_0 = new java.util.Hashtable(); 
 issueTitle_0.put("size", "70"); 
 
 %> 
 <input:text name="issueTitle" attributes="<%=issueTitle_0%>" default="" viewMode="<%=InputConstants.VIEW%>" />&nbsp;</li>
</ul>
<ul>
    <li>Please upload the files (if you have a file).
    <table cellspacing="0" cellpadding="0" width="200" border="0">
        <tbody>
            <tr>
                <td><input:fileupload name="fileUpload" value="fileupload" viewmode="<%=InputConstants.VIEW%>"  fileclass="general"></input:fileupload></td>
                <td width="10">
                <div id="ctrlIconDiv"><img class="hiddenIcon" alt="" src="/uengine-web/processmanager/images/fileUpload.gif" /></div>
                </td>
            </tr>
        </tbody>
    </table>
    </li>
</ul>
<ul>
    <li>Please select the Priority after considering rate of important and emergency. <br />
    
 <% 
 java.util.Hashtable pathClass_5 = new java.util.Hashtable(); 
 
 %> <input:radio name="pathClass" value="1" attributes="<%=pathClass_5%>" default="" viewMode="<%=InputConstants.VIEW%>" />Critical Path&nbsp; 
 <% 
 java.util.Hashtable pathClass_6 = new java.util.Hashtable(); 
 
 %> <input:radio name="pathClass" value="2" attributes="<%=pathClass_6%>" default="" viewMode="<%=InputConstants.VIEW%>" />A&nbsp;&nbsp; 
 <% 
 java.util.Hashtable pathClass_7 = new java.util.Hashtable(); 
 
 %> <input:radio name="pathClass" value="3" attributes="<%=pathClass_7%>" default="" viewMode="<%=InputConstants.VIEW%>" />&nbsp;B&nbsp;&nbsp; 
 <% 
 java.util.Hashtable pathClass_8 = new java.util.Hashtable(); 
 
 %> <input:radio name="pathClass" value="4" attributes="<%=pathClass_8%>" default="" viewMode="<%=InputConstants.VIEW%>" />C&nbsp;</li>
</ul>
<ul>
    <li>Select the date of request for the issue(If the issue is not finished until the required date, its progress will be transfered to the stage of unsettled sceme)&nbsp;
    <table cellspacing="2" cellpadding="0" width="200" border="0">
        <tbody>
            <tr>
                <td><input:calendartag name="endDate" value="calendartag" viewmode="<%=InputConstants.VIEW%>"  objecttype="string"></input:calendartag></td>
                <td width="10"><img class="hiddenIcon" alt="" align="middle" src="/uengine-web/images/Icon/btn_calendar.gif" /></td>
            </tr>
        </tbody>
    </table>
    </li>
</ul>
<ul>
    <li>Please input the content of issue.<br />
    <table style="width: 700px; height: 150px" cellspacing="0" cellpadding="0" border="0">
        <tbody>
            <tr>
                <td>
                <table class="hiddenIcon" style="width: 100%; height: 150px" cellspacing="0" cellpadding="0" border="0">
                    <tbody>
                        <tr>
                            <td align="center"><lable></lable>Rich Text Area</td>
                        </tr>
                    </tbody>
                </table>
                </td>
            </tr>
            <tr>
                <td><input:richtextarea id="issueContext" name="issueContext" height="150px" width="100%" viewmode="<%=InputConstants.VIEW%>" ></input:richtextarea></td>
            </tr>
        </tbody>
    </table>
    <br />
    *Check Point*&nbsp;<br />
    If the task cannot be finished after making efforts for some hours, report immediately &nbsp;
 <% 
 java.util.Hashtable time_11 = new java.util.Hashtable(); 
 time_11.put("size", "5"); 
 
 %> 
 <input:text name="time" attributes="<%=time_11%>" default="" viewMode="<%=InputConstants.VIEW%>" />&nbsp;hours Is it have to report plans before start? 
 <% 
 java.util.Hashtable reportYn_9 = new java.util.Hashtable(); 
 
 %> <input:radio name="reportYn" value="1" attributes="<%=reportYn_9%>" default="" viewMode="<%=InputConstants.VIEW%>" />&nbsp;yes&nbsp;&nbsp;
 <% 
 java.util.Hashtable reportYn_10 = new java.util.Hashtable(); 
 
 %> <input:radio name="reportYn" value="2" attributes="<%=reportYn_10%>" default="" viewMode="<%=InputConstants.VIEW%>" />&nbsp;no</li>
</ul>
