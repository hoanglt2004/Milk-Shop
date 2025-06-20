package control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DAO;
import entity.Account;

@WebServlet(name = "ProfileControl", urlPatterns = {"/profile"})
public class ProfileControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("acc");
        
        if (account == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        try {
            DAO dao = new DAO();
            // Lấy thông tin account đầy đủ từ database
            Account fullAccount = dao.getAccountWithFullInfo(account.getId());
            
            if (fullAccount != null) {
                request.setAttribute("account", fullAccount);
            } else {
                request.setAttribute("account", account);
            }
            
            request.getRequestDispatcher("Profile.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi tải thông tin: " + e.getMessage());
            request.getRequestDispatcher("Profile.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Profile Control for displaying account information";
    }
} 