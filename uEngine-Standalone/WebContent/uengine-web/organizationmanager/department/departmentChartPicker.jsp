<html>


<head>
	
</head>
<body>
	 <br>
	<%@include file="departmentChart.jsp"%>
	<br><br>
	<div align="center">
	<table>
	    <tr>
			<td class="gBtn">
	            <a onclick="onOk(selectedDepartmentList, opener.inputName);window.close()">
	            <span><%=GlobalContext.getMessageForWeb("Ok", loggedUserLocale) %></span></a>
	            <a onclick="window.close();">
	            <span><%=GlobalContext.getMessageForWeb("Cancel", loggedUserLocale) %></span></a>
			</td>
	    </tr>
	</table> 
	</div>
</body>


</html>