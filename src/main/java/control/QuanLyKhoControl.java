package control;

import dao.WarehouseDAO;
import entity.Product;
import entity.Warehouse;
import entity.ProductStock;

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

@WebServlet(name = "QuanLyKhoControl", urlPatterns = {"/quanLyKho"})
public class QuanLyKhoControl extends HttpServlet {

     private static final SimpleDateFormat SDF_DATETIME = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
     private static final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy-MM-dd");

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
        WarehouseDAO warehouseDAO = new WarehouseDAO();
        String errorMessage = null;

        if (action != null) {
            try {
                if (action.equalsIgnoreCase("add")) {
                    int productID = Integer.parseInt(request.getParameter("productID"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    String importDateStr = request.getParameter("importDate");
                    
                    Date importDate = null;

                     // Basic Validation
                    if (quantity < 1) {
                        errorMessage = "Số lượng nhập phải lớn hơn 0.";
                    } else {
                         try {
                             importDate = SDF_DATETIME.parse(importDateStr);
                         } catch (ParseException e) {
                              errorMessage = "Định dạng ngày nhập không hợp lệ.";
                         }
                    }
                    
                    if (errorMessage == null) {
                        Warehouse entry = new Warehouse();
                        entry.setProductID(productID);
                        entry.setQuantity(quantity);
                        entry.setImportDate(importDate);
                        entry.setRemainingQuantity(quantity);

                        warehouseDAO.addWarehouseEntry(entry);
                         request.setAttribute("successMessage", "Nhập kho thành công.");
                    }

                } else if (action.equalsIgnoreCase("edit")) {
                     int warehouseID = Integer.parseInt(request.getParameter("warehouseID"));
                     int productID = Integer.parseInt(request.getParameter("productID"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    String importDateStr = request.getParameter("importDate");
                     int remainingQuantity = Integer.parseInt(request.getParameter("remainingQuantity"));
                     
                     Date importDate = null;

                     // Basic Validation
                     if (quantity < 0 || remainingQuantity < 0) {
                         errorMessage = "Số lượng không được âm.";
                     } else if (remainingQuantity > quantity) {
                         errorMessage = "Số lượng tồn không thể lớn hơn số lượng nhập.";
                     } else {
                          try {
                             importDate = SDF_DATETIME.parse(importDateStr);
                         } catch (ParseException e) {
                              errorMessage = "Định dạng ngày nhập không hợp lệ.";
                         }
                     }
                    
                     if(errorMessage == null) {
                        Warehouse entry = new Warehouse();
                        entry.setWarehouseID(warehouseID);
                        entry.setProductID(productID);
                        entry.setQuantity(quantity);
                        entry.setImportDate(importDate);
                        entry.setRemainingQuantity(remainingQuantity);

                        warehouseDAO.updateWarehouseEntry(entry);
                         request.setAttribute("successMessage", "Cập nhật thông tin nhập kho thành công.");
                     }

                } else if (action.equalsIgnoreCase("delete")) {
                    int warehouseID = Integer.parseInt(request.getParameter("warehouseID"));
                    warehouseDAO.deleteWarehouseEntry(warehouseID);
                     request.setAttribute("successMessage", "Xóa thông tin nhập kho thành công.");
                }
            } catch (NumberFormatException e) {
                 errorMessage = "Dữ liệu nhập vào không hợp lệ.";
                e.printStackTrace();
            } catch (Exception e) {
                 errorMessage = "Đã xảy ra lỗi trong quá trình xử lý.";
                 e.printStackTrace();
            }
        }

        List<Warehouse> listEntries = warehouseDAO.getAllWarehouseEntries();
        List<Product> listProducts = warehouseDAO.getAllProducts();
        List<ProductStock> listProductStock = warehouseDAO.getTotalStockPerProduct();

        request.setAttribute("listE", listEntries);
        request.setAttribute("listP", listProducts);
        request.setAttribute("listPS", listProductStock);
        request.setAttribute("errorMessage", errorMessage);
         request.setAttribute("successMessage", request.getAttribute("successMessage")); // Keep success message after redirect

        request.getRequestDispatcher("QuanLyKho.jsp").forward(request, response);
    }
}
