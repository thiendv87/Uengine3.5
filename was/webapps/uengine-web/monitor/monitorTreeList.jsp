<%@page import="org.uengine.ui.monitor.filter.MonitorFilterList"%>
<%@page import="org.uengine.ui.monitor.filter.MonitorFilter"%>
<%@page import="org.uengine.util.UEngineUtil"%>
<%
MonitorFilterList mfl = MonitorFilterList.load(loggedUserId);
MonitorFilter[] monitorFilters = mfl.getMonitorFilters();
%>

<script type="text/javascript">
<!--
function clearForm() {
    document.selectedItem.endpoint.value = "";
    document.selectedItem.processDefinitionId.value = "";
    document.selectedItem.processDefinitionName.value = "";
    document.selectedItem.orderby.value = "";
    document.selectedItem.status.value = "";
    document.selectedItem.partCode.value = "";
    document.selectedItem.roleCode.value = "";
    document.selectedItem.tag.value = "";
    document.selectedItem.filter.value = "";
    document.selectedItem.filterName.value = "";
}

function viewGanttChart(item, orderby) {
    clearForm();
    
    if (item != null) {
	    if (orderby == "resource") {                
	        document.selectedItem.endpoint.value = item.code;
	    } else if (orderby == "instance") {
	        document.selectedItem.processDefinitionId.value = item.id;
	        document.selectedItem.processDefinitionName.value = item.name;
	    }
    }
    
    document.selectedItem.filter.value = "no";
    
    document.selectedItem.orderby.value = orderby;
    document.selectedItem.submit();
}

function addFilter(){
    var url = "../processparticipant/commonfilter/monitor/dlgMonitorAddFilter.jsp";
    window.open(url,'','top=100,left=100,width=600,height=470,scrollbars=no');
}

function deleteFilter(UID){
    result = confirm("Are you sure to delete this filter?");
    if(result==true){
        var url = "../processparticipant/commonfilter/monitor/deleteMonitorFilter.jsp?filterUID="+UID;
        window.open(url,'','top=100,left=100,width=600,height=300,resizable=true,scrollbars=yes');
    }
}

function filterGanttChart(defId, status, partCode, roleCode, tag, defName, filterName) {
	clearForm();
	
    document.selectedItem.orderby.value = "instance";
    document.selectedItem.processDefinitionId.value = defId;
    document.selectedItem.status.value = status;
    document.selectedItem.partCode.value = partCode;
    document.selectedItem.roleCode.value = roleCode;
    document.selectedItem.tag.value = tag;
    document.selectedItem.processDefinitionName.value = defName;
    document.selectedItem.filter.value = "yes";
    document.selectedItem.filterName.value = filterName;
    
    document.selectedItem.submit();
}
//-->
</script>

<div class="soria">

<!-- Json -->
<div dojoType="dojo.data.ItemFileWriteStore" jsId="organizationUserStore" url="../organizationmanager/organizationUserListJson.jsp"></div>
<div dojoType="dojo.data.ItemFileReadStore" jsId="continentStore" url="../processparticipant/processListForParticipantJson.jsp"></div>
<div dojoType="dijit.tree.ForestStoreModel" jsId="continentModel" store="continentStore" rootId="continentRoot" rootLabel="Definitions" childrenAttrs="children"></div>

