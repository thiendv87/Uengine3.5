<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<%
	int sepCount = -1; // default seperator count;
	
	Cookie[] cookies = request.getCookies();
	if ( cookies != null && cookies.length > 0 ) {
		for (int i=0; i<cookies.length; i++) {
			if ("cookieProcessMap1Col".equals(cookies[i].getName())) {
				sepCount = Integer.parseInt(cookies[i].getValue());
				break;
			}
		}
	}
	
	if (sepCount == -1) {
		sepCount = 3;
	}
	
	String strategyId = request.getParameter("strategyId");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%@page import="javax.sql.DataSource"%>
<%@page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@page import="org.uengine.ui.tree.model.Item"%>

<%@page import="org.uengine.ui.tree.dao.ProcessDefinitionListDAO"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
	
	<title>Process Map</title>
	<link rel="stylesheet" type="text/css" href="../style/default.css" />

	<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
	
	<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/crossBrowser/elementControl.js"></script>
	<script type="text/javascript">
		var sepCount = <%=sepCount%>;
		var strategyId = "<%=strategyId%>";
		
		var rootTableId = "tdProcessMapArea";

		function getSize(iDep) {
			var strSize = "6px";
			if (iDep > 0) {
				strSize = "3px"
			}

			return strSize;
		}

		function getImageHeadName(iDep) {
			var sName = "ps";
			if (iDep > 0) {
				sName += "_inner"
			}
			
			return sName;
		}

		function getNewCell(eParentTable, iDep) {
			var eParentRow = null;
			var eParentCell = null;

			if (iDep > 0) {
				// 루트테이블이 아닐 경우에 대한 설정
				if (
						eParentTable.rows.length == 0
						|| eParentTable.rows[eParentTable.rows.length - 1].cells.length > (sepCount + 1)
				) {
					// create new row.
					eParentRow = appendRow(eParentTable);
					
					addStartLineCell(eParentRow, iDep - 1);
					eParentCell = appendCell(eParentRow);
					eParentCell.colSpan = sepCount.toString();
					addEndLineCell(eParentRow, iDep - 1);
					
				} else {
					// add new cell to row
					eParentRow = eParentTable.rows[eParentTable.rows.length - 1];

					//var tmpColorForDebug = eParentTable.style.backgroundColor;
					//eParentTable.style.backgroundColor = "red";
					//alert("else : " + iDep);
					//eParentTable.style.backgroundColor = tmpColorForDebug;
					
					var cells = eParentRow.cells;
					var oldSpan = cells[cells.length - 2].colSpan;
					cells[cells.length - 2].colSpan = "1";
					
					eParentCell = appendCellWithIndex(eParentRow, eParentRow.cells.length - 1);
					eParentCell.colSpan = (parseInt(oldSpan) - 1);
				}
			} else {
				// 루트테이블에 대한 설정 : 루트테이블은 tFoot 이 없다.
				if (getCellCount(eParentTable) % (sepCount) == 0) {
					eParentRow = appendRow(eParentTable);
					eParentCell = appendCell(eParentRow);
					eParentCell.colSpan = sepCount.toString();
				} else {
					eParentRow = eParentTable.rows[eParentTable.rows.length - 1];
					var cells = eParentRow.cells;
					cells[cells.length - 1].colSpan = "1";

					eParentCell = appendCellWithIndex(eParentRow, eParentRow.cells.length);
					eParentCell.colSpan = "1";
				}
			}
			
			return eParentCell;
		}

		function addFolderTitleCell(sHtml, eRow, iDep) {
			addStartLineCell(eRow, iDep);
			
			eTd = appendCell(eRow);
			eTd.colSpan = sepCount.toString();
			eTd.align = "center";

			if (iDep > 0) {
				eTd.style.padding = "0px;";
				eTd.style.height = "21px";
				eTd.style.backgroundImage = "url(../images/Common/ps_2d_bg.gif)";
			} else {
				eTd.className = "pstitle";
			}
			
			var eSepRow = appendRowWithIndex(eRow.parentNode, eRow.rowIndex + 1);
			addStartLineCell(eSepRow, iDep);
			var eSepCell = appendCell(eSepRow);
			addEndLineCell(eSepRow, iDep);
			
			eSepCell.style.height = "1px";
			eSepCell.colSpan = sepCount.toString();
			
			eTd.innerHTML =  sHtml ;
			addEndLineCell(eRow, iDep);
			
			return eTd;
		}

		function addStartLineCell(eRow, iDep) {
			var eTd = appendCellWithIndex(eRow, 0);
			
			eTd.style.width = getSize(iDep)
			eTd.style.backgroundImage = "url(../images/Common/" + getImageHeadName(iDep) + "_table_line_L.gif)";
		}

		function addEndLineCell(eRow, iDep) {
			var eTd = appendCell(eRow);

			eTd.style.width = getSize(iDep);
			eTd.style.backgroundImage = "url(../images/Common/" + getImageHeadName(iDep) + "_table_line_R.gif)";
		}
		
		function addFolderHeadLineRow(eTable, iDep) {
			var size = getSize(iDep);
			var imgHead = getImageHeadName(iDep);
			
			var eRow = appendRowWithIndex(eTable, 0);
			
			var eCell = appendCell(eRow);
			eCell.style.width = size;
			eCell.style.height = size;
			eCell.innerHTML = "<img src='../images/Common/" + imgHead + "_table_mo01.gif' width='" +size + "' height='" + size + "' />";
			
			eCell = appendCell(eRow);
			eCell.colSpan = sepCount.toString();
			eCell.style.height = size;
			eCell.style.backgroundImage = "url(../images/Common/" + imgHead + "_table_line_T.gif)";

			eCell = appendCell(eRow);
			eCell.style.width = size;
			eCell.style.height = size;
			eCell.innerHTML = "<img src='../images/Common/" + imgHead + "_table_mo02.gif' width='" + size + "' height='" + size + "' />";
		}

		function addFolderFootLineRow(eTable, iDep) {
			var size = getSize(iDep);
			var imgHead = getImageHeadName(iDep);
			
			var eRow = appendRow(eTable);
			
			var eCell = appendCell(eRow);
			eCell.style.width = size;
			eCell.style.height = size;
			eCell.innerHTML = "<img src='../images/Common/" + imgHead + "_table_mo04.gif' width='" + size + "' height='" + size + "' />";
			
			eCell = appendCell(eRow);
			eCell.colSpan = sepCount.toString();
			eCell.style.height = size;
			eCell.style.backgroundImage = "url(../images/Common/" + imgHead + "_table_line_B.gif)";

			eCell = appendCell(eRow);
			eCell.style.width = size;
			eCell.style.height = size;
			eCell.innerHTML = "<img src='../images/Common/" + imgHead + "_table_mo03.gif' width='" + size + "' height='" + size + "' />";
		}
		
		function addFolder(sTitle, sParent, sTableId, iDep) {
			var eParentTable = document.getElementById(sParent);
			
			if (eParentTable == null) {
				eParentTable = document.getElementById(rootTableId);
			}

			var eParentCell = getNewCell(eParentTable, iDep);
			
			if (iDep > 0) {
				eParentCell.style.padding = "3px";
			} else {
				eParentCell.style.padding = "10px";
			}
			
			var newFolder = document.createElement("table");
			newFolder.borderStyle = "none";
			newFolder.style.width = "100%";
			newFolder.cellSpacing = 0;
			newFolder.cellPadding = 0;

			if (iDep > 0) {
				newFolder.style.backgroundColor = "#ffffff";
			} else {
				newFolder.style.backgroundColor = "#F2F2F2";
			}
			
			var eThead = document.createElement("thead");
			newFolder.appendChild(eThead);
			
			var eTbody = document.createElement("tbody");
			newFolder.appendChild(eTbody);
			eTbody.id = sTableId;
			
			var eTfoot = document.createElement("tfoot");
			newFolder.appendChild(eTfoot);
			
			addFolderHeadLineRow(eThead, iDep);
			addFolderTitleCell(sTitle, appendRow(eThead), iDep);
			addFolderFootLineRow(eTfoot, iDep);
			
			eParentCell.appendChild(newFolder);
			eParentCell.vAlign = "top";
		}
		
		function addProcess(sHtml, sTableId, sId, iDep) {
			var eTable = document.getElementById(sTableId);
			if (!eTable) {
				eTable = document.getElementById("tbodyProcessArea");
			} else {
				var eRow = appendRow(eTable);

				addStartLineCell(eRow, iDep - 1);
				
				eTd = appendCell(eRow);
				eTd.colSpan = sepCount;
				eTd.style.width = "160px";
				eTd.style.padding = "2px 15px 2px 2px";
				// 요놈 높이 잡아주면 파폭등의 브라우저에서 테이블 상하단 높이 바뀌기 때문에 요놈은 가변길이로
				//eTd.style.height = "22px";
				eTd.vAlign = "top";
				eTd.innerHTML = "<nobr><img src='../processmanager/images/obj_icon_process.gif'  style='margin:-3px 5px;'/><a href=\"javascript:viewObjectType('" + sId + "')\"><strong>" + sHtml + "<strong></a></nobr>";
				
				addEndLineCell(eRow, iDep - 1);
			}
		}
		
		function alignTable() {
			var rootTable = document.getElementById(rootTableId);

			var tables = rootTable.getElementsByTagName("table");
			for (var i = 0; i < tables.length; i++) {
				var table = tables[i];
				var height = table.parentNode.offsetHeight;
				
				var parentPadding = table.parentNode.style.padding.replace("px", "");
				var tableBorder = table.style.margin;
				table.style.height = (height - (parseInt(parentPadding) * 2)) + "px";
			}
		}
		
		function viewObjectType(id) {
			var screenWidth = screen.width;
			var screenHeight = screen.Height;
			var windowWidth = 950;
			var windowHeight = 650;
			var window_left = (screenWidth-windowWidth)/2; 
 			var window_top = (screenHeight-windowHeight)/2;

 			var isViewMode = (status == "COMPLETED") 
	
			var option = "left=" + window_left + ", top=" + window_top + ", width=" + windowWidth + ", height=" + windowHeight + " ,scrollbars=yes,resizable=yes";
			var url = "../processparticipant/viewProcessFlowChart.jsp?processDefinition=" + id + "&strategyId=" + strategyId;
			window.open(url, "processView", option);	
		}

		function changeCol() {
			var sepCount = document.getElementsByName("sepCount")[0];		
			var valCol = sepCount.options[sepCount.selectedIndex].value;

			var cookieProcessMap1Col = document.getElementsByName("cookieProcessMap1Col")[0];
			cookieProcessMap1Col.value = valCol;
			
			document.changeProcessMap1.submit();
		}

		function init(col) {
			var sepCount = document.getElementsByName("sepCount")[0];
			for (i =0; i<sepCount.options.length; i++) {
				if (sepCount.options[i].value == col) {
					sepCount.options.selectedIndex = i;
					break;
				} 
			}		
		}
	</script>
