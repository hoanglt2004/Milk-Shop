<%-- 
    Simple Version Configuration - No Page Directives
    Alternative to functions.jsp for version management only
--%>

<%!
    // CSS/JS Version Configuration
    public static final String CSS_VERSION = "2.0.1";
    public static final String JS_VERSION = "2.0.1";
%>

<%
    // Set version variables in page context
    pageContext.setAttribute("cssVersion", CSS_VERSION);
    pageContext.setAttribute("jsVersion", JS_VERSION);
    
    // Also available in request scope
    request.setAttribute("cssVersion", CSS_VERSION);
    request.setAttribute("jsVersion", JS_VERSION);
%> 