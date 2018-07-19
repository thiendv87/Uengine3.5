var loopDraw_originObj;
var loopDraw_zoom = -1;
var stroke;

function getAbsPosition( oElement ){
	var iOffsetLeft = 0;
	var iOffsetTop = 0;
	while( oElement != null){
		iOffsetLeft += oElement.offsetLeft;
		iOffsetTop += oElement.offsetTop;
		oElement = oElement.offsetParent;
	} 
	var absOffset = new Array(2);
	absOffset[0] = iOffsetLeft;
	absOffset[1] = iOffsetTop;
	return absOffset;
}

var isDrewOnce = false;
function drawLoopLine(surfaceObject , namespace, tracingTag){

 var g = surfaceObject.createGroup();
 var jg_doc = '';
 
 if(stroke !=undefined){
   jg_doc=stroke;
 }else{
 	jg_doc = g.createPath().setStroke({color: "gray",width: 2});
 	stroke = jg_doc;
 }

	if(!isDrewOnce){
		//canvasForLoopLines
		isDrewOnce = true;
	}

  //determines whether it should be draw vertically or not.
  var leftSpacer = document.getElementById("leftSpacer"+tracingTag);
  var rightLabel = document.getElementById("rightLabel"+tracingTag);

  var isVertical = (leftSpacer!=null);
 
  if(isVertical){ 	
  	 var spacerwidth = leftSpacer.width = rightLabel.offsetWidth;	
  }
  
 var point = getAbsPosition(document.getElementById('start' + tracingTag));
 var startX = point[0] + (document.getElementById('start' + tracingTag).offsetWidth/2);
 var startY = point[1];
 var point = getAbsPosition(document.getElementById('switch' + tracingTag));
 var switchX = point[0]+ (document.getElementById('switch' + tracingTag).offsetWidth/2);
 var switchY = point[1];
 
 var point = getAbsPosition(document.getElementById('loop' + tracingTag));
 var loopX = point[0];
 var loopY = point[1];

  if(isVertical) {
    var loopTopRightX = loopX+ document.getElementById('loop' + tracingTag).offsetWidth;
    var loopTopRightY = loopY;
    var lablePoint = getAbsPosition(rightLabel);
    loopTopRightX = lablePoint[0]+ spacerwidth/2;
  }
  
  loopY +=7;
  
  //transform
 if(loopDraw_originObj!=null && loopDraw_zoom!=-1){
  	var originPoint = getAbsPosition(loopDraw_originObj);
 	var originX = originPoint[0];
 	var originY = originPoint[1];
 	
 	startX = (startX - originX)*loopDraw_zoom / 100 + originX;
 	startY = (startY - originY)*loopDraw_zoom / 100 + originY;
 	switchX = (switchX - originX)*loopDraw_zoom / 100 + originX;
 	switchY = (switchY - originY)*loopDraw_zoom / 100 + originY;
 	loopY = (loopY - originY)*loopDraw_zoom / 100 + originY;
 	loopTopRightX = (loopTopRightX - originX)*loopDraw_zoom / 100 + originX;
 	loopTopRightY = (loopTopRightY - originY)*loopDraw_zoom / 100 + originY;
  } 
 //
 
 var lineWidth=10;
 if(isVertical) {
 
   startX +=3;
   startY +=4;
   loopTopRightX -=10;
   
   jg_doc.moveTo(startX,  startY);
   jg_doc.lineTo(loopTopRightX, startY);
		
   jg_doc.moveTo(loopTopRightX, startY);
   jg_doc.curveTo(loopTopRightX, startY, loopTopRightX+lineWidth, startY,loopTopRightX+lineWidth,startY+lineWidth);
   jg_doc.lineTo(loopTopRightX+lineWidth, switchY-lineWidth);
   jg_doc.curveTo(loopTopRightX+lineWidth, switchY-lineWidth, loopTopRightX+lineWidth,switchY,loopTopRightX-lineWidth, switchY);
	
   jg_doc.moveTo(loopTopRightX-lineWidth, switchY);
   jg_doc.lineTo(switchX, switchY);
	
   jg_doc.moveTo(startX+lineWidth/2, startY-lineWidth/2);
   jg_doc.lineTo(startX, startY);
	
   jg_doc.moveTo(startX+lineWidth/2, startY+lineWidth/2);
   jg_doc.lineTo(startX, startY);

 } else {
   loopY +=10;
   
   jg_doc.moveTo(startX,  startY);
   jg_doc.lineTo(startX, loopY);
		
   jg_doc.moveTo(startX, loopY);
   jg_doc.curveTo(startX, loopY, startX, loopY-lineWidth,startX+lineWidth,loopY-lineWidth);
   jg_doc.lineTo(switchX-lineWidth, loopY-lineWidth);
   jg_doc.curveTo(switchX-lineWidth, loopY-lineWidth, switchX,loopY-lineWidth,switchX, loopY);
	
   jg_doc.moveTo(switchX, loopY);
   jg_doc.lineTo(switchX, startY);
	
   jg_doc.moveTo(startX+lineWidth/2, startY-lineWidth/2);
   jg_doc.lineTo(startX, startY);
	
   jg_doc.moveTo(startX-lineWidth/2, startY-lineWidth/2);
   jg_doc.lineTo(startX, startY);
 }

}

