/*
var Log = {
    elem: false,
    write: function(text){
        if (!this.elem) 
            this.elem = document.getElementById('log');
        this.elem.innerHTML = text;
        this.elem.style.left = (500 - this.elem.offsetWidth / 2) + 'px';
    }
};
*/

var json;
var st;
var strategyId;
var actionCode;
var canvas;

function createXMLHttpRequest() {
	if (window.ActiveXObject) {
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	} else if (window.XMLHttpRequest) {
		xmlHttp = new XMLHttpRequest();
	}
	return xmlHttp;
}

function getJSONData() {			
	var url = "data.jsp?cmd=getAll";
	
	var xmlHttp = createXMLHttpRequest();
	xmlHttp.open("GET", url, true); 
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				var result = xmlHttp.responseText;
				init(result);
			}
		}
	};
	xmlHttp.send(null);
}

function addEvent(obj, type, fn) {
    if (obj.addEventListener) obj.addEventListener(type, fn, false);
    else obj.attachEvent('on' + type, fn);
};

var labelOffsetWidth = 0;
function createST(){
    ST.Plot.NodeTypes.implement({
        'nodeline': function(node, canvas, animating) {
            if(animating === 'expand' || animating === 'contract') {
                var pos = node.pos.getc(true), nconfig = this.node, data = node.data;
                var width  = nconfig.width, height = nconfig.height;
                var algnPos = this.getAlignedPos(pos, width, height);
                var ctx = canvas.getCtx(), ort = this.config.orientation;
                ctx.beginPath();
                if(ort == 'left' || ort == 'right') {
                    ctx.moveTo(algnPos.x, algnPos.y + height / 2);
                    ctx.lineTo(algnPos.x + width, algnPos.y + height / 2);
                } else {
                    ctx.moveTo(algnPos.x + width / 2, algnPos.y);
                    ctx.lineTo(algnPos.x + width / 2, algnPos.y + height);
                }
                ctx.stroke();
            } 
        }
    });
    
    st = new ST(canvas, {
        //set duration for the animation
        duration: 200,
        //set animation transition type
        transition: Trans.Quart.easeInOut,
        //set distance between node and its children
        levelDistance: 50,
        //set max levels to show. Useful when used with
        //the request method for requesting trees of specific depth
        levelsToShow: 5,
        //set node and edge styles
        //set overridable=true for styling individual
        //nodes or edges
        Node: {
            //height: 20,
            width: 90,
            //use a custom
            //node rendering function
            type: 'nodeline',
            color:'#C4CACE',
            lineWidth: 1,
            align:"center",
            overridable: true
        },
        
        Edge: {
            type: 'bezier',
            lineWidth: 2,
            color:'#C4CACE',
            overridable: true
        },
        
        //Add a request method for requesting on-demand json trees. 
        //This method gets called when a node
        //is clicked and its subtree has a smaller depth
        //than the one specified by the levelsToShow parameter.
        //In that case a subtree is requested and is added to the dataset.
        //This method is asynchronous, so you can make an Ajax request for that
        //subtree and then handle it to the onComplete callback.
        //Here we just use a client-side tree generator (the getTree function).
        /*
        request: function(nodeId, level, onComplete) {
          var ans = getTree(nodeId, level);
          onComplete.onComplete(nodeId, ans);  
        },
        */
        
        onBeforeCompute: function(node){
            //Log.write("loading " + node.name);
        },
        
        onAfterCompute: function(){
            //Log.write("done");
        },
        
        //This method is called on DOM label creation.
        //Use this method to add event handlers and styles to
        //your node.
        onCreateLabel: function(label, node){
            label.id = node.id;            
            label.innerHTML = node.name;
            label.onclick = function(){
            	//label.innerHTML = "<B>"+node.name+"</B>";
                initPosition();
                st.onClick(node.id);
                document.getElementsByName("strategyId")[0].value = node.id;
                document.getElementsByName("strategyName").value = node.name;
                callGanttChart(node.id,node.name);
            };
            
            $(label).contextMenu({
        		menu: 'myMenu'
        	},
        	function (action, el, pos) {
        		contextAction(action, el, pos, label, node);
        	});
            
            //set label styles
            var style = label.style;
			labelOffsetWidth = label.offsetWidth;
			if(label.offsetWidth > 85){
            	style.width = 85 + 'px';		
			}if(label.offsetWidth < 50){
				style.width = 55 + 'px';
			}else{
				style.width = label.offsetWidth + 5 + 'px';	
			}
			style.cursor = 'pointer';
            style.color = '#000';				
            style.textAlign= 'center';
            //style.backgroundColor = '#1a1a1a';
            style.fontSize = '0.9em';
        },
        
        //This method is called right before plotting
        //a node. It's useful for changing an individual node
        //style properties before plotting it.
        //The data properties prefixed with a dollar
        //sign will override the global node style properties.
        onBeforePlotNode: function(node){
            //add some color to the nodes in the path between the
            //root node and the selected node.
            if (node.selected) {
                node.data.$color = "#ff7";
            }
            else {
                delete node.data.$color;
            }
        },
        
        //This method is called right before plotting
        //an edge. It's useful for changing an individual edge
        //style properties before plotting it.
        //Edge data proprties prefixed with a dollar sign will
        //override the Edge global style properties.
        onBeforePlotLine: function(adj){
            if (adj.nodeFrom.selected && adj.nodeTo.selected) {
                adj.data.$color = "#23A4FF";
                adj.data.$lineWidth = 3;
            }
            else {
                delete adj.data.$color;
                delete adj.data.$lineWidth;
            }
        }
    });
}

