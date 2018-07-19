<div class="size90per">
	<div id="srctiontab">
		<ul>
			<li>
				<span>이슈항목</span></li>
		</ul>
	</div>
</div>
<table cellpadding="5" width="100%">
	<tbody>
		<tr>
			<td class="ui-state-default">
				분류</td>
			<td class="ui-state-default">
				레벨</td>
			<td class="ui-state-default">
				요청일</td>
			<td class="ui-state-default">
				금액</td>
			<td class="ui-state-default">
				Dataselect</td>
			<td class="ui-state-default">
				내용요약</td>
			<td class="ui-state-default" colspan="2">
				첨부파일</td>
		</tr>
		<input:foreach variablename="val_reqdt">
		<tr>
			<td class="ui-widget-content">
				<select name="val_cls"><option selected="selected" value="">선택</option><option value="sw">SoftWare</option><option value="hw">Hardware</option><option value="etc">Etc</option></select></td>
			<td class="ui-widget-content">
				<input name="val_lev" type="radio" value="a" viewmode="0" />A <input name="val_lev" type="radio" value="b" viewmode="0" />B <input name="val_lev" type="radio" value="c" viewmode="0" />C</td>
			<td class="ui-widget-content">
				<input:calendartag name="val_reqdt" objecttype="string" value="calendartag" viewmode="0"></input:calendartag></td>
			<td class="ui-widget-content">
				<input name="val_cost" viewmode="0" /></td>
			<td class="ui-widget-content">
				<input:databaseref codefield="DEFID" displayfield="NAME" dsn="java:/uEngineDS" name="val_datasel" sql="select DEFID as value, NAME as displayValue from BPM_PROCDEF where objtype='process' and isdeleted='0' " tablename="BPM_PROCDEF" viewmode="0"></input:databaseref></td>
			<td class="ui-widget-content">
				<textarea cols="30" name="val_note" rows="5"></textarea></td>
			<td class="ui-widget-content">
				<input:fileupload fileclass="general" name="val_file" value="fileupload" viewmode="0"></input:fileupload></td>
			<td class="ui-widget-content">
				<input:addrow></input:addrow></td>
		</tr>
		</input:foreach>
	</tbody>
</table>
<p>
	&nbsp;</p>
<div class="size90per">
	<div id="srctiontab">
		<ul>
			<li>
				<span>Comment</span></li>
		</ul>
	</div>
</div>
<table cellpadding="5" width="100%">
	<tbody>
		<tr>
			<td class="ui-widget-content">
				<input:richtextarea height="150px" id="val_cmt" name="val_cmt" viewmode="0" width="100%"></input:richtextarea></td>
		</tr>
	</tbody>
</table>
