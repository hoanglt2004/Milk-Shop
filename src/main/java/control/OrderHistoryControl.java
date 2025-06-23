package control;

import dao.DAO;
import dao.InvoiceDAO;
import entity.Account;
import entity.Invoice;
import entity.Product;
import entity.Cart;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "OrderHistoryControl", urlPatterns = {"/orderHistory"})
public class OrderHistoryControl extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("acc");
        
        // Kiểm tra session và account
        if (account == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        try {
            DAO dao = new DAO();
            InvoiceDAO invoiceDAO = new InvoiceDAO();
            
            // Lấy parameters để filter
            String statusFilter = request.getParameter("status");
            String timeFilter = request.getParameter("time");
            String searchKeyword = request.getParameter("search");
            
            // Lấy danh sách invoice của user
            List<Invoice> invoiceList = invoiceDAO.getInvoicesByAccountId(account.getId());
            
            // Filter theo status nếu có
            if (statusFilter != null && !statusFilter.isEmpty() && !statusFilter.equals("all")) {
                invoiceList = invoiceList.stream()
                    .filter(invoice -> statusFilter.equals(invoice.getStatus()))
                    .collect(java.util.stream.Collectors.toList());
            }
            
            // Filter theo thời gian nếu có
            if (timeFilter != null && !timeFilter.isEmpty()) {
                long currentTime = System.currentTimeMillis();
                long filterTime = 0;
                
                switch (timeFilter) {
                    case "30days":
                        filterTime = currentTime - (30L * 24 * 60 * 60 * 1000);
                        break;
                    case "3months":
                        filterTime = currentTime - (90L * 24 * 60 * 60 * 1000);
                        break;
                    case "6months":
                        filterTime = currentTime - (180L * 24 * 60 * 60 * 1000);
                        break;
                    case "1year":
                        filterTime = currentTime - (365L * 24 * 60 * 60 * 1000);
                        break;
                }
                
                if (filterTime > 0) {
                    final long finalFilterTime = filterTime;
                    invoiceList = invoiceList.stream()
                        .filter(invoice -> invoice.getNgayXuat().getTime() >= finalFilterTime)
                        .collect(java.util.stream.Collectors.toList());
                }
            }
            
            // Lấy thông tin sản phẩm cho từng invoice
            List<Product> allProducts = dao.getAllProduct();
            
            // Tính toán thống kê
            int totalOrders = invoiceList.size();
            double totalSpent = invoiceList.stream()
                .mapToDouble(Invoice::getTongGia)
                .sum();
            
            long completedOrders = invoiceList.stream()
                .filter(invoice -> "Hoàn thành".equals(invoice.getStatus()))
                .count();
            
            // Set attributes
            request.setAttribute("invoiceList", invoiceList);
            request.setAttribute("allProducts", allProducts);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalSpent", totalSpent);
            request.setAttribute("completedOrders", completedOrders);
            request.setAttribute("statusFilter", statusFilter);
            request.setAttribute("timeFilter", timeFilter);
            request.setAttribute("searchKeyword", searchKeyword);
            
        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi khi tải lịch sử đơn hàng: " + e.getMessage());
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("OrderHistory.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        String invoiceId = request.getParameter("invoiceId");
        
        if ("cancelOrder".equals(action) && invoiceId != null) {
            try {
                InvoiceDAO invoiceDAO = new InvoiceDAO();
                invoiceDAO.updateInvoiceStatus(Integer.parseInt(invoiceId), "Đã hủy");
                request.setAttribute("mess", "Hủy đơn hàng thành công!");
            } catch (Exception e) {
                request.setAttribute("error", "Có lỗi khi hủy đơn hàng: " + e.getMessage());
            }
        }
        
        // Redirect để tránh resubmit
        response.sendRedirect("orderHistory");
    }

    @Override
    public String getServletInfo() {
        return "Order History Control";
    }
} 