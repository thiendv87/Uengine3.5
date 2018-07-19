function controlContents() {
		  
		  var contents_table = document.getElementById('contents_table').style;
		  document.getElementById('btnimg').innerHTML = (contents_table.display == 'none' ? '<div id="btnimg" onClick="controlContents();" style="margin-left:0px"><object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="15" height="102" id="123" align="middle"><param name="movie" value="/Flash/closebtn.swf" ><param name="quality" value="high"><param name="wmode" value="transparent" ><param name="quality" value="high"><embed src="/Flash/closebtn.swf" quality="high" bgcolor="#ffffff" width="15" height="102" name="closebtn" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" ></object></div>' : '<div id="btnimg"  onClick="controlContents();" style="margin-left:-3px"><img src="/images/Common/SplitBtnOpen.gif"></div>');
		  contents_table.display = (contents_table.display == 'none' ? 'block' : 'none');
		  
		 }		