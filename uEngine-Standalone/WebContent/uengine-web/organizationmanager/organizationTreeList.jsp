<%@page import="org.uengine.util.UEngineUtil"%>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/ajax/ajaxCommon.js"></script>
<script type="text/javascript">
        var listtype = "1";
        
        function allRoleList(){
            document.selectedItem.type.value = 'all';
            document.selectedItem.objType.value = 'role';
            document.selectedItem.submit();
        }
        
        function selectedGroup(viewType, item) {
            var groupForm = document.selectedItem;
            
            if (viewType == "department")
            {
                groupForm.action = "organizationListDetail.jsp";
            }
            else if (viewType == "role")
            {
                groupForm.action = "organizationRoleList.jsp";
            }
            document.selectedItem.type.value = item.type;
            document.selectedItem.objType.value = item.objType;
            document.selectedItem.code.value = item.code;
            document.selectedItem.itemName.value = item.name;
            document.selectedItem.comCode.value = item.comcode;
            document.selectedItem.submit();
        }
        
        function addUser(item){
            document.addUser.groupCode.value = item.code;
            document.addUser.groupName.value = item.name;
            document.addUser.comName.value = item.comname;
            document.addUser.comCode.value = item.globalcom;
            document.addUser.isModification.value = "false";
            document.addUser.submit();
        }
        
        function addGroup(item){
            document.addGroup.comCode.value = item.globalcom;
            document.addGroup.comName.value = item.name;
            document.addGroup.type.value = item.type;
            document.addGroup.parent.value = item.code;
            document.addGroup.submit();
        }
        
        function addRole(item){
            document.addRole.comCode.value = item.globalcom;
            document.addRole.submit();
        }
        
        function addUserToSelectedRole(item)
        {
            var childrenUser = new Array();
            
            if (item.children != undefined)
            {
                var childrenSize = item.children.length;
                
                for(var i = 0; i < childrenSize; i++)
                {
                    childrenUser[i] = item.children[i].code;    
                }
            }
            //document.addUserToSelectedRole.roles.value = roles;
            document.addUserToSelectedRole.mappedUser.value = childrenUser;
            document.addUserToSelectedRole.comCode.value = item.globalcom;
            document.addUserToSelectedRole.selectedRole.value = item.code;
            document.addUserToSelectedRole.submit();
        }
        
        function deleteObject(itemType, item){
            if (itemType == 'department' && item.children != undefined)
            {
                alert("This group have users, delete users first...");
            }
            else
            {
                if (confirm("Sure?"))
                {
                    if (itemType == 'roleUser')
                    {
                        document.deleteObject.roleCode.value = item.rolecode;
                        document.deleteObject.comCode.value = item.comcode;
                    }
                    else
                    {
                        document.deleteObject.comCode.value = item.globalcom;
                    }
                    
                    document.deleteObject.itemType.value = itemType;
                    document.deleteObject.itemId.value = item.code;
                    
                    document.deleteObject.submit();
                }
            }
        }
        
        function selectedUser(item){
            var id = "" + (item.code);
            var splitedId;
            var selectedId;
            if(id.indexOf(":") > 0){
                splitedId = id.split(":");
                selectedId = splitedId[1];
            }else{
                selectedId = id;
            }
            window.innerworkarea.location.href = "userInfo.jsp?empCode=" + selectedId;
        }


        var appendChildNodeToTree = function(item, treeStore, resultString)
        {
            var arrayOfResult = new Array();
            arrayOfResult = eval(resultString);
            
            for (var i = 0; i < arrayOfResult.length; i++)
            {
                var result = arrayOfResult[i];
                
                if (result.discription != undefined)
                {
                    result.discription = decodeURIComponent(result.discription);
                }
                
                if (result.name != undefined)
                {
                    result.name = decodeURIComponent(result.name);
                }
                
                var newItem = treeStore.newItem(result, {parent : item, attribute : "children"});

                if (result.partname != undefined)
                {
                    //result.partname = (decodeURIComponent(result.partname).encodeHtml();
                    result.partname = decodeURIComponent(result.partname);
                }

                if (result.type != "user")
                {
                    try
                    {
                        var tempChild = {code : "temp_" + i + result.type + "_" + result.code, name : "tempChildrenForItem", type : "temp"};
                        if(parseInt(result.cnt) > 0)
                            treeStore.newItem(tempChild, {parent : newItem, attribute : "children"});
                    }
                    catch(e)
                    {
                        alert(result.name);
                    }
                }
            }
        }

        function getDepartmentList(item)
        {
            var param = null;
            var firstChild = item.children[0];
            if ("temp" == firstChild.type)
            {
                organizationUserStore.deleteItem(firstChild);
                var url = WEB_ROOT + "/organizationmanager/json/getDepartmentsWithUsersToJson.jsp?";
                
                if (item.type == "company")
                {
                    param = "comCode=" + item.code;
                }
                else if(item.type == "department")
                {
                    param = "parentCode=" + item.code;
                }
                
                submitAjaxServlet(
                        url,
                        "POST",
                        function (resultString) {
                            appendChildNodeToTree(item, organizationUserStore, resultString);
                        },
                        param
                );
            }
        }


        function getRleList(item)
        {
            var param = null;
            var firstChild = item.children[0];
            
            if ("tempChildrenForItem" == firstChild.name)
            {
                organizationRoleStore.deleteItem(firstChild);
                var url = WEB_ROOT + "/organizationmanager/json/roleUsersToJson.jsp?";
                
                if (item.type == "company")
                {
                    param = "comCode=" + item.code;
                }
                else if(item.type == "role")
                {
                    param = "roleCode=" + item.code;
                }
                
                submitAjaxServlet(
                        url,
                        "POST",
                        function (resultString) {
                            appendChildNodeToTree(item, organizationRoleStore, resultString);
                        },
                        param
                );
            }
        }
        
        function viewinfo(item){
            if (item.type == 'user') {
                selectedUser(item);
            } else {
                selectedGroup("department", item);
            }
        }
        
     </script>

