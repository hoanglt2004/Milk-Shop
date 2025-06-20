<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%!
    // Function to format price in Vietnamese Dong
    public static String formatPrice(double price) {
        // Format with thousand separators using dots
        java.text.DecimalFormat formatter = new java.text.DecimalFormat("#,###");
        String formattedPrice = formatter.format(price);
        
        // Replace commas with dots for Vietnamese format
        formattedPrice = formattedPrice.replace(",", ".");
        
        return formattedPrice + " VNĐ";
    }
    
    // Function for discounted price
    public static String formatDiscountPrice(double price, double discountPercent) {
        double discountedPrice = price * (1 - discountPercent);
        return formatPrice(discountedPrice);
    }
%>

<%
    // Make functions available in request scope
    request.setAttribute("formatPrice", new Object() {
        public String format(double price) {
            return formatPrice(price);
        }
        public String formatDiscount(double price, double discount) {
            return formatDiscountPrice(price, discount);
        }
    });
%> 