<div dojoType="dijit.layout.LayoutContainer" style="height: 100%;">
        <div dojoType="dijit.layout.AccordionContainer" layoutAlign="client">
    
        <div dojoType="dijit.layout.AccordionPane" title="<%=GlobalContext.getMessageForWeb("monitor.instance", loggedUserLocale) %>">
            <div dojoType="dijit.Tree" id="tree2" model="continentModel" showRoot="true" onClick="true">
                    <script type="dojo/method" event="getIconClass" args="item, opened">
                        if (item == this.model.root) {
                            ObjType = "definition";
                        } else if(item.obj == "folder") {
                            ObjType = "folder";
                        } else {
                            ObjType = item.obj;
                        }
           
                        if (ObjType == "folder") {
                            ObjType = opened ? "folderOpenIcon" : "folderClosedIcon";
                        } else {
                            ObjType += "Icon";
                        }

                        return ObjType;
                    </script>
                    <script type="dojo/method" event="onClick" args="item">
                        if(item == this.model.root){
                            viewGanttChart(null, "instance");
                        }
                        if (item.obj != "folder") {
                            viewGanttChart(item, "instance");
                        }
                    </script>
            </div>
        </div>
        
        <!-- User manage Accodion -->
        <div dojoType="dijit.layout.AccordionPane" title="<%=GlobalContext.getMessageForWeb("monitor.user", loggedUserLocale) %>">
            <div dojoType="dijit.Tree" id="userList" store="organizationUserStore" childrenAttr="children" query="{type:'com'}" label="<%=GlobalContext.getLocalizedMessageForWeb("user",loggedUserLocale,"User") %>">
                <script type="dojo/method" event="getIconClass" args="item, opened">
                    var IconType="main";
                    if(item != null){
                        if (item.type == "main"){
                            IconType = "main";
                        } else {
                            IconType = item.type;
                        }
                    }

                    if (IconType == "main") {
                        IconType = opened ? "customFolderOpenedIcon" : "customFolderClosedIcon";
                    } else if(IconType == "com") {
                        IconType = "comIcon";
                    } else if(IconType == "dept") {
                        IconType = "deptIcon";
                    } else {
                        IconType = "userIcon";
                    }

                    return IconType;
                </script>
                <script type="dojo/method" event="onClick" args="item">
                    if (item.type == 'user') {
                        viewGanttChart(item, "resource");
                    }
                </script>
            </div>          
        </div>

        <div dojoType="dijit.layout.AccordionPane" title="<%=GlobalContext.getMessageForWeb("monitor.filter", loggedUserLocale) %>" class="menuList">
<%
            String defId = null;
            String status = null;
            String partCode = null;
            String roleCode = null;
            String tag = null;
            String defName = null;
            
            for (int i=0; i<monitorFilters.length; i++) {
                defId = monitorFilters[i].getDefinition();
                status = monitorFilters[i].getStatus();
                partCode = monitorFilters[i].getPartCode();
                roleCode = monitorFilters[i].getRoleCode();
                tag = monitorFilters[i].getTag();
                defName = monitorFilters[i].getDefinitionName();
%>
            <ul id="dojoList" >
                <li>
                    <a href="#" onclick="filterGanttChart('<%=defId%>', '<%=status%>', '<%=partCode%>', '<%=roleCode%>', '<%=tag%>', '<%=defName %>', '<%=monitorFilters[i].getFilterName()%>');"><%=monitorFilters[i].getFilterName()%></a>&nbsp;&nbsp;
                    <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/b_smalldel.gif" width="29" height="11" onClick="javascript:deleteFilter('<%=monitorFilters[i].getFilterUId()%>')" style="cursor:pointer; right:15px; position:absolute; ">
                </li>
            </ul>
<%
            }
%>
            <ul style=" border-bottom:1px dotted #CCCCCC; background:#FFF none; ">
                <li style=" background:#FFF none; border:none; padding:2px; cursor:pointer; text-align:center;" onClick="javascript:addFilter();">
                   <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/addfilter.gif" width="97" height="19"/>
                </li>
            </ul>
        </div>
    </div>
</div>        

<form name="selectedItem" action="ganttChart.jsp" method="post" target="innerworkarea">
    <input type="hidden" name="processDefinitionName" id="processDefinitionName" />
    <input type="hidden" name="processDefinitionId" id="processDefinitionId" />
    <input type="hidden" name="orderby" id="orderby" />
    <input type="hidden" name="endpoint" id="endpoint" />
    <input type="hidden" name="status" id="status" />
    <input type="hidden" name="partCode" id="partCode" />
    <input type="hidden" name="roleCode" id="roleCode" />
    <input type="hidden" name="tag" id="tag" />
    <input type="hidden" name="filter" id="filter" />
    <input type="hidden" name="filterName" id="filterName" />
</form>

</div>