<div class="soria">

<!-- Json -->
<div dojoType="dojo.data.ItemFileWriteStore" jsId="organizationUserStore" url="json/jsonConfig.json"></div>
<div dojoType="dijit.tree.ForestStoreModel" jsId="organizationUserModel" store="organizationUserStore" childrenAttrs="children" ></div>
               
<div dojoType="dojo.data.ItemFileWriteStore" jsId="organizationRoleStore" url="json/jsonConfig.json"></div>

<!-- Menu -->
<ul dojoType="dijit.Menu" id="user_menu" style="display: none;">
    <li dojoType="dijit.MenuItem" onClick="listtype='1';addGroup(global_tn.item);">Add Group</li>
    <li dojoType="dijit.MenuItem" onClick="listtype='1';deleteObject('department', global_tn.item);">Delete Group</li>
    <li dojoType="dijit.MenuItem" onClick="listtype='1';addUser(global_tn.item);">Add user</li>
    <li dojoType="dijit.MenuItem" onClick="listtype='1';deleteObject('groupUser', global_tn.item);">Delete user</li>
    <li dojoType="dijit.MenuItem" onClick="listtype='1';document.location.reload()">Refresh</li>
    <li dojoType="dijit.MenuItem" onClick="listtype='1';viewinfo(global_tn.item);">View Info</li>
</ul>

<ul dojoType="dijit.Menu" id="role_menu" style="display: none;">
    <li dojoType="dijit.MenuItem" onClick="listtype='2';addRole(global_tn.item);">Add Role</li>
    <li dojoType="dijit.MenuItem" onClick="listtype='2';deleteObject('role', global_tn.item);">Delete Role</li>
    <li dojoType="dijit.MenuItem" onClick="listtype='2';addUserToSelectedRole(global_tn.item);">Add User</li>
    <li dojoType="dijit.MenuItem" onClick="listtype='2';deleteObject('roleUser', global_tn.item);">Delete User</li>
    <li dojoType="dijit.MenuItem" onClick="listtype='2';document.location.reload()">Refresh</li>
</ul>