function initPosition(){
	dragobjekt = document.getElementById("mycanvas");
	var pane = document.getElementById("leftPane")
	dragobjekt.style.left = (1280-pane.offsetWidth)/2*-1; 
	dragobjekt.style.top = (1280-pane.offsetHeight/6)/2*-1; 
}



function init(json){
	//getJSONData();
    //init data
    //var json = "{id:\"node02\", name:\"0.2\", data:{}, children:[{id:\"node13\", name:\"1.3\", data:{}, children:[{id:\"node24\", name:\"2.4\", data:{}, children:[{id:\"node35\", name:\"3.5\", data:{}, children:[{id:\"node46\", name:\"4.6\", data:{}, children:[]}]}, {id:\"node37\", name:\"3.7\", data:{}, children:[{id:\"node48\", name:\"4.8\", data:{}, children:[]}, {id:\"node49\", name:\"4.9\", data:{}, children:[]}, {id:\"node410\", name:\"4.10\", data:{}, children:[]}, {id:\"node411\", name:\"4.11\", data:{}, children:[]}]}, {id:\"node312\", name:\"3.12\", data:{}, children:[{id:\"node413\", name:\"4.13\", data:{}, children:[]}]}, {id:\"node314\", name:\"3.14\", data:{}, children:[{id:\"node415\", name:\"4.15\", data:{}, children:[]}, {id:\"node416\", name:\"4.16\", data:{}, children:[]}, {id:\"node417\", name:\"4.17\", data:{}, children:[]}, {id:\"node418\", name:\"4.18\", data:{}, children:[]}]}, {id:\"node319\", name:\"3.19\", data:{}, children:[{id:\"node420\", name:\"4.20\", data:{}, children:[]}, {id:\"node421\", name:\"4.21\", data:{}, children:[]}]}]}, {id:\"node222\", name:\"2.22\", data:{}, children:[{id:\"node323\", name:\"3.23\", data:{}, children:[{id:\"node424\", name:\"4.24\", data:{}, children:[]}]}]}]}, {id:\"node125\", name:\"1.25\", data:{}, children:[{id:\"node226\", name:\"2.26\", data:{}, children:[{id:\"node327\", name:\"3.27\", data:{}, children:[{id:\"node428\", name:\"4.28\", data:{}, children:[]}, {id:\"node429\", name:\"4.29\", data:{}, children:[]}]}, {id:\"node330\", name:\"3.30\", data:{}, children:[{id:\"node431\", name:\"4.31\", data:{}, children:[]}]}, {id:\"node332\", name:\"3.32\", data:{}, children:[{id:\"node433\", name:\"4.33\", data:{}, children:[]}, {id:\"node434\", name:\"4.34\", data:{}, children:[]}, {id:\"node435\", name:\"4.35\", data:{}, children:[]}, {id:\"node436\", name:\"4.36\", data:{}, children:[]}]}]}, {id:\"node237\", name:\"2.37\", data:{}, children:[{id:\"node338\", name:\"3.38\", data:{}, children:[{id:\"node439\", name:\"4.39\", data:{}, children:[]}, {id:\"node440\", name:\"4.40\", data:{}, children:[]}, {id:\"node441\", name:\"4.41\", data:{}, children:[]}]}, {id:\"node342\", name:\"3.42\", data:{}, children:[{id:\"node443\", name:\"4.43\", data:{}, children:[]}]}, {id:\"node344\", name:\"3.44\", data:{}, children:[{id:\"node445\", name:\"4.45\", data:{}, children:[]}, {id:\"node446\", name:\"4.46\", data:{}, children:[]}, {id:\"node447\", name:\"4.47\", data:{}, children:[]}]}, {id:\"node348\", name:\"3.48\", data:{}, children:[{id:\"node449\", name:\"4.49\", data:{}, children:[]}, {id:\"node450\", name:\"4.50\", data:{}, children:[]}, {id:\"node451\", name:\"4.51\", data:{}, children:[]}, {id:\"node452\", name:\"4.52\", data:{}, children:[]}, {id:\"node453\", name:\"4.53\", data:{}, children:[]}]}, {id:\"node354\", name:\"3.54\", data:{}, children:[{id:\"node455\", name:\"4.55\", data:{}, children:[]}, {id:\"node456\", name:\"4.56\", data:{}, children:[]}, {id:\"node457\", name:\"4.57\", data:{}, children:[]}]}]}, {id:\"node258\", name:\"2.58\", data:{}, children:[{id:\"node359\", name:\"3.59\", data:{}, children:[{id:\"node460\", name:\"4.60\", data:{}, children:[]}, {id:\"node461\", name:\"4.61\", data:{}, children:[]}, {id:\"node462\", name:\"4.62\", data:{}, children:[]}, {id:\"node463\", name:\"4.63\", data:{}, children:[]}, {id:\"node464\", name:\"4.64\", data:{}, children:[]}]}]}]}, {id:\"node165\", name:\"1.65\", data:{}, children:[{id:\"node266\", name:\"2.66\", data:{}, children:[{id:\"node367\", name:\"3.67\", data:{}, children:[{id:\"node468\", name:\"4.68\", data:{}, children:[]}, {id:\"node469\", name:\"4.69\", data:{}, children:[]}, {id:\"node470\", name:\"4.70\", data:{}, children:[]}, {id:\"node471\", name:\"4.71\", data:{}, children:[]}]}, {id:\"node372\", name:\"3.72\", data:{}, children:[{id:\"node473\", name:\"4.73\", data:{}, children:[]}, {id:\"node474\", name:\"4.74\", data:{}, children:[]}, {id:\"node475\", name:\"4.75\", data:{}, children:[]}, {id:\"node476\", name:\"4.76\", data:{}, children:[]}]}, {id:\"node377\", name:\"3.77\", data:{}, children:[{id:\"node478\", name:\"4.78\", data:{}, children:[]}, {id:\"node479\", name:\"4.79\", data:{}, children:[]}]}, {id:\"node380\", name:\"3.80\", data:{}, children:[{id:\"node481\", name:\"4.81\", data:{}, children:[]}, {id:\"node482\", name:\"4.82\", data:{}, children:[]}]}]}, {id:\"node283\", name:\"2.83\", data:{}, children:[{id:\"node384\", name:\"3.84\", data:{}, children:[{id:\"node485\", name:\"4.85\", data:{}, children:[]}]}, {id:\"node386\", name:\"3.86\", data:{}, children:[{id:\"node487\", name:\"4.87\", data:{}, children:[]}, {id:\"node488\", name:\"4.88\", data:{}, children:[]}, {id:\"node489\", name:\"4.89\", data:{}, children:[]}, {id:\"node490\", name:\"4.90\", data:{}, children:[]}, {id:\"node491\", name:\"4.91\", data:{}, children:[]}]}, {id:\"node392\", name:\"3.92\", data:{}, children:[{id:\"node493\", name:\"4.93\", data:{}, children:[]}, {id:\"node494\", name:\"4.94\", data:{}, children:[]}, {id:\"node495\", name:\"4.95\", data:{}, children:[]}, {id:\"node496\", name:\"4.96\", data:{}, children:[]}]}, {id:\"node397\", name:\"3.97\", data:{}, children:[{id:\"node498\", name:\"4.98\", data:{}, children:[]}]}, {id:\"node399\", name:\"3.99\", data:{}, children:[{id:\"node4100\", name:\"4.100\", data:{}, children:[]}, {id:\"node4101\", name:\"4.101\", data:{}, children:[]}, {id:\"node4102\", name:\"4.102\", data:{}, children:[]}, {id:\"node4103\", name:\"4.103\", data:{}, children:[]}]}]}, {id:\"node2104\", name:\"2.104\", data:{}, children:[{id:\"node3105\", name:\"3.105\", data:{}, children:[{id:\"node4106\", name:\"4.106\", data:{}, children:[]}, {id:\"node4107\", name:\"4.107\", data:{}, children:[]}, {id:\"node4108\", name:\"4.108\", data:{}, children:[]}]}]}, {id:\"node2109\", name:\"2.109\", data:{}, children:[{id:\"node3110\", name:\"3.110\", data:{}, children:[{id:\"node4111\", name:\"4.111\", data:{}, children:[]}, {id:\"node4112\", name:\"4.112\", data:{}, children:[]}]}, {id:\"node3113\", name:\"3.113\", data:{}, children:[{id:\"node4114\", name:\"4.114\", data:{}, children:[]}, {id:\"node4115\", name:\"4.115\", data:{}, children:[]}, {id:\"node4116\", name:\"4.116\", data:{}, children:[]}]}, {id:\"node3117\", name:\"3.117\", data:{}, children:[{id:\"node4118\", name:\"4.118\", data:{}, children:[]}, {id:\"node4119\", name:\"4.119\", data:{}, children:[]}, {id:\"node4120\", name:\"4.120\", data:{}, children:[]}, {id:\"node4121\", name:\"4.121\", data:{}, children:[]}]}, {id:\"node3122\", name:\"3.122\", data:{}, children:[{id:\"node4123\", name:\"4.123\", data:{}, children:[]}, {id:\"node4124\", name:\"4.124\", data:{}, children:[]}]}]}, {id:\"node2125\", name:\"2.125\", data:{}, children:[{id:\"node3126\", name:\"3.126\", data:{}, children:[{id:\"node4127\", name:\"4.127\", data:{}, children:[]}, {id:\"node4128\", name:\"4.128\", data:{}, children:[]}, {id:\"node4129\", name:\"4.129\", data:{}, children:[]}]}]}]}, {id:\"node1130\", name:\"1.130\", data:{}, children:[{id:\"node2131\", name:\"2.131\", data:{}, children:[{id:\"node3132\", name:\"3.132\", data:{}, children:[{id:\"node4133\", name:\"4.133\", data:{}, children:[]}, {id:\"node4134\", name:\"4.134\", data:{}, children:[]}, {id:\"node4135\", name:\"4.135\", data:{}, children:[]}, {id:\"node4136\", name:\"4.136\", data:{}, children:[]}, {id:\"node4137\", name:\"4.137\", data:{}, children:[]}]}]}, {id:\"node2138\", name:\"2.138\", data:{}, children:[{id:\"node3139\", name:\"3.139\", data:{}, children:[{id:\"node4140\", name:\"4.140\", data:{}, children:[]}, {id:\"node4141\", name:\"4.141\", data:{}, children:[]}]}, {id:\"node3142\", name:\"3.142\", data:{}, children:[{id:\"node4143\", name:\"4.143\", data:{}, children:[]}, {id:\"node4144\", name:\"4.144\", data:{}, children:[]}, {id:\"node4145\", name:\"4.145\", data:{}, children:[]}, {id:\"node4146\", name:\"4.146\", data:{}, children:[]}, {id:\"node4147\", name:\"4.147\", data:{}, children:[]}]}]}]}]}";
    //end
    
    var infovis = document.getElementById('infovis');
    var w = infovis.offsetWidth, h = infovis.offsetHeight;
    //init canvas
    //Create a new canvas instance.
    canvas = new Canvas('mycanvas', {
        'injectInto': 'infovis',
        'width': 1280,
        'height':1280,
        'backgroundColor': '#1a1a1a'
    });
    //end
    
    createST();
    
    //load json data
    st.loadJSON(eval( '(' + json + ')' ));
    //compute node positions and layout
    st.compute();
    //emulate a click on the root node.
    
    
    if (currentNodeId.length > 0) {
    	st.onClick(currentNodeId);
    } else {
    	st.onClick(st.root);
    	initPosition();
    }
    
    //st.onClick(st.root);
    
    //end
    //Add event handlers to switch spacetree orientation.
   function get(id) {
      return document.getElementById(id);  
    };

    var top = get('r-top'), 
    left = get('r-left'), 
    bottom = get('r-bottom'), 
    right = get('r-right');
    
    function changeHandler() {
        if(this.checked) {
            top.disabled = bottom.disabled = right.disabled = left.disabled = true;
            st.switchPosition(this.value, "animate", {
                onComplete: function(){
                    top.disabled = bottom.disabled = right.disabled = left.disabled = false;
                }
            });
        }
    };
    
    top.onchange = left.onchange = bottom.onchange = right.onchange = changeHandler;
    //end
    
    draginit();
}

