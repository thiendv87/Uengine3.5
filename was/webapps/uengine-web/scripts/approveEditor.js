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

Dim MIMEData

<!-- �������� ������ ȣ��ȴ�...----------------------------------->
Function Window_OnLoad

	document.we.SetDefaultFont "����", 12, "����ü", 10
	showEditbar
	showStylebar
	showFieldbar
	document.we.SetDefaultTableAttr 1, 1, 0
	Window_OnLoad = TRUE
End Function


<!--Editbar�� ���̰� �Ѵ�.----------------------------------------->
Function showEditbar
  document.we.SetToolbarContents2 0, Array(IDM_MENU, 0, IDM_NEW, IDM_OPEN, IDM_SAVE, 0, IDM_PRINT, 0, IDM_UNDO, IDM_REDO, 0, IDM_INSERT_HR, IDM_INSERT_IMAGE, IDM_HYPERLINK, IDM_NEW_TABLE_RIBBON, 0, IDM_INSERT_SYMBOL, IDM_INSERT_COMMENT, 0, IDM_FIND, IDM_REPLACE, 0, IDM_VIEW_SOURCE)
  document.we.ShowToolbar 0, TRUE
End Function

<!------Edit bar�� �����---------------------------------------->
Function hideEditbar
  document.we.ShowToolbar 0, FALSE
End Function


<!----Style bar�� ���̰� �Ѵ�.----------------------------->
Function showStylebar
  document.we.SetToolbarContents2 1, Array(0, IDM_PARA_COMBOBOX, 0, IDM_FONT_COMBOBOX, 0, IDM_FONTSIZE_COMBOBOX, 0, IDM_CHAR_BOLD, IDM_CHAR_ITALIC, IDM_CHAR_UNDERLINE, IDM_CHAR_COLOR, 0, IDM_LIST_NUMBERED, IDM_LIST_BULLET, IDM_INDENT_DECREASE, IDM_INDENT_INCREASE)
  document.we.ShowToolbar 1, TRUE
End Function

<!------style bar�� �����---------------------------->
Function hideStylebar
  document.we.ShowToolbar 1, FALSE
End Function

<!-------fieldbar�� ���̰� �Ѵ�----------------------->
Function showFieldbar
  document.we.SetToolbarContents2 2, Array(IDM_FORM_ONELINE_TXTBOX, IDM_FORM_TXTBOX, IDM_FORM_CHECKBOX, IDM_FORM_RADIOBTN, IDM_FORM_MENU, IDM_FORM_PUSHBTN)
  document.we.ShowToolbar 2, TRUE
End Function


<!-----fieldbar�� �����------------------>
Function hideFieldbar
  document.we.ShowToolbar 2, FALSE
End Function


Sub we_FileLoadCompleted(status)
	if status = 0 then
		MsgBox "���� ���� ����"
	end if
End Sub

'Sub we_ToolbarSelected(id)
'	Dim fRef
'	Set fRef = document.writeForm

'	if id = IDM_BACKIMAGE then
'		fRef.we.SetBackground "http://www.namo.co.kr/images/logo.gif", 0, 0
'	end if
'End Sub


'Function writeForm_onSubmit
'	Dim fRef, res
'	Dim backImg, size
'	Set fRef = Document.writeForm

'	MsgBox fRef.we.GetLocalFilesNum

'	res = True
'	if fRef.title.value = "" then res = False
'	if fRef.name.value = "" then  res = False
'	if res then
'		fRef.body.value = fRef.we.TextValue
'		MsgBox fRef.body.value
'	else
'		MsgBox "Please fill title or name field"
'	end if

'	writeForm_onSubmit = res
'End Function

Function setEditMode
End Function

Function setViewMode
End Function

<!--- ������ �������θ� Ȯ���Ѵ�.------>
Function IsModified
  Dim bModified
  bModified =  document.we.IsDirty
  if(bModified) Then msgBox "Document is modified"
End Function

<!-----���������� �����´�.(html) ------------------->
Function getHtml
  Dim html
  html = document.we.Value
  msgbox html
  getHtml = html
End Function


