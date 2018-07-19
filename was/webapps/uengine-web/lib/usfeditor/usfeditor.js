SimpleEditor = function(config, url) {
	this.id = "";
	//button tag
	var _EDIT_BTN_TAG = "<img src='http://localhost:8080/uengine-web/lib/usfeditor/images/page_edit.png' />";
	var _DONE_BTN_TAG = "<img src='http://localhost:8080/uengine-web/lib/usfeditor/images/accept.png' />";
	var _ADD_BTN_TAG = "<img src='http://localhost:8080/uengine-web/lib/usfeditor/images/add.png' />";
	var _DEL_BTN_TAG = "<img src='http://localhost:8080/uengine-web/lib/usfeditor/images/cross.png' />";
	var _ADD_GROUP_BTN_TAG = "+ addGroup";
	var _DEL_GROUP_BTN_TAG = "- removeGroup";
	var _LEFT_INDENT_BTN_TAG = "<img src='http://localhost:8080/uengine-web/lib/usfeditor/images/shape_align_left.png' />";
	var _RIGHT_INDENT_BTN_TAG = "<img src='http://localhost:8080/uengine-web/lib/usfeditor/images/shape_align_right.png' />";
	var _ITEM_ADD_BTN_TAG = "<img src='http://localhost:8080/uengine-web/lib/usfeditor/images/add.png' />";
	var _ITEM_DEL_BTN_TAG = "<img src='http://localhost:8080/uengine-web/lib/usfeditor/images/cross.png' />";
	//title button tag
	var _BOLD_BTN_TAG = "<img src='http://localhost:8080/uengine-web/lib/usfeditor/images/text_bold.png' />";
	var _ITALIC_BTN_TAG = "<img src='http://localhost:8080/uengine-web/lib/usfeditor/images/text_italic.png' />";
	var _UNDERLINE_BTN_TAG = "<img src='http://localhost:8080/uengine-web/lib/usfeditor/images/text_underline.png' />"
	var _CANCELLINE_BTN_TAG = "<img src='http://localhost:8080/uengine-web/lib/usfeditor/images/cancel.png' />";
	//group title
	var _GROUP_TITLE = "Group Name";
	//attribute title
	var _FIELD_TYPE_TITLE = "Field Type";
	var _FIELD_NAME_TITLE = "Field Id";
	var _FIELD_VIEWMODE_TITLE = "View Mode";
	var _FIELD_ATTRIBUTE_TITLE = "Field Attribute";
	//indent size
	var _INDENT_SIZE = 50;	
	var _DEFAULT_TYPE = 'title';
	//mendatory msg
	var _MSG_INPUT_REQUIRED = "is required";
	//control size
	var _TITLE_WIDTH = "50%";
	var _TEXT_WIDTH = "50%";
	var _TEXTAREA_WIDTH = "50%";
	var _TEXTAREA_HEIGHT = "50";
	var _SEPARATOR_WIDTH = "100%";
	var _SEPARATOR_BORDER_COLOR = "#a9a9a9";
	var _SEPARATOR_BORDER_STYLE = "solid";
	var _SEPARATOR_BORDER_WIDTH = "medium";
	
	if (config) {
		if (config.editBtn) {
			_EDIT_BTN_TAG = config.editBtn;
		} else if (config.url) {
			_EDIT_BTN_TAG = "<img src='"+config.url+"/lib/usfeditor/images/page_edit.png' />";
		}
		
		if (config.doneBtn) {
			_DONE_BTN_TAG = config.doneBtn;
		} else if (config.url) {
			_DONE_BTN_TAG = "<img src='"+config.url+"/lib/usfeditor/images/accept.png' />";
		}
		
		if (config.addBtn) {
			_ADD_BTN_TAG = config.addBtn;
		} else if (config.url) {
			var _ADD_BTN_TAG = "<img src='"+config.url+"/lib/usfeditor/images/add.png' />";
		}
		
		if (config.delBtn) {
			_DEL_BTN_TAG = config.delBtn;
		} else if (config.url) {
			var _DEL_BTN_TAG = "<img src='"+config.url+"/lib/usfeditor/images/cross.png' />";
		}
		
		if (config.delGroupBtn) _DEL_GROUP_BTN_TAG = config.delGroupBtn;
		
		if (config.addGroupBtn) _ADD_GROUP_BTN_TAG = config.addGroupBtn;
		
		if (config.leftIndentBtn) {
			_LEFT_INDENT_BTN_TAG = config.leftIndentBtn;
		} else if (config.url) {
			var _LEFT_INDENT_BTN_TAG = "<img src='"+config.url+"/lib/usfeditor/images/shape_align_left.png' />";
		}
		
		if (config.rightIndentBtn) {
			_RIGHT_INDENT_BTN_TAG = config.rightIndentBtn;
		} else if (config.url) {
			var _RIGHT_INDENT_BTN_TAG = "<img src='"+config.url+"/lib/usfeditor/images/shape_align_right.png' />";
		}
		
		if (config.itemAddBtn) {
			_ITEM_ADD_BTN_TAG = config.itemAddBtn;
		} else if (config.url) {
			var _ITEM_ADD_BTN_TAG = "<img src='"+config.url+"/lib/usfeditor/images/add.png' />";
		}
		
		if (config.itemDelBtn) {
			_ITEM_DEL_BTN_TAG = config.itemDelBtn;
		} else if (config.url) {
			var _ITEM_DEL_BTN_TAG = "<img src='"+config.url+"/lib/usfeditor/images/cross.png' />";
		}
		
		if (config.boldBtn) {
			_BOLD_BTN_TAG = config.boldBtn;
		} else if (config.url) {
			var _BOLD_BTN_TAG = "<img src='"+config.url+"/lib/usfeditor/images/text_bold.png' />";
		}
		
		if (config.italicBtn) {
			_ITALIC_BTN_TAG = config.italicBtn;
		} else if (config.url) {
			var _ITALIC_BTN_TAG = "<img src='"+config.url+"/lib/usfeditor/images/text_italic.png' />";
		}
		
		if (config.underlineBtn) {
			_UNDERLINE_BTN_TAG = config.underlineBtn;
		} else if (config.url) {
			var _UNDERLINE_BTN_TAG = "<img src='"+config.url+"/lib/usfeditor/images/text_underline.png' />"
		}
		
		if (config.cancellineBtn) {
			_CANCELLINE_BTN_TAG = config.cancellineBtn;
		} else if (config.url) {
			var _CANCELLINE_BTN_TAG = "<img src='"+config.url+"/lib/usfeditor/images/cancel.png' />";
		}
		
		if (config.groupTitle) _GROUP_TITLE = config.groupTitle;
		if (config.fieldTypeTitle) _FIELD_TYPE_TITLE = config.fieldTypeTitle;
		if (config.fieldNameTitle) _FIELD_NAME_TITLE = config.fieldNameTitle;
		if (config.fieldViewModeTitle) _FIELD_VIEWMODE_TITLE = config.fieldViewModeTitle;
		if (config.fieldAttributeTitle) _FIELD_ATTRIBUTE_TITLE = config.fieldAttributeTitle;
		if (config.indentSize) _INDENT_SIZE = config.indentSize;
		if (config.msgInputRequired) _MSG_INPUT_REQUIRED = config.msgInputRequired;
		if (config.titleWidth) _TITLE_WIDTH = config.titleWidth;
		if (config.textWidth) _TEXT_WIDTH = config.textWidth;
		if (config.textareaWidth) _TEXTAREA_WIDTH = config.textareaWidhth;
		if (config.textareaHeight) _TEXTAREA_HEIGHT = config.textareaHeight;
		if (config.separatorWidth) _SEPARATOR_BORDER_WIDTH = config.separatorWidth;
		if (config.separatorBorderColor) _SEPARATOR_BORDER_COLOR = config.separatorBorderColor;
		if (config.separatorBorderStyle) _SEPARATOR_BORDER_STYLE = config.separatorBorderStyle;
		if (config.separatorBorderWidth) _SEPARATOR_BORDER_WIDTH = config.separatorBorderWidth;
	}
	
	var groupTemplate =  "<div id=\"groupArea\">"
					+ "<div id=\"editGroupArea\" style=\"width:auto;display:inline;\">" 
					+ _GROUP_TITLE 
					+ "<input type=\"text\" name=\"groupName\" id=\"groupName\" style=\"width:250px; margin-left:15px;\" />"
					+ "</div>"
					+ "<div id=\"viewGroupArea\" style=\"width:50%;display:none\">"
					+ "<span></span>"
					+ "</div>"
					+ "<div id=\"groupMenuArea\" style=\"text-align:right;width:49%;display:inline;\">"
					+ "<a id=\"sss\" style=\"cursor:pointer;\">"
					+ _DEL_GROUP_BTN_TAG
					+ "</a>"
					+ "</div>"
					+ "</div>";
	
	var menu = "<div id=\"menuArea\" style=\"text-align:right;\">"
			//+ "<span class=\"ui-icon ui-icon-arrowthick-2-n-s\"></span>"
			+ "<a id=\"indentToLeft\" style=\"cursor:pointer;padding-right:3px;\">" + _LEFT_INDENT_BTN_TAG + "</a>"
			+ "<a id=\"indentToRight\" style=\"cursor:pointer;padding-right:3px;\" >" + _RIGHT_INDENT_BTN_TAG + "</a>"
			+ "<a id=\"editRow\" value=\"" + _DONE_BTN_TAG + "\" style=\"cursor:pointer;padding-right:3px;\">" + _DONE_BTN_TAG + "</a>"
			+ "<a id=\"addRow\" style=\"cursor:pointer;padding-right:3px;\" >" + _ADD_BTN_TAG + "</a>"
			+ "<a id=\"removeRow\" style=\"cursor:pointer;padding-right:3px;\" >" + _DEL_BTN_TAG + "</a>"
			+ "</div>";
	var titleAreaTemplate = "<div id=\"titleArea\">"
						+ "<div id=\"editTitleArea\">"
						+ "<input type=\"text\" name=\"_fieldlabel\" style=\"width:"  + _TITLE_WIDTH + ";\" />"
						+ "<a id=\"titleBold\" value=\"off\" style=\"cursor:pointer;padding-left:3px\">" + _BOLD_BTN_TAG + "</a>"
						+ "<a id=\"titleItalic\" value=\"off\" style=\"cursor:pointer;padding-left:3px;\">" + _ITALIC_BTN_TAG + "</a>"
						+ "<a id=\"titleUnderline\" value=\"off\" style=\"cursor:pointer;padding-left:3px;\">" + _UNDERLINE_BTN_TAG + "</a>"
						+ "<a id=\"titleCancelline\" value=\"off\" style=\"cursor:pointer;padding-left:3px;\">" + _CANCELLINE_BTN_TAG + "</a>"
						+ "</div>"
						+ "<div id=\"viewTitleArea\"><span style=\"font-weight:normal;\"></span></div>"
						+ "</div>";
	var fieldAreaTemplate = "<div id=\"fieldArea\"><div id=\"editFieldArea\"></div><div id=\"viewFieldArea\"></div></div>";
	var attributeAreaTemplate = "<div id=\"attributeArea\">"
							 + "<span id=\"_fieldTypeTitle\" style=\"padding-right:3px;\">" 
							 + _FIELD_TYPE_TITLE
							 + "</span>"
							 + "<select name=\"_fieldType\">"
							 + "<option value=\"title\">Title</option>"
							 + "<option value=\"text\">Text</option>"
							 + "<option value=\"richtext\">RichText</option>"
							 + "<option value=\"combobox\">Combobox</option>"
							 + "<option value=\"checkbox\">Checkbox</option>"
							 + "<option value=\"radio\">Radio</option>"
							 + "<option value=\"finduser\">UserPicker</option>"
							 + "<option value=\"calendartag\">Calendar</option>"
							 + "<option value=\"fileupload\">FileUpload</option>"
							 + "<option value=\"googlemap\">GoogleMap</option>"
							 + "<option value=\"separator\">Separator</option>"
							 + "</select> "
							 + "<span id=\"_fieldNameTitle\" style=\"padding-left:5px;padding-right:3px;\">"
							 + _FIELD_NAME_TITLE
							 + "</span>"
							 + " <input type=\"text\" name=\"_fieldName\" />"
							 + "<span id=\"_fieldViewModeTitle\" style=\"padding-left:5px;padding-right:3px;\">"
							 + _FIELD_VIEWMODE_TITLE
							 + "</span>"
							 + " <input type=\"checkbox\" name=\"_fieldViewMode\" />"
							 + "<span id=\"_fieldAttributeTitle\" style=\"padding-left:5px;padding-right:3px;\">"
							 + _FIELD_ATTRIBUTE_TITLE
							 + "</span>"
							 + " <select name=\"_fieldAttribute\" />"
							 + " <input type=\"hidden\" name=\"_fieldAttributeKey\" />"
							 + "</div>";
	
	var fieldButtonTemplate = "<a id=\"addItem\" style=\"cursor:pointer;\">" 
							+ _ITEM_ADD_BTN_TAG 
							+ "</a>"
							+ "<a id=\"removeItem\" style=\"display:none;cursor:pointer;\">"
							+ _ITEM_DEL_BTN_TAG
							+ "</a>";
	
	this.attachFieldTypeEvent = function (li) {
		var funcAttachItemEvent = this.attachItemEvent;
		
		$("#attributeArea > select[name=_fieldType]", li).bind('change', function () {
			var type = this.value;
			var html = "<div id=\"rowEditFieldArea\">";
			var style = "";
			var attrDisplayValue = "none";
			
			switch(type) {
			case 'title' : 
				break;
			case 'text' : 
				style = "width:" + _TEXT_WIDTH + ";";
				html += "<input type=\"text\" name=\"text\" style=\"" + style + "\"/>";
				break;
			case 'richtext' : 
				style = "width:" + _TEXTAREA_WIDTH + ";height:" + _TEXTAREA_HEIGHT + ";";
				html += "<textarea name=\"textarea\" style=\"" + style + "\" />";
				break;
			case 'combobox' : 
				html += "<input type=\"text\" name=\"combobox\" value=\"\" />";
				html += fieldButtonTemplate;
				break;
			case 'checkbox' :
			case 'radio' : 
				html += "<input type=\"" + type + "\" name=\"" + type + "\" />";
				html += "<input type=\"text\" value=\"\" />";
				html += fieldButtonTemplate;
				break;
			case 'googlemap' :
				style = "height:15px;";
				html += "<img  name=\"fakeImage\" id=\"fakeImage\" src=\"./images/" + type + ".gif\" style=\"" + style + "\"/>";
				break;
			case 'finduser' :
			case 'calendartag' :
			case 'fileupload' :
				attrDisplayValue = "inline";
				style = "height:15px;";
				html += "<img  name=\"fakeImage\" id=\"fakeImage\" src=\"./images/" + type + ".gif\" style=\"" + style + "\"/>";
				break;
			case 'separator' : 
				style = "width:" + _SEPARATOR_WIDTH + ";"
					+ "border-top-color:" + _SEPARATOR_BORDER_COLOR + ";"
					+ "border-top-style:" + _SEPARATOR_BORDER_STYLE + ";"
					+ "border-top-width:" + _SEPARATOR_BORDER_WIDTH + ";";			
				html += "<div  name=\"separator\" id=\"separator\" style=\"height:10px;" + style + "\"></div>";
				break;
			}
			html += "</div>";
			
			var currLi = $(this).parent().parent();
			var displayValue = "none";

			if (!(type == "title" || type == "separator")) {
				displayValue = "inline";
				
				if (type == "finduser") {
					$("#attributeArea > select[name=_fieldAttribute]", currLi).html("<option value=\"true\">Multiple</option><option value=\"false\">Single</option>");
					$("#attributeArea > input[name=_fieldAttributeKey]", currLi).val("multiple");
				} else if (type == "calendartag") {
					$("#attributeArea > select[name=_fieldAttribute]", currLi).html("<option value=\"calendar\">Calendar</option><option value=\"string\">String</option>");
					$("#attributeArea > input[name=_fieldAttributeKey]", currLi).val("objecttype");
				} else if (type == "fileupload") {
					$("#attributeArea > select[name=_fieldAttribute]", currLi).html("<option value=\"general\">General</option><option value=\"image\">Image</option>");
					$("#attributeArea > input[name=_fieldAttributeKey]", currLi).val("fileclass");
				}
			}
			
			if (type == "separator") {
				$("#titleArea > #editTitleArea", currLi).hide();
			} else {
				$("#titleArea > #editTitleArea", currLi).show();
			}
			
			$("#attributeArea > input[name=_fieldName]", currLi).css("display", displayValue);
			$("#attributeArea > span[id=_fieldNameTitle]", currLi).css("display", displayValue);
			$("#attributeArea > input[name=_fieldViewMode]", currLi).css("display", displayValue);
			$("#attributeArea > span[id=_fieldViewModeTitle]", currLi).css("display", displayValue);
			$("#attributeArea > select[name=_fieldAttribute]", currLi).css("display", attrDisplayValue);
			$("#attributeArea > span[id=_fieldAttributeTitle]", currLi).css("display", attrDisplayValue);
			
			$("#fieldArea", currLi).show();
			$("#fieldArea > #editFieldArea", currLi).html(html);
			
			//li resizing
			refreshRowHeight(currLi, false);
			//ul resizing
			refreshGroupHeight($(currLi).parent());

			$("#fieldArea > #editFieldArea > #rowEditFieldArea > a", currLi).bind('click', function () {
				var curItem = $(this).parent();
				var items = $(curItem).parent();
				var txtField = $(this).prev();

				switch (this.id) {
				case 'addItem' : 
					var addBtn = $(this);
					var delBtn = $(addBtn).next();
					var newItem = $(curItem).clone(true).appendTo(items);
					$("input[type=text]", newItem).val("");
					$(txtField).attr("disabled", false);
					$(addBtn).hide();
					$(delBtn).show();
					break;
				case 'removeItem' :
					if ($(items).children().length > 1) {
						$(curItem).remove();
					}
					break;
				}
				//li resizing
				refreshRowHeight(currLi, false);
				//ul resizing
				refreshGroupHeight($(currLi).parent());
			});
		});				
	};

	this.attachFrameMenuEvent = function (li) {
		var funcEditRow = this.editRow;
		var funcAddRow = this.addRow;
		var funcRemoveRow = this.removeRow;
		var funcAddLeftIndent = this.addLeftIndent;
		var funcAddRightIndent = this.addRightIndent;

		$("div > a", li).bind('click', function () {
			switch (this.id) {
			case 'editRow' :
				funcEditRow(this);
				break;
			case 'addRow' : 
				funcAddRow(this);
				break;
			case 'removeRow' : 
				funcRemoveRow(this);
				break;
			case 'indentToLeft' :
				funcAddLeftIndent(this);
				break;
			case 'indentToRight' : 
				funcAddRightIndent(this);
				break;
			}
		});
	};
	
	this.attachTitleMenu = function (li) {
		$("#titleArea > #editTitleArea > a", li).bind('click', function() {
			var currLi = $(this).parent().parent().parent();
			var val = "none";
			var bold = "normal";
			var italic = "normal";
			var underline = "none";
			var cancelline = "none";
			
			if ($(this).attr("value") == "off") {
				val = "on";
				bold = "bold";
				italic = "italic";
				underline = "underline"; 
				cancelline = "line-through";
				//$(this).css("color", "#FF0000");
			} else {
				val = "off";
				bold = "";
				italic = "";
				underline = ""; 
				cancelline = "";
				//$(this).css("color", "#2779AA");
			}
			
			$(this).attr("value", val);
			
			switch (this.id) {
			case 'titleBold' :
				$("#titleArea > #viewTitleArea > span", currLi).css("font-weight", bold);				
				break;
			case 'titleItalic' :
				$("#titleArea > #viewTitleArea > span", currLi).css("font-style", italic);
				break;
			case 'titleUnderline' :
				$("#titleArea > #viewTitleArea > span", currLi).css("text-decoration", underline);
				break;
			case 'titleCancelline' :
				$("#titleArea > #viewTitleArea > span", currLi).css("text-decoration", cancelline);
				break;
			}
		});
	} 

	this.editRow = function (btn) {
		var li = $(btn).parent().parent();
		var titleArea = $("#titleArea", li);
		var fieldArea = $("#fieldArea", li);
		var attributeArea = $("#attributeArea", li);
		var isDone = ($(btn).attr("value") == _DONE_BTN_TAG);
		
		if (isDone) {
			var type = $("select[name=_fieldType]", attributeArea).val();
			var fieldName = $("input[name=_fieldName]", attributeArea).val();
			var viewMode = $("input[name=_fieldViewMode]", attributeArea).attr("checked") ? 1 : 0;
			var fieldAttributeKey = $("input[name=_fieldAttributeKey]", attributeArea).val();
			var fieldAttribute = $("select[name=_fieldAttribute]", attributeArea).val();
			
			if (!(type == "title" || type == "separator") && $.trim(fieldName) == "") {
				alert("[" + $("span[id=_fieldNameTitle]", attributeArea).html() + "] " + _MSG_INPUT_REQUIRED);
				$("input[name=_fieldName]", attributeArea).focus();
				return;
			}
			
			$(attributeArea).hide();
			$("#editTitleArea", titleArea).hide();
			$("#viewTitleArea", titleArea).show();
			$("#editFieldArea", fieldArea).hide();
			$("#viewFieldArea", fieldArea).show();
			
			$("#viewTitleArea > span", titleArea).html($("#editTitleArea > input[type=text]", titleArea).val());
			$("#viewFieldArea", fieldArea).children().remove();
			
			if (type != 'title' && type != 'combobox') {
				$("#editFieldArea", fieldArea).children().clone().appendTo($("#viewFieldArea", fieldArea));
				$("#viewFieldArea > #rowEditFieldArea", fieldArea).attr("id", "rowViewFieldArea");
			}
			
			switch (type) {
			case 'title' : 
				break;
			case 'text' : 
			case 'richtext' : 	
				$("#viewFieldArea > #rowViewFieldArea", fieldArea).children().each(function (index, obj) {
					if (type == 'text') {
						$("<input type=\"text\" name=\"" + fieldName + "\" style=\"width:" + _TEXT_WIDTH + ";\" />").attr("id", fieldName).val($(obj).val()).insertAfter(obj).attr("viewMode", viewMode);
					} else {
						$("<textarea name=\"" + fieldName + "\" style=\"width:" + _TEXTAREA_WIDTH + ";height:" + _TEXTAREA_HEIGHT + ";\" />").attr("id", fieldName).html($(obj).html()).insertAfter(obj).attr("viewMode", viewMode);
					}
					$(obj).remove();
				});
				break;
			case 'combobox' :
				$("#viewFieldArea > #rowViewFieldArea > select", fieldArea).remove();
				//make select tag
				$("#viewFieldArea", fieldArea).append("<div id=\"rowViewFieldArea\"><select name=\"" + fieldName + "\" id=\"" + fieldName + "\" /></div>");
				$("#viewFieldArea > select", fieldArea).attr("id", fieldName).attr("viewMode", viewMode);
				//make option tag
				$($("#editFieldArea > #rowEditFieldArea", fieldArea).children()).each(function(index, obj) {
					if ($(obj).attr("type") == "text" && !$(obj).attr("disabled")) {
						$("#viewFieldArea > #rowViewFieldArea > select", fieldArea).append("<option>");
						$("#viewFieldArea > #rowViewFieldArea >select > option:last-child", fieldArea).attr("text", $(obj).val());
						$("#viewFieldArea > #rowViewFieldArea >select > option:last-child", fieldArea).attr("value", $(obj).val());
					}
				});
				break;
			case 'checkbox' : 
			case 'radio' : 
				$("#viewFieldArea > #rowViewFieldArea", fieldArea).children().each(function (index, obj) {
					var tagName = $(obj).attr("tagName").toLowerCase();
					var tagType = $(obj).attr("type").toLowerCase();
					if (tagName == "a") {
						$(obj).remove();
					} else if (tagName == "input") {
						if (tagType == "text") {
							var span = $("<span>").insertAfter(obj);
							$(span).html($(obj).val());
						} else {
							$("<input type=\"" + type + "\" name=\"" + fieldName + "\" />").attr("id", fieldName).val($(obj).val()).insertAfter(obj).attr("viewMode", viewMode);;
						}
						$(obj).remove();
					}
				});
				break;
			case 'googlemap' :
				$("#viewFieldArea > #rowViewFieldArea", fieldArea).children().each(function (index, obj) {
					var tagName = $(obj).attr("tagName").toLowerCase();
					if (tagName == "img" || tagName == "image") {
						var customTagHtml = "<input:" + type + " name='" + fieldName + "' viewmode='" + viewMode + "'></input:" + type + ">";
						$("<div id=\"fakeRowViewFieldArea\"/>").insertAfter(obj).html(customTagHtml).hide();
					}
				});
				break;
			case 'finduser' :
			case 'calendartag' :
			case 'fileupload' :
				$("#viewFieldArea > #rowViewFieldArea", fieldArea).children().each(function (index, obj) {
					var tagName = $(obj).attr("tagName").toLowerCase();
					if (tagName == "img" || tagName == "image") {
						var customTagHtml = "<input:" + type + " name='" + fieldName + "' viewmode='" + viewMode + "'" + fieldAttributeKey + "='" + fieldAttribute + "'></input:" + type + ">";
						$("<div id=\"fakeRowViewFieldArea\"/>").insertAfter(obj).html(customTagHtml).hide();
					}
				});
				break;
			case 'separator' :
				break;
			}
			//li resizing...
			refreshRowHeight(li, true);
			//ul resizing
			refreshGroupHeight($(li).parent());
		} else {
			$(attributeArea).show();
			$("#viewTitleArea", titleArea).hide();
			$("#editTitleArea", titleArea).show();
			$("#viewFieldArea", fieldArea).hide();
			$("#editFieldArea", fieldArea).show();
			
			//close edit mode of siblings
			$(li).siblings().each(function (rowIndex, row) {
				if ($(row).attr("rowStatus") != "current" && $("#menuArea > #editRow", row).attr("value") == _DONE_BTN_TAG) {
					$("#menuArea > #editRow", row).click();
				}
			});
			
			//close edit mode of other ul 
			$(li).parent().siblings("ul").each(function (ulIndex, sul) {
				$(sul).children("li").each(function (liIndex, oli) {
					if ($("#menuArea > #editRow", oli).attr("value") == _DONE_BTN_TAG) {
						$("#menuArea > #editRow", oli).click();
					}
				});
			});
			
			//li resizing...
			refreshRowHeight(li, false);
			//ul resizing...
			refreshGroupHeight($(li).parent());
		}
		$(btn).html(isDone ? _EDIT_BTN_TAG : _DONE_BTN_TAG);
		$(btn).attr("value", isDone ? _EDIT_BTN_TAG : _DONE_BTN_TAG);
	};

	this.addRow = function (btn) {
		var nextLi = null;
		if (btn) {
			var li = $(btn).parent().parent();
			var attributeArea = $("#attributeArea", li);
			var fieldName = $("input[name=_fieldName]", attributeArea).val();
			var type = $("select[name=_fieldType]", attributeArea).val(); 
			if (!(type == "title" || type == "separator") && $.trim(fieldName) == "") {
				alert("[" + $("span[id=_fieldNameTitle]", attributeArea).html() + "] " + _MSG_INPUT_REQUIRED);
				$("input[name=_fieldName]", attributeArea).focus();
				return;
			}
			// copy current row 
			nextLi = $(li).clone(true).insertAfter(li);
			$("#titleArea > #editTitleArea", nextLi).show();
			$("#titleArea > #viewTitleArea > span", nextLi).html(null);
			$("#titleArea > #editTitleArea > input[type=text]", nextLi).val(null);
			$("#fieldArea", nextLi).hide();
			$("#attributeArea > select[name=_fieldType]", nextLi).val(_DEFAULT_TYPE);
			$("#attributeArea > input[name=_fieldName]", nextLi).val(null);

			//li resizing...
			refreshRowHeight(nextLi, false);
			
			if ($("#menuArea > #editRow", li).attr("value") == _DONE_BTN_TAG) {
				$("#menuArea > #editRow", li).click();
			} else {
				$("#menuArea > #editRow", nextLi).click();
			}
		} else {
			//initialize...
			nextLi = $("<li class=\"ui-state-default\"/>").insertAfter("#" + this.id + " > ul > #groupArea");
			$(nextLi).append(menu).append(titleAreaTemplate).append(fieldAreaTemplate).append(attributeAreaTemplate);
			
			//attach event
			this.attachFrameMenuEvent(nextLi);
			this.attachFieldTypeEvent(nextLi);
			this.attachTitleMenu(nextLi);
		}
		
		$("#attributeArea > input[name=_fieldName]", nextLi).hide();
		$("#attributeArea > span[id=_fieldNameTitle]", nextLi).hide();
		$("#attributeArea > input[name=_fieldViewMode]", nextLi).hide();
		$("#attributeArea > span[id=_fieldViewModeTitle]", nextLi).hide();
		$("#attributeArea > select[name=_fieldAttribute]", nextLi).hide();
		$("#attributeArea > span[id=_fieldAttributeTitle]", nextLi).hide();
		
		//ul resizing
		refreshGroupHeight($(nextLi).parent());
	};
	
	this.removeRow = function (btn) {
		var li = $(btn).parent().parent();
		var ul = $(li).parent();
		if ($(ul).children("li").length > 1 || $(ul).siblings().children("li").length > 0) {
			$(li).remove();
		}
		
		if ($(ul).children("li").length == 0) {
			$(ul).remove();
		} else {
			//ul resizing
			refreshGroupHeight(ul);
		}
	};

	this.addLeftIndent = function (obj) {
		var li = $(obj).parent().parent();
		var margin = parseInt($(li).css("margin-left"));
		margin = isNaN(margin) ? 0 : margin;
		var indent = margin <= _INDENT_SIZE ? margin : _INDENT_SIZE;
		if (margin > 0) {
			margin -= indent;
			$(li).css("margin-left", margin);
		}
	};

	this.addRightIndent = function (obj) {
		var li = $(obj).parent().parent();
		var margin = parseInt($(li).css("margin-left"));
		margin = isNaN(margin) ? 0 : margin;
		margin += _INDENT_SIZE;
		if (_INDENT_SIZE < $(li).width()) {
			$(li).css("margin-left", margin);
		}
	};
	
	this.setFrameLayout = function (selector) {
		var html = "<div id=\"addGroupMenu\" style=\"width:100%;text-align:right;margin-right:13px;\" class=\"ui-state-disabled\">"
				+ "<a id=\"addGroup\" style=\"cursor:pointer;padding-right:3px;\" >" + _ADD_GROUP_BTN_TAG + "</a>"
				+ "</div>";
		$(selector).append(html);
		//attach addGroup button event
		$("#addGroupMenu > #addGroup", selector).bind('click', function() {
			var nextUl = null;
			if($(selector + "> ul:last-child").length == 0) {
				nextUl = $("<ul>").insertBefore(selector + "> #addGroupMenu");
			} else {
				nextUl = $("<ul>").insertAfter(selector + "> ul:last-child");
			}
			
			$(nextUl).html(groupTemplate);
			$(nextUl).css({"border":"solid 1px gray", "margin":"25px 0 15px 0","padding":"10px"});
			$(nextUl).sortable({axis:'y', 
								connectWith: "ul", 
								items: "li:not(.ui-state-disabled)",
								placeholder: "ui-state-highlight",
								receive: function(event, ui) {
									var height = 0;
									$(this).children().each(function (index, li) {
										height += $(li).height();
									});
									$(this).height(height);
									$("#groupMenuArea", this).hide();
								},
								remove : function(event, ui) {
									var height = 0;
									if ($(this).children("li").length == 0) {
										$(this).remove();
									} else {
										$(this).children().each(function (index, li) {
											height += $(li).height();
										});
										$(this).height(height);
									}
								}
			});
			
			$("#groupMenuArea > a", nextUl).bind('click', function() {
				$(nextUl).remove();
			});
			
			if($(selector + " > ul").length == 1) {
				$("#groupMenuArea", nextUl).hide();
			}
		});
		$("#addGroupMenu > #addGroup", selector).click();
	};	
	
	//ul resizing
	var refreshGroupHeight = function(ul) {
		var height = 0;
		$(ul).children().each(function(rowIndex, row) {
			height += $(row).height();
		});
		$(ul).height(height);
	};

	//li resizing
	var refreshRowHeight = function(li, isView) {
		var mode = isView ? "view" : "edit";
		$(li).height($("#menuArea", li).height() 
				+ $("#titleArea > #" + mode + "TitleArea", li).height() 
				+  $("#fieldArea > #" + mode + "FieldArea", li).height()
				+  $("#attributeArea", li).height());
	};
};

