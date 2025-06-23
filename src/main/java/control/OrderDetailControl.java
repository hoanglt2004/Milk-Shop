package control;

import dao.DAO;
import dao.InvoiceDAO;
import entity.Account;
import entity.Invoice;
import entity.Product;
import entity.Cart;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "OrderDetailControl", urlPatterns = {"/orderDetail"})
public class OrderDetailControl extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("acc");
        
        if (account == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        String orderIdStr = request.getParameter("orderId");
        if (orderIdStr == null || orderIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            InvoiceDAO invoiceDAO = new InvoiceDAO();
            DAO dao = new DAO();
            
            // Lấy thông tin invoice
            Invoice invoice = invoiceDAO.getInvoiceById(orderId);
            
            // Kiểm tra quyền truy cập (chỉ cho phép xem đơn hàng của chính mình)
            if (invoice == null || invoice.getAccountID() != account.getId()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
            
            // Lấy chi tiết sản phẩm (giả lập từ Cart)
            List<Cart> orderDetails = dao.getOrderDetailsByInvoiceId(orderId);
            List<Product> allProducts = dao.getAllProduct();
            
            // Render HTML response
            PrintWriter out = response.getWriter();
            out.println("<div class='order-detail'>");
            
            // Order info
            out.println("<div class='row mb-4'>");
            out.println("<div class='col-md-6'>");
            out.println("<h6><strong>Thông tin đơn hàng</strong></h6>");
            out.println("<p><strong>Mã đơn hàng:</strong> #" + invoice.getMaHD() + "</p>");
            out.println("<p><strong>Ngày đặt:</strong> " + invoice.getNgayXuat() + "</p>");
            out.println("<p><strong>Trạng thái:</strong> " + invoice.getStatus() + "</p>");
            out.println("</div>");
            out.println("<div class='col-md-6'>");
            out.println("<h6><strong>Thông tin thanh toán</strong></h6>");
            out.println("<p><strong>Tổng tiền:</strong> " + String.format("%,.0f", invoice.getTongGia()).replace(",", ".") + " VNĐ</p>");
            if (invoice.getDeliveryDate() != null) {
                out.println("<p><strong>Ngày giao:</strong> " + invoice.getDeliveryDate() + "</p>");
            }
            out.println("</div>");
            out.println("</div>");
            
            // Product list
            out.println("<h6><strong>Sản phẩm đã đặt</strong></h6>");
            out.println("<div class='table-responsive'>");
            out.println("<table class='table table-bordered'>");
            out.println("<thead class='thead-light'>");
            out.println("<tr>");
            out.println("<th>Sản phẩm</th>");
            out.println("<th>Hình ảnh</th>");
            out.println("<th>Số lượng</th>");
            out.println("<th>Đơn giá</th>");
            out.println("<th>Thành tiền</th>");
            out.println("</tr>");
            out.println("</thead>");
            out.println("<tbody>");
            
            double subtotal = 0;
            for (Cart cart : orderDetails) {
                for (Product product : allProducts) {
                    if (product.getId() == cart.getProductID()) {
                        double itemTotal = product.getPrice() * cart.getAmount();
                        subtotal += itemTotal;
                        
                        out.println("<tr>");
                        out.println("<td>" + product.getName() + "</td>");
                        out.println("<td><img src='" + product.getImage() + "' alt='" + product.getName() + "' style='width: 50px; height: 50px; object-fit: cover;'></td>");
                        out.println("<td>" + cart.getAmount() + "</td>");
                        out.println("<td>" + String.format("%,.0f", product.getPrice()).replace(",", ".") + " VNĐ</td>");
                        out.println("<td>" + String.format("%,.0f", itemTotal).replace(",", ".") + " VNĐ</td>");
                        out.println("</tr>");
                        break;
                    }
                }
            }
            
            out.println("</tbody>");
            out.println("<tfoot>");
            out.println("<tr>");
            out.println("<th colspan='4' class='text-right'>Tổng cộng:</th>");
            out.println("<th>" + String.format("%,.0f", subtotal).replace(",", ".") + " VNĐ</th>");
            out.println("</tr>");
            out.println("</tfoot>");
            out.println("</table>");
            out.println("</div>");
            
            // Timeline (optional)
            out.println("<div class='mt-4'>");
            out.println("<h6><strong>Trạng thái đơn hàng</strong></h6>");
            out.println("<div class='timeline'>");
            out.println("<div class='timeline-item'>");
            out.println("<i class='fas fa-check text-success'></i> Đơn hàng đã được đặt");
            out.println("</div>");
            if (!"Đã hủy".equals(invoice.getStatus())) {
                out.println("<div class='timeline-item'>");
                if ("Chờ xác nhận".equals(invoice.getStatus())) {
                    out.println("<i class='fas fa-clock text-warning'></i> Đang chờ xác nhận");
                } else {
                    out.println("<i class='fas fa-check text-success'></i> Đã xác nhận");
                }
                out.println("</div>");
                
                if ("Đang giao".equals(invoice.getStatus()) || "Hoàn thành".equals(invoice.getStatus())) {
                    out.println("<div class='timeline-item'>");
                    out.println("<i class='fas fa-shipping-fast text-info'></i> Đang giao hàng");
                    out.println("</div>");
                }
                
                if ("Hoàn thành".equals(invoice.getStatus())) {
                    out.println("<div class='timeline-item'>");
                    out.println("<i class='fas fa-check-circle text-success'></i> Đã hoàn thành");
                    out.println("</div>");
                }
            } else {
                out.println("<div class='timeline-item'>");
                out.println("<i class='fas fa-times text-danger'></i> Đơn hàng đã bị hủy");
                out.println("</div>");
            }
            out.println("</div>");
            out.println("</div>");
            
            out.println("</div>");
            
            // Add CSS for timeline
            out.println("<style>");
            out.println(".timeline { margin-left: 20px; }");
            out.println(".timeline-item { margin-bottom: 10px; padding-left: 30px; position: relative; }");
            out.println(".timeline-item i { position: absolute; left: -20px; top: 2px; }");
            out.println("</style>");
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    public String getServletInfo() {
        return "Order Detail Control";
    }
} 