<%@ page pageEncoding="UTF-8" %><%response.setContentType("text/html; charset=UTF-8");%>
<%@include file="../../../common/commons.jsp"%>

<ul>
    <li><font face="맑은 고딕" size="2"><strong>Selcet the Type of Issue Item</strong></font><br />
    
 <% 
 java.util.Hashtable issueType_1 = new java.util.Hashtable(); 
 issueType_1.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:radio name="issueType" viewMode="0" value="1" attributes="<%=issueType_1%>" default="" />Draft Type A
 <% 
 java.util.Hashtable issueType_2 = new java.util.Hashtable(); 
 issueType_2.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:radio name="issueType" viewMode="0" value="2" attributes="<%=issueType_2%>" default="" />Draft Type B&nbsp; 
 <% 
 java.util.Hashtable issueType_3 = new java.util.Hashtable(); 
 issueType_3.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:radio name="issueType" viewMode="0" value="3" attributes="<%=issueType_3%>" default="" />Draft T&nbsp;&nbsp; 
 <% 
 java.util.Hashtable issueType_4 = new java.util.Hashtable(); 
 issueType_4.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:radio name="issueType" viewMode="0" value="4" attributes="<%=issueType_4%>" default="" />Others&nbsp;</li>
</ul>
<ul>
    <li>Select a person in charge (who) solved..
    <table cellspacing="2" cellpadding="0" width="200" border="0">
        <tbody>
            <tr>
                <td><input:finduser name="rightPerson" value="finduser" viewmode="0" multiple="true"></input:finduser></td>
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
 issueTitle_0.put("attrid", "TEMP_ATTR_ID"); 
%>
<input:text name="issueTitle" viewMode="0" attributes="<%=issueTitle_0%>" default="" />&nbsp;</li>
</ul>
<ul>
    <li>Please upload the files (if you have a file).
    <table cellspacing="0" cellpadding="0" width="200" border="0">
        <tbody>
            <tr>
                <td><input:fileupload name="fileUpload" value="fileupload" viewmode="0" fileclass="general"></input:fileupload></td>
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
 pathClass_5.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:radio name="pathClass" viewMode="0" value="1" attributes="<%=pathClass_5%>" default="" />Critical Path&nbsp; 
 <% 
 java.util.Hashtable pathClass_6 = new java.util.Hashtable(); 
 pathClass_6.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:radio name="pathClass" viewMode="0" value="2" attributes="<%=pathClass_6%>" default="" />A&nbsp;&nbsp; 
 <% 
 java.util.Hashtable pathClass_7 = new java.util.Hashtable(); 
 pathClass_7.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:radio name="pathClass" viewMode="0" value="3" attributes="<%=pathClass_7%>" default="" />&nbsp;B&nbsp;&nbsp; 
 <% 
 java.util.Hashtable pathClass_8 = new java.util.Hashtable(); 
 pathClass_8.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:radio name="pathClass" viewMode="0" value="4" attributes="<%=pathClass_8%>" default="" />C&nbsp;</li>
</ul>
<ul>
    <li>Select the date of request for the issue(If the issue is not finished until the required date, its progress will be transfered to the stage of unsettled sceme)&nbsp;
    <table cellspacing="2" cellpadding="0" width="200" border="0">
        <tbody>
            <tr>
                <td><input:calendartag name="endDate" value="calendartag" viewmode="0" objecttype="string"></input:calendartag></td>
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
                <td><input:richtextarea id="issueContext" name="issueContext" height="150px" width="100%" viewmode="0"></input:richtextarea></td>
            </tr>
        </tbody>
    </table>
    <br />
    *Check Point*&nbsp;<br />
    If the task cannot be finished after making efforts for some hours, report immediately &nbsp;
<%
java.util.Hashtable time_11 = new java.util.Hashtable();
 time_11.put("size", "5");
 time_11.put("attrid", "TEMP_ATTR_ID"); 
%>
<input:text name="time" viewMode="0" attributes="<%=time_11%>" default="" />&nbsp;hours Is it have to report plans before start? 
 <% 
 java.util.Hashtable reportYn_9 = new java.util.Hashtable(); 
 reportYn_9.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:radio name="reportYn" viewMode="0" value="1" attributes="<%=reportYn_9%>" default="" />&nbsp;yes&nbsp;&nbsp;
 <% 
 java.util.Hashtable reportYn_10 = new java.util.Hashtable(); 
 reportYn_10.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:radio name="reportYn" viewMode="0" value="2" attributes="<%=reportYn_10%>" default="" />&nbsp;no</li>
</ul>

<script language="javascript"> 
<!-- 
function valid_check(){ 

	return true; 
} 

//--> 
</script> 