function setViewMode(){

//	var orientation = document.getElementsByName("orientation");
//
//    for(i=0; i < orientation.length; i++){
//        if(orientation[i].checked){
//
//        	st.switchPosition( orientation[i].value, "animate", {
//                onComplete: function(){
//                    top.disabled = bottom.disabled = right.disabled = left.disabled = false;
//                }
//            });
//
//        }
//	}
//		    

	
}

//---------------Drag and Drop functionalities-------------- 
var dragobjekt = null; 
var dragFlag = 0;

//Position 
var dragx = 0; 
var dragy = 0; 

//Mouse Position 
var posx = 0; 
var posy = 0; 

function draginit() { 
	document.onmousemove = drag; 
	document.onmouseup = dragstop; 
}

function dragstop() { 
	dragFlag=0;
	dragobjekt=null;
}

function drag(ereignis) { 
	posx = document.all ? window.event.clientX : ereignis.pageX; 
	posy = document.all ? window.event.clientY : ereignis.pageY; 

	if(dragFlag==1) {  
		dragobjekt = document.getElementById("mycanvas"); 

		dragobjekt.style.left = (posx - dragx) + "px"; 
		if(event.button == 1){ //IE
			dragobjekt.style.top = (posy - dragy) + "px"; 
		}else{ //crome
			dragobjekt.style.top = (posy - dragy -100 ) + "px"; 
		}
	}
}

