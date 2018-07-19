document.write("<OBJECT id=IEPageSetupX classid='clsid:41C5BC45-1BE8-42C5-AD9F-495D6C8D7586' codebase='/jsp/web/common/cab/IEPageSetupX.cab#version=1,1,0,1' width=0 height=0><param name='copyright' value='http://isulnara.com'><div style='position:absolute;top:276;left:320;width:300;height:68;border:solid 1 #99B3A0;background:#D8D7C4;overflow:hidden;z-index:1;visibility:visible;'><FONT style='font-family: \"굴림\", \"Verdana\"; font-size: 9pt; font-style: normal;'><BR>  인쇄 여백제어 컨트롤이 설치되지 않았습니다.</div></OBJECT>");

function IEPageSetupXInstalled()
{
  if (typeof(document.all("IEPageSetupX"))!="undefined" && document.all("IEPageSetupX")!=null)
	return true;
  else 
	return false;
}

function IEPageSetupXPrint()
{
	if (!IEPageSetupXInstalled())
		alert("컨트롤이 설치되지 않았습니다. 인쇄를 취소합니다.");
	else {
		IEPageSetupX.header = "";
		IEPageSetupX.footer = "";
		IEPageSetupX.topMargin = 0;
		IEPageSetupX.bottomMargin = 0;
		IEPageSetupX.Preview();
	}
}