var point;
var theTracingTag;
var widthOfSubProcessActivity = 50;
var droppingDistance = 30;


function openSubProcess(defVerId, InstanceId, tracingTag, subDefVerId, subInstanceId, labels, segment){

	var SubList = parent.opennedSubProc;
	var SubListType = parent.opennedSubProcType;
	var divSubProcess = parent.document.getElementById("viewSubProcess");

	var getInfo = new Array();
		getInfo[0] = InstanceId;
		getInfo[1] = subDefVerId;
		getInfo[2] = subInstanceId;
		getInfo[3] = defVerId;
	
	//alert(getInfo[0] +" | " + getInfo[1]+ " | " + getInfo[2] + " | " + getInfo[3]);
	
	var findNextInstance = false;

	if  ( InstanceId.indexOf("Volatile") == -1 && subInstanceId != null ) {
//		alert("now instance -> next instance");
	
		for ( i=0 ; i<SubList.length ; i++ ) {
			if (SubListType[i] == "definition" ) {
				SubList[i] = "";
				SubListType[i] = "";
			}

			if ( SubList[i].indexOf(getInfo[0]+"_"+getInfo[2]) > -1 ) {
				SubList[i] = "";
				SubListType[i] = "";
				findNextInstance = true;
			}
		}

		SubList = creanArray(SubList);
		SubListType = creanArray(SubListType);

		var temp;
		if ( findNextInstance == false ) {
			for ( i=0 ; i<SubList.length ; i++ ) {
				temp = SubList[i];
			}
			SubListType[SubList.length] = "instance";
			SubList[SubList.length] = temp+"_"+getInfo[2];
		}

	}


	else if ( InstanceId.indexOf("Volatile") == -1 && subInstanceId == null ) {
		//alert("now instance -> next definition");
		
		var isDeleted = false;

		for ( i=0 ; i<SubList.length ; i++ ) {
			if ( SubList[i].indexOf(subDefVerId) > -1) {
				SubList[i] = "";
				SubListType[i] = "";
				for (j=i ; j<SubList.length ; j++ ) {
					SubList[j] = "";
					SubListType[j] = "";
				}
				isDeleted = true;
				break;
			}
		}

		SubList = creanArray(SubList);
		SubListType = creanArray(SubListType);

		var searchCount = 0;
		for ( i=0 ; i<SubList.length ; i++ ) {
			if ( SubList[i].indexOf(subDefVerId) > -1 ) {
				count++;
			}
		}
		
		if (isDeleted == false ) {
			if ( searchCount == 0) {
				var i = 0;
				for ( i=0 ; i<SubList.length ; i++ ) {
					var tempInstanceId = SubList[i].split("_");
					if ( tempInstanceId[tempInstanceId.length -1] == InstanceId ) {
						var str = SubList[i];
						SubList[i+1] = str+"_"+subDefVerId;
						SubListType[i+1] = "definition";
						
						for ( j=i+2 ; j<SubList.length ; j++ ) {
							SubList[j] = "";
							SubListType[j] = "";
						}
						break;
					}
				}
			}
		}

		SubList = creanArray(SubList);
		SubListType = creanArray(SubListType);
		
	} 


	else if ( InstanceId.indexOf("Volatile") > -1 && subInstanceId == null ) { 
	//	alert("now definition -> next definition");
		InstanceId = null;

		var isDeleted = false;

		var subListTypeTemp1 = "";
		var subListTypeTemp2 = "";

		var i=0;
		
		for ( i=0 ; i<SubList.length ; i++ ) {

			subListTypeTemp1 = SubListType[i];
			subListTypeTemp2 = SubListType[i+1];

			if ( (subListTypeTemp1 == "instance" && subListTypeTemp2 == "definition")
				|| (subListTypeTemp1 == "definition" && subListTypeTemp2 == "definition") ) {
				i = i + 1;
				if (SubList[i] != null) {
					if ( SubList[i].indexOf(subDefVerId) > -1) {
						SubList[i] = "";
						SubListType[i] = "";

						for ( j=i ; j<SubList.length ; j++ ) {
							SubList[j] = "";
							SubListType[j] = "";
						}

						isDeleted = true;
						break;
					}
				}
				i = i - 1;

			}
		}

		SubList = creanArray(SubList);
		SubListType = creanArray(SubListType);

		var searchCount = 0;
		for ( i=0 ; i<SubList.length ; i++ ) {
			if ( SubList[i].indexOf(subDefVerId) > -1 ) {
				count++;
			}
		}
		
		if (isDeleted == false ) {
			if ( searchCount == 0) {
				var i = 0;
				for ( i=0 ; i<SubList.length ; i++ ) {
					
					subListTypeTemp1 = SubListType[i];
					subListTypeTemp2 = SubListType[i+1];

					if ( (subListTypeTemp1 == "instance" && subListTypeTemp2 == "definition")
						|| ( subListTypeTemp1 == "definition" && subListTypeTemp2 == "definition" ) ) {
						i= i+1;

						var tempInstanceId = SubList[i].split("_");
						
						if ( tempInstanceId[tempInstanceId.length -1] == defVerId ) {
							var str = SubList[i];
							SubList[i+1] = str+"_"+subDefVerId;
							SubListType[i+1] = "definition";
							
							for ( j=i+2 ; j<SubList.length ; j++ ) {
								SubList[j] = "";
								SubListType[j] = "";
							}
							break;
						}
						i= i-1;

					}
				}
			}
		}

		SubList = creanArray(SubList);
		SubListType = creanArray(SubListType);

	}
	parent.opennedSubProc = SubList;
	parent.opennedSubProcType = SubListType;

	//printSubList(SubList);
	//printSubList(SubListType);

	var content = "";
	for ( i=0 ; i<SubList.length ; i++ ) {
		var tempInstanceId = SubList[i].split("_");
		var url;

		if (SubListType[i] == "instance") {
			url = "<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/viewProcessFlowChart_Simple.jsp?instanceId="+tempInstanceId[tempInstanceId.length-1]+"&viewFrame="+SubList[i];
		} else {
			url = "<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/viewProcessFlowChart_Simple.jsp?definitionVersionId="+tempInstanceId[tempInstanceId.length-1]+"&viewFrame="+SubList[i];
		}

		//head
		content += 
			"<table width=\"900\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tr><td width=\"8\" height=\"7\"><img src=\"imges/Common/fc_mo01.gif\" width=\"8\" height=\"7\" /></td><td background=\"imges/Common/fc_lineBG_top.gif\"></td><td width=\"8\"><img src=\"imges/Common/fc_mo02.gif\" width=\"8\" height=\"7\" /></td></tr><tr><td background=\"imges/Common/fc_lineBG_left.gif\"></td><td height=\"80\" align=\"center\">";
		
		//iframe
		content += "<iframe id=\""+SubList[i]+"\" style=\"width=900\"  frameborder=\"0\" src=\""+ url +"\"></iframe>";
		
		//footer
		content += 
			"<td background=\"imges/Common/fc_lineBG_right.gif\"></td></tr><tr><td height=\"7\"><img src=\"imges/Common/fc_mo04.gif\" width=\"8\" height=\"7\" /></td><td background=\"imges/Common/fc_lineBG_bottom.gif\"></td><td><img src=\"imges/Common/fc_mo03.gif\" width=\"8\" height=\"7\" /></td></tr></table>";
		
		//shadow
		if (i != SubList.length-1) {
			content +=
			"<table width=\"900\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tr><td width=\"46\"><img src=\"imges/Common/sub_p_shdow_L.gif\" width=\"46\" height=\"45\" /></td><td background=\"imges/Common/sub_p_shdow_C.gif\">&nbsp;</td><td width=\"46\"><img src=\"imges/Common/sub_p_shdow_R.gif\" width=\"46\" height=\"45\" /></td></tr></table>";
		}

	}
	divSubProcess.innerHTML = content;

}

