/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import dao.DAO;
import entity.Account;
import entity.Cart;
import entity.Product;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AddCartControl", urlPatterns = {"/addCart"})
public class AddCartControl extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8"); 
        int productID = Integer.parseInt(request.getParameter("pid"));
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");
        
        int amount = Integer.parseInt(request.getParameter("quantity"));
        String size = request.getParameter("size");
        
        DAO dao = new DAO();
        String message = "";
        
        if (a != null) {
            // Nếu đã đăng nhập, thêm vào database
            Cart cartExisted = dao.checkCartExist(a.getId(), productID);
            if (cartExisted != null) {
                dao.editAmountAndSizeCart(a.getId(), productID, 
                    cartExisted.getAmount() + amount, size);
            } else {
                dao.insertCart(a.getId(), productID, amount, size);
            }
            message = "Đã thêm sản phẩm vào giỏ hàng!";
        } else {
            // Nếu chưa đăng nhập, thêm vào session
            List<Cart> cartList = (List<Cart>) session.getAttribute("cartList");
            if (cartList == null) {
                cartList = new ArrayList<>();
            }
            
            boolean productExists = false;
            for (Cart cart : cartList) {
                if (cart.getProductID() == productID) {
                    cart.setAmount(cart.getAmount() + amount);
                    productExists = true;
                    break;
                }
            }
            
            if (!productExists) {
                Cart cart = new Cart();
                cart.setProductID(productID);
                cart.setAmount(amount);
                cart.setSize(size);
                cartList.add(cart);
            }
            
            session.setAttribute("cartList", cartList);
            message = "Đã thêm sản phẩm vào giỏ hàng! (Chưa đăng nhập)";
        }
        
        // Return JSON response for AJAX requests
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("{\"success\": true, \"message\": \"" + message + "\"}");
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
