<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/html; charset=UTF-8");%>
<html>

<head>
<title>��Ƽ�꽺���� 6 ���� ����</title>
<style>
<!--
p,td,ul,ol,form { line-height:150%; margin-top:0; margin-bottom:0;}
a { color:blue; text-decoration:none; }
-->
</style>
<base target="_blank"></head>
<body text="white" link="blue" vlink="purple" alink="red" topmargin="0" marginheight="0" leftmargin="0" marginwidth="0" bgcolor="#F6F6FD">



<table cellpadding="0" cellspacing="0" style="margin-bottom:12;" align="center">
    <tr>
        <td>
            <p align="left"><img src="images/topimage.gif" width="1024" height="72" border="1"></p>
        </td>
    </tr>
</table>
<table cellspacing="0" bordercolordark="white" bordercolorlight="black" align="center" cellpadding="0">
    <tr>
        <td valign="top"><form name="testForm">
    <table align="center" cellpadding="0" cellspacing="0" width="706">
        <tr>
            <td colspan="3" valign="top" bgcolor="#d6d3Ce" style="border-top-width:1; border-right-width:2; border-bottom-width:1; border-left-width:1; border-color:rgb(99,101,99); border-style:solid;" width="703"><p style="margin-top:3; margin-bottom:4;" align="center">
	
	<font color="black"><span style="font-size:9pt;"><select name="menutype" size="1" style="font-size:9pt;">
    <option value="0" selected>���� ��� ���̱�</option>
	<option value="1">���� �Ϻ� ���̱�</option>
	<option value="2">���� ��� ���߱�</option>
	<option value="3">���� ����� ����</option>
    </select> <select name="tabtype" size="1" style="font-size:9pt;">
    <option selected value="0">�� ���̱�</option>
	<option value="1">�� ���߱�</option>
    </select> <select name="rulertype" size="1" style="font-size:9pt;">
    <option selected value="0">������ ��� ���߱�</option>
	<option value="1">������ ���� ���̱�</option>
	<option value="2">������ ���� ���̱�</option>
	<option value="3">������ ��� ���̱�</option>
    </select> 
	
	<select name="scrolltype" size="1" style="font-size:9pt;">
    <option selected value="0">��ũ�ѹ� ��� ���̱�</option>
	<option value="1">��ũ�ѹ� ���� ���̱�</option>
	<option value="2">��ũ�ѹ� ���� ���̱�</option>
	<option value="3">��ũ�ѹ� ��� ���߱�</option>

    </select>
	
	<select name="doctype" size="1" style="font-size:9pt;">
    <option selected value="0">�� �󹮼�</option>
	<option value="1">�� ǥ�ذ˻��û��</option>
	<option value="2">�� �Ի�������</option>
                <option value="3">�� ��������</option>
    </select> &nbsp;</span><span style="font-size:8pt;">�̸�Ƽ��</span></font><span style="font-size:9pt;"><font color="black"><input type=button name="InsertImoticon" size=35 style="font-size:9pt; background-color:transparent; background-image:url('images/imt0.gif'); background-repeat:no-repeat; padding-top:0; padding-bottom:0; border-width:0; border-style:none; width:23; height:23; cursor:hand;" onfocus="this.blur();"></font></span></p>
            </td>
        </tr>
        <tr>
            <td valign="top" colspan="3" width="704" height="498" style="border-right-width:1; border-bottom-width:1; border-left-width:1; border-right-color:rgb(99,101,99); border-bottom-color:rgb(99,101,99); border-left-color:rgb(99,101,99); border-right-style:solid; border-bottom-style:solid; border-left-style:solid;">
    <p style="line-height:100%; margin-top:0; margin-bottom:0;">

<font color="black"><span style="font-size:9pt;">

		                  <OBJECT WIDTH="0" HEIGHT="0" CLASSID="clsid:5220cb21-c88d-11cf-b347-00aa00a28331">
		                    <param name="LPKPath" value="lib/namo/ActiveSquare6/user/NamoWec6_korealife_eagle.lpk"/>
		                  </OBJECT>
		                  <OBJECT ID="Wec" style="width:100%;height:400px;text-align:center;" 
						  CLASSID="CLSID:F5BF0251-F07B-42a6-85B7-8A6ABBB35C78" 
						  codebase="lib/namo/ActiveSquare6/user/NamoWec.cab#version=6,0,0,25" viewMode="edit">
		                  </OBJECT>