function creanArray(SubList) {
	var tempSubList = new Array();
	var k=0;
	for ( i=0 ; i<SubList.length ; i++) {
		if(SubList[i] != "") {
			tempSubList[k] = SubList[i];
			k++;
		}
	}
	SubList = tempSubList;
	return SubList;
}

function printSubList(SubList) {
	var temp2="";
	for (i=0; i<SubList.length; i++ ) {
		temp2 += SubList[i] +" | ";
	}
	//alert(temp2);
}




var xmlHttp;
function createXMLHttpRequest() {
    if (window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    } 
    else if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    }
}

function onLoadFlowChart() {
//alert("xmlHttp.readyState = " + xmlHttp.readyState + "  xmlHttp.status = " +xmlHttp.status );

 if(xmlHttp.readyState == 4) {
  if(xmlHttp.status == 200) {
 
	var floater = document.getElementById('floater'+theTracingTag);
	var htmlsource = xmlHttp.responseText;
	floater.innerHTML = "<table border=1 cellpadding=20 bgcolor=gray><td bgcolor=white>"+ htmlsource +"</td></table>";
	
//  	var floaterLocation = getAbsPosition(floater);
	var floaterLocationX = point[0] - floater.offsetWidth/2;
	if(floaterLocationX < 0) floaterLocationX = 0;// let it bounds
    
	floater.style.left = floaterLocationX;
	floater.style.top = point[1]+droppingDistance;
	//floater.style.filter = '';
	//drawLoopLines2();
	//eval("drawLoopLines" + theTracingTag + "()");
	var switchActivityTTs = new Array();
	var j=0;
	var allElements = floater.all;
	for(i=0; i<allElements.length; i++){
		var element = allElements[i];
		var elementName = ''+element.id;
		if(elementName.indexOf("switch") > -1){
			tracingTagForSwitch = elementName.substring("switch".length, elementName.length);
			switchActivityTTs[j++] = tracingTagForSwitch;
		}
	}

	//for(i=0; i<j; i++){
	//	var surfaceObject = dojox.gfx.createSurface(floater.id, floater.offsetWidth, floater.offsetHeight);
	//	drawLoopLine(surfaceObject ,theTracingTag, switchActivityTTs[i]);
	//}
	var indexFirst = htmlsource.indexOf("function");
	
	if(indexFirst>-1){
		var source = htmlsource.substring(indexFirst,htmlsource.length);
		source = "<script>" + source;

		if (match = source.match(/<script[^>]*>(([^<]|\n|\r|<[^\/])+)<\/script>/))
		{
    		eval(match[1] + " drawLoopLines" + theTracingTag + "()");
		}
	}

	var jg_doc = new jsGraphics("canvasForLoopLines"+theTracingTag);	
//	jg_doc.setColor("#959595");
	jg_doc.setColor("#000000"); 
	jg_doc.setStroke(Stroke.DOTTED);
	
	var floaterPoint = getAbsPosition(floater);
	jg_doc.fillPolygon(new Array(point[0], floaterPoint[0], floaterPoint[0] + floater.offsetWidth, point[0]+widthOfSubProcessActivity), new Array(point[1], point[1]+droppingDistance, point[1]+droppingDistance, point[1])); 	
//	jg_doc.fillPolygon(new Array(floaterPoint[0], floaterPoint[0]+floater.offsetWidth, point[0]+widthOfSubProcessActivity, point[0]), new Array(point[1]+droppingDistance, point[1]+droppingDistance, point[1], point[1])); 
	jg_doc.paint(); // draws, in this case, directly into the document
  }
 }
}

