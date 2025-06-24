package control;

import dao.DAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateInvoiceStatusControl", urlPatterns = {"/updateInvoiceStatus"})
public class UpdateInvoiceStatusControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        String maHDStr = request.getParameter("maHD");
        String newStatus = request.getParameter("status");
        
        try {
            int maHD = Integer.parseInt(maHDStr);
            DAO dao = new DAO();
            
            // Cập nhật trạng thái
            dao.updateInvoiceStatus(maHD, newStatus);
            
            // Nếu trạng thái = "Hoàn thành", cập nhật doanh thu và số lượng đã bán
            if ("Hoàn thành".equals(newStatus)) {
                dao.updateRevenueAndSales(maHD);
            }
            
            // Trả về JSON response
            response.getWriter().println("{\"success\": true, \"message\": \"Cập nhật trạng thái thành công\"}");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("{\"success\": false, \"message\": \"Lỗi: " + e.getMessage() + "\"}");
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
} 