</head>
<body onLoad="init(<%=sepCount%>)">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="right" style="padding:2px 12px 0 0;">
            <table width="*" border="0" cellspacing="0" cellpadding="0">
                <tr height="25" valign="middle">
                    <td valign="middle"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/viewModeTitle.gif" height="25"></td>
                    <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif" valign="middle"></td>
                    <td width="5" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif"></td>
                    <td width="*" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif" style="padding-top:1px;"><a href="viewProcessMap2.jsp"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/i_pm1Off.gif" width="20" height="19" border="0"></a> <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/i_pm2On.gif" width="20" height="19" border="0"></td>
                    <td width="5" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif"></td>
                    <td  colspan="<%=sepCount %>" width="*" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif"><form action="viewProcessMap.jsp" method="get">
				<select name="sepCount" id="selectSepCount" style="height:19px;" onChange="changeCol();">
					<option value="2">2 <%=GlobalContext.getMessageForWeb("cols", loggedUserLocale) %></option>
					<option value="3">3 <%=GlobalContext.getMessageForWeb("cols", loggedUserLocale) %></option>
					<option value="4">4 <%=GlobalContext.getMessageForWeb("cols", loggedUserLocale) %></option>
					<option value="5">5 <%=GlobalContext.getMessageForWeb("cols", loggedUserLocale) %></option>
				</select>
				<!-- 
				<input type="submit" value="<%=GlobalContext.getMessageForWeb("View", loggedUserLocale) %>"/>
				<script type="text/javascript">
					var selectSepCount = document.getElementById("selectSepCount");
					for (var ii = 0; ii < selectSepCount.options.length; ii++) {
						var optionTemp = selectSepCount.options[ii];
						if (optionTemp.value == sepCount.toString()) {
							optionTemp.selected = true;
							break;
						}
					}
				</script>
				 -->
			</form></td>
                    <td valign="middle" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleCenter.gif">    </td>
                    <td valign="middle"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/searchTitleRight.gif"></td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<table border="0" cellspacing="0" cellpadding="0">
    <tbody id="tdProcessMapArea"></tbody>
