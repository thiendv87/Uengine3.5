/**
 * @author erim1005
 */

function addItems(selectedPeople){
	var sep = ';';
	var box = document.forms[0].approvalLine;
	
	box.length=0;
	//selectAll(box);
	//removeItem(box,box.value);

	for(i=0; i<selectedPeople.length; i++){
		//alert(selectedPeople[i].koreanname+selectedPeople[i].type);
		var text = selectedPeople[i].koreanname+","+selectedPeople[i].type+","+selectedPeople[i].preConfirm; 
		var value = selectedPeople[i].empno + sep 
				 + selectedPeople[i].koreanname + sep
				 + selectedPeople[i].deptfullname + sep
				 + selectedPeople[i].remark + sep
				 + selectedPeople[i].type + sep
				 + selectedPeople[i].preConfirm + sep
				 + selectedPeople[i].status + sep
				 + selectedPeople[i].comname + sep
				 + selectedPeople[i].phone + sep;

		if(selectedPeople[i].status =="대기" || selectedPeople[i].status =="진행중"){
			addItem(box, text, value, false);
		}
	}
}

function onApprovalLineSelected(data){

	addPassValues(data);
    delRow("myTable",data);
    addRows("myTable",data);
	addItems(data);	
}

function SelectedInfo() {
	var empno		="";
	var koreanname	="";
	var remark		="";
	var type		="";
	var preConfirm	="";
	var status		="";
	var comname		="";
	var phone		="";
	var stepName	="";
	var deptfullname="";
}

