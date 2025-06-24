package control;

import dao.DAO;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Comparator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SortByNameZA", urlPatterns = {"/sortByNameZA"})
public class SortByNameZA extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String txtSearch = request.getParameter("txt");
        String cid = request.getParameter("cid");
        DAO dao = new DAO();
        List<Product> list;
        if (cid != null && !cid.isEmpty()) {
            list = dao.getProductByCID(cid);
        } else if (txtSearch != null && !txtSearch.isEmpty()) {
            list = dao.searchByName(txtSearch);
        } else {
            list = dao.getAllProduct();
        }
        list.sort((a, b) -> b.getName().compareToIgnoreCase(a.getName()));
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