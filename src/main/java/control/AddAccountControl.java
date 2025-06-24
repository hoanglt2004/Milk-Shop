/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 * author: H.M.Duc
 */
package control;

import dao.DAO;
import entity.Account;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "AddAccountControl", urlPatterns = {"/addAccount"})
public class AddAccountControl extends HttpServlet {

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
        
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
        String isAdmin = request.getParameter("isAdmin");
        String email = request.getParameter("email");
       
        // Validation
        if(user == null || user.trim().isEmpty() || 
           pass == null || pass.trim().isEmpty() || 
           isAdmin == null || isAdmin.trim().isEmpty() ||
           email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc!");
            request.getRequestDispatcher("managerAccount").forward(request, response);
            return;
        }
        
        DAO dao = new DAO();
        
        // Kiểm tra tài khoản đã tồn tại
        Account existingAccount = dao.checkAccountExist(user);
        if(existingAccount != null) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("managerAccount").forward(request, response);
            return;
        }
        
        // Kiểm tra email đã tồn tại
        if(dao.checkEmailExists(email)) {
            request.setAttribute("error", "Email đã được sử dụng!");
            request.getRequestDispatcher("managerAccount").forward(request, response);
            return;
        }
        
        try {
            // Thêm tài khoản mới
            dao.insertAccount(user, pass, isAdmin, email);
            request.setAttribute("mess", "Thêm tài khoản thành công!");
        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi xảy ra khi thêm tài khoản: " + e.getMessage());
        }

        request.getRequestDispatcher("managerAccount").forward(request, response);
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
        return "Add Account Controller";
    }// </editor-fold>

}
