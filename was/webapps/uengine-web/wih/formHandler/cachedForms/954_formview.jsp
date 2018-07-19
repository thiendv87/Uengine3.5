<%@ page pageEncoding="UTF-8" %><%response.setContentType("text/html; charset=UTF-8");%>
<%@include file="../../../common/commons.jsp"%>

<p>
	&nbsp;</p>
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
				
 <% 
 java.util.Hashtable val_cls_0 = new java.util.Hashtable(); 
 java.util.List val_cls_1 = new java.util.Vector(); 
 java.util.List val_cls_2 = new java.util.Vector(); 
 val_cls_1.add("선택"); val_cls_2.add(""); 
 val_cls_1.add("SoftWare"); val_cls_2.add("sw"); 
 val_cls_1.add("Hardware"); val_cls_2.add("hw"); 
 val_cls_1.add("Etc"); val_cls_2.add("etc"); 
 
 %> 
 <% 
 String[] val_cls_3 = new String[1]; 
 val_cls_3[0] = ""; 
 %> 
 <input:select name="val_cls" defaults="<%=val_cls_3%>" optionLabels="<%=val_cls_1%>" optionValues="<%=val_cls_2%>" attributes="<%=val_cls_0%>" multiple="false" viewMode="<%=InputConstants.VIEW%>"  /> </td>
			<td class="ui-widget-content">
				
 <% 
 java.util.Hashtable val_lev_5 = new java.util.Hashtable(); 
 val_lev_5.put("viewmode", "0"); 
 %> <input:radio name="val_lev" value="a" attributes="<%=val_lev_5%>" default="" viewMode="<%=InputConstants.VIEW%>" />A 
 <% 
 java.util.Hashtable val_lev_6 = new java.util.Hashtable(); 
 val_lev_6.put("viewmode", "0"); 
 %> <input:radio name="val_lev" value="b" attributes="<%=val_lev_6%>" default="" viewMode="<%=InputConstants.VIEW%>" />B 
 <% 
 java.util.Hashtable val_lev_7 = new java.util.Hashtable(); 
 val_lev_7.put("viewmode", "0"); 
 %> <input:radio name="val_lev" value="c" attributes="<%=val_lev_7%>" default="" viewMode="<%=InputConstants.VIEW%>" />C</td>
			<td class="ui-widget-content">
				<input:calendartag name="val_reqdt" objecttype="calendar" viewmode="<%=InputConstants.VIEW%>" ></input:calendartag></td>
			<td class="ui-widget-content">
				
 <% 
 java.util.Hashtable val_cost_4 = new java.util.Hashtable(); 
 val_cost_4.put("viewmode", "0"); 
 
 %> 
 <input:text name="val_cost" attributes="<%=val_cost_4%>" default="" viewMode="<%=InputConstants.VIEW%>" /></td>
			<td class="ui-widget-content">
				<input:databaseref codefield="DEFID" displayfield="NAME" dsn="java:/uEngineDS" name="val_datasel" sql="select DEFID as value, NAME as displayValue from BPM_PROCDEF where objtype='process' and isdeleted='0' " tablename="BPM_PROCDEF" viewmode="<%=InputConstants.VIEW%>" ></input:databaseref></td>
			<td class="ui-widget-content">
				
 <% 
 java.util.Hashtable val_note_8 = new java.util.Hashtable(); 
 val_note_8.put("cols", "30"); 
 val_note_8.put("rows", "5"); 
 
 %> 
 <input:textarea name="val_note" attributes="<%=val_note_8%>" default="" viewMode="<%=InputConstants.VIEW%>" /></td>
			<td class="ui-widget-content">
				<input:fileupload fileclass="general" name="val_file" value="fileupload" viewmode="<%=InputConstants.VIEW%>" ></input:fileupload></td>
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
				<input:richtextarea height="150px" id="val_cmt" name="val_cmt" viewmode="<%=InputConstants.VIEW%>"  width="100%"></input:richtextarea></td>
		</tr>
	</tbody>
</table>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