<%  
    String listtype=request.getParameter("listtype");
    String selectedList = "true";
    String userList = "false";
    String roleList = "false";
    if("2".equals(listtype))
        roleList = selectedList;
    else
        userList = selectedList;
%>
<div dojoType="dijit.layout.LayoutContainer" style="height: 100%;">
    <div dojoType="dijit.layout.AccordionContainer" layoutAlign="client">
        <!-- User manage Accordion -->
        
        <div dojoType="dijit.layout.AccordionPane"  selected=<%=userList %> title="<%=GlobalContext.getLocalizedMessageForWeb("user_manager",loggedUserLocale,"User manager") %>">
            <div dojoType="dijit.Tree" id="userListTree" model="organizationUserModel" showRoot="false" openOnClick="false" >
                <script type="dojo/connect">
                var menuEmpty = dijit.byId("user_menu");
                
                menuEmpty.bindDomNode(this.domNode);
                
                dojo.connect(menuEmpty, "_openMyself", this, function(e) {
                    global_tn = dijit.getEnclosingWidget(e.target);

                    if (
                            global_tn.item.type != "user"
                            && global_tn.item.type != "department"
                            && global_tn.item.type != "company"
                    ) {
                        menuEmpty.getChildren().forEach(function(i) {
                            if (
                                    i.id == "dijit_MenuItem_1" 
                                    || i.id == "dijit_MenuItem_2"
                                    || i.id == "dijit_MenuItem_3"
                                    || i.id == "dijit_MenuItem_5"
<% if (!loggedUserIsMaster) { %>|| i.id == "dijit_MenuItem_0"<% } else { %>|| i.id == "dijit_MenuItem_3"<% } %>
                            ) {
                               i.setDisabled(true); 
                            } else {
                               i.setDisabled(false); 
                            }
                        });
                    } else if (global_tn.item.type == "company") {
                        menuEmpty.getChildren().forEach (
                            function(i) {
                                if (i.id == "dijit_MenuItem_2" || i.id == "dijit_MenuItem_3" || i.id == "dijit_MenuItem_5") {
                                    i.setDisabled(true);
                                } else {
                                    i.setDisabled(false);
                                }
                            }
                        );
                    } else if (global_tn.item.type == "department") {
                        menuEmpty.getChildren().forEach (
                            function(i) {
                                if (i.id == "dijit_MenuItem_3") {
                                    i.setDisabled(true);
                                } else {
                                    i.setDisabled(false);
                                }
                            }
                        );
                    } else if (global_tn.item.type == "user") {
                        menuEmpty.getChildren().forEach(function(i){
                            if (i.id == "dijit_MenuItem_0" || i.id == "dijit_MenuItem_1" || i.id=="dijit_MenuItem_2") {
                                i.setDisabled(true);
                            } else {
                                i.setDisabled(false);
                            }
                        });
                    }
                });
                </script>
                <script type="dojo/method" event="onClick" args="item">
                    if (item.type == 'user') {
                        selectedUser(item);
                    } else {
                        selectedGroup("department", item);
                    }
                </script>
                <script type="dojo/method" event="getIconClass" args="item, opened">
                    var ObjType="";
                    
                    if (item == this.model.root) {
                        ObjType = "organization";
                    } else if (organizationUserStore.getValue(item, "type") == "root") {
                        ObjType="organization";
                    } else {
                        ObjType = organizationUserStore.getValue(item, "type");
                    }
                    
                    if (ObjType == "user") {
                        ObjType = "userIcon";
                    } else if (ObjType == "company") {
                        ObjType = "comIcon";
                    } else if (ObjType == "department") {
                        ObjType = "deptIcon";
                    } else if (ObjType == "organization") {
                        ObjType = "organizationIcon";
                    } else {
                        ObjType = opened ? "folderOpenIcon" : "folderClosedIcon";
                    }
                    
                    return ObjType;
                </script>
                <script type="dojo/method" event="onOpen" args="item, node">
                    getDepartmentList(item);
                </script>
            </div>
        </div>

        <div dojoType="dijit.layout.AccordionPane" selected=<%=roleList %> title="<%=GlobalContext.getLocalizedMessageForWeb("role_manager", loggedUserLocale, "Role manager") %>">
            <div dojoType="dijit.Tree" id="roleList" store="organizationRoleStore" childrenAttr="children" showRoot="false" openOnClick="false" >
                <script type="dojo/connect">
                var menuEmpty = dijit.byId("role_menu");
                
                menuEmpty.bindDomNode(this.domNode);
                
                dojo.connect(menuEmpty, "_openMyself", this, function(e)
                {
                    global_tn = dijit.getEnclosingWidget(e.target);
                    var itemType = global_tn.item.type;
                    
                    if(itemType != "role" && itemType != "user") {
                        menuEmpty.getChildren().forEach(function(i){ 
                            if(i.id=="dijit_MenuItem_7" || i.id=="dijit_MenuItem_9"){
                               i.setDisabled(true); 
                             }else{
                               i.setDisabled(false); 
                             }
                        });
                    }else if(itemType == "role"){
                        menuEmpty.getChildren().forEach(function(i){
                            if(i.id == "dijit_MenuItem_6" || i.id=="dijit_MenuItem_9" ){
                                i.setDisabled(true);
                            }else{
                                i.setDisabled(false);
                            }
                        });
                    }else if(itemType == "user"){
                        menuEmpty.getChildren().forEach(function(i){
                            if(i.id == "dijit_MenuItem_6" || i.id == "dijit_MenuItem_7" || i.id=="dijit_MenuItem_8"){
                                i.setDisabled(true);
                            }else{
                                i.setDisabled(false);
                            }
                        });
                    }
                });
                </script>
                <script type="dojo/method" event="onClick" args="item">
                    if(item.type == "user")
                    {
                        selectedUser(item);
                    }
                    else
                    {
                        selectedGroup("role", item);
                    }
                </script>
                <script type="dojo/method" event="onOpen" args="item, node">
                    getRleList(item);
                </script>
                <script type="dojo/method" event="getIconClass" args="item, opened">
                    var IconType="";
                    if(item != null){
                        if(item.type == "root"){
                            IconType = "organizationIcon";
                        } else if(item.type == "company"){
                            IconType = "comIcon";
                        } else if (item.type == "role") {
                            IconType = "roleIcon";
                        } else if (item.type == "user") {
                            IconType = "userIcon";
                        } else {
                            IconType = opened ? "customFolderOpenedIcon" : "customFolderClosedIcon";
                        }
                    }

                    return IconType;
                </script>
            </div>
        </div>
    </div>