function expandDiv(fromDivName, toDivName){
  	var floater = document.getElementById(toDivName);

	if(floater.style.display==''){
		floater.style.display='NONE';
		return;
	}
	
	var fromDiv = document.getElementById(fromDivName);
	point = getAbsPosition(fromDiv);
	var startX = point[0];
	var startY = point[1];

   	floater.style.display = '';
    var floaterLocationX = point[0] - (floater.offsetWidth - widthOfSubProcessActivity)/2;
	if(floaterLocationX < 0) floaterLocationX = 0;// let it bounds
   	floater.style.left = floaterLocationX;
   	floater.style.top = (point[1]+droppingDistance);
//   	floater.style.z-index = 100;

   
//	document.body.innerHTML = document.body.innerHTML + "<div id=canvasForLoopLines_"+fromDivName+" style='position:absolute;left:0px;top:0px;width:2000;height:"+(point[1]+1000)+";border:10px red sollid; filter:alpha(opacity=30)'></div>";
  	
	var canvasForLoopLinesHTML = "";
  		
	var jg_doc = new jsGraphics(toDivName); 
	jg_doc.setColor("#e1e1e1"); 
	jg_doc.setStroke(Stroke.DOTTED);

	var adjustingDistance = 19;

	var floaterPoint = getAbsPosition(floater);
	if(floaterLocationX ==0){
	    jg_doc.fillPolygon(new Array(startX, 0, floater.offsetWidth, startX+ widthOfSubProcessActivity), new Array(adjustingDistance, droppingDistance+adjustingDistance, droppingDistance+adjustingDistance, adjustingDistance)); 
	}
	else{
	    jg_doc.fillPolygon(new Array((floater.offsetWidth - widthOfSubProcessActivity)/2, 0, floater.offsetWidth, (floater.offsetWidth + widthOfSubProcessActivity)/2), new Array(adjustingDistance, droppingDistance+adjustingDistance, droppingDistance+adjustingDistance, adjustingDistance)); 
	}
	//alert('x');		jg_doc.fillPolygon(new Array(floaterPoint[0], floaterPoint[0]+floater.offsetWidth, point[0]+widthOfSubProcessActivity, point[0]), new Array(point[1]+droppingDistance, point[1]+droppingDistance, point[1], point[1])); 
	jg_doc.paint(); // draws, in this case, directly into the document
	//alert('x');		alert('x');

}

