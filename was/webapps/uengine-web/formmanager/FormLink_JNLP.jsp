<%@page pageEncoding="UTF-8"%><%response.setContentType("application/x-java-jnlp-file; charset=UTF-8");%><?xml version="1.0" encoding="UTF-8"?>
<%@include file="../../common/commons.jsp"%>
<%
	String url = request.getRequestURL().toString();
	String codebase = url.substring( 0, url.lastIndexOf( "/" ) );
	java.net.URL baseURL = new java.net.URL(codebase);
	String host = baseURL.getHost();
	int port = baseURL.getPort();
	if ( port < 0 ) port = 80;
	System.out.println("[port : " + port + ", userId : " + loggedUserId + "]");

	hanwha.commons.Crypt crypt = new hanwha.commons.Crypt();
	String bpm_userId = crypt.getEncodeString(loggedUserId);
	String bpm_encryptedPasswd = crypt.getEncodeString(loggedUser.getPassword());
%>

	<!-- you should modify the ip address for 'codebase' with an actual IP address of web server -->
	<jnlp spec="1.0+" codebase="<%=codebase%>">
	<information>
		<title>EagleBPM FormLink</title>
		<vendor>HANWHA S&amp;C</vendor>
		<homepage href="http://hsnc.hanwha.co.kr"/>
		<description>EagleBPM FormLink</description>
		<description kind="short">EagleBPM FormLink</description>
		<offline-allowed/>
	</information>
	<security>
		<all-permissions/>
	</security>
	<resources>
		<j2se version="1.4+ 1.3+"/>
		
		<jar href="./signedLibraries/signed-eagle-mapper-2.0.jar"/>
		<jar href="./signedLibraries/signed-commons-el.jar"/>
		<jar href="./signedLibraries/signed-commons-logging-api.jar"/>
		<jar href="./signedLibraries/signed-jakarta-oro-2.0.5.jar"/>
		<jar href="./signedLibraries/signed-jlfgr-1_0.jar"/>
		<jar href="./signedLibraries/signed-jsp-api.jar"/>
		<jar href="./signedLibraries/signed-junit.jar"/>
		<jar href="./signedLibraries/signed-jxl.jar"/>
		<jar href="./signedLibraries/signed-kunststoff.jar"/>
		<jar href="./signedLibraries/signed-tinylaf_.jar"/>
		<jar href="./signedLibraries/signed-swinglink.jar"/>
		<jar href="./signedLibraries/signed-xerces.jar"/>
		<jar href="./signedLibraries/signed-xml-apis.jar"/>
		<jar href="./signedLibraries/signed-commons-codec-1.3.jar"/> 
		<jar href="./signedLibraries/signed-commons-httpclient-3.0-rc2.jar"/> 
		<jar href="./signedLibraries/signed-commons-logging.jar"/>
		
		<property name="bpm_host" value="<%=host%>"/>
		<property name="bpm_port" value="<%=port%>"/>
		<property name="bpm_userId" value="<%=bpm_userId%>"/>
		<property name="bpm_encryptedPasswd" value="<%=bpm_encryptedPasswd%>"/>
		<property name="companyCode" value="<%=loggedUserCompanyId%>"/>
		<property name="connectionURL" value="<%=HttpUtil.getBaseUrl(request)%>"/>		
	</resources> 	  
<%
	String formId = request.getParameter("formId");
	String formVerId = request.getParameter("formVerId");
	String definitionId = request.getParameter("definitionId");
	String savePath = request.getParameter("savePath");
	String mode = request.getParameter("mode");
	
	System.out.println(">>>formId : " + formId);
	System.out.println(">>>definitionId : " + definitionId);
%>
	<application-desc main-class="com.webdeninteractive.xbotts.Mapping.maptool.MapToolController"> 
		<argument><%=formId%></argument>
		<argument><%=formVerId%></argument> 
		<argument><%=definitionId%></argument>
		<argument><%=savePath%></argument>
		<argument><%=mode%></argument> 
		<argument>C:/home6/xoffice/bpm/formlink</argument>
		<argument><%=codebase%></argument>		    
	</application-desc>
</jnlp>