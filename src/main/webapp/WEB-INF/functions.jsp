<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@ page import="java.util.*" %>
                <%@ page import="java.text.SimpleDateFormat" %>
                    <%@ page import="utils.PriceFormatter" %>
                        <%@ page import="utils.VersionUtil" %>

                            <%! // Function to format price in Vietnamese Dong public String formatPrice(double price) {
                                return PriceFormatter.formatPriceVND(price); } // CSS Versioning để tránh cache browser
                                public String getCSSVersion() { return VersionUtil.getCSSVersion(); } %>

                                <% // Make functions available in request scope request.setAttribute("priceFormatter",
                                    new Object() { public String format(double price) { return formatPrice(price); } });
                                    // Set CSS version as page context attribute pageContext.setAttribute("cssVersion",
                                    getCSSVersion()); %>