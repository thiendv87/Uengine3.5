<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>

* {
	margin:0;
	padding:0;
	font-family:"돋움", Dotum, "굴림", Gulim, AppleGothic, Sans-serif;
	font-size:12px;
	color:#333333;
}
img, fieldset, button {	border:none;}
a {	text-decoration:none;}

a:link, a:hover, a:active, a:focus {text-decoration:none;}

body, html {margin:0;padding:0;	width:100%;	height:100%;overflow: hidden;}  


</style>
<script type="text/javascript">

var roll_Class=function(){this.initialize.apply(this,arguments);} 
roll_Class.prototype={ 

initialize:function(){ 

this.className=arguments[0]?arguments[0]:null; 
this.foundit(arguments[1],'',false); 
this.contents=new Array('0'); 
this.contents_delay=null; 
this.nowdelay=null; 

this.foundit( 
this.roll.childNodes,this.foundvalue , 
function(rt,that){ 

if(that.constrain_size !== null) that.foundit(rt.childNodes,'IMG',function(rt,that){rt.style[(this.moving != 'left' ? 'width' : 'height')] = that.constrain_size;}); 
that.contents_delay=that.contents[that.contents.length]=that.contents_delay+-rt[(that.moving=='left'?'offsetWidth':'offsetHeight')];}); 

{ 
this.rollHeight=this.proll.style[(this.moving=='left'?'width':'height')]=Math.abs(this.contents[this.contents.length-1]); 
this.roll.appendChild(this.roll.cloneNode(true)); 
};}, 


foundit:function(tg,n){ 

var temp=new Array(); 

	for(var v in tg) 
		switch(typeof arguments[2]){ 
		case 'object':if(arguments[2].initialize(tg[v],n,this)==true) return; else break; 
		case 'function':if(tg[v].nodeName==n) arguments[2](tg[v],this); break; 
		case 'boolean':this[v]=tg[v]; break; 
		default:if(tg[v].nodeName==n) return tg[v]; 
	} 

return temp;}, 

inaction:function(time){ 

this.roll.style[this.moving]=time=time < 0 ?(this.fall==false && time <= -this.rollHeight?0:time):-this.rollHeight,null; 
this.foundit(this.contents,time,{initialize:function(rt,vrt,that){if(Math.abs(rt - vrt) <(that.fast==false?that.tick:that.ftick)){that.roll.style[that.moving]=rt; that.nowdelay=that.fast==true?that.lengthen:that.delay; that.fast=false; return true;} else that.nowdelay=that.lengthen;}}); 
{var ticks=this.fast==true?this.ftick:this.tick;} 
this.control=setTimeout(this.className+".inaction("+(parseInt(this.roll.style[this.moving])+(this.fall==true?ticks:-ticks))+");",this.nowdelay);}, 

stop:function(){ 

this.temp=parseInt(this.roll.style[this.moving]); 
clearTimeout(this.control);}};

</script>
<title>Untitled Document</title>
</head>
<body scroll=no >
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td><div id="parent_rolltable" name="parent_rolltable" style='overflow:hidden; height:12px; border:0px solid #000000;' 
	        onMouseOver="width_class.stop();" onMouseOut="width_class.inaction(width_class.temp);"> 
	        <nobr id="rolltable" name="rolltable" style="position:relative;" > 
		        <span>
		        	<img src="images/Icon/ding2.gif" align="middle" />
		        	<a href="http://uengine.org/web/guest/home" target="_new">
		        	uEngine For Korean 3.5버전이 릴리스 되었습니다.</a> 
		        	&nbsp; &nbsp; &nbsp;
		        </span>
		        <span>
		        	<img src="images/Icon/ding2.gif" align="middle" />
		        	<a href="http://uengine.org/web/guest/home" target="_new">
		        	프로세스 다운로드 서비스가 준비중입니다.</a> 
		        	&nbsp; &nbsp; &nbsp;
		        </span>
		        <span>
		        	<img src="images/Icon/ding2.gif" align="middle" />
		        	<a href="http://uengine.org/web/guest/home" target="_new">
		        	uEngine 개인용 BPMS 다운로드가 준비중입니다.</a> 
		        	&nbsp; &nbsp; &nbsp;
		        </span>
		        <span>
		        	<img src="images/Icon/ding2.gif" align="middle" />
		        	<a href="http://uengine.org/web/guest/home" target="_new">
		        	장진영, 김보상, 공무제, 신창훈, 김천호, 이용홍, 강태욱.... 기타등등 ㅋㅋㅋ</a> 
		        	&nbsp; &nbsp; &nbsp;
		        </span>
	        </nobr> </div></td>
	    </tr>
	</table>
	<script language="Javascript">

			{ 

				// 가로롤링 설정키 
				var roll_init=new Array(); 
				roll_init.constrain_size=null;										// 전체의 높이값 [기본 default] 
				roll_init.tick=1; 														// 움직이는 칸수 
				roll_init.ftick=10; 													// 빠른 움직이는 칸수 
				roll_init.lengthen=30;												// 1초당 움직이는 속도 
				roll_init.delay=2000; 												// 잠시멈춤 속도 
				roll_init.fall=false; 													// 이동 반대로 설정 ~ 
				roll_init.fast=false;													// 빠른속도:true 는 on 이며,false 는 off 이다. 
				roll_init.foundvalue = 'SPAN'; 										// Nobr 내부엘리멘트 
				roll_init.moving='left'; 												// 상하좌우 움직임 설정 
				roll_init.roll=document.getElementById('rolltable'); 				// roll 
				roll_init.proll=document.getElementById('parent_rolltable');	// proll 

			}; 

			{ 

				// 가롤롤링 선언부분 

				var width_class=new roll_Class('width_class',roll_init); 
				width_class.inaction(); 

			}; 
	</script>
</body>
</html>
