<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@ page import="java.util.*" %>
                <%@ page import="java.text.SimpleDateFormat" %>

                    <%! // Function to format price in Vietnamese Dong public static String formatPrice(double price) {
                        // Format with thousand separators using dots java.text.DecimalFormat formatter=new
                        java.text.DecimalFormat("#,###"); String formattedPrice=formatter.format(price); // Replace
                        commas with dots for Vietnamese format formattedPrice=formattedPrice.replace(",", "." ); return
                        formattedPrice + " VNĐ" ; } // CSS Versioning để tránh cache browser public static String
                        getCSSVersion() { // Sử dụng build timestamp hoặc version từ manifest String version="1.0" ; try
                        { // Lấy từ MANIFEST.MF hoặc properties Properties props=new Properties(); String
                        buildTime=System.getProperty("app.build.time"); if (buildTime !=null) { version=buildTime; }
                        else { // Fallback: sử dụng deployment time version=String.valueOf(System.currentTimeMillis() /
                        1000); // Unix timestamp } } catch (Exception e) { // Fallback: sử dụng thời gian hiện tại
                        version=String.valueOf(System.currentTimeMillis() / 1000); } return version; } %>

                        <% // Make functions available in request scope request.setAttribute("formatPrice", new Object()
                            { public String format(double price) { return formatPrice(price); } }); // Set CSS version
                            as page context attribute pageContext.setAttribute("cssVersion", getCSSVersion()); %>