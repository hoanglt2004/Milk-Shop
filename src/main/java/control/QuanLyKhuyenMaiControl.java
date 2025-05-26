package control;

import dao.DiscountDAO;
import entity.Discount;
import entity.Product;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "QuanLyKhuyenMaiControl", urlPatterns = {"/quanLyKhuyenMai"})
public class QuanLyKhuyenMaiControl extends HttpServlet {

    private static final SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        DiscountDAO discountDAO = new DiscountDAO();
        String errorMessage = null;

        if (action != null) {
            try {
                if (action.equalsIgnoreCase("add")) {
                    int productID = Integer.parseInt(request.getParameter("productID"));
                    int percentOff = Integer.parseInt(request.getParameter("percentOff"));
                    String startDateStr = request.getParameter("startDate");
                    String endDateStr = request.getParameter("endDate");
                    boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
                    
                    Date startDate = null;
                    Date endDate = null;

                    // Basic Validation
                    if (percentOff < 1 || percentOff > 100) {
                        errorMessage = "Phần trăm giảm giá phải từ 1 đến 100.";
                    } else {
                         try {
                            startDate = SDF.parse(startDateStr);
                            endDate = SDF.parse(endDateStr);
                            if (startDate.after(endDate)) {
                                errorMessage = "Ngày kết thúc phải sau hoặc cùng ngày bắt đầu.";
                            }
                         } catch (ParseException e) {
                             errorMessage = "Định dạng ngày không hợp lệ.";
                         }
                    }

                    if (errorMessage == null) {
                        Discount discount = new Discount();
                        discount.setProductID(productID);
                        discount.setPercentOff(percentOff);
                        discount.setStartDate(startDate);
                        discount.setEndDate(endDate);
                        discount.setActive(isActive);

                        discountDAO.addDiscount(discount);
                         request.setAttribute("successMessage", "Thêm khuyến mãi thành công.");
                    }

                } else if (action.equalsIgnoreCase("edit")) {
                     int discountID = Integer.parseInt(request.getParameter("discountID"));
                    int productID = Integer.parseInt(request.getParameter("productID"));
                    int percentOff = Integer.parseInt(request.getParameter("percentOff"));
                    String startDateStr = request.getParameter("startDate");
                    String endDateStr = request.getParameter("endDate");
                    boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));

                    Date startDate = null;
                    Date endDate = null;

                    // Basic Validation
                    if (percentOff < 1 || percentOff > 100) {
                        errorMessage = "Phần trăm giảm giá phải từ 1 đến 100.";
                    } else {
                         try {
                            startDate = SDF.parse(startDateStr);
                            endDate = SDF.parse(endDateStr);
                             if (startDate.after(endDate)) {
                                errorMessage = "Ngày kết thúc phải sau hoặc cùng ngày bắt đầu.";
                            }
                         } catch (ParseException e) {
                             errorMessage = "Định dạng ngày không hợp lệ.";
                         }
                    }

                    if (errorMessage == null) {
                         Discount discount = new Discount();
                         discount.setDiscountID(discountID);
                         discount.setProductID(productID);
                         discount.setPercentOff(percentOff);
                         discount.setStartDate(startDate);
                         discount.setEndDate(endDate);
                         discount.setActive(isActive);

                        discountDAO.updateDiscount(discount);
                         request.setAttribute("successMessage", "Cập nhật khuyến mãi thành công.");
                    }

                } else if (action.equalsIgnoreCase("delete")) {
                    int discountID = Integer.parseInt(request.getParameter("discountID"));
                    discountDAO.deleteDiscount(discountID);
                     request.setAttribute("successMessage", "Xóa khuyến mãi thành công.");
                }
            } catch (NumberFormatException e) {
                errorMessage = "Dữ liệu nhập vào không hợp lệ.";
                e.printStackTrace();
            } catch (Exception e) {
                 errorMessage = "Đã xảy ra lỗi trong quá trình xử lý.";
                 e.printStackTrace();
            }
        }

        List<Discount> listDiscounts = discountDAO.getAllDiscounts();
        List<Product> listProducts = discountDAO.getAllProducts();

        request.setAttribute("listD", listDiscounts);
        request.setAttribute("listP", listProducts);
        request.setAttribute("errorMessage", errorMessage);

        request.getRequestDispatcher("QuanLyKhuyenMai.jsp").forward(request, response);
    }

}