//swimlane
function drawSwimlaneLine(sourceDivName, targetDivName,actStatus){

 	setCanvasSize();
 	
	var point_s = getAbsPosition(document.getElementById(sourceDivName));
	var point_t = getAbsPosition(document.getElementById(targetDivName));
	
	if(point_s[1] < point_t[1]){
		var sourceX = point_s[0] + (document.getElementById(sourceDivName).offsetWidth/2);
		var sourceY = point_s[1] + (document.getElementById(sourceDivName).offsetHeight);
		var targetX = point_t[0]+ (document.getElementById(targetDivName).offsetWidth/2);
		var targetY = point_t[1];
	}else{
		var sourceX = point_s[0] + (document.getElementById(sourceDivName).offsetWidth)-(document.getElementById(sourceDivName).offsetWidth)/2;
		var sourceY = point_s[1] + (document.getElementById(sourceDivName).offsetHeight/2);
		var targetX = point_t[0]+ (document.getElementById(targetDivName).offsetWidth);
		var targetY = point_t[1]+ (document.getElementById(targetDivName).offsetHeight/2);
	}
 
   //transform
 if(loopDraw_originObj!=null && loopDraw_zoom!=-1){
  	var originPoint = getAbsPosition(loopDraw_originObj);
 	var originX = originPoint[0];
 	var originY = originPoint[1];
 	
 	sourceX = (sourceX - originX)*loopDraw_zoom / 100 + originX;
 	sourceY = (sourceY - originY)*loopDraw_zoom / 100 + originY;
 	targetX = (targetX - originX)*loopDraw_zoom / 100 + originX;
 	targetY = (targetY - originY)*loopDraw_zoom / 100 + originY;
  } 
 //
	var jg_doc = new jsGraphics('canvasForLoopLines'); 
 	if(actStatus =="Ready"){
 		jg_doc.setColor("#868585");
	}else {
	    jg_doc.setColor("#666666");
	    jg_doc.setStroke(2);
	}
	   
	if(Math.abs(sourceX - targetX) < 10) sourceX = targetX; //ignore minor differences between X axis
	if(targetDivName=="sw_act_end" )
		var halfOfDistanceY = (targetY - sourceY)-15;
	else
		var halfOfDistanceY = (targetY - sourceY)/2;
	var halfOfDistanceX = 15;
	
    if(sourceY < targetY){
		jg_doc.drawLine(sourceX, sourceY, sourceX, sourceY+halfOfDistanceY);
		jg_doc.drawLine(sourceX, sourceY+halfOfDistanceY, targetX, sourceY+halfOfDistanceY);
		jg_doc.drawLine(targetX, sourceY+halfOfDistanceY, targetX, targetY);
		jg_doc.fillPolygon(new Array(targetX-3,targetX+3,targetX), new Array(targetY-8,targetY-8,targetY)); 
	}
	else{
		jg_doc.drawLine(sourceX, sourceY, targetX+halfOfDistanceX, sourceY);
		jg_doc.drawLine(targetX+15, targetY, targetX+15, sourceY);
		jg_doc.drawLine(targetX, targetY, targetX+15, targetY);
		jg_doc.fillPolygon(new Array(targetX+8,targetX+8,targetX), new Array(targetY-3,targetY+3,targetY)); 
	}
	
	jg_doc.paint(); // draws, in this case, directly into the document
}

