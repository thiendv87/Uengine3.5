<%@page pageEncoding="UTF-8"%>
<%!
	public String CONTEXT 	= org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT;
	public static final String CSS		= "../css";
	public static final String JS		= "../../../scripts";
	public static final String IMG		= "../images";
%>	


<script>
//메세지창 띄우기
function open_alert(msg,width,height){

	var newObj = "";
	var myText = "";
	var script = "";
	newObj=window.open("","_message","scrollbars=no, status=no, resizable=no, width="+width+", height="+height+", top=250, left=500");
	

	myText +="<html>";
	myText +="<head>";
	myText +="<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>";
	myText +="<title>메세지창</title>";
	myText +="<link href='<%=CSS%>/basic.css' rel='stylesheet' type='text/css'>";
	//myText +="<s"+script+"cript> function resize_open(){  this.window.resizeBy("+width+", "+height+");  } </s"+script+"cript>";
	myText +="</head>";
	myText +="<body>";
	myText +="<table width='100%' border='0' cellspacing='1' cellpadding='0'>";
	myText +="  <tr>";
	myText +="    <td><table width='100%' border='0' cellpadding='15' cellspacing='1' bgcolor='CADFEF'>";
	myText +="      <tr>";
	myText +="        <td align='center' bgcolor='F2F8FB' class='pop_bl'><b>"+msg+"<b></td>";
	myText +="      </tr>";
	myText +="    </table></td>";
	myText +="  </tr>";
	myText +="  <tr>";
	myText +="    <td height='36' align='center' bgcolor='EAEAEA'><img src='<%=IMG%>/pop_bt_ok2.gif' onClick='self.close();' style='cursor:hand' width='72' height='23' border='0'></td>";
	myText +="  </tr>";
	myText +="</table>";
	//myText +="<s"+script+"cript>resize_open();</s"+script+"cript>";
	myText +="</body>";
	myText +="</html>";
	newObj.document.write(myText);
	newObj.focus();
}

</script>

