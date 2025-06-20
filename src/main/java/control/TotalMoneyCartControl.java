/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import dao.DAO;
import entity.Account;
import entity.Cart;
import entity.Category;
import entity.Product;
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


@WebServlet(name = "TotalMoneyCartControl", urlPatterns = {"/totalMoneyCart"})
public class TotalMoneyCartControl extends HttpServlet {

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
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");
        
        List<Cart> cartList;
        if (a != null) {
            // Nếu đã đăng nhập, lấy giỏ hàng từ database
            DAO dao = new DAO();
            cartList = dao.getCartByAccountID(a.getId());
        } else {
            // Nếu chưa đăng nhập, lấy giỏ hàng từ session
            cartList = (List<Cart>) session.getAttribute("cartList");
            if (cartList == null) {
                cartList = new ArrayList<>();
            }
        }
        
        // Lấy thông tin sản phẩm
        DAO dao = new DAO();
        List<Product> listProduct = dao.getAllProduct();
        
        // Tính tổng tiền
        double totalMoney = 0;
        for (Cart cart : cartList) {
            for (Product product : listProduct) {
                if (cart.getProductID() == product.getId()) {
                    totalMoney += product.getPrice() * cart.getAmount();
                }
            }
        }
        
        // Tính VAT (10% của tổng tiền hàng)
        double vatAmount = totalMoney * 0.1;
        
        // Tổng thanh toán = Tổng tiền hàng + VAT
        double totalMoneyVAT = totalMoney + vatAmount;
        
        // Format số tiền để hiển thị với VNĐ
        String formattedTotalMoney = String.format("%,.0f", totalMoney).replace(",", ".");
        String formattedVAT = String.format("%,.0f", vatAmount).replace(",", ".");
        String formattedTotalMoneyVAT = String.format("%,.0f", totalMoneyVAT).replace(",", ".");
        
        PrintWriter out = response.getWriter();
        out.println("<li class=\"d-flex justify-content-between py-3 border-bottom\"><strong class=\"text-muted\">Tổng tiền hàng</strong><strong>" + formattedTotalMoney + " VNĐ</strong></li>"
                + "<li class=\"d-flex justify-content-between py-3 border-bottom\"><strong class=\"text-muted\">Phí vận chuyển</strong><strong>Free ship</strong></li>"
                + "<li class=\"d-flex justify-content-between py-3 border-bottom\"><strong class=\"text-muted\">VAT (10%)</strong><strong>" + formattedVAT + " VNĐ</strong></li>"
                + "<li class=\"d-flex justify-content-between py-3 border-bottom\"><strong class=\"text-muted\">Tổng thanh toán</strong>"
                + "<h5 class=\"font-weight-bold\">" + formattedTotalMoneyVAT + " VNĐ</h5></li>");
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
