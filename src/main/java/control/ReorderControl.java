package control;

import dao.DAO;
import entity.Account;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ReorderControl", urlPatterns = {"/reorder"})
public class ReorderControl extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("acc");
        
        if (account == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        // Trả về JSON response thông báo
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"success\": false, \"message\": \"Chức năng mua lại không khả dụng do hệ thống không lưu trữ chi tiết sản phẩm trong đơn hàng. Vui lòng thêm sản phẩm vào giỏ hàng thủ công.\"}");
    }

    @Override
    public String getServletInfo() {
        return "Reorder Control";
    }
} 