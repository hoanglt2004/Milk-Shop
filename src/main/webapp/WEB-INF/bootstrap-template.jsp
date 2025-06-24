<%--
    Bootstrap Template - Centralized Bootstrap CSS/JS includes
    Version: Bootstrap 4.6.0 (Stable)
    Include this file in JSP pages to ensure consistent Bootstrap loading
--%>
<%@ include file="functions.jsp" %>

<!-- Meta tags required for Bootstrap -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- ===== CORE CSS ===== -->
<!-- Bootstrap 4.6.0 CSS (CDN) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet" 
      integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

<!-- Font Awesome 5.15.4 -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">

<!-- ===== CUSTOM CSS (Load after Bootstrap) ===== -->
<link href="css/style.css?v=${cssVersion}" rel="stylesheet" type="text/css">
<link href="css/categories.css?v=${cssVersion}" rel="stylesheet" type="text/css">
<link href="css/product-cards.css?v=${cssVersion}" rel="stylesheet" type="text/css">

<!-- ===== JAVASCRIPT (Should be at end of body, but defined here for template) ===== -->
<!-- jQuery 3.6.0 (Required for Bootstrap) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js" 
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<!-- Popper.js (Required for Bootstrap dropdowns, tooltips, etc.) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js" 
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

<!-- Bootstrap 4.6.0 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" 
        integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>

<%--
    Usage Instructions:
    
    1. In JSP files, include this template in <head>:
       <%@ include file="WEB-INF/bootstrap-template.jsp" %>
    
    2. For custom CSS, add after the template:
       <link href="css/your-custom.css?v=${cssVersion}" rel="stylesheet">
    
    3. For custom JS, add before closing </body>:
       <script src="js/your-script.js?v=${jsVersion}"></script>
    
    4. DO NOT add additional Bootstrap CDN links to avoid conflicts
--%> 