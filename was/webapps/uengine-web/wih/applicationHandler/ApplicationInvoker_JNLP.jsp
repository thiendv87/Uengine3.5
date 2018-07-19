<%@page contentType="application/x-java-jnlp-file"%>
<%	response.setContentType("application/x-java-jnlp-file");
	response.setHeader("Cache-Control", "public");
	response.setHeader("Expires", "0");

        String url = request.getRequestURL().toString();
        String codebase = url.substring( 0, url.lastIndexOf( "/" ) );
%>
<?xml version="1.0" encoding="utf-8"?> 
	<!-- you should modify the ip address for 'codebase' with an actual IP address of web server -->
	<jnlp 
  	  spec="1.0+" 
	  codebase="<%=codebase%>"> 
  	  <information> 
    	    <title>Metaworks Application</title> 
    	    <vendor>uEngine.org</vendor> 
    	      <homepage href="http://www.uengine.org/metaworks"/> 
    	      <description>Application invoker for u|Engine</description> 
    	      <description kind="short">Metaworks Application invoker for u|Engine.</description> 
    	    <offline-allowed/> 
  	  </information> 
	  <security> 
	    <all-permissions/> 
	  </security>   	  
  	  <resources> 
	    <j2se version="1.4+ 1.3+"/> 
            <jar href="signedmetaworks.jar"/> 
            <jar href="signedoracledriver.jar"/> 
          </resources> 
          <application-desc main-class="org.metaworks.defaultimplementation.DefaultDesktop"> 
		    <argument>legacyERP</argument> 
		    <argument>jdbc:oracle:thin:@localhost:1521:pongsor2</argument> 
		    <argument>scott</argument> 
		    <argument>tiger</argument> 
		    <argument><%=request.getParameter("defaultApplication")%></argument> 
		    <argument><%=codebase%></argument> 
	  </application-desc> 
</jnlp>