</table>
<table>
	<tbody id="tbodyProcessArea"></tbody>
</table>



<script type="text/javascript">
	<%!
		private StringBuffer createMap(Hashtable childs, Hashtable versions, String parent, PrintWriter pw, int iDep, String loggedUserId, int iSepCount) {
			StringBuffer sb = new StringBuffer();
			
			try {
				if (childs.containsKey(parent)) {
					Vector childprocesses = (Vector) childs.get(parent);
					
					for (Iterator iter = childprocesses.iterator(); iter.hasNext();) {
						String id = (String) iter.next(); //first is id
						Item definition = (Item) iter.next(); //second is the object
		
						if ("folder".equals(definition.getObj())) {
							StringBuffer strTmp01 = new StringBuffer("\n addFolder(\"" + definition.getName() + "\", \"" + parent + "\", \"" + id + "\", " + iDep + ");");
							String strTmp02 = createMap(childs, versions, id, pw, iDep + 1, loggedUserId, iSepCount).toString();
							
							if (strTmp02.split("addProcess").length > 1) {
								sb.append(strTmp01).append(strTmp02);
							}
							
						} else {
							sb.append("\n addProcess(\"" + definition.getName() + "\", \"" + parent + "\", \"" + id + "\", " + iDep + ");");
						}
					}
				}
		
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return sb;
		}
	%>
	<%
		DataSource dataSource = DefaultConnectionFactory.create().getDataSource();
	ProcessDefinitionListDAO pdfpDAO = new ProcessDefinitionListDAO(dataSource);
		
		Collection<Item> pds = pdfpDAO.findAllProcessDefinitionsForParticipant(loggedUserId);
		
		Hashtable childs = new Hashtable();
		Hashtable versions = new Hashtable();

		for (Item definition : pds) {
			if (definition != null) {
				String definitionId = definition.getId();
				String parent = definition.getParent();
	
				if (!childs.containsKey(parent)) {
					childs.put(parent, new Vector());
				}
	
				Vector v = (Vector) (childs.get(parent));
				v.add(definitionId);
				v.add(definition);
			}
		}

		PrintWriter pw = response.getWriter();
		StringWriter sw = new StringWriter();
		PrintWriter spw = new PrintWriter(sw);

		spw.println(createMap(childs, versions, "-1", spw, 0, loggedUserId, sepCount));
	%>
	<%=sw.toString()%>
	alignTable();
</script>

<form name="changeProcessMap1" action="setCookies.jsp" method="post" style="display: none;">
	<input name="cookieProcessMap1Col" type="text" value="" />
	<input name="strategyId" type="text" value="<%=strategyId%>" />
</form>

</body>
</html>