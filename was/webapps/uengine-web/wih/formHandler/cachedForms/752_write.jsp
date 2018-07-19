<%@ page pageEncoding="UTF-8" %><%response.setContentType("text/html; charset=UTF-8");%>
<%@include file="../../../common/commons.jsp"%>

<script type="text/javascript">
function ttt() {
$("#aaadiv").html(CKEDITOR.instances.rta.getData());
alert($("#aaadiv").text());
}
</script>
<div id="aaadiv" style="display: none">
	&nbsp;</div>
<p>
	STEP 1</p>
<p>
	<input:richtextarea height="300px" name="rta" viewmode="0" width="100%"></input:richtextarea></p>
<p>
	<input name="testBtn" onclick="ttt()" type="button" value="눌러" /></p>
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
			<td>
				add row</td>
		</tr>
		<input:foreach variablename="txtA">
		<tr>
			<td>
				성명
<%
java.util.Hashtable txtA_13 = new java.util.Hashtable();
 txtA_13.put("format", "number");
 txtA_13.put("attrid", "TEMP_ATTR_ID"); 
%>
<input:text name="txtA" viewMode="0" attributes="<%=txtA_13%>" default="" /></td>
			<td>
				
 <% 
 java.util.Hashtable rdoA_6 = new java.util.Hashtable(); 
 rdoA_6.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:radio name="rdoA" viewMode="0" value="0" attributes="<%=rdoA_6%>" default="" />남자
 <% 
 java.util.Hashtable rdoA_7 = new java.util.Hashtable(); 
 rdoA_7.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:radio name="rdoA" viewMode="0" value="1" attributes="<%=rdoA_7%>" default="" />여자</td>
			<td>
				차량
 <% java.util.Hashtable chkA_0 = new java.util.Hashtable(); 
 chkA_0.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:checkbox name="chkA" viewMode="0" value="111" attributes="<%=chkA_0%>" /> 자가
 <% java.util.Hashtable chkB_2 = new java.util.Hashtable(); 
 chkB_2.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:checkbox name="chkB" viewMode="0" value="222" attributes="<%=chkB_2%>" /> 자녀
 <% java.util.Hashtable chkC_4 = new java.util.Hashtable(); 
 chkC_4.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:checkbox name="chkC" viewMode="0" value="333" attributes="<%=chkC_4%>" /></td>
			<td>
				
 <% 
 java.util.Hashtable selA_8 = new java.util.Hashtable(); 
 java.util.List selA_9 = new java.util.Vector(); 
 java.util.List selA_10 = new java.util.Vector(); 
 selA_9.add("사과"); selA_10.add("apple"); 
 selA_9.add("오렌지"); selA_10.add("orange"); 
 selA_9.add("파인애플"); selA_10.add("pinapple"); 
 selA_9.add("망고"); selA_10.add("mango"); 
 selA_8.put("attrid", "TEMP_ATTR_ID"); 
 %> 
 <% 
 String[] selA_11 = new String[1]; 
 selA_11[0] = "apple"; 
 %> 
 <input:select name="selA" defaults="<%=selA_11%>" optionLabels="<%=selA_9%>" optionValues="<%=selA_10%>" viewMode="0" attributes="<%=selA_8%>" multiple="false"  /> </td>
			<td>
				
 <% 
 java.util.Hashtable taA_12 = new java.util.Hashtable(); 
 taA_12.put("cols", "10"); 
 taA_12.put("rows", "5"); 
 taA_12.put("attrid", "TEMP_ATTR_ID"); 
 %> 
 <input:textarea name="taA" viewMode="0" attributes="<%=taA_12%>" default="" /></td>
			<td>
				<table border="0" cellpadding="0" cellspacing="0" width="200">
					<tbody>
						<tr>
							<td>
								<input:fileupload fileclass="general" name="testFile" viewmode="0"></input:fileupload></td>
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
								<input:finduser multiple="true" name="fuser" viewmode="0"></input:finduser></td>
							<td width="10">
								&nbsp;</td>
						</tr>
					</tbody>
				</table>
			</td>
			<td>
				<input:addrow name="add" removename="remove" removevalue="삭제" value="추가" viewmode="0"></input:addrow></td>
		</tr>
		</input:foreach>
	</tbody>
</table>
<p>
	abc<br />
	한글을 쓰자.<br />
	아이씐나<br />
	이런...어디서 쓰나 Form2View.java 이니?</p>

<script language="javascript"> 
<!-- 
function valid_check(){ 

	return true; 
} 

//--> 
</script> 