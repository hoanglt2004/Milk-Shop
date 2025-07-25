/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import dao.DAO;
import entity.Account;
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
import javax.servlet.http.HttpSession;


@WebServlet(name = "ShopControl", urlPatterns = {"/shop"})
public class ShopControl extends HttpServlet {

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
        //b1: get data from dao
        DAO dao = new DAO();
        List<Category> listC = dao.getAllCategory();
        
        // Check if category ID is provided
        String cid = request.getParameter("cid");
        String index = request.getParameter("index");
        
        List<Product> list;
        int allProduct;
        int endPage;
        
        if(cid != null && !cid.isEmpty()) {
            // Get products by category
            list = dao.getProductByCID(cid);
            allProduct = list.size();
            endPage = allProduct/9;
            if(allProduct % 9 != 0) {
                endPage++;
            }
            // Set selected category for JSP
            request.setAttribute("selectedCid", cid);
        } else if(index != null && !index.isEmpty()) {
            // Get products with pagination
            int indexPage = Integer.parseInt(index);
            list = dao.getProductByIndex(indexPage);
            allProduct = dao.countAllProduct();
            endPage = allProduct/9;
            if(allProduct % 9 != 0) {
                endPage++;
            }
            request.setAttribute("tag", indexPage);
        } else {
            // Default: Show all products when accessing /shop directly
            list = dao.getAllProduct();
            allProduct = list.size();
            endPage = allProduct/9;
            if(allProduct % 9 != 0) {
                endPage++;
            }
            request.setAttribute("tag", 1);
        }
        
        request.setAttribute("endPage", endPage);
        request.setAttribute("listCC", listC);
        request.setAttribute("listP", list);

        request.getRequestDispatcher("Shop.jsp").forward(request, response);
        //404 -> url
        //500 -> jsp properties
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
