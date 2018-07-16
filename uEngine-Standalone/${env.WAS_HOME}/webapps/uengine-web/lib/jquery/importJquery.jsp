<link rel='stylesheet' type='text/css' href='<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT %>/lib/jquery/jquery-ui.css' />
<script type='text/javascript' src='<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT %>/lib/jquery/jquery-1.12.0.js'></script>
<script type='text/javascript' src='<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT %>/lib/jquery/jquery-ui.js'></script>
<script type='text/javascript' src='<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT %>/lib/jquery/jquery.cookie.js'></script>
<script>
jQuery.browser = {};
(function () {
    jQuery.browser.msie = false;
    jQuery.browser.version = 0;
    if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
        jQuery.browser.msie = true;
        jQuery.browser.version = RegExp.$1;
    }
})();
</script>
<script type='text/javascript' src='<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT %>/lib/jquery/jcalendar.js'></script>

<script type='text/javascript' src='<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT %>/lib/jquery/ajaxfileupload.js'></script>
<script type='text/javascript' src='<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT %>/lib/jquery/jquery.blink.min.js'></script>
