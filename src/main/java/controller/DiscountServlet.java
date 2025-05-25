package controller;

import dao.DiscountDAO;
import entity.Discount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "DiscountServlet", urlPatterns = {"/discount"})
public class DiscountServlet extends HttpServlet {

    private DiscountDAO discountDAO;

    @Override
    public void init() throws ServletException {
        discountDAO = new DiscountDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            // Default action: show all discounts
            List<Discount> discounts = discountDAO.getAllDiscounts();
            request.setAttribute("discountList", discounts);
            request.getRequestDispatcher("discount.jsp").forward(request, response);
        } else {
            switch (action) {
                case "edit":
                    handleEdit(request, response);
                    break;
                case "delete":
                    handleDelete(request, response);
                    break;
                default:
                    response.sendRedirect("discount");
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
                response.sendRedirect("discount");
        }
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Discount discount = new Discount();
            discount.setProductID(Integer.parseInt(request.getParameter("productID")));
            discount.setPercentOff(Integer.parseInt(request.getParameter("percentOff")));
            discount.setStartDate(Date.valueOf(request.getParameter("startDate")));
            discount.setEndDate(Date.valueOf(request.getParameter("endDate")));
            discount.setActive(request.getParameter("isActive") != null);
            
            discountDAO.addDiscount(discount);
            response.sendRedirect("discount");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi thêm khuyến mãi: " + e.getMessage());
            request.getRequestDispatcher("discount.jsp").forward(request, response);
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Discount discount = new Discount();
            discount.setDiscountID(Integer.parseInt(request.getParameter("discountID")));
            discount.setProductID(Integer.parseInt(request.getParameter("productID")));
            discount.setPercentOff(Integer.parseInt(request.getParameter("percentOff")));
            discount.setStartDate(Date.valueOf(request.getParameter("startDate")));
            discount.setEndDate(Date.valueOf(request.getParameter("endDate")));
            discount.setActive(request.getParameter("isActive") != null);
            
            discountDAO.updateDiscount(discount);
            response.sendRedirect("discount");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi cập nhật khuyến mãi: " + e.getMessage());
            request.getRequestDispatcher("discount.jsp").forward(request, response);
        }
    }

    private void handleEdit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Discount discount = discountDAO.getDiscountByID(id);
            request.setAttribute("discount", discount);
            request.getRequestDispatcher("discount.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Lỗi khi lấy thông tin khuyến mãi: " + e.getMessage());
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            discountDAO.deleteDiscount(id);
            response.sendRedirect("discount");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi xóa khuyến mãi: " + e.getMessage());
            request.getRequestDispatcher("discount.jsp").forward(request, response);
        }
    }
} 