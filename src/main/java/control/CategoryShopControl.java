/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import dao.DAO;
import entity.Category;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "CategoryShopControl", urlPatterns = {"/categoryShop"})
public class CategoryShopControl extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String cateID = request.getParameter("cid");
        //da lay dc category id ve roi
        DAO dao = new DAO();
        List<Product> list = dao.getProductByCID(cateID);
        //in list p day
        PrintWriter out = response.getWriter();
        for(Product o : list) {
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
"                    <p class=\"product-description\">" + o.getBrand() + "</p>\n" + // Assuming getBrand() is what was meant by title
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
//        List<Category> listC = dao.getAllCategory();
//        Product last = dao.getLast();
//        
//        
//        
//        request.setAttribute("listP", list);
//        request.setAttribute("listCC", listC);
//        request.setAttribute("p", last);
//        request.setAttribute("tag", cateID);
//        request.getRequestDispatcher("Home.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
