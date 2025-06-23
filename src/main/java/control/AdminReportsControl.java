/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import dao.DAO;
import entity.Account;
import entity.Product;
import entity.SoLuongDaBan;
import entity.TongChiTieuBanHang;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "AdminReportsControl", urlPatterns = {"/adminReports"})
public class AdminReportsControl extends HttpServlet {

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
        DAO dao = new DAO();
        
        if(a == null) {
            response.sendRedirect("login");
            return;
        }
        
        int uID = a.getId();
        int checkIsAdmin = dao.checkAccountAdmin(uID);
        if(checkIsAdmin == 0) {
            response.sendRedirect("login");
            return;
        }
        
        // Lấy dữ liệu Top 10 sản phẩm bán chạy
        List<SoLuongDaBan> listTop10Product = dao.getTop10SanPhamBanChay();
        List<Product> listAllProduct = dao.getAllProduct();
        
        // Lấy dữ liệu Top 5 khách hàng VIP
        List<TongChiTieuBanHang> listTop5KhachHang = dao.getTop5KhachHang();
        List<Account> listAllAccount = dao.getAllAccount();
        
        // Set attributes cho JSP
        request.setAttribute("listTop10Product", listTop10Product);
        request.setAttribute("listAllProduct", listAllProduct);
        request.setAttribute("listTop5KhachHang", listTop5KhachHang);
        request.setAttribute("listAllAccount", listAllAccount);
        
        // Forward đến trang Reports
        request.getRequestDispatcher("AdminReports.jsp").forward(request, response);
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
        return "Admin Reports Controller";
    }// </editor-fold>

} 