function addRows(id,selectedPeople) {

	//document.getElementById(id).width = 100 * selectedPeople.length;
    var tbody = document.getElementById(id).getElementsByTagName("TBODY")[0];

    for (var i = 0; i < selectedPeople.length; i++) {
    	
    	if (i != 0) {
        	line = document.createElement("TR");
    		
    		td0 = document.createElement("TD");
    		td0.setAttribute("background",WEB_CONTEXT_ROOT + "/images/Common/GrayBoxLine04.gif");
    		td0.width = "3";

    		//종류
            td1 = document.createElement("TD");
            td1.align = "center";
            td1.height = "1"
            td1.width = "144";
            td1.className = "tbllinedot";
            
            td1_1 = document.createElement("TD");
            td1_1.className = "tbllistbg";
            
            
            //결재자
            td2 = document.createElement("TD");
            td2.align = "center";
            td2.height = "1"
            td2.width = "144";
            td2.className = "tbllinedot";
            
            td2_1 = document.createElement("TD");
            td2_1.className = "tbllistbg";
            
            
            //결재일
            td3 = document.createElement("TD");
            td3.align = "center";
            td3.height = "1"
            td3.width = "144";
            td3.className = "tbllinedot";
            
            td3_1 = document.createElement("TD");
            td3_1.className = "tbllistbg";

    		//결과
            td4 = document.createElement("TD");
    		td4.align = "center";
            td4.height = "1"
            td4.width = "144";
            td4.className = "tbllinedot";
            
            td4_1 = document.createElement("TD");
            td4_1.className = "tbllistbg";
    		
    		//결재의견
    		td5 = document.createElement("TD");
            td5.appendChild(document.createTextNode(""));
            td5.align = "center";
            td5.height = "1"
            td5.width = "144";
            td5.className = "tbllinedot";

            td6 = document.createElement("TD");
            td6.background = WEB_CONTEXT_ROOT + "/images/Common/GrayBoxLine04.gif";
            td6.height = "1"
            td6.width = "3";

            line.appendChild(td0);
            line.appendChild(td1);
            line.appendChild(td1_1);
            line.appendChild(td2);
            line.appendChild(td2_1);
            line.appendChild(td3);
            line.appendChild(td3_1);
            line.appendChild(td4);
            line.appendChild(td4_1);
            line.appendChild(td5);
            line.appendChild(td6);
     		
    	    tbody.appendChild(line);
    	}		
    	
    	line = document.createElement("TR");
		
		td0 = document.createElement("TD");
		td0.setAttribute("background",WEB_CONTEXT_ROOT + "/images/Common/GrayBoxLine04.gif");
		td0.width = "3";

		//종류
        td1 = document.createElement("TD");        
        if(selectedPeople[i].stepName != null){
        	td1.appendChild(document.createTextNode(selectedPeople[i].stepName));
        }else{
        	td1.appendChild(document.createTextNode("<%=draftActivityName%> " + selectedPeople[i].remark + " " + selectedPeople[i].koreanname + " (" +selectedPeople[i].type + ")"));
        }
        
        td1.align = "center";
        td1.width = "144";
        td1.height = "24";
        td1.className = "graybg1";
        
        td1_1 = document.createElement("TD");
        td1_1.className = "tbllistbg";
        
        
        //결재자
        td2 = document.createElement("TD");
        td2.appendChild(document.createTextNode(selectedPeople[i].remark + " " + selectedPeople[i].koreanname));
        td2.align = "center";
        td2.width = "144";
        td2.height = "24";
        td2.className = "tbllistcon";
        
        td2_1 = document.createElement("TD");
        td2_1.className = "tbllistbg";
        
        
        //결재일
        td3 = document.createElement("TD");
        if(selectedPeople[i].approveDate != null){
        	td3.appendChild(document.createTextNode(selectedPeople[i].approveDate));
        }else{
        	td3.appendChild(document.createTextNode("-"));
        }
        
        td3.align = "center";
        td3.width = "144";
        td3.height = "24";
        td3.className = "tbllistcon";
        
        td3_1 = document.createElement("TD");
        td3_1.className = "tbllistbg";

		//결과
        td4 = document.createElement("TD");
        //if(i==0) td4.appendChild(document.createTextNode(" signed "));
		//else td4.appendChild(document.createTextNode("-"));
		td4.appendChild(document.createTextNode("[" + selectedPeople[i].status + "]"));
		td4.align = "center";
        td4.width = "144";
        td4.height = "24";
        td4.className = "tbllistcon";
        
        td4_1 = document.createElement("TD");
        td4_1.className = "tbllistbg";
		
		//결재의견
		td5 = document.createElement("TD");
        td5.appendChild(document.createTextNode(""));
        td5.align = "center";
        td5.height = "24";
        td5.width = "144";
        td5.className = "tbllistcon";

        td6 = document.createElement("TD");
        td6.background = WEB_CONTEXT_ROOT + "/images/Common/GrayBoxLine04.gif";
        td6.width = "3";

        line.appendChild(td0);
        line.appendChild(td1);
        line.appendChild(td1_1);
        line.appendChild(td2);
        line.appendChild(td2_1);
        line.appendChild(td3);
        line.appendChild(td3_1);
        line.appendChild(td4);
        line.appendChild(td4_1);
        line.appendChild(td5);
        line.appendChild(td6);
 		
	    tbody.appendChild(line);
    }

    function createNewCell() {
        var cell = document.createElement("td");
        cell.setAttribute("background", WEB_CONTEXT_ROOT + "/images/Common/GrayBoxLine01.gif");
        cell.height = "3";
        return cell;
    }
    
     var line2 = document.createElement("TR");
 
	    td0 = document.createElement("TD");
	    td0.width = "3";
	    td0.height = "3";
	    
	    td0Image = document.createElement("img");
	    td0Image.setAttribute("src", WEB_CONTEXT_ROOT + "/images/Common/GrayBoxMo04.gif");
	    td0Image.width = "3";
	    td0Image.height = "3";
	    
	    td0.appendChild(td0Image);
	    
	    td1 = createNewCell();
	    td2 = createNewCell();
	    td3 = createNewCell();
	    td4 = createNewCell();
	    td5 = createNewCell();
	    td6 = createNewCell();
	    td7 = createNewCell();
	    td8 = createNewCell();
	    td9 = createNewCell();

	    td10 = document.createElement("TD");
	    td10.width = "3";
   
	    td10Image = document.createElement("img");
	    td10Image.setAttribute("src", WEB_CONTEXT_ROOT + "/images/Common/GrayBoxMo03.gif");
	    td10Image.width = "3";
	    td10Image.height = "3";
	    
	    td10.appendChild(td10Image);

	    line2.appendChild(td0);
	    line2.appendChild(td1);
	    line2.appendChild(td2);
	    line2.appendChild(td3);
	    line2.appendChild(td4);
	    line2.appendChild(td5);
	    line2.appendChild(td6);
	    line2.appendChild(td7);
	    line2.appendChild(td8);
	    line2.appendChild(td9);
	    line2.appendChild(td10);
	    
	    tbody.appendChild(line2);
}

function delRow(id,data)
{
    var tbody = document.getElementById(id).getElementsByTagName("TBODY")[0];

    for(var i=tbody.rows.length; i>0; i--){
    	tbody.deleteRow(i-1);
    }
    //if(tbody.rows.length>0){
    //    tbody.deleteRow(tbody.rows.length-1);
    //    tbody.deleteRow(tbody.rows.length-1);
    //    tbody.deleteRow(tbody.rows.length-1);
    //}
}

function completeApprove(apprStat){
	var confirmMessage = "";
	if( apprStat == "draft" ){
		confirmMessage = "draft?";
		selectAll(document.apprForm.approvalLine);
		if( !isSelected(document.apprForm.approvalLine) ){
			// alert('draftAlert');
			return;
		}
	}else if( apprStat == "approve" ){
		confirmMessage = "Approve?";
	}else if( apprStat == "arbitraryApprove" ){
		confirmMessage = "arbitraryApprove?";
	}else if( apprStat == "reject" ){
		confirmMessage = "reject?";
	}
	
	if(confirm(confirmMessage)){
		document.apprForm.apprStat.value = apprStat;
		document.apprForm.target = "_self";
		document.apprForm.submit();
	}else{
		//alert("Cancled");
	}
	
	return;
}