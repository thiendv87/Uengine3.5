/**
 * @author erim1005
 */
var OrganizationTree = function(containerId, editAble){
    var container = document.getElementById(containerId),
    	dataURL = WEB_CONTEXT_ROOT + "/organizationmanager/datas/organizationDataForJtree.jsp",
		imagesFolder = WEB_CONTEXT_ROOT + "/processmanager/images";
		plugins = editAble ? ["themes", "json_data", "ui", "crrm", "dnd", "types", "hotkeys", "contextmenu"] : ["themes", "json_data", "ui", "crrm", "dnd", "types", "hotkeys"]
	;
    
    var tree = $("#divOrganizationTree").jstree({
        "plugins": plugins,
        "json_data": {
            "ajax": {
                "url": dataURL,
                "data": function(n){
                    var params = {};
                    
                    if (this._get_type(n)) {
                        switch (this._get_type(n)) {
                            case "company":
                                params = {
                                    comCode: n.attr("code")
                                };
                                break;
                            case "department":
                                params = {
                                    parentCode: n.attr("code")
                                };
                            default:
                                break;
                        }
                    }
                    
                    return params;
                }
            }
        },
        "types": {
            "max_depth": -2,
            "max_children": -2,
            "valid_children": ["company"],
            "types": {
                "company": {
                    "icon": {
                        "image": imagesFolder + "/obj_icon_company.png"
                    },
                    "valid_children": ["department", "user"],
                    "max_depth": -1,
                    "hover_node": false,
                    "select_node": function(){
                        return true;
                    }
                },
                "department": {
                    "icon": {
                        "image": imagesFolder + "/obj_icon_quarter.png"
                    },
                    "valid_children": ["department", "user"],
                    "max_depth": -1,
                    "hover_node": false,
                    "select_node": function(n){
                        getUserList("partcode", this._get_node(n).attr("code"), "tableUserList", IS_MULTIPLE, IS_APPROVAL);
                        try {
                            document.getElementById("chkBoxAllUsers").checked = false;
                        } 
                        catch (e) {
                        }
                        return true;
                    }
                },
                "user": {
                    "icon": {
                        "image": imagesFolder + "/obj_icon_user.png"
                    },
                    "valid_children": "none",
                    "max_depth": -1,
                    "hover_node": false,
                    "select_node": function(n){
                        //							var id = item.code;
                        //							var name = item.name;	
                        //							var jikname= item.jikname;	
                        //							
                        //							adduser(id, name, jikname);
                        return true;
                    }
                }
            }
        }
    });
}