function dragstart(element) { 
	if(event.button !== 2){
		dragobjekt = element; 
		dragFlag=1;
		dragx = posx - dragobjekt.offsetLeft; 
		dragy = posy - dragobjekt.offsetTop; 
	}
}

function start(){
	mcanvas = document.getElementById("mycanvas"); 
	mcanvas.onMousedown = dragstart(mcanvas);
}

//----------------------------------------------------------------- 

 

function runProcess() {
	var strategyId = document.getElementsByName("strategyId")[0].value;
	if (strategyId.length > 0) {
		callModal(WEB_CONTEXT_ROOT + "/processparticipant/viewProcessMap2.jsp?strategyId=" + strategyId);
	} else {
		alert("select strategy");
	}
}

function callModal(pageUrl) {
	$('#iframeViewTotalResult').attr('src', pageUrl).modal({
		opacity:70,
		overlayCss: {backgroundColor:"black"}
	});
}

var notiDiv;
var cutStrtg="";
function contextAction(action, el, pos, label, node) {
	strategyId = $(el).attr('id');

	actionCode = action;

	if (action == "processStart") {
		callModal(WEB_CONTEXT_ROOT + "/processparticipant/viewProcessMap2.jsp?strategyId=" + strategyId);
	} else if (action == "edit") {
		callModal(WEB_CONTEXT_ROOT+"/processparticipant/initiateForm.jsp?alias=editStrategy&strategyId=" + strategyId);
	} else if (action == "delete") {
		callModal(WEB_CONTEXT_ROOT+"/processparticipant/initiateForm.jsp?alias=delStrategy&strategyId=" + strategyId);
	} else if (action == "addStrategy") {
		callModal(WEB_CONTEXT_ROOT+"/processparticipant/initiateForm.jsp?alias=addStrategy&strategyId=" + strategyId);
	} else if (action == "addParent") {
		notiDiv = document.getElementById("selectParentStrategy");
		notiDiv.style.display="";
	} else if (action == "cut") {
		cutStrtg=strategyId;
	} else if (action == "paste" && cutStrtg!="") {
		url = "moveStrategy.jsp?fromStrategy="+cutStrtg+"&toStrategy="+strategyId;
		StrategyAjaxRefresh(url, strategyId);
		actionCode="";
		cutStrtg="";
	} else if (action == "refresh") {
	    try{
			StrategyAjaxRefresh("data.jsp?cmd=getAll", "0");
			notiDiv.style.display="none";
			action="";
			cutStrtg="";
	    }catch(e){}   
	}
	
	hideTooltip();
}