SimpleEditor.prototype = {
	renderToDiv : function (divId) {
		this.id = divId;
		this.setFrameLayout("#" + divId);
		this.addRow();
		
		$("#" + this.id + " > ul").sortable({axis:'y', connectWith: "ul"});
	},
	renderEditToDiv : function (divId) {
		this.id = divId;
		
		this.attachFrameMenuEvent($(".ui-state-default"));
		this.attachFieldTypeEvent($(".ui-state-default"));
		this.attachTitleMenu($(".ui-state-default"));
		
		var objSimple = this;
		$(".ui-state-default").each(function (index, obj) {
			var attributeArea = $("#attributeArea", obj);
			
            var type = $("select[name=_fieldType]", attributeArea).val();

            if (type == "finduser" || type == "calendartag" || type == "fileupload") {
            	$("#menuArea > #editRow", obj).click();
            	$("#menuArea > #editRow", obj).click();
            }
		});
		$("#" + this.id + " > ul").sortable({axis:'y', connectWith: "ul"});
	},
	getEditModeContents : function () {
		var contentsObject = $("#" + this.id).clone();
		$("#viewTitleArea", contentsObject).remove();
		$("#viewFieldArea", contentsObject).remove();
		$("#viewGroupArea", contentsObject).remove();
		return $(contentsObject).html();
	},
	getAllModeContents : function () {
		var contentsObject = $("#" + this.id);
		$("#groupArea > #viewGroupArea", contentsObject).show();
		$("#groupArea > #editGroupArea", contentsObject).remove();
		
		$("#fieldArea > #viewFieldArea > #rowViewFieldArea > #fakeImage", contentsObject).remove();
		$("#fieldArea > #viewFieldArea > #rowViewFieldArea > #fakeRowViewFieldArea", contentsObject).children().unwrap();
		
		return replaceAll($(contentsObject).html());
	},
	getViewModeContents : function () {
		var contentsObject = $("#" + this.id).clone();
		$("#addGroupMenu", contentsObject).remove();
		$("#groupArea > #viewGroupArea > span", contentsObject).each(function(index, span) {
			$(span).html($(span).parent().siblings().children("input[type=text]").val());
		});
		$("#groupArea > #viewGroupArea", contentsObject).show();
		$("#groupArea > #editGroupArea", contentsObject).remove();
		$("#menuArea", contentsObject).remove();
		$("#editTitleArea", contentsObject).remove();
		$("#editFieldArea", contentsObject).remove();
		$("#fieldArea > #viewFieldArea > #rowViewFieldArea > #fakeImage", contentsObject).remove();
		$("#fieldArea > #viewFieldArea > #rowViewFieldArea > #fakeRowViewFieldArea", contentsObject).children().unwrap();
		$("#attributeArea", contentsObject).remove();
		return replaceAll($(contentsObject).html());
	},
	getAllContents : function () {
		//return $("#" + this.id).html();
		return this.getAllModeContents();
	},
	getContents : function () {
		return this.getViewModeContents();
	}
};

function replaceAll(string) {
    var x = ["\\<\\?XML:NAMESPACE PREFIX = INPUT \/\>", "INPUT:FINDUSER", "INPUT:FILEUPLOAD", "INPUT:CALENDARTAG", "INPUT:GOOGLEMAP"];
    var y = ["", "input:finduser", "input:fileupload", "input:calendartag", "input:googlemap"];

    for (var i=0; i < x.length; i++) {
    	var strip = new RegExp(x[i], "gi");
	    string = string.replace(strip, y[i]);
    }

    return string;
}