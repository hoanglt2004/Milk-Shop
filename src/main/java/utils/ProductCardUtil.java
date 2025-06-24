package utils;

import entity.Product;
import java.text.NumberFormat;
import java.util.Locale;

public class ProductCardUtil {

    public static String generateProductCardHtml(Product o) {
        NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
        String price = nf.format(o.getPrice());
        
        StringBuilder html = new StringBuilder();
        html.append("<div class=\"col-md-4 mb-5 product-card-container\">")
            .append("<div class=\"product-card h-100\">")
            .append("<div class=\"product-image-container\">")
            .append("<img class=\"product-image\" src=\"").append(o.getImage()).append("\" alt=\"").append(o.getName()).append("\">")
            .append("<a href=\"detail?pid=").append(o.getId()).append("\">")
            .append("<div class=\"quick-view-overlay\">")
            .append("<button class=\"quick-view-btn\" onclick=\"window.location.href='detail?pid=").append(o.getId()).append("'; event.preventDefault();\">")
            .append("<i class=\"fas fa-eye mr-2\"></i>Xem chi tiết")
            .append("</button>")
            .append("</div>")
            .append("</a>");

        if (o.getDiscountPercent() > 0) {
            html.append("<div class=\"product-badge sale-badge\">-").append(o.getDiscountPercent()).append("%</div>");
        }

        html.append("</div>")
            .append("<div class=\"product-card-body\">")
            .append("<h4 class=\"product-title\">")
            .append("<a href=\"detail?pid=").append(o.getId()).append("\" title=\"View Product\">").append(o.getName()).append("</a>")
            .append("</h4>")
            .append("<p class=\"product-description\">").append(o.getBrand()).append("</p>")
            .append("<div class=\"product-rating\">")
            .append("<div class=\"stars\">")
            .append("<i class=\"fas fa-star\"></i><i class=\"fas fa-star\"></i><i class=\"fas fa-star\"></i><i class=\"fas fa-star\"></i><i class=\"fas fa-star-half-alt\"></i>")
            .append("</div>")
            .append("<span class=\"rating-text\">(4.5)</span>")
            .append("</div>")
            .append("<div class=\"product-price-section\">");

        if (o.getDiscountPercent() > 0) {
            String salePrice = nf.format(o.getSalePrice());
            html.append("<span class=\"product-price sale-price\">").append(salePrice).append(" VNĐ</span>")
                .append("<span class=\"product-price original-price\">").append(price).append(" VNĐ</span>");
        } else {
            html.append("<span class=\"product-price\">").append(price).append(" VNĐ</span>");
        }

        html.append("</div>") // close product-price-section
            .append("</div>") // close product-card-body
            .append("</div>") // close product-card
            .append("</div>"); // close col

        return html.toString();
    }
} 