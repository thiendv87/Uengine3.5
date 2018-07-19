const IDM_NEW			= 40003
const IDM_OPEN			= 40004
const IDM_SAVE			= 40007
const IDM_PRINT			= 40006
const IDM_PRINT_PREVIEW		= 40026
const IDM_UNDO			= 40013
const IDM_REDO			= 40016
const IDM_FIND              	= 40018
const IDM_REPLACE           	= 40019

const IDM_INSERT_HR		= 40020
const IDM_INSERT_IMAGE		= 40032
const IDM_INSERT_COMMENT    	= 40038
const IDM_INSERT_SYMBOL     	= 40072
const IDM_INSERT_SCRIPT     	= 40100
const IDM_INSERT_UNKNOWN_TAG    = 40101
const IDM_INSERT_APPLET     	= 40104
const IDM_INSERT_PLUGIN     	= 40166

const IDM_CHAR_BOLD		= 40042
const IDM_CHAR_ITALIC		= 40043
const IDM_CHAR_UNDERLINE	= 40044
const IDM_CHAR_CLEAR		= 40046
const IDM_CHAR_COLOR		= 40047

const IDM_LIST_NUMBERED		= 40052
const IDM_LIST_BULLET		= 40053

const IDM_INDENT_DECREASE	= 40055
const IDM_INDENT_INCREASE	= 40054

const IDM_ALIGN_LEFT		= 40049
const IDM_ALIGN_CENTER		= 40050
const IDM_ALIGN_RIGHT		= 40051

const IDM_HYPERLINK		= 40034
const IDM_NEW_TABLE_RIBBON	= 40129


const IDM_FORM_ONELINE_TXTBOX	= 40059
const IDM_FORM_TXTBOX       	= 40060
const IDM_FORM_CHECKBOX     	= 40061
const IDM_FORM_RADIOBTN     	= 40062
const IDM_FORM_MENU         	= 40063
const IDM_FORM_PUSHBTN      	= 40064
const IDM_FORM_IMAGE        	= 40099

const IDM_PARA_COMBOBOX		= 40039
const IDM_FONT_COMBOBOX		= 40105
const IDM_FONTSIZE_COMBOBOX	= 40164

const IDM_VIEW_SOURCE       	= 40035
const IDM_LINESPACING		= 40224
const IDM_MENU			= 40229

const IDM_SHOWHIDE_TAG_MARK	= 40068
const IDM_SHOWHIDE_PARA_MARK	= 40058
const IDM_SHOWHIDE_SPACE_MARK	= 40178

const IDM_TABLE_SPLIT_CELLS	= 40074
const IDM_TABLE_MERGE_CELLS	= 40075
const IDM_CELL_VALIGN_TOP	= 40235
const IDM_CELL_VALIGN_CENTER    = 40236
const IDM_CELL_VALIGN_BOTTOM	= 40237

const IDM_TABLE_SAME_WIDTH_CELLS	= 40232
const IDM_TABLE_SAME_HEIGHT_CELLS	= 40233

Dim arrFiles(50)

Function Window_OnLoad
	document.we.SetDefaultFont "굴림", 12, "굴림체", 12
	showEditbar
	showStylebar
'	showFieldbar
	document.we.SetDefaultTableAttr 1, 1, 0
'	document.we.Value = document.makeform.inhtml.value
	setProductName
	Window_OnLoad = TRUE
End Function


Function showEditbar
  document.we.SetToolbarContents2 0, Array(IDM_NEW, IDM_OPEN, IDM_SAVE, 0, IDM_PRINT, 0, IDM_UNDO, IDM_REDO, 0, IDM_INSERT_HR, IDM_INSERT_IMAGE, IDM_HYPERLINK, IDM_NEW_TABLE_RIBBON, 0, IDM_INSERT_SYMBOL, IDM_INSERT_COMMENT, 0, IDM_FIND, IDM_REPLACE, 0, IDM_VIEW_SOURCE)
  document.we.ShowToolbar 0, TRUE
End Function


Function showStylebar
  document.we.SetToolbarContents2 1, Array(0, IDM_PARA_COMBOBOX, 0, IDM_FONT_COMBOBOX, 0, IDM_FONTSIZE_COMBOBOX, 0, IDM_CHAR_BOLD, IDM_CHAR_ITALIC, IDM_CHAR_UNDERLINE, IDM_CHAR_COLOR, 0, IDM_LIST_NUMBERED, IDM_LIST_BULLET, IDM_INDENT_DECREASE, IDM_INDENT_INCREASE, IDM_ALIGN_LEFT, IDM_ALIGN_CENTER, IDM_ALIGN_RIGHT)
  document.we.ShowToolbar 1, TRUE
End Function


Function showFieldbar
  document.we.SetToolbarContents2 2, Array(IDM_FORM_ONELINE_TXTBOX, IDM_FORM_TXTBOX, IDM_FORM_CHECKBOX, IDM_FORM_RADIOBTN, IDM_FORM_MENU, IDM_FORM_PUSHBTN)
  document.we.ShowToolbar 2, TRUE
End Function


Function getLocalFileList

  document.we.GetLocalFileList2 arrFiles
  getLocalFileList = arrFiles
End Function


Function getHtml 
  Dim html
  html = document.we.Value
  getHtml = html
End Function


Function previewDoc
  document.we.PreviewInBrowser(1)
End Function

Function previewRgn

  Dim win
  Dim w, h, param

  w = document.makeform.editwidth.value
  h = document.makeform.editheight.value
  param = "width="+w+ " height="+h+ " scrollbars=no"
  
  win = window.open("preview.htm","미리보기",param)

End Function

Function regDocument

  '양식 제목 입력확인
  if (document.makeform.formtitle.value = "") Then 
  	msgBox("양식 제목을 입력하세요")
	document.makeform.formtitle.focus()
  End if
  
  '문서에 포함된 이미지를 변수에 넣는다.
'  getLocalFileList

  document.makeform.srchtml.value   = getHtml
  document.makeform.mimevalue.value =  getMIMEValue
  document.makeform.work.value = "insert"

  if(document.makeform.chkfreeedit.checked = true) Then 
	document.makeform.chkfreeedit.value = "Y"
  End if

  document.makeform.submit

End Function

Function cancel
  if(confirm("창을 닫으시겠습니까?")) Then  self.close()
End Function


Function saveAppDoc
  document.we.DoMenuAction(IDM_SAVE)
End Function

Function getMIMEValue
  Dim mimeValue
  mimeValue = document.we.MIMEValue
  getMIMEValue = mimeValue
End Function

Function setProductName
  Dim pName
  pName = "Hanwha"
  document.we.ProductName = "Hanwha Officemate"
End Function
