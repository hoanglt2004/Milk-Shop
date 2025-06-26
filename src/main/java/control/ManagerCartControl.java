/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import dao.DAO;
import dao.WarehouseDAO;
import entity.Account;
import entity.Cart;
import entity.Category;
import entity.Product;
import entity.ProductStock;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author trinh
 */
@WebServlet(name = "ManagerCartControl", urlPatterns = {"/managerCart"})
public class ManagerCartControl extends HttpServlet {

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
        
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");
        
        DAO dao = new DAO();
        WarehouseDAO warehouseDAO = new WarehouseDAO();
        
        List<Category> listC = dao.getAllCategory();
        List<Product> listProduct = dao.getAllProduct();
        List<ProductStock> listProductStock = warehouseDAO.getTotalStockPerProduct();
        
        List<Cart> listCart;
        
        if(a == null) {
            // Nếu chưa đăng nhập, lấy cart từ session
            listCart = (List<Cart>) session.getAttribute("cartList");
            if (listCart == null) {
                listCart = new ArrayList<>();
            }
            request.setAttribute("isGuest", true);
        } else {
            // Nếu đã đăng nhập, lấy cart từ database
            int accountID = a.getId();
            listCart = dao.getCartByAccountID(accountID);
            request.setAttribute("isGuest", false);
        }
        
        request.setAttribute("listCategory", listC);
        request.setAttribute("listCart", listCart);
        request.setAttribute("listProduct", listProduct);
        request.setAttribute("listProductStock", listProductStock);
        request.getRequestDispatcher("Cart.jsp").forward(request, response);
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
