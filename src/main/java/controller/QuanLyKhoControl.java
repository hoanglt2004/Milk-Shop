package controller;

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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        WarehouseDAO warehouseDAO = new WarehouseDAO();
        List<Warehouse> listEntries = warehouseDAO.getAllWarehouseEntries();
        List<Product> listProducts = warehouseDAO.getAllProducts();
        List<entity.ProductStock> listProductStock = warehouseDAO.getTotalStockPerProduct();

        request.setAttribute("listE", listEntries);
        request.setAttribute("listP", listProducts); // Pass product list for dropdown
        request.setAttribute("listPS", listProductStock); // Pass total stock per product
        request.getRequestDispatcher("QuanLyKho.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        WarehouseDAO warehouseDAO = new WarehouseDAO();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        if (action != null) {
            try {
                if (action.equalsIgnoreCase("add")) {
                    int productID = Integer.parseInt(request.getParameter("productID"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    java.util.Date importDate = sdf.parse(request.getParameter("importDate"));

                    Warehouse entry = new Warehouse();
                    entry.setProductID(productID);
                    entry.setQuantity(quantity);
                    entry.setImportDate(importDate);
                    entry.setRemainingQuantity(quantity); // Initially remaining is full quantity

                    warehouseDAO.addWarehouseEntry(entry);
                    request.getSession().setAttribute("successMessage", "Thêm thông tin nhập kho thành công!");

                } else if (action.equalsIgnoreCase("edit")) {
                    int warehouseID = Integer.parseInt(request.getParameter("warehouseID"));
                     int productID = Integer.parseInt(request.getParameter("productID"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    java.util.Date importDate = sdf.parse(request.getParameter("importDate"));
                     int remainingQuantity = Integer.parseInt(request.getParameter("remainingQuantity")); // Allow editing remaining quantity with caution

                    Warehouse entry = new Warehouse();
                    entry.setWarehouseID(warehouseID);
                     entry.setProductID(productID);
                    entry.setQuantity(quantity);
                    entry.setImportDate(importDate);
                    entry.setRemainingQuantity(remainingQuantity);

                    warehouseDAO.updateWarehouseEntry(entry);
                    request.getSession().setAttribute("successMessage", "Cập nhật thông tin kho thành công!");

                } else if (action.equalsIgnoreCase("delete")) {
                    int warehouseID = Integer.parseInt(request.getParameter("warehouseID"));
                    warehouseDAO.deleteWarehouseEntry(warehouseID);
                    request.getSession().setAttribute("successMessage", "Xóa thông tin kho thành công!");
                }
            } catch (ParseException | NumberFormatException e) {
                e.printStackTrace();
                // Set error in session for redirect
                request.getSession().setAttribute("errorMessage", "Lỗi: Dữ liệu nhập vào không hợp lệ. Vui lòng kiểm tra lại.");
            } catch (Exception e) {
                e.printStackTrace();
                // Set error in session for redirect
                request.getSession().setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            }
        }

        // Redirect back to the warehouse management page after processing
        response.sendRedirect("quanLyKho");
    }
}