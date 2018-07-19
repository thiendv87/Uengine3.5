<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.defaultcompany.web.tag.TagDAO"%>
<jsp:useBean id="allTagArray" scope="application" class="java.lang.String" />
<%
String hiddenTag = "";
String defaultTagName = "{\"defaultTag\":\"\"}";
TagDAO dao = new TagDAO();

allTagArray = dao.getAllTag(allTagArray, loggedUserGlobalCom);

if (initiate) {
	defaultTagName = dao.getDefaultTagString(processDefinition, loggedUserGlobalCom);
%>
<div style="width:100%;padding-left:30px;">
	<div style="float:left; padding-top:3px;"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/tag.gif" width="28" height="14" align="absmiddle" /></div>
	<div id="divTag" style="text-align:left; width:auto; float:left; padding-top:3px; padding-left:2px; padding-right:2px;"></div>
	<div style="float:left;">
	    <input type="text" id="tagText" name="tagText" value="" title="<%=GlobalContext.getMessageForWeb("tag.enter", loggedUserLocale) %>"/>
	    <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/addtag.gif" width="45" height="18" align="absmiddle" id="tagAdd" style="cursor:pointer;"/>
	</div>
</div>
<%
/**
 * not initiator
 * 
 **/
} else if (piRemote != null) { // not initiate
    String[] result = dao.getTagList(loggedUserGlobalCom, piRemote.getInstanceId(), piRemote.getRootProcessInstanceId());
    String tags = result[0] == null ? "" : result[0];
    hiddenTag = result[1] == null ? "" : result[1];
%>

<div style="float:left; padding-top:3px;"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/tag.gif" width="28" height="14" align="absmiddle" /></div>
<div style="text-align:left; width:auto; float:left; padding-top:3px; padding-left:2px; padding-right:2px;">
<%=tags %>&nbsp;
</div>
<%
    String status = pm.getActivityStatus(instanceId, tracingTag);
    if(status!=null && !status.equals("Completed") && !status.equals("Timeout")){
%>
<div id="divTag" style="text-align:left; width:auto; float:left; padding-top:3px; padding-left:2px; padding-right:2px;"></div>
<div style="float:left;">
    <input type="text" id="tagText" name="tagText" value="" title="<%=GlobalContext.getMessageForWeb("tag.enter", loggedUserLocale) %>" style="text-align:left;"/>
    <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/addtag.gif" width="45" height="18" align="absmiddle" id="tagAdd" style="cursor:pointer;"/>
</div>
<%
    }
}
%>

<input type="hidden" id="tags" name="tags" value="<%=hiddenTag %>"/>
<style>
    .ui-autocomplete-loading { background: white url('<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/ui-anim_basic_16x16.gif') right center no-repeat; }
    #tagText { width: 10em; }
</style>
<script type="text/javascript">
<!--
var cnt = 0;
var availableTags = <%=allTagArray %>;

$("#tagAdd").click(function() {
    if($("#tagText").val() == "") {
        alert("태그를 입력해 주세요.");
        return;
    }
    
    addTag($("#tagText").val());
});

function addTag(message) {
    var tags = $("#tags").val();
    
    var tagArray = tags.split(";");
    for (var i=0; i < tagArray.length; i++) {
    	if (tagArray[i] == message) {
    		alert("이미 등록된 Tag 입니다.");
    		return;
    	}
    }
    
    if (message == ";") {
        alert("특수문자 \";\"는 태그로 등록할수 없는 문자 입니다.");
        return;
    }
    
    cnt++;
    
    var tagText = message.toLowerCase() + ";";
    
    var spanTag = "<span style=\"text-align:left; font-size:12px; color:#7b7b7b\" id=\"tag_"+cnt+"\">" 
                + message 
                + "<img src=\"<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/tag_del.gif\" onclick=\"tagDelete("+cnt+", '" + tagText + "')\" style=\"cursor:pointer\"/>"
                + "</span>";
    
    $("#divTag").append(spanTag);
    $("#tags").val($("#tags").val() + tagText);
    $("input[name=tagText]").val("");
}

function addText(message) {
}

$("#tagText")
    .bind("keydown", function() {
        if ( event.keyCode === $.ui.keyCode.ENTER) {
            if($(this).val() != "") {
                addTag($("#tagText").val());
            }
           
            return false;
        }
    })
    .autocomplete({
        source: availableTags,
        	//function( request, response ) {
            //$.ajax({
            //    url:"<%=GlobalContext.WEB_CONTEXT_ROOT%>/tagService",
            //    dataType: "json",
            //    data: {"tag" : $("#tagText").val(), "type" : "json"},
            //    type : "post",
            //    success: function( data ) {
            //        response( $.map( data.tagList, function( item ) {
            //            return {
            //                label: item.name,
            //                value: item.name
            //            }
            //        }));
            //    },
            //    error:function(){
            //        alert("Fail load Fire Action");
            //        alert(this.url);
            //    }
            //});
        //},
        minLength: 1,
        select: function( event, ui ) {
        	if ($(this).val() == "") return false;
            //addText( ui.item ? ui.item.label : this.value);
        },
        open: function() {
            $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
        },
        close: function() {
            $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
        }
});

function tagDelete(num, text) {
    $("#tags").val($("#tags").val().replace(text, ""));
    $("#tag_"+num).remove();
}

function tagValidation() {
    var racing = "<%=isRacing%>";
    var inituser = "<%=initiate%>";

    if (racing == "false" && inituser == "true" && $("#tags").val() == "") {
        alert("태그는 필수 입력사항 입니다. 하나 이상의 태그를 등록해 주십시요.");
        return false;
    }
    
    return true;
}

$(document).ready(function() {
	var tag = <%=defaultTagName%>;
	if (tag.defaultTag != "") {
		addTag(tag.defaultTag);
	}
});
//-->
</script>