<!------������ ������ MIME ������ �����´�------------------>
Function getMIMEValue
  Dim mimeValue
  mimeValue = document.we.MIMEValue
   msgBox mimeValue
  document.we.Value = mimeValue
End Function

<!-------������ �����ڸ� ǥ���Ѵ�.----------------->
Function setProductName
  Dim pName
  pName = "Hanwha"
  document.we.ProductName = pName
End Function

<!-------������ �����ڸ� �����´�----------------->
Function getProductName
  Dim pName
  pName =  document.we.ProductName
  msgBox pName
End Function

<!-------������ <body> tag ���� �����´�.----------------->
Function getBodyValue
  Dim bValue
  bValue = document.we.BodyValue
  msgBox bValue
End Function

<!-----���� ������ path�� �����´�.------------------->
Function getDocumentPath
  Dim docPath
  docPath = document.we.DocumentPath
  msgBox docPath
End Function


Function setBaseUrl
  document.we.RelativeBaseUrl = "http://officemate.co.kr"
End Function


<!-------������ <HEAD> tag ���� �����´�.----------------->
Function getHeadValue
  Dim hValue
  hValue = document.we.HeadValue
  msgBox hValue
End Function

<!--------������ ���Ե� local ����(�ַ� image) ������ �����´�.---------------->
Function getLocalFilesNum
  Dim fcount
  fcount = document.we.GetLocalFilesNum()
  msgBox fcount
End Function

<!--------������ ���Ե� ������ path�� �迭�� �����´�.---------------->
Function getLocalFileList
  Dim arrFiles(100)
  document.we.GetLocalFileList2 arrFiles
End Function

<!------������ open �Ѵ�(local �Ǵ� remote)------------------>
Function openFile
  Dim filename
  filename = "http://officemate.co.kr/joins.htm"
  document.we.OpenFile(filename)
End Function

<!-------������ �̸����⸦ �Ѵ�.----------------->
Function previewDoc
  document.we.PreviewInBrowser(1)
End Function

<!-------������ �μ��Ѵ�.(�μ� ��ȭ���ڸ� ���ؼ�..)----------------->
Function printDoc
  document.we.Print(1)
End Function

<!-------������ �μ��Ѵ�.(�μ� ��ȭ���ڸ� ������ �ʰ�..)----------------->
Function printDocDirectly
  document.we.Print(0)
End Function

<!-----Ŀ���� ���δ�------------->
Function showCaret
  document.we.ShowCaret(TRUE)
End Function

<!------Ŀ���� �����------------------>
Function hideCaret
  document.we.ShowCaret(FALSE)
End Function

<!-------html�� ������ �տ� �ٿ� �ִ´�----------------->
Function insertHtmlToFront
  Dim html
  html = "<p>�� ���� ������ ó���� �߰��˴ϴ�.</p>"
  document.we.InsertHTMLToPos 0, html
End Function


<!-------html�� ������ �ڿ� �ٿ� �ִ´�----------------->
Function insertHtmlToBottom
  Dim html
  html = "<p>�� ���� ������ �������� �߰��˴ϴ�.</p>"
  document.we.InsertHTMLToPos -1, html
End Function


<!-------html�� ���� Ŀ�� ��ġ�� �����Ѵ�.----------------->
Function insertHtml
  Dim html
  html = "<p>�� ���� ���� ��ġ�� �߰��˴ϴ�.</p>"
  document.we.InsertHTMLToPos 1, html
End Function


<!------���� ��ũ�ѹٸ� ���̰� �Ѵ�.------------------>
Function showVertScrollBar
  document.we.EnableVertScrollBar(TRUE)
End Function

<!------���� ��ũ�ѹٸ� �����.------------------>
Function hideVertScrollBar
  document.we.EnableVertScrollBar(FALSE)
End Function


<!------���� ��ũ�ѹٸ� ���̰� �Ѵ�.------------------>
Function showHorzScrollBar
  document.we.EnableHorzScrollBar(TRUE)
End Function

<!-------���� ��ũ�ѹٸ� �����.----------------->
Function hideHorzScrollBar
  document.we.EnableHorzScrollBar(FALSE)
End Function