</span></font></p>
            </td>
        </tr>
        <tr>
            <td valign="top" width="353">
                <p style="line-height:100%; margin-top:3; margin-bottom:3;" align="center"><span style="font-size:9pt;"><font color="black"><input type=button name="GetValue" size=35 value="HTML�� ���� ��" style="font-size:9pt; padding-top:3;"></font></span></p>
            </td>
            <td valign="top" width="4">
                <p>&nbsp;</p>
            </td>
            <td valign="top" width="349">
                <p style="line-height:100%; margin-top:3; margin-bottom:3;" align="center"><span style="font-size:9pt;"><font color="black"><input type=button name="GetMimeValue" size=35 value="MIME�� ���� ��" style="font-size:9pt; padding-top:3;"></font></span></p>
            </td>
        </tr>
        <tr>
            <td valign="top" width="351" bgcolor="#d6d3Ce" style="border-width:1; border-color:rgb(99,101,99); border-style:solid;" height="172">
                <p style="line-height:100%; margin-top:3; margin-bottom:0;"> 
                <font color="black"><span style="font-size:9pt;">&nbsp;&nbsp;&nbsp;�ۼ��� ���뿡 ���� ���� �����ݴϴ�.</span></font></p>
                <p style="line-height:100%; margin-top:0; margin-bottom:5;" align="center"><font color="black"><span style="font-size:9pt;"><textarea name="ValueContent" rows="12" cols="43"></textarea></span></font></p>
                            <p style="line-height:100%; margin-top:1; margin-bottom:2;" align="center"> 
                 
                <font color="black"><span style="font-size:9pt;"><input type="button" value="��Ƽ�꽺����� �����ϱ� ��" name="PutValue" style="font-size:9pt; padding-top:3;"></span></font></p>
            </td>
            <td valign="top" width="4" style="border-top-color:rgb(0,0,0); border-right-color:rgb(0,0,0); border-bottom-color:rgb(0,0,0); border-style:none;" height="172">
                <p>&nbsp;</p>
            </td>
            <td valign="top" width="347" bgcolor="#D6D3CE" style="border-width:1; border-color:rgb(99,101,99); border-style:solid;" height="172">
                <p style="line-height:100%; margin-top:3; margin-bottom:0;"><span style="font-size:9pt;"><font color="black">&nbsp;&nbsp;&nbsp;�ۼ��� ������ MIME ���� ���ڵ��Ͽ� �����ݴϴ�.</font></span></p>
                <p style="line-height:100%; margin-top:0; margin-bottom:5;" align="center"><font color="black"><span style="font-size:9pt;"><textarea name="MimeValueContent" rows="12" cols="43"></textarea></span></font></p>
                <p style="line-height:100%; margin-top:1; margin-bottom:2;" align="center"><font color="black"><span style="font-size:9pt;"><input type="button" value="��Ƽ�꽺����� �����ϱ� ��" name="PutMimeValue" style="font-size:9pt; padding-top:3;"></span></font></p>
            </td>
        </tr>
    </table>
