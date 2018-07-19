
function resizeIframe(frameid){
	//alert('resizeIframe' + frameid);
	//var currentfr=document.getElementById(frameid)
	document.getElementById(frameid+"Name").height=100 // required for Moz, value can be "", null, or integer 

//alert(window.frames[frameid+"Name"].document.body.scrollHeight );
	document.getElementById(frameid).height=window.frames[frameid+"Name"].document.body.scrollHeight + 20
}