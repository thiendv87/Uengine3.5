<table border="1" cellspacing="1" cellpadding="1" width="723" style="width: 723px; height: 60px">
    <tbody>
        <input:foreach variablename="testFile">
        <tr>
            <td>성명<input name="txtA" type="text" /></td>
            <td><input type="radio" name="rdoA" value="0" />남자<input type="radio" name="rdoA" value="1" />여자</td>
            <td>자가:<input type="checkbox" name="chkA" value="on" /></td>
            <td><select name="selA">
            <option value="apple" selected="selected">사과</option>
            <option value="orange">오렌지</option>
            <option value="pinapple">파인애플</option>
            <option value="mango">망고</option>
            </select></td>
            <td><textarea rows="5" cols="10" name="taA"></textarea></td>
            <td>
            <table border="0" cellspacing="0" cellpadding="0" width="200">
                <tbody>
                    <tr>
                        <td><input:fileupload name="testFile" value="fileupload" fileclass="general" viewmode="0"></input:fileupload></td>
                        <td width="10">
                        <div id="ctrlIconDiv"><img class="hiddenIcon" alt="" src="/uengine-web/processmanager/images/fileUpload.gif" /></div>
                        </td>
                    </tr>
                </tbody>
            </table>
            </td>
            <td><input:addrow></input:addrow><input type="button" onclick="addRow(this)" style="width: 60px; display: none" name="nameBtnAddRow" value="Add" /><input type="button" onclick="removeRow(this)" style="width: 60px; display: none" value="Remove" /></td>
        </tr>
        </input:foreach>
    </tbody>
</table>
<br />
<input name="txtB" type="text" />&nbsp;필드1<br />
<br />
<input type="checkbox" name="chkB" value="on" />&nbsp;필드2<br />
<br />
<input type="radio" name="rdoB" value="A" />필드3 <input type="radio" name="rdoB" value="B" />필드3<br />
<br />
<textarea rows="10" cols="5" name="taB"></textarea>&nbsp;필드4<br />
<br />
<select name="selB">
<option value="sonata" selected="selected">소나타</option>
<option value="k5">K5</option>
<option value="grandure">그랜져</option>
<option value="ecuos">에쿠스</option>
</select>&nbsp;필드5