<%@ page pageEncoding="UTF-8" %><%response.setContentType("text/html; charset=UTF-8");%>
<%@include file="../../../common/commons.jsp"%>

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
				성명
<%
java.util.Hashtable txtA_22 = new java.util.Hashtable();
 txtA_22.put("attrid", "TEMP_ATTR_ID"); 
%>
<input:text name="txtA" viewMode="0" attributes="<%=txtA_22%>" default="" /></td>
			<td>
				
 <% 
 java.util.Hashtable rdoA_8 = new java.util.Hashtable(); 
 rdoA_8.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:radio name="rdoA" viewMode="0" value="0" attributes="<%=rdoA_8%>" default="" />남자
 <% 
 java.util.Hashtable rdoA_9 = new java.util.Hashtable(); 
 rdoA_9.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:radio name="rdoA" viewMode="1" value="1" attributes="<%=rdoA_9%>" default="" />여자</td>
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
 java.util.Hashtable selA_12 = new java.util.Hashtable(); 
 java.util.List selA_13 = new java.util.Vector(); 
 java.util.List selA_14 = new java.util.Vector(); 
 selA_13.add("사과"); selA_14.add("apple"); 
 selA_13.add("오렌지"); selA_14.add("orange"); 
 selA_13.add("파인애플"); selA_14.add("pinapple"); 
 selA_13.add("망고"); selA_14.add("mango"); 
 selA_12.put("attrid", "TEMP_ATTR_ID"); 
 %> 
 <% 
 String[] selA_15 = new String[1]; 
 selA_15[0] = "apple"; 
 %> 
 <input:select name="selA" defaults="<%=selA_15%>" optionLabels="<%=selA_13%>" optionValues="<%=selA_14%>" viewMode="0" attributes="<%=selA_12%>" multiple="false"  /> </td>
			<td>
				
 <% 
 java.util.Hashtable taA_20 = new java.util.Hashtable(); 
 taA_20.put("cols", "10"); 
 taA_20.put("rows", "5"); 
 taA_20.put("attrid", "TEMP_ATTR_ID"); 
 %> 
 <input:textarea name="taA" viewMode="0" attributes="<%=taA_20%>" default="" /></td>
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
	
<%
java.util.Hashtable txtB_23 = new java.util.Hashtable();
 txtB_23.put("attrid", "TEMP_ATTR_ID"); 
%>
<input:text name="txtB" viewMode="0" attributes="<%=txtB_23%>" default="" />&nbsp;필드1<br />
	<br />
	
 <% java.util.Hashtable chkD_6 = new java.util.Hashtable(); 
 chkD_6.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:checkbox name="chkD" viewMode="0" value="" attributes="<%=chkD_6%>" />&nbsp;필드2<br />
	<br />
	
 <% 
 java.util.Hashtable rdoB_10 = new java.util.Hashtable(); 
 rdoB_10.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:radio name="rdoB" viewMode="0" value="A" attributes="<%=rdoB_10%>" default="" />필드3 
 <% 
 java.util.Hashtable rdoB_11 = new java.util.Hashtable(); 
 rdoB_11.put("attrid", "TEMP_ATTR_ID"); 
 %> <input:radio name="rdoB" viewMode="0" value="B" attributes="<%=rdoB_11%>" default="" />필드3<br />
	<br />
	
 <% 
 java.util.Hashtable taB_21 = new java.util.Hashtable(); 
 taB_21.put("cols", "5"); 
 taB_21.put("rows", "10"); 
 taB_21.put("attrid", "TEMP_ATTR_ID"); 
 %> 
 <input:textarea name="taB" viewMode="0" attributes="<%=taB_21%>" default="" />&nbsp;필드4<br />
	<br />
	
 <% 
 java.util.Hashtable selB_16 = new java.util.Hashtable(); 
 java.util.List selB_17 = new java.util.Vector(); 
 java.util.List selB_18 = new java.util.Vector(); 
 selB_17.add("소나타"); selB_18.add("sonata"); 
 selB_17.add("K5"); selB_18.add("k5"); 
 selB_17.add("그랜져"); selB_18.add("grandure"); 
 selB_17.add("에쿠스"); selB_18.add("ecuos"); 
 selB_16.put("attrid", "TEMP_ATTR_ID"); 
 %> 
 <% 
 String[] selB_19 = new String[1]; 
 selB_19[0] = "sonata"; 
 %> 
 <input:select name="selB" defaults="<%=selB_19%>" optionLabels="<%=selB_17%>" optionValues="<%=selB_18%>" viewMode="0" attributes="<%=selB_16%>" multiple="false"  /> &nbsp;필드5</p>

<script language="javascript"> 
<!-- 
function valid_check(){ 

	return true; 
} 

//--> 
</script> 