</form>

        </td>
        <td valign="top">            <table cellpadding="0" cellspacing="0" style="margin-left:3; border-bottom-width:1; border-bottom-color:rgb(204,204,204); border-bottom-style:solid;">
                <tr>
                    <td valign="top" colspan="2"><a href="http://www.namo.co.kr/enterprise.php"><img src="images/title_product2.gif" width="318" height="32" border="0"></a></td>
                </tr>
                <tr>
                    <td valign="top" background="images/box_bg_left.gif"><a href="http://www.namo.co.kr/activesquare/"><img src="images/product_b_as.gif" width="90" height="66" border="0"></a></td>
                    <td valign="top" background="images/box_bg_right.gif"><a href="http://www.namo.co.kr/activesquare/"><img src="images/product_text_as.gif" width="205" height="49" border="0" name="image52"></a></td>
                </tr>
		<tr>
                    <td valign="top" background="images/box_bg_left.gif"><img src="images/box_line_left.gif" width="90" height="1" border="0"></td>
                    <td valign="top" background="images/box_bg_right.gif"><img src="images/box_line_right.gif" width="228" height="1" border="0"></td>
                </tr>
                <tr>
                    <td valign="top" background="images/box_bg_left.gif"><a href="http://www.namo.co.kr/deepsearch/"><img src="images/product_b_ds.gif" width="90" height="66" border="0"></a></td>
                    <td valign="top" background="images/box_bg_right.gif"><a href="http://www.namo.co.kr/deepsearch/"><img src="images/product_text_ds.gif" width="205" height="49" border="0" name="image53"></a></td>
                </tr>
        <tr>
                    <td valign="top" background="images/box_bg_left.gif"><img src="images/box_line_left.gif" width="90" height="1" border="0"></td>
                    <td valign="top" background="images/box_bg_right.gif"><img src="images/box_line_right.gif" width="228" height="1" border="0"></td>
                </tr>
                <tr>
                    <td valign="top" background="images/box_bg_left.gif"><a href="http://www.namo.co.kr/kcerp/"><img src="images/product_b_kcerp.gif" width="90" height="66" border="0"></a></td>
                    <td valign="top" background="images/box_bg_right.gif"><a href="http://www.namo.co.kr/kcerp/"><img src="images/product_text_kcerp.gif" width="205" height="49" border="0"></a></td>
                </tr>
		<tr>
                    <td valign="top" background="images/box_bg_left.gif"><img src="images/box_line_left.gif" width="90" height="1" border="0"></td>
                    <td valign="top" background="images/box_bg_right.gif"><img src="images/box_line_right.gif" width="228" height="1" border="0"></td>
                </tr>
                <tr>
                    <td valign="top" background="images/box_bg_left.gif"><a href="http://www.namo.co.kr/visionone/"><img src="images/product_b_vo.gif" width="90" height="66" border="0"></a></td>
                    <td valign="top" background="images/box_bg_right.gif"><a href="http://www.namo.co.kr/visionone/"><img src="images/product_text_vo.gif" width="205" height="49" border="0" name="image54"></a></td>
                </tr>
		<tr>
                    <td valign="top" background="images/box_bg_left.gif"><img src="images/box_line_left.gif" width="90" height="1" border="0"></td>
                    <td valign="top" background="images/box_bg_right.gif"><img src="images/box_line_right.gif" width="228" height="1" border="0"></td>
                </tr>
                <tr>
                    <td valign="top" background="images/box_bg_left.gif"><a href="http://www.namo.co.kr/mobile/"><img src="images/product_b_mobile.gif" width="90" height="66" border="0"></a></td>
                    <td valign="top" background="images/box_bg_right.gif"><a href="http://www.namo.co.kr/mobile/"><img src="images/product_text_mobile.gif" width="205" height="49" border="0" name="image55"></a></td>
                </tr>
                <tr>
                    <td colspan="2"><a href="http://www.namo.co.kr/"><img src="images/title_product1.gif" width="318" height="32" border="0"></a></td>
                </tr>
				<tr>
                    <td valign="top" background="images/box_bg_left.gif"><a href="http://www.namo.co.kr/webstudio/"><img src="images/product_b_ws.gif" width="90" height="66" border="0"></a></td>
                    <td valign="top" background="images/box_bg_right.gif"><a href="http://www.namo.co.kr/webstudio/"><img src="images/product_text_ws.gif" width="205" height="49" border="0" name="image56"></a></td>
                </tr>
                <tr>
                    <td valign="top" background="images/box_bg_left.gif"><img src="images/box_line_left.gif" width="90" height="1" border="0"></td>
                    <td valign="top" background="images/box_bg_right.gif"><img src="images/box_line_right.gif" width="228" height="1" border="0"></td>
                </tr>
                <tr>
                    <td valign="top" background="images/box_bg_left.gif"><a href="http://www.namo.co.kr/webeditor/"><img src="images/product_b_we.gif" width="90" height="66" border="0"></a></td>
                    <td valign="top" background="images/box_bg_right.gif"><a href="http://www.namo.co.kr/webeditor/"><img src="images/product_text_we.gif" width="205" height="49" border="0" name="image50"></a></td>
                </tr>
                <tr>
                    <td valign="top" background="images/box_bg_left.gif"><img src="images/box_line_left.gif" width="90" height="1" border="0"></td>
                    <td valign="top" background="images/box_bg_right.gif"><img src="images/box_line_right.gif" width="228" height="1" border="0"></td>
                </tr>
                <tr>
                    <td valign="top" background="images/box_bg_left.gif"><a href="http://www.namo.co.kr/handstory/"><img src="images/product_b_hs.gif" width="90" height="66" border="0"></a></td>
                    <td valign="top" background="images/box_bg_right.gif"><a href="http://www.namo.co.kr/handstory/"><img src="images/product_text_hs.gif" width="205" height="49" border="0" name="image51"></a></td>
                </tr>
                <tr>
                    <td valign="top" background="images/box_bg_left.gif"><img src="images/box_line_left.gif" width="90" height="1" border="0"></td>
                    <td valign="top" background="images/box_bg_right.gif"><img src="images/box_line_right.gif" width="228" height="1" border="0"></td>
                </tr>
                <tr>
                    <td valign="top" background="images/box_bg_left.gif"><a href="http://www.namo.co.kr/flashcreator/"><img src="images/product_b_fc.gif" width="90" height="66" border="0"></a></td>
                    <td valign="top" background="images/box_bg_right.gif"><a href="http://www.namo.co.kr/flashcreator/"><img src="images/product_text_fc.gif" width="205" height="49" border="0"></a></td>
                </tr>
				<tr>
                    <td valign="top" background="images/box_bg_left.gif"><img src="images/box_line_left.gif" width="90" height="1" border="0"></td>
                    <td valign="top" background="images/box_bg_right.gif"><img src="images/box_line_right.gif" width="228" height="1" border="0"></td>
                </tr>
				<!--odin
                <tr>
                    <td width="90" valign="top" background="/images/box_bg_left.gif"><a href="/odin/"><img src="/images/product_b_odin.gif" width="90" height="66" border="0"></a></td>
                    <td width="228" valign="top" background="/images/box_bg_right.gif"><a href="/odin/"><img src="/images/product_text_odin.gif" width="205" height="49" border="0"></a></td>
                </tr>
                <tr>
                    <td width="90" valign="top" background="/images/box_bg_left.gif"><img src="/images/box_line_left.gif" width="90" height="1" border="0"></td>
                    <td width="228" valign="top" background="/images/box_bg_right.gif"><img src="/images/box_line_right.gif" width="228" height="1" border="0"></td>
                </tr>
				-->
                <tr>
                    <td valign="top" background="images/box_bg_left.gif"><a href="http://www.ictclass.net" target="new"><img src="images/product_b_ict.gif" width="90" height="66" border="0"></a></td>
                    <td valign="top" background="images/box_bg_right.gif"><a href="http://www.ictclass.net" target="new"><img src="images/product_text_ict.gif" width="205" height="49" border="0"></a></td>
                </tr>
				<tr>
                    <td valign="top" background="images/box_bg_left.gif"><img src="images/box_line_left.gif" width="90" height="1" border="0"></td>
                    <td valign="top" background="images/box_bg_right.gif"><img src="images/box_line_right.gif" width="228" height="1" border="0"></td>
                </tr>
				<tr>
                    <td valign="top" background="images/box_bg_left.gif"><a href="http://www.namo.co.kr/game/"><img src="images/product_b_mobile2.gif" width="90" height="66" border="0"></a></td>
                    <td valign="top" background="images/box_bg_right.gif"><a href="http://www.namo.co.kr/game/"><img src="images/product_text_mobile2.gif" width="205" height="49" border="0"></a></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table cellpadding="0" cellspacing="0" width="1027" align="center" style="margin-top:5; margin-bottom:3; border-collapse:collapse;" bgcolor="#DEDEF4">
    <tr>
        <td width="382" height="12" style="border-top-width:1; border-right-width:1; border-bottom-width:1; border-left-width:1; border-top-color:black; border-bottom-color:black; border-left-color:black; border-top-style:solid; border-right-style:none; border-bottom-style:solid;">
            <p style="margin-right:5;"><SPAN style="font-size:8pt;"><FONT face="Microsoft Sans Serif" color="#000033"><STRONG>&nbsp;SeJoong 
            Namo 
