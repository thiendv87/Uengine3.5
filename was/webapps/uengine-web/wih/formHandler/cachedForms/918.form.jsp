<p>
	STEP 2</p>
<table border="1" cellpadding="1" cellspacing="1" style="width: 723px; height: 60px" width="100%">
	<tbody>
		<tr>
			<td>
				텍스트</td>
			<td>
				라디오</td>
			<td>
				체크</td>
			<td>
				콤보</td>
			<td>
				Textarea</td>
			<td>
				FileUp</td>
			<td>
				Calendar</td>
			<td>
				Find User</td>
		</tr>
		<input:foreach variablename="txtA">
		<tr>
			<td>
				성명<input name="txtA" viewmode="0" /></td>
			<td>
				<input name="rdoA" type="radio" value="0" viewmode="0" />남자<input name="rdoA" type="radio" value="1" viewmode="1" />여자</td>
			<td>
				차량<input name="chkA" type="checkbox" value="111" viewmode="0" /> 자가<input name="chkB" type="checkbox" value="222" viewmode="0" /> 자녀<input name="chkC" type="checkbox" value="333" viewmode="0" /></td>
			<td>
				<select name="selA"><option selected="selected" value="apple" viewmode="1">사과</option><option value="orange">오렌지</option><option value="pinapple">파인애플</option><option value="mango">망고</option></select></td>
			<td>
				<textarea cols="10" name="taA" rows="5" viewmode="0"></textarea></td>
			<td>
				<table border="0" cellpadding="0" cellspacing="0" width="200">
					<tbody>
						<tr>
							<td>
								<input:fileupload fileclass="general" name="testFile" value="fileupload" viewmode="0"></input:fileupload></td>
							<td width="10">
								<div id="ctrlIconDiv">
									&nbsp;</div>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
			<td>
				<table border="0" cellpadding="0" cellspacing="2" width="200">
					<tbody>
						<tr>
							<td>
								<input:calendartag name="caltest" objecttype="calendar" value="calendartag" viewmode="0"></input:calendartag></td>
							<td width="10">
								&nbsp;</td>
						</tr>
					</tbody>
				</table>
			</td>
			<td>
				<table border="0" cellpadding="0" cellspacing="2" width="200">
					<tbody>
						<tr>
							<td>
								<input:finduser multiple="false" name="fuser" value="finduser" viewmode="0"></input:finduser></td>
							<td width="10">
								&nbsp;</td>
						</tr>
					</tbody>
				</table>
			</td>
			<td>
				<input:addrow></input:addrow><input name="nameBtnAddRow" onclick="addRow(this)" style="width: 60px; display: none" type="button" value="Add" /><input onclick="removeRow(this)" style="width: 60px; display: none" type="button" value="Remove" /></td>
		</tr>
		</input:foreach>
	</tbody>
</table>
<br />
<p>
	<input name="txtB" />&nbsp;필드1<br />
	<br />
	<input name="chkD" type="checkbox" />&nbsp;필드2<br />
	<br />
	<input name="rdoB" type="radio" value="A" />필드3 <input name="rdoB" type="radio" value="B" />필드3<br />
	<br />
	<textarea cols="5" name="taB" rows="10"></textarea>&nbsp;필드4<br />
	<br />
	<select name="selB"><option selected="selected" value="sonata">소나타</option><option value="k5">K5</option><option value="grandure">그랜져</option><option value="ecuos">에쿠스</option></select>&nbsp;필드5</p>
