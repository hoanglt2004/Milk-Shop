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


@WebServlet(name = "EditProfileControl", urlPatterns = {"/editProfile"})
public class EditProfileControl extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("acc");
        
        // Kiểm tra session và account
        if (account == null) {
            // Session đã hết hạn hoặc không có account, chuyển về trang login
            response.sendRedirect("Login.jsp");
            return;
        }
        
        try {
            DAO dao = new DAO();
            // Lấy thông tin đầy đủ của account từ database
            Account fullAccount = dao.getAccountWithFullInfo(account.getId());
            request.setAttribute("fullAccount", fullAccount);
        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi khi tải thông tin tài khoản: " + e.getMessage());
        }
        
        request.getRequestDispatcher("EditProfile.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");
        
        // Debug log
        System.out.println("Session ID: " + session.getId());
        System.out.println("Account in session: " + a);
        if (a != null) {
            System.out.println("Account ID: " + a.getId());
            System.out.println("Account Username: " + a.getUser());
        }
        
        // Kiểm tra session và account
        if (a == null) {
            // Session đã hết hạn hoặc không có account, chuyển về trang login
            System.out.println("Account is null, redirecting to login");
            response.sendRedirect("Login.jsp");
            return;
        }
        
        int id = a.getId();
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String province = request.getParameter("province");
        
        // Kiểm tra dữ liệu đầu vào bắt buộc
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty() || 
            email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc!");
            request.setAttribute("fullAccount", a);
            request.getRequestDispatcher("EditProfile.jsp").forward(request, response);
            return;
        }
        
        try {
            DAO dao = new DAO();
            dao.editProfileWithFullInfo(username, password, email, fullName, phone, address, province, id);
            
            // Cập nhật session với thông tin mới
            Account updatedAccount = dao.getAccountWithFullInfo(id);
            session.setAttribute("acc", updatedAccount);
            
            request.setAttribute("mess", "Cập nhật thông tin cá nhân thành công!");
            request.setAttribute("fullAccount", updatedAccount);
        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi xảy ra khi cập nhật thông tin: " + e.getMessage());
            request.setAttribute("fullAccount", a);
        }

        request.getRequestDispatcher("EditProfile.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
