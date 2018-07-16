<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../scripts/jquery.jsp"%>
<link rel="stylesheet" type="text/css" href="http://static.jstree.com/v.1.0rc2/_docs/!style.css" />
<script type="text/javascript">
$(function () {
	$("#divDefTree").jstree({ 
		"json_data" : {
			"ajax" : {
				"url" : "processDefinitionListForParticipantJson_1.jsp",
				"data" : function (n) {
					var params = {};
                    
                    if (this._get_type(n)) {
                        switch (this._get_type(n)) {
                            case "folder":
                                params = {
                                    "id" : n.attr("id")
                                };
                                break;
                            default:
                                break;
                        }
                    }
                    
                    return params;
				}
			}
		},
		"plugins" : [ "themes", "json_data", "ui", "crrm", "cookies", "dnd", "search", "types", "hotkeys", "contextmenu" ],
		"theme" : "apple",
		"types" : {
			// I set both options to -2, as I do not need depth and children count checking
			// Those two checks may slow jstree a lot, so use only when needed
			"max_depth" : -2,
			"max_children" : -2,
			// I want only `drive` nodes to be root nodes 
			// This will prevent moving or creating any other type as a root node
			"valid_children" : [ "drive" ],
			"types" : {
				// The default type
				"file" : {
					// I want this type to have no children (so only leaf nodes)
					// In my case - those are files
					"valid_children" : "none",
					// If we specify an icon for the default type it WILL OVERRIDE the theme icons
					"icon" : {
						"image" : "http://www.jstree.com/static/v.1.0rc2/_demo/folder.png"
					},
					"select_node": function(n){
						$("#defId").val(this._get_node(n).attr("id"));
						$("#formTree").submit();
                        return true;
                    }
				},
				// The `folder` type
				"folder" : {
					// can have files and other folders inside of it, but NOT `drive` nodes
					"icon" : {
						"image" : "http://www.jstree.com/static/v.1.0rc2/_demo/folder.png"
					},
					"valid_children" : [ "file", "folder" ],
					"max_depth": -1,
                    "hover_node": false,
					"select_node": function(n){
						$("#defId").val(this._get_node(n).attr("id"));
						$("#formTree").submit();
                        return true;
                    }
				},
				// The `drive` nodes 
				"drive" : {
					// can have files and folders inside, but NOT other `drive` nodes
					"valid_children" : [ "default", "folder" ],
					"icon" : {
						"image" : "http://www.jstree.com/static/v.1.0rc2/_demo/root.png"
					},
					// those options prevent the functions with the same name to be used on the `drive` type nodes
					// internally the `before` event is used
					"start_drag" : false,
					"move_node" : false,
					"delete_node" : false,
					"remove" : false
				}
			}
		}
	});
});
</script>
</head>
<body>
<div id="divDefTree"></div>
<form name="formTree" id="formTree" action="test.jsp" target="innerworkarea" method="post">
	<input type="hidden" name="defId" id="defId" value=""/>
</form>
</body>
</html>