Interactive Inc.</STRONG> &nbsp;�� 1997-2005 All rights reserved.</FONT></SPAN><font color="#000033"><span style="font-size:9pt;">&nbsp;</span></font></p>
        </td>
        <td width="642" height="12" style="border-top-width:1; border-right-width:1; border-bottom-width:1; border-left-width:1; border-top-color:black; border-right-color:black; border-bottom-color:black; border-top-style:solid; border-bottom-style:solid; border-left-style:none;">
            <p align="right" style="margin-right:5;"><font color="#000099"><span style="font-size:9pt;">�� 
            API �� �ʱ�ȭ���Ͽ� ���� �ڼ��� ������  </span></font><a href="http://www.namo.co.kr/activesquare/techlist/help/devel" target="_blank"><span style="font-size:9pt;"><font color="#000099"><b>[������ ���̵�</b></font></span></a><span style="font-size:9pt;"><font color="#000099"><b>]</b></font></span><font color="#000099"><span style="font-size:9pt;">�� ������ �ּ���</span></font></p>
        </td>
    </tr>
</table>
</body>

<SCRIPT LANGUAGE="VBScript"><!--

Function Window_Onbeforeunload
	Dim fRef
	Set fRef = Document.testForm
	'fRef.Wec.SaveState "Wec"
