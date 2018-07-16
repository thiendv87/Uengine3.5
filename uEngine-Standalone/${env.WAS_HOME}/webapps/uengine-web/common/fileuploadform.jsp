<form action="fileupload.jsp" method="post">
<input type=file name="comment">
<input type=file name="fileSupposedToBeUploaded" onclick="changeEncType()">
<input name="testfield">
<input type=submit>
</form>

<script>
	function changeEncType(){
		document.forms[0].encoding = "multipart/form-data";
	}

</script>