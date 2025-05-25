package controller;

import dao.WarehouseDAO;
import entity.Warehouse;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "WarehouseServlet", urlPatterns = {"/warehouse"})
public class WarehouseServlet extends HttpServlet {

    private WarehouseDAO warehouseDAO;

    @Override
    public void init() throws ServletException {
        warehouseDAO = new WarehouseDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            // Default action: show all warehouses
            List<Warehouse> warehouses = warehouseDAO.getAllWarehouses();
            request.setAttribute("warehouseList", warehouses);
            request.getRequestDispatcher("warehouse.jsp").forward(request, response);
        } else {
            switch (action) {
                case "edit":
                    handleEdit(request, response);
                    break;
                case "delete":
                    handleDelete(request, response);
                    break;
                default:
                    response.sendRedirect("warehouse");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        switch (action) {
            case "add":
                handleAdd(request, response);
                break;
            case "update":
                handleUpdate(request, response);
                break;
            default:
                response.sendRedirect("warehouse");
        }
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Warehouse warehouse = new Warehouse();
            warehouse.setProductID(Integer.parseInt(request.getParameter("productID")));
            warehouse.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            warehouse.setImportDate(Date.valueOf(request.getParameter("importDate")));
            warehouse.setRemainingQuantity(Integer.parseInt(request.getParameter("remainingQuantity")));
            
            warehouseDAO.addWarehouse(warehouse);
            response.sendRedirect("warehouse");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi thêm kho: " + e.getMessage());
            request.getRequestDispatcher("warehouse.jsp").forward(request, response);
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Warehouse warehouse = new Warehouse();
            warehouse.setWarehouseID(Integer.parseInt(request.getParameter("warehouseID")));
            warehouse.setProductID(Integer.parseInt(request.getParameter("productID")));
            warehouse.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            warehouse.setImportDate(Date.valueOf(request.getParameter("importDate")));
            warehouse.setRemainingQuantity(Integer.parseInt(request.getParameter("remainingQuantity")));
            
            warehouseDAO.updateWarehouse(warehouse);
            response.sendRedirect("warehouse");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi cập nhật kho: " + e.getMessage());
            request.getRequestDispatcher("warehouse.jsp").forward(request, response);
        }
    }

    private void handleEdit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Warehouse warehouse = warehouseDAO.getWarehouseByID(id);
            request.setAttribute("warehouse", warehouse);
            request.getRequestDispatcher("warehouse.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Lỗi khi lấy thông tin kho: " + e.getMessage());
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            warehouseDAO.deleteWarehouse(id);
            response.sendRedirect("warehouse");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi xóa kho: " + e.getMessage());
            request.getRequestDispatcher("warehouse.jsp").forward(request, response);
        }
    }
} 