function drawBackLine(isVertical,namespace,startTracingTag, backTracingTag){
 	
  setCanvasSize();
 
  var sPoint = getAbsPosition(document.getElementById('act_idx_' + startTracingTag));
  var bPoint = getAbsPosition(document.getElementById('act_idx_' + backTracingTag));
  
  if(isVertical=="true"){
     var startX = sPoint[0]+(document.getElementById('act_idx_' + startTracingTag).offsetWidth);
     var startY = sPoint[1]+(document.getElementById('act_idx_' + startTracingTag).offsetHeight/2);
     var backX = bPoint[0]+(document.getElementById('act_idx_' + backTracingTag).offsetWidth/2);
     var backY = bPoint[1]+(document.getElementById('act_idx_' + backTracingTag).offsetHeight/2);
  }
  else{
     var startX = sPoint[0]+(document.getElementById('act_idx_' + startTracingTag).offsetWidth/2);
     var startY = sPoint[1];
     var backX = bPoint[0]+(document.getElementById('act_idx_' + backTracingTag).offsetWidth/2);
     var backY = bPoint[1]; 
 }
 	
 var jg_doc = new jsGraphics('canvasForLoopLines'+namespace); 
 
 if(loopDraw_originObj!=null && loopDraw_zoom!=-1){
  	var originPoint = getAbsPosition(loopDraw_originObj);
 	var originX = originPoint[0];
 	var originY = originPoint[1];

 	startX = (startX - originX)*loopDraw_zoom / 100 + originX;
 	startY = (startY - originY)*loopDraw_zoom / 100 + originY;
 	backX = (backX - originX)*loopDraw_zoom / 100 + originX;
 	backY = (backY - originY)*loopDraw_zoom / 100 + originY;
  } 
  
  var lineX = startX + 25
  var lineY = startY - 20
 
  if(isVertical=="true"){

     jg_doc.fillPolygon(new Array(startX+8,startX+8,startX), new Array(startY-3,startY+3,startY)); 

     jg_doc.drawLine(startX, startY, lineX, startY);
     jg_doc.drawLine(lineX, startY, lineX, backY);
     jg_doc.drawLine(backX, backY, lineX, backY);
     
  }else{
 	jg_doc.fillPolygon(new Array(startX-3,startX+3,startX), new Array(startY-8,startY-8,startY)); 

 	jg_doc.drawLine(startX, startY, startX, lineY);
 	jg_doc.drawLine(startX, lineY, backX, lineY);
 	jg_doc.drawLine(backX, lineY, backX, backY);
 }
 
 jg_doc.paint(); 
}

function setCanvasSize(){
 	var canvasForLoopLinesTemp = document.getElementById('canvasForLoopLines');

 	if(document.getElementById('oZoom')!=null){//processparticipant
		canvasForLoopLinesTemp.style.width=oZoom.offsetWidth+20;
		canvasForLoopLinesTemp.style.height=oZoom.offsetHeight+400;
	}else if(document.getElementById('processLine')!=null){//processmanager
		canvasForLoopLinesTemp.style.width=processLine.offsetWidth+200;
		canvasForLoopLinesTemp.style.height=processLine.offsetHeight+400;
	}else if(document.getElementById('processLine1')!=null){//WIH
		canvasForLoopLinesTemp.style.width=processLine1.offsetWidth+200;
		canvasForLoopLinesTemp.style.height=processLine1.offsetHeight+400;
	}	
}