End Function

Function Wec_OnInitCompleted
	Dim fRef
	Set fRef = Document.testForm
	fRef.Wec.DoCommand "marktable"
	fRef.Wec.DoCommand "marktag"
	fRef.Wec.OpenFile "pages/defdoc.htm"
	'fRef.Wec.SetBasicCSSFile "pages/format.css"
	fRef.Wec.RestoreState "Wec"
	fRef.Wec.InstallSourceURL = "http://www.namo.co.kr/activesquare/products/update"
End Function
 
Function StartPRN
	Dim fRef
	Set fRef = document.testForm
	fRef.Wec.SetPaperSize 1    ' ������ A4 ������ �ϰ� ���� �������� ���� �μ�
	fRef.Wec.PrintFile ""      ' ����â�� ���븸 ����Ʈ ����
End Function

Function doctype_OnChange

	Dim fRef
	Dim fSel
	Set fRef = Document.testForm
	fSel = fRef.doctype.value
	
	if fSel = 0 then
		fRef.Wec.OpenFile "pages/defdoc.htm"
	elseif fSel = 1 then
		fRef.Wec.OpenFile "pages/sam1.htm"
	elseif fSel = 2 then
		fRef.Wec.OpenFile "pages/sam2.htm"
	elseif fSel = 3 then
		fRef.Wec.OpenFile "pages/sam3.htm"	
	end if
	
	
End Function	

Function menutype_OnChange

	'--- ����: ShowToolbar ��������(0,1,2), ���̱⿩��(0,1)

	Dim fRef
	Dim fSel
	Set fRef = Document.testForm
	fSel = fRef.menutype.value
	
	if fSel = 0 then
		fRef.Wec.CreateToolbar "CreateToolbar = filenew fileopen | print printpreview | undo redo | hr hyperlink bookmark image tableribbon layer | listnumber listbullet indentdecrease indentincrease | marktable markpara marktag ; paralist fontlist fontsizelist lineheight | charbold charitalic charunderline charcolor charbgcolor charclear | alignleft aligncenter alignright"
		fRef.Wec.ShowToolbar 0,1
		fRef.Wec.ShowToolbar 1,1
		fRef.Wec.ShowToolbar 2,1
	elseif fSel = 1 then
		fRef.Wec.ShowToolbar 0,0
		fRef.Wec.ShowToolbar 1,0
		fRef.Wec.ShowToolbar 2,1
	elseif fSel = 2 then
		fRef.Wec.ShowToolbar 0,0
		fRef.Wec.ShowToolbar 1,0
		fRef.Wec.ShowToolbar 2,0
	elseif fSel = 3 then
		fRef.Wec.ShowToolbar 0,0
		fRef.Wec.CreateToolbar "CreateToolbar = menu | FileNew FileOpen FileSaveAs  | undo redo | hr hyperlink bookmark image bgimage layer | table_ribbon table_draw table_erase rowcol_insert rowcol_delete | symbol find replace | cut copy paste | Help ; font_list fontsize_list | char_bold char_italic char_underline char_color char_bgcolor char_clear | list_number list_bullet indent_decrease indent_increase | align_left align_center align_right | para_property"
	end if	

	fRef.Wec.Focus
