/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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


@WebServlet(name = "LoadMoreAdidasControl", urlPatterns = {"/loadAdidas"})
public class LoadMoreAdidasControl extends HttpServlet {

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
        
        String amount = request.getParameter("exitsAdidas");
        int iamount = Integer.parseInt(amount);
        DAO dao = new DAO();
        List<Product> list = dao.getNext4AdidasProduct(iamount);
        PrintWriter out = response.getWriter();

        for (Product o : list) {
            out.println("<div class=\"productAdidas col-12 col-md-6 col-lg-3 product-card-container\">\r\n"
                    + "    <div class=\"product-card\">\r\n"
                    + "        <div class=\"product-image-container\">\r\n"
                    + "            <img class=\"product-image\" src=\"" + o.getImage() + "\" alt=\"" + o.getName() + "\">\r\n"
                    + "            <div class=\"product-badge\">Sale</div>\r\n"
                    + "            <div class=\"quick-view-overlay\">\r\n"
                    + "                <button class=\"quick-view-btn\" onclick=\"window.location.href='detail?pid=" + o.getId() + "'\">\r\n"
                    + "                    <i class=\"fas fa-eye mr-2\"></i>Xem chi tiết\r\n"
                    + "                </button>\r\n"
                    + "            </div>\r\n"
                    + "        </div>\r\n"
                    + "        <div class=\"product-card-body\">\r\n"
                    + "            <h4 class=\"product-title\">\r\n"
                    + "                <a href=\"detail?pid=" + o.getId() + "\" title=\"View Product\">" + o.getName() + "</a>\r\n"
                    + "            </h4>\r\n"
                    + "            <p class=\"product-description\">" + o.getTitle() + "</p>\r\n"
                    + "            <div class=\"product-rating\">\r\n"
                    + "                <div class=\"stars\">\r\n"
                    + "                    <i class=\"fas fa-star\"></i>\r\n"
                    + "                    <i class=\"fas fa-star\"></i>\r\n"
                    + "                    <i class=\"fas fa-star\"></i>\r\n"
                    + "                    <i class=\"fas fa-star\"></i>\r\n"
                    + "                    <i class=\"fas fa-star\"></i>\r\n"
                    + "                </div>\r\n"
                    + "                <span class=\"rating-text\">(5.0)</span>\r\n"
                    + "            </div>\r\n"
                    + "            <div class=\"product-price-section\">\r\n"
                    + "                <a href=\"detail?pid=" + o.getId() + "\" class=\"product-price\">\r\n"
                    + "                    " + String.format("%,.0f", o.getPrice()).replace(",", ".") + " VNĐ\r\n"
                    + "                </a>\r\n"
                    + "            </div>\r\n"
                    + "        </div>\r\n"
                    + "    </div>\r\n"
                    + "</div>");
        }
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