function drawAllActivityLine(surfaceObject,namespace, parentTracingTag, childTracingTag, isVertical){
	
	var g = surfaceObject.createGroup();
	var shape1;
	var parentObj;
	var childObj;
	
	if(namespace !=""){
		shape1 = g.createPath().setStroke({color: "gray",width: 2});
   		//shape1=stroke;
   		
   		parentTracingTag = namespace+'_'+parentTracingTag;
   		childTracingTag = namespace+'_'+childTracingTag;
   		parentObj = document.getElementById('act_idx_' + parentTracingTag);
   		childObj =document.getElementById('act_idx_' + childTracingTag);
   		
 	}else{
 		shape1 = g.createPath().setStroke({color: "gray",width: 2});
 		stroke = shape1;
 		
 		parentObj = document.getElementById('act_idx_' + parentTracingTag);
   		childObj =document.getElementById('act_idx_' + childTracingTag);
 	} 	
 	
   // var shape1 = g.createPath().setStroke({color: "gray",width:2});
   // stroke = shape1;
	
	
	var canvasDivPoint = getAbsPosition(document.getElementById('canvasForLoopLines' + namespace));
	
    var pPoint = getAbsPosition(parentObj);
    var cPoint = getAbsPosition(childObj);

	var centerPointX=0;
	var centerPointY=0;
	var PointX=0;
	var pointY=0;
	var lineWidth=10;
	var roundCornerDiff =0;
	var isNotCurve=false;

	if(isVertical=='false'){
		var iconSize=20;
	    centerPointX = pPoint[0]+iconSize;
	    centerPointY = pPoint[1]+ (parentObj.offsetHeight/2)-1-canvasDivPoint[1];
		var allActWidth = parentObj.offsetWidth;
	
	    PointX = centerPointX+lineWidth;
	    pointY = cPoint[1]+ (childObj.offsetHeight/2)-1-canvasDivPoint[1];
		var actWidth= childObj.offsetWidth+2;
		
		//transform
		 if(loopDraw_originObj!=null && loopDraw_zoom!=-1){
		  	var originPoint = getAbsPosition(loopDraw_originObj);
		 	var originX = originPoint[0];
		 	var originY = originPoint[1];
		 	
		 	centerPointX = (centerPointX - originX)*loopDraw_zoom / 100 + originX;
		 	centerPointY = (centerPointY - originY)*loopDraw_zoom / 100 + originY;
		 	PointX = (PointX - originX)*loopDraw_zoom / 100 + originX;
		 	pointY = (pointY - originY)*loopDraw_zoom / 100 + originY;
		 	
		 	allActWidth = (allActWidth - originX)*loopDraw_zoom / 100 + originX;
		 	actWidth = (actWidth - originX)*loopDraw_zoom / 100 + originX;
		 	lineWidth  = (lineWidth - originX)*loopDraw_zoom / 100 + originX;
		  } 
		 //
		
		roundCornerDiff = (centerPointY-pointY);
		if(roundCornerDiff < -10) roundCornerDiff = -10;
		if(roundCornerDiff > 10) roundCornerDiff = 10;	
 		
 		
		//front
		isNotCurve = ((centerPointY - pointY) < 15)&&((centerPointY - pointY) > -15);
		if(isNotCurve){
			pointY = centerPointY;
			shape1.moveTo(centerPointX, centerPointY);
			shape1.lineTo(PointX+lineWidth, pointY);
		}else{
			shape1.moveTo(centerPointX, centerPointY);
			shape1.curveTo(centerPointX, centerPointY, PointX, centerPointY,PointX, centerPointY-roundCornerDiff);
			shape1.lineTo(PointX, pointY+roundCornerDiff);
			shape1.curveTo(PointX, pointY+roundCornerDiff, PointX, pointY, PointX+lineWidth, pointY);
		}
		shape1.moveTo(PointX+lineWidth, pointY);
		shape1.lineTo(PointX+lineWidth+lineWidth, pointY);
	
		shape1.moveTo(PointX+lineWidth+lineWidth/2, pointY-lineWidth/2);
		shape1.lineTo(PointX+lineWidth+lineWidth, pointY);
	
		shape1.moveTo(PointX+lineWidth+lineWidth, pointY);
		shape1.lineTo(PointX+lineWidth+lineWidth/2, pointY+lineWidth/2);
	
		//back
		PointX = PointX+lineWidth+lineWidth+actWidth;
		var lineGap=(centerPointX+allActWidth)-(PointX+lineWidth+lineWidth+lineWidth)-(iconSize-3);
		
		shape1.moveTo(PointX,  pointY);
		shape1.lineTo(PointX+lineGap, pointY);
		
		if(isNotCurve){
			shape1.moveTo(PointX+lineGap,  pointY);
			shape1.lineTo(PointX+lineGap+lineWidth+lineWidth, centerPointY);
		}else{
			shape1.moveTo(PointX+lineGap,  pointY);
			shape1.curveTo(PointX+lineGap, pointY, PointX+lineGap+lineWidth, pointY,PointX+lineGap+lineWidth, pointY+roundCornerDiff);
			shape1.lineTo(PointX+lineGap+lineWidth, centerPointY-roundCornerDiff);
			shape1.curveTo(PointX+lineGap+lineWidth, centerPointY-roundCornerDiff, PointX+lineGap+lineWidth, centerPointY, PointX+lineGap+lineWidth+lineWidth, centerPointY);
		}
		shape1.moveTo(PointX+lineGap+lineWidth+lineWidth, centerPointY);
		shape1.lineTo(PointX+lineGap+lineWidth+lineWidth+lineWidth, centerPointY);
	
		//arrow
		//shape1.moveTo(PointX+lineGap+lineWidth+lineWidth+lineWidth/2, centerPointY-lineWidth/2);
		//shape1.lineTo(PointX+lineGap+lineWidth+lineWidth+lineWidth, centerPointY);
	
		//shape1.moveTo(PointX+lineGap+lineWidth+lineWidth+lineWidth, centerPointY);
		//shape1.lineTo(PointX+lineGap+lineWidth+lineWidth+lineWidth/2, centerPointY+lineWidth/2);
	}else{
		var iconSize=23;
	    centerPointX = pPoint[0]+ (document.getElementById('act_idx_' + parentTracingTag).offsetWidth/2)-1;
	    centerPointY = pPoint[1]+ iconSize;
		allActHeight = document.getElementById('act_idx_' + parentTracingTag).offsetHeight;

	    PointX = cPoint[0]+ (document.getElementById('act_idx_' + childTracingTag).offsetWidth/2);
	    pointY = centerPointY+lineWidth;
		actHeight= document.getElementById('act_idx_' + childTracingTag).offsetHeight;
		
		//transform
		 if(loopDraw_originObj!=null && loopDraw_zoom!=-1){
		  	var originPoint = getAbsPosition(loopDraw_originObj);
		 	var originX = originPoint[0];
		 	var originY = originPoint[1];
		 	
		 	centerPointX = (centerPointX - originX)*loopDraw_zoom / 100 + originX;
		 	centerPointY = (centerPointY - originY)*loopDraw_zoom / 100 + originY;
		 	PointX = (PointX - originX)*loopDraw_zoom / 100 + originX;
		 	pointY = (pointY - originY)*loopDraw_zoom / 100 + originY;
		 	
		 	allActHeight = (allActHeight - originY)*loopDraw_zoom / 100 + originY;
		 	actHeight = (actHeight - originY)*loopDraw_zoom / 100 + originY;
		 	lineWidth  = (lineWidth - originX)*loopDraw_zoom / 100 + originX;
		  } 
		 //

		roundCornerDiff = (centerPointX-PointX);
		
		if(roundCornerDiff < -10) roundCornerDiff = -10;
		if(roundCornerDiff > 10) roundCornerDiff = 10;	
		
		//front
		isNotCurve = ((centerPointX - PointX) < 15)&&((centerPointX - PointX) > -15);
		if(isNotCurve){
			PointX = centerPointX;
			shape1.moveTo(centerPointX, centerPointY);
			shape1.lineTo(PointX, pointY+lineWidth);
		}else{
			shape1.moveTo(centerPointX, centerPointY);
			shape1.curveTo(centerPointX, centerPointY, centerPointX,pointY,centerPointX-roundCornerDiff, pointY);
			shape1.lineTo(PointX+roundCornerDiff, pointY);
			shape1.curveTo(PointX+roundCornerDiff, pointY, PointX, pointY, PointX, pointY+lineWidth);
		}
		shape1.moveTo(PointX, pointY+lineWidth);
		shape1.lineTo(PointX, pointY+lineWidth+lineWidth);
	
		shape1.moveTo(PointX-lineWidth/2, pointY+lineWidth);
		shape1.lineTo(PointX, pointY+lineWidth+lineWidth);
	
		shape1.moveTo(PointX+lineWidth/2, pointY+lineWidth);
		shape1.lineTo(PointX, pointY+lineWidth+lineWidth);
		
		//back
		pointY = pointY+lineWidth+lineWidth+actHeight;
		var lineGap=(centerPointY+allActHeight)-(pointY+lineWidth+lineWidth+lineWidth)-(iconSize-3);

		shape1.moveTo(PointX,  pointY);
		shape1.lineTo(PointX, pointY+lineGap);
		
		if(isNotCurve){
			shape1.moveTo(PointX,  pointY+lineGap);
			shape1.lineTo(centerPointX, pointY+lineGap+lineWidth+lineWidth);
		}else{
			shape1.moveTo(PointX,  pointY+lineGap);
			shape1.curveTo(PointX, pointY+lineGap, PointX, pointY+lineGap+lineWidth,PointX+roundCornerDiff, pointY+lineGap+lineWidth);
			shape1.lineTo(centerPointX-roundCornerDiff, pointY+lineGap+lineWidth);
			shape1.curveTo(centerPointX-roundCornerDiff, pointY+lineGap+lineWidth, centerPointX, pointY+lineGap+lineWidth, centerPointX, pointY+lineGap+lineWidth+lineWidth);
		}
		shape1.moveTo(centerPointX, pointY+lineGap+lineWidth+lineWidth);
		shape1.lineTo(centerPointX, pointY+lineGap+lineWidth+lineWidth+lineWidth);
	
	    //arrow
		//shape1.moveTo(centerPointX+lineWidth/2, pointY+lineGap+lineWidth+lineWidth+lineWidth-lineWidth/2);
		//shape1.lineTo(centerPointX, pointY+lineGap+lineWidth+lineWidth+lineWidth);
	
		//shape1.moveTo(centerPointX-lineWidth/2, pointY+lineGap+lineWidth+lineWidth+lineWidth-lineWidth/2);
		//shape1.lineTo(centerPointX, pointY+lineGap+lineWidth+lineWidth+lineWidth);
	}
	//shape1.setTransform([dojox.gfx.matrix.translate(-1000,0),'']);	
}