End Function

Function rulertype_OnChange

	'--- ����: ShowRuler ���� ������ ���̱⿩��(0,1), ���� ������ ���̱⿩��(0,1)

	Dim fRef
	Dim fSel
	Set fRef = Document.testForm
	
	fSel = fRef.rulertype.value
	
	if fSel = 0 then
		fRef.Wec.ShowRuler 0,0
	elseif fSel = 1 then
		fRef.Wec.ShowRuler 1,0
	elseif fSel = 2 then
		fRef.Wec.ShowRuler 0,1
	elseif fSel = 3 then
		fRef.Wec.ShowRuler 1,1
	end if
	fRef.Wec.Focus
End Function

Function tabtype_OnChange

	'--- ����: ShowTab ���̱�(TRUE) or ���߱�(FALSE)

	Dim fRef
	Dim fSel
	Set fRef = Document.testForm
	
	fSel = fRef.tabtype.value

	if fSel = 0 then
		fRef.Wec.ShowTab TRUE
	elseif fSel = 1 then
		fRef.Wec.ShowTab FALSE
	end if

	fRef.Wec.Focus
End Function

Function scrolltype_OnChange

	'--- ����: EnableHorzScrollbar ���̱�(1) or ���߱�(0)
	'          EnableVerrtScrollbar ���̱�(1) or ���߱�(0)

	Dim fRef
	Dim fSel
	Set fRef = Document.testForm
	
	fSel = fRef.scrolltype.value

	if  fSel = 0 then
		fRef.Wec.EnableHorzScrollbar 1
	    fRef.Wec.EnableVertScrollbar 1
	elseif fSel = 1 then
		fRef.Wec.EnableHorzScrollbar 1
	    fRef.Wec.EnableVertScrollbar 0
	elseif fSel = 2 then
		fRef.Wec.EnableHorzScrollbar 0
	    fRef.Wec.EnableVertScrollbar 1
	elseif fSel = 3 then
		fRef.Wec.EnableHorzScrollbar 0
	    fRef.Wec.EnableVertScrollbar 0
	end if

	fRef.Wec.Focus
	
End Function

Function PutValue_OnClick
 	Dim fRef
	Set fRef = Document.testForm
    fRef.Wec.Value = fRef.ValueContent.value
End Function

Function PutMimeValue_OnClick
 	Dim fRef
	Set fRef = Document.testForm
    fRef.Wec.MimeValue = fRef.MimeValueContent.value
End Function

Function GetValue_OnClick
 	Dim fRef
	Set fRef = Document.testForm
    fRef.ValueContent.value = fRef.Wec.Value
End Function

Function GetMimeValue_OnClick
 	Dim fRef
	Set fRef = Document.testForm
    fRef.MimeValueContent.value = fRef.Wec.MimeValue
End Function


Function InsertImoticon_OnClick
	call Imoticon
End Function

Function Imoticon
 	Dim fRef
	Dim x
	Set fRef = Document.testForm
	Set x = Window.Open("pages/imoticon.htm","","left=300,top=250,Width=195,Height=115,status=no")
	x.focus
End Function

Function Wec_OnCustomMenu(menuid)
	if menuid = 1 then call StartPRN '--- �μ�ȣ��
End Function

Function Wec_OnCommand(cmdstr, finished)

 	Dim fRef
	Set fRef = Document.testForm

   if cmdstr="filenew" then
   		fRef.Wec.OpenFile "pages/defdoc.htm"
        finished = true
   end if
	
End Function

--></SCRIPT>


</html>