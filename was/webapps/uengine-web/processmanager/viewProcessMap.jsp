<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	
	<title>Process Map</title>
	<link rel="stylesheet" type="text/css" href="../style/default.css" />

	
<%!private String createMap(Hashtable childs, Hashtable versions, String parent, PrintWriter pw, int iDep) {
		String str = "";
		
		try {
			if (childs.containsKey(parent)) {
				Vector childprocesses = (Vector) childs.get(parent);
				
				for (Iterator iter = childprocesses.iterator(); iter.hasNext();) {
					String id = (String) iter.next(); //first is id
					ProcessDefinitionRemote process = (ProcessDefinitionRemote) iter.next(); //second is the object

					if (process.isFolder()) {
						String strTmp01 = "\n addFolder(\"" + process.getName() + "\", \"" + parent + "\", \"" + id + "\", " + iDep + ");";
						String strTmp02 = createMap(childs, versions, id, pw, iDep + 1);
						
						if (strTmp02.split("addCell").length > 1) {
							str += strTmp01 + strTmp02;
						}
						
					} else {
						str += "\n addCell(\"" + process.getName() + "\", \"" + parent + "\", \"" + id + "\", " + iDep + ");";
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return str;
	}%>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
	ProcessManagerRemote pm = processManagerFactory.getProcessManagerForReadOnly();
%>
	
	<script type="text/javascript">
		function addFolder(sTitle, sParent, sTableId, iDep) {


			var eParentTable = document.getElementById(sParent);

			//alert(eParentTable);
			if (eParentTable == null) {
				eParentTable = document.getElementById("tdProcessMapArea");
			}

			var eParentCell = getTableRow(eParentTable, iDep);
			
			var newElement = document.createElement("table");
			newElement.id = sTableId;
			newElement.borderStyle = "none";
			newElement.style.width = "99%";
			newElement.align = "center";
			newElement.cellSpacing = 0;
			newElement.cellPadding = 0;
			newElement.style.margin = "3";

			if (iDep > 0) {
				newElement.style.backgroundColor = "#ffffff";
			} else {
				newElement.style.backgroundColor = "#f5f5f5";
			}
			
			addHeadLineRow(newElement, iDep + 1);
			addHCell(sTitle, newElement.insertRow(), iDep + 1);
			addFootLineRow(newElement, iDep);
			 
			eParentCell.appendChild(newElement);
			eParentCell.vAlign = "top";

			return newElement;
		}

		function needAddLine(eParentTable) {
			var isNeed = false;
			
			if (eParentTable.rows.length < 4) {
				isNeed = true;
			} else if (eParentTable.rows(eParentTable.rows.length - 2).cells.length > 3) {
				isNeed = true;
			}

			return isNeed;
		}

		function getSize(iDep) {
			var strSize = "6px";
			if (iDep > 0) {
				strSize = "3px"
			}

			return strSize;
		}

		function changeImageName(iDep) {
			var sName = "ps";
			if (iDep > 1) {
				sName += "_inner"
			}
			
			return sName;
		}

		function getTableRow(eParentTable, iDep) {
			var eParentRow = null;
			var eParentCell = null;

			if (iDep > 0) {
				if (needAddLine(eParentTable)) {
					eParentRow = eParentTable.insertRow(eParentTable.rows.length -1);
					addBegineLine(eParentRow, iDep);
					eParentCell = eParentRow.insertCell();
					addAfterLine(eParentRow, iDep);
					eParentCell.colSpan = "2";
					
				} else {
					eParentRow = eParentTable.rows(eParentTable.rows.length - 2);
					eParentRow.cells(eParentRow.cells.length - 2).colSpan = "1";
					
					eParentCell = eParentRow.insertCell(eParentRow.cells.length - 1);
					eParentCell.colSpan = "1";
				}
			} else {
				if (eParentTable.cells.length % 2 == 1) {
					eParentRow = eParentTable.insertRow(eParentTable.rows.length);
					eParentCell = eParentRow.insertCell();
					eParentCell.colSpan = "2";
					eParentCell.style.width = "49%";
				} else {
					eParentRow = eParentTable.rows(eParentTable.rows.length - 1);
					eParentRow.cells(eParentRow.cells.length - 1).colSpan = "1";

					eParentCell = eParentRow.insertCell(eParentRow.cells.length);
					eParentCell.colSpan = "1";
					eParentCell.style.width = "99%";
				}
			}
			

			return eParentCell;
		}

		function addHCell(sHtml, eRow, iDep) {
			
			addBegineLine(eRow, iDep);
			
			eTd = eRow.insertCell();
			eTd.colSpan = "2";
			eTd.align = "center";

			if (iDep > 1) {
				eTd.style.padding = "0px;";
				eTd.style.height = "20px";
				eTd.innerHTML = "<img src='../images/Common/i_blue01.gif' width='5' height='7' style='margin-right:10px;'/><strong>" + sHtml + "</strong>";

				var eSepRow = eRow.parentNode.insertRow(eRow.rowIndex + 1);
				addBegineLine(eSepRow, iDep);
				var eSepCell = eSepRow.insertCell();
				addAfterLine(eSepRow, iDep);

				eSepCell.style.backgroundImage = "url(../images/Common/dot.gif)";
				eSepCell.style.height = "1px";
				eSepCell.colSpan = "2";
			} else {
				eTd.className = "pstitle";
				eTd.innerHTML = "<img src='../images/Common/I_info.gif' width='11' height='11'  style='margin-right:10px;'/><strong>" + sHtml + "</strong>";
			}

			addAfterLine(eRow, iDep);

			return eTd;
		}

		function addCell(sHtml, sTableId, sId, iDep) {
			var eTable = document.getElementById(sTableId);
			var eRow = eTable.insertRow(eTable.rows.length - 1);

			addBegineLine(eRow, iDep);
			
			eTd = eRow.insertCell();
			eTd.colSpan = "2";
			eTd.style.padding = "2px";
			eTd.style.height = "22px";
			eTd.innerHTML = "<img src='images/obj_icon_process.gif'  style='margin:-3px 5px;'/><a href=\"javascript:viewObjectType('" + sId + "')\">" + sHtml + "</a>";

			addAfterLine(eRow, iDep);

			return eTd;
		}

		function addBegineLine(eRow, iDep) {
			var eTd = eRow.insertCell(0);
			
			eTd.style.width = getSize(iDep)
			eTd.style.backgroundImage = "url(../images/Common/" + changeImageName(iDep) + "_table_line_L.gif)";
		}

		function addAfterLine(eRow, iDep) {
			var eTd = eRow.insertCell(eRow.cells.length);

			eTd.style.width = getSize(iDep);
			eTd.style.backgroundImage = "url(../images/Common/" + changeImageName(iDep) + "_table_line_R.gif)";
		}
		
		function addHeadLineRow(eTable, iDep) {
			var eRow = eTable.insertRow(0);
			
			var eCell = eRow.insertCell();
			eCell.style.width = getSize(iDep)
			eCell.style.height = getSize(iDep)
			eCell.innerHTML = "<img src='../images/Common/" + changeImageName(iDep) + "_table_mo01.gif' width='" + getSize(iDep) + "' height='" + getSize(iDep) + "' />";
			
			eCell = eRow.insertCell();
			eCell.colSpan = "2";
			eCell.style.height = getSize(iDep)
			eCell.style.backgroundImage = "url(../images/Common/" + changeImageName(iDep) + "_table_line_T.gif)";

			eCell = eRow.insertCell();
			eCell.style.width = getSize(iDep)
			eCell.style.height = getSize(iDep)
			eCell.innerHTML = "<img src='../images/Common/" + changeImageName(iDep) + "_table_mo02.gif' width='" + getSize(iDep) + "' height='" + getSize(iDep) + "' />";
		}

		function addFootLineRow(eTable, iDep) {
			var eRow = eTable.insertRow();
			
			var eCell = eRow.insertCell();
			eCell.style.width = getSize(iDep);
			eCell.style.height = getSize(iDep)
			eCell.innerHTML = "<img src='../images/Common/" + changeImageName(iDep) + "_table_mo04.gif' width='" + getSize(iDep) + "' height='" + getSize(iDep) + "' />";
			
			eCell = eRow.insertCell();
			eCell.colSpan = "2";
			eCell.style.height = getSize(iDep)
			eCell.style.backgroundImage = "url(../images/Common/" + changeImageName(iDep) + "_table_line_B.gif)";

			eCell = eRow.insertCell();
			eCell.style.width = getSize(iDep)
			eCell.style.height = getSize(iDep)
			eCell.innerHTML = "<img src='../images/Common/" + changeImageName(iDep) + "_table_mo03.gif' width='" + getSize(iDep) + "' height='" + getSize(iDep) + "' />";
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
			var url = "../processparticipant/viewProcessFlowChart.jsp?processDefinition=" + id;
			window.open(url, "processView", option);	
		}
	</script>
</head>
<body>
<table cellspacing="0" cellpadding="0" align="center" width="100%" id="tdProcessMapArea"  style="border:#c7d3e4 1px solid;">
	<tr>
		<td colspan="2" class="tabletitle" style="padding-left:15px;" ><strong>Process Map</strong></td>
	</tr>
    
</table>

<script type="text/javascript">
		<%
			ProcessDefinitionRemote[] pds = null;
				try {
					pds = pm.listProcessDefinitionRemotesLight();
				} finally {
					pm.remove();
				}

				Hashtable childs = new Hashtable();
				Hashtable versions = new Hashtable();

				for (int i = 0; i < pds.length; i++) {
					ProcessDefinitionRemote definitionRemote = pds[i];
					String definitionId = definitionRemote.getId();
					String parent = definitionRemote.getParentFolder();

					//indexing the names for searching versions

					if ("process".equals(definitionRemote.getObjType())) {
						String definitionGroupId = definitionRemote.getBelongingDefinitionId();
						if (definitionGroupId == null) {
							definitionGroupId = definitionRemote.getId();
						}
	
						//indexing the names for making tree
						if (!childs.containsKey(parent)) {
							childs.put(parent, new Vector());
						}
	
						Vector v;
						if (definitionRemote.isProduction() || definitionRemote.isFolder()) {
							v = (Vector) (childs.get(parent));
							v.add(definitionGroupId);
							v.add(definitionRemote);
						}
					}
				}

				PrintWriter pw = response.getWriter();

				StringWriter sw = new StringWriter();
				PrintWriter spw = new PrintWriter(sw);

				spw.println(createMap(childs, versions, "-1", spw, 0));
		%>
		<%=sw.toString()%>

</script>

</body>
</html>