function updateStrategy() {
	
	var strategyId = $('#updateStrategyId').val();
	var strategyName = $('#updateStrategyName').val();
	//$('#updateStrategyType').val();	
	
	if (strategyId.length > 0) {
		var url = "data.jsp";
		var params = "cmd=update&strategyId=" + strategyId + "&strategyName=" + encodeURIComponent(strategyName);
		
		var xmlHttp = createXMLHttpRequest();
		xmlHttp.open("POST", url, true);
		xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
		xmlHttp.onreadystatechange = function() {
			if (xmlHttp.readyState == 4) {
				if (xmlHttp.status == 200) {
					var result = xmlHttp.responseText;
					document.getElementsByName("strategyId")[0].value = strategyId;
					$('#updateStrategyResult').attr('innerHTML', "succes");
					//location.reload(true);
					setTimeout("$('#strategyForm').submit();", 1 * 1000);
				}
			}
		};
		xmlHttp.send(params);
	} else {
		alert("enter strategy name");
	}
}

function mouseRightBtnUp(el){
	strategyId = $(el).attr('id');
}

function mouseRightBtnDown(el){
	var previousStrategy =  strategyId;
	strategyId = $(el).attr('id');
	
	if(event.button == 1){
		var alertDiv;
		var url;

		if(actionCode=="addParent"){
			url = "setParentStrategy.jsp?fromStrategy="+previousStrategy+"&toStrategy="+strategyId;
			document.getElementById("selectParentStrategy").style.display="none";
			actionCode="";
			StrategyAjaxRefresh(url, previousStrategy);
		}
	}
	
	if(event.button == 2){
		//st.onClick(strategyId);
	}
}

