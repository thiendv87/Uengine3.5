<h1>TO-DO:</h1>


<ul>
<table cellpadding=1 cellspacing=0 border=0><tr><td bgcolor=d0d0d0>
<table cellpadding=0 border=0 cellspacing=0>

<%@include file="showInputForm.jsp"%>
<script>
	function customizeForm(){	
		document.forms[0].action='showEditor.jsp';
		document.forms[0].submit();
	}
</script>
<a href="javascript:customizeForm()">Customize...</a>

</td><td width=1></td></tr><tr><td colspan=2 height=1></td></tr></table></td></tr></table>

</ul>
