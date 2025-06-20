/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DAO;
import entity.Account;

@WebServlet(name = "SignUpControl", urlPatterns = {"/signup"})
public class SignUpControl extends HttpServlet {

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
        
        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String province = request.getParameter("province");
        
        DAO dao = new DAO();
        
        try {
            // Validation phía server
            String errorMessage = validateInput(username, password, confirmPassword, email, fullName, phone, address, province);
            
            if (errorMessage != null) {
                request.setAttribute("errorMessage", errorMessage);
                request.getRequestDispatcher("SignUp.jsp").forward(request, response);
                return;
            }
            
            // Kiểm tra tài khoản đã tồn tại
            Account existingAccount = dao.checkAccountExist(username);
            if (existingAccount != null) {
                request.setAttribute("errorMessage", "Tên đăng nhập đã tồn tại!");
                request.getRequestDispatcher("SignUp.jsp").forward(request, response);
                return;
            }
            
            // Kiểm tra email đã tồn tại
            if (dao.checkEmailExists(email)) {
                request.setAttribute("errorMessage", "Email đã được sử dụng!");
                request.getRequestDispatcher("SignUp.jsp").forward(request, response);
                return;
            }
            
            // Tạo tài khoản mới với đầy đủ thông tin
            dao.signupWithFullInfo(username, password, fullName, phone, address, province, email);
            
            // Chuyển hướng đến trang đăng nhập với thông báo thành công
            request.getSession().setAttribute("successMessage", 
                "Đăng ký tài khoản thành công! Chào mừng " + fullName + " đến với hệ thống. Vui lòng đăng nhập để tiếp tục.");
            response.sendRedirect("Login.jsp");
            return;
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("SignUp.jsp").forward(request, response);
        }
    }
    
    private String validateInput(String username, String password, String confirmPassword, 
                               String email, String fullName, String phone, String address, String province) {
        
        // Validate username
        if (username == null || username.trim().length() < 3 || username.trim().length() > 20) {
            return "Tên đăng nhập phải từ 3-20 ký tự";
        }
        if (!username.matches("^[a-zA-Z0-9_]+$")) {
            return "Tên đăng nhập chỉ được chứa chữ cái, số và dấu gạch dưới";
        }
        
        // Validate email
        if (email == null || !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            return "Email không hợp lệ";
        }
        
        // Validate password
        if (password == null || password.length() < 6) {
            return "Mật khẩu phải có ít nhất 6 ký tự";
        }
        
        // Validate confirm password
        if (!password.equals(confirmPassword)) {
            return "Mật khẩu xác nhận không khớp";
        }
        
        // Validate full name
        if (fullName == null || fullName.trim().length() < 2) {
            return "Họ và tên phải có ít nhất 2 ký tự";
        }
        
        // Validate phone
        if (phone == null || !phone.matches("^[0-9]{10,11}$")) {
            return "Số điện thoại phải có 10-11 chữ số";
        }
        
        // Validate province
        if (province == null || province.trim().isEmpty()) {
            return "Vui lòng chọn tỉnh/thành phố";
        }
        
        // Validate address
        if (address == null || address.trim().length() < 5) {
            return "Địa chỉ phải có ít nhất 5 ký tự";
        }
        
        return null; // No errors
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
        // Chuyển đến trang đăng ký
        request.getRequestDispatcher("SignUp.jsp").forward(request, response);
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
        return "Enhanced Signup Control for Account registration with full information";
    }// </editor-fold>

}