function strtgIframeClose(){
	var url = "data.jsp?cmd=getAll";
	
	StrategyAjaxRefresh(url, strategyId);
}

function getAbsPosition(oElement) {
	var iOffsetLeft = 0;
	var iOffsetTop = 0;
	while (oElement != null) {
		iOffsetLeft += oElement.offsetLeft;
		iOffsetTop += oElement.offsetTop;
		oElement = oElement.offsetParent;
	}
	var absOffset = new Array(2);
	absOffset[0] = iOffsetLeft;
	absOffset[1] = iOffsetTop;
	return absOffset;
}

function StrategyAjaxRefresh(url,focusStrategy){
	var xmlHttp = createXMLHttpRequest();
	xmlHttp.open("GET",url, true); 
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				var result = xmlHttp.responseText;
				try{
					canvas.clear();
					createST();
				    st.fx.clearLabels();
				    st.loadJSON(eval( '(' + result + ')' ));
				    st.compute();

				    if(actionCode =="delete"){
				    	st.onClick("0"); //root
				    }else{
				    	st.onClick(focusStrategy);
				    }
				    initPosition();
				}catch (e) {}
			}
		}
	};
	xmlHttp.send(null);
}

function callGanttChart(nodeId,nodeName){
	var onlyStrategyInstance = document.getElementsByName("OnlyStrategyInstance");
	var isOnlyStrategyInstance="";
    if(onlyStrategyInstance[0].checked){
    	isOnlyStrategyInstance = onlyStrategyInstance[0].value;
    }else{
    	isOnlyStrategyInstance = "";
    }

    if(nodeName !=null || nodeName !=''){
	    var fontFirstIndex= nodeName.indexOf('<a>');
	    var fontLastIndex= nodeName.indexOf('</a>');

	    var name = "Initiatives on \""+nodeName.substring(fontFirstIndex+3,fontLastIndex)+"\"";
	    $('#divPageTitle').attr('innerHTML',name);
    }
    $('#iframeGanttChart').attr('src', '../monitor/ganttChart.jsp?strategyId=' + nodeId+'&isOnlyStrategyInstance='+isOnlyStrategyInstance);
}

