package control;

import dao.DAO;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SearchAjaxPriceDesc", urlPatterns = {"/searchAjaxPriceDesc"})
public class SearchAjaxPriceDesc extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String txtSearch = request.getParameter("txt");
        String cid = request.getParameter("cid");
        DAO dao = new DAO();
        List<Product> list;
        
        if (cid != null && !cid.isEmpty()) {
            // If category is selected, get products by category
            list = dao.getProductByCID(cid);
        } else if (txtSearch != null && !txtSearch.isEmpty()) {
            // If search text exists, get products by search
            list = dao.searchByName(txtSearch);
        } else {
            // If neither category nor search, get all products
            list = dao.getAllProduct();
        }
        
        // Sort the list by price in descending order
        list.sort((p1, p2) -> Double.compare(p2.getPrice(), p1.getPrice()));
        
        PrintWriter out = response.getWriter();
        for (Product o : list) {
            out.println("<div class=\"col-md-4 mb-5 product-card-container\">\n" +
"                <div class=\"product-card h-100\">\n" +
"                  <div class=\"product-image-container\">\n" +
"                    <img class=\"product-image\" src=\"" + o.getImage() + "\" alt=\"" + o.getName() + "\">\n" +
"                    <a href=\"detail?pid=" + o.getId() + "\">\n" +
"                      <div class=\"quick-view-overlay\">\n" +
"                        <button class=\"quick-view-btn\" onclick=\"window.location.href='detail?pid=" + o.getId() + "'; event.preventDefault();\">\n" +
"                            <i class=\"fas fa-eye mr-2\"></i>Xem chi tiết\n" +
"                        </button>\n" +
"                      </div>\n" +
"                    </a>\n" +
"                  </div>\n" +
"                  <div class=\"product-card-body\">\n" +
"                    <h4 class=\"product-title\">\n" +
"                        <a href=\"detail?pid=" + o.getId() + "\" title=\"View Product\">" + o.getName() + "</a>\n" +
"                    </h4>\n" +
"                    <p class=\"product-description\">" + o.getBrand() + "</p>\n" +
"                    <div class=\"product-rating\">\n" +
"                        <div class=\"stars\">\n" +
"                            <i class=\"fas fa-star\"></i>\n" +
"                            <i class=\"fas fa-star\"></i>\n" +
"                            <i class=\"fas fa-star\"></i>\n" +
"                            <i class=\"fas fa-star\"></i>\n" +
"                            <i class=\"fas fa-star-half-alt\"></i>\n" +
"                        </div>\n" +
"                        <span class=\"rating-text\">(4.5)</span>\n" +
"                    </div>\n" +
"                     <div class=\"product-price-section\">\n" +
"                        <a href=\"detail?pid=" + o.getId() + "\" class=\"product-price\">\n" +
"                            " + String.format("%,.0f", o.getPrice()).replace(",", ".") + " VNĐ\n" +
"                        </a>\n" +
"                    </div>\n" +
"                  </div>\n" +
"                </div>\n" +
"              </div>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
} 