<ul>
    <li><font face="맑은 고딕" size="2"><strong>Selcet the Type of Issue Item</strong></font><br />
    <input type="radio" checked="checked" name="issueType" value="1" />Draft Type A<input type="radio" name="issueType" value="2" />Draft Type B&nbsp; <input type="radio" name="issueType" value="3" />Draft T&nbsp;&nbsp; <input type="radio" name="issueType" value="4" />Others&nbsp;</li>
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
    <input size="70" name="issueTitle" type="text" />&nbsp;</li>
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
    <input type="radio" name="pathClass" value="1" />Critical Path&nbsp; <input type="radio" name="pathClass" value="2" />A&nbsp;&nbsp; <input type="radio" name="pathClass" value="3" />&nbsp;B&nbsp;&nbsp; <input type="radio" checked="checked" name="pathClass" value="4" />C&nbsp;</li>
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
    If the task cannot be finished after making efforts for some hours, report immediately &nbsp;<input size="5" name="time" type="text" />&nbsp;hours Is it have to report plans before start? <input type="radio" name="reportYn" value="1" />&nbsp;yes&nbsp;&nbsp;<input type="radio" checked="checked" name="reportYn" value="2" />&nbsp;no</li>
</ul>