function searchName(isEnterKey) {
	var nameSearch = document.getElementsByName("nameSearch");

    var url = "data.jsp?name="+ encodeURI(nameSearch[0].value);	

    if(isEnterKey !=null && event.keyCode == 13){
    	StrategyAjaxRefresh(url, "0");
    }else if(isEnterKey !=null && event.keyCode != 13){
    
    }else if(isEnterKey ==null ){
    	StrategyAjaxRefresh(url, "0");
    }
}

function search(isSelecedPeriod) {
	var isNotCompleted = document.getElementsByName("includingNotCompleted");
	var isNotCompleted_value="";
    if(isNotCompleted[0].checked){
       isNotCompleted_value = isNotCompleted[0].value;
    }

	var period = document.getElementsByName("period");
	var period_value="";
	var period_selected_value="";
    for(i=0; i < period.length; i++){
        if(period[i].checked){
        	period_value = period[i].value;
        	
        	if(i == 0){
        		isNotCompleted[0].disabled=true;
        		isNotCompleted[0].checked=false;
        	}else {
        		isNotCompleted[0].disabled=false;
        	}

        	for ( var j = 1; j < 5; j++) {
        		var select = document.getElementById("period_select"+j);
        		if( i == j){
        			select.style.display="";
        			
        			//to set the value of selected period.  
        			if(isSelecedPeriod==true){
	           		    for(k=0; k < select.options.length; k++){
	        		        if(select.options[k].selected){
	        		        	period_selected_value = select.options[k].value;
	        		        	break;
	        		        }
	        			}
        			}
        		}else{
        			select.style.display="none";
        		}
			}
        	
        	break;
        }
	}

	var partSelect = document.getElementById("partSelect");
	var part_value="";
    for(i=0; i < partSelect.options.length; i++){
        if(partSelect.options[i].selected){
        	part_value = partSelect.options[i].value;
        	break;
        }
	}

    var url = "data.jsp?period="+period_value+"&selectedPeriod="+period_selected_value+"&partCode="+part_value+"&includingNotCompleted="+isNotCompleted_value;

    StrategyAjaxRefresh(url, "0");
}

function viewSearchForm(isView){
	var searchForm = document.getElementById("searchForm");
	var searchLink = document.getElementById("searchLink");
	
	if(isView ==true){
		searchForm.style.display='';
		searchLink.style.display='none';
	}else{
		searchForm.style.display='none';
		searchLink.style.display='';
	}
}

function initialize(){
	var isNotCompleted = document.getElementsByName("includingNotCompleted");
    isNotCompleted[0].checked=false;
 
	var isNotCompleted = document.getElementsByName("OnlyStrategyInstance");
    isNotCompleted[0].checked=false;
     
	document.getElementById("nameSearch").value="";
	
	var period = document.getElementsByName("period");
    period[0].checked=true;
    
	var partSelect = document.getElementById("partSelect");
    partSelect.options[0].selected=true;
    
    StrategyAjaxRefresh("data.jsp", "0");
    
    dragobjekt = document.getElementById("mycanvas"); 
    initPosition();
    
}

function expand(){
	var option = "width=1024,height=768,scrollbars=yes,resizable=yes";
	window.open(WEB_CONTEXT_ROOT + "/strategy/popupDlg.jsp","",option);
}