</div>

<form name="selectedItem" action="organizationListDetail.jsp" method="post" target="innerworkarea">
    <input type="hidden" name="type" />
    <input type="hidden" name="objType" />
    <input type="hidden" name="code" />
    <input type="hidden" name="itemName" />
    <input type="hidden" name="roleCode" />
    <input type="hidden" name="comCode" />
</form>

<form name="addUser" action="addUser.jsp" method="post" target="innerworkarea">
    <input type="hidden" name="groupCode" />
    <input type="hidden" name="groupName" />
    <input type="hidden" name="comCode" />
    <input type="hidden" name="comName" />
    <input type="hidden" name="isModification" />
</form>

<form name="addGroup" action="addGroup.jsp" method="post" target="innerworkarea">
    <input type="hidden" name="comCode" />
    <input type="hidden" name="comName" />
    <input type="hidden" name="parent" />
    <input type="hidden" name="type" />
</form>

<form name="addRole" action="addRole.jsp" method="post" target="innerworkarea">
    <input type="hidden" name="comCode" />
</form>

<form name="addUserToSelectedRole" action="addUserToSelectedRole.jsp" method="post" target="innerworkarea">
    <input type="hidden" name="roles" />
    <input type="hidden" name="comCode" />
    <input type="hidden" name="mappedUser" />
    <input type="hidden" name="selectedRole" />
</form>

<form name="deleteObject" action="deleteObjectAction.jsp" method="post" target="innerworkarea">
    <input type="hidden" name="itemType" />
    <input type="hidden" name="itemId" />
    <input type="hidden" name="roleCode" />
    <input type="hidden" name="comCode" />
</form>

</div>