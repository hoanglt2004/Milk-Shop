package controller;

import dao.DiscountDAO;
import entity.Discount;
import entity.Product;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "QuanLyKhuyenMaiControl", urlPatterns = {"/quanLyKhuyenMai"})
public class QuanLyKhuyenMaiControl extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DiscountDAO discountDAO = new DiscountDAO();
        List<Discount> listDiscounts = discountDAO.getAllDiscounts();
        List<Product> listProducts = discountDAO.getAllProducts();

        request.setAttribute("listD", listDiscounts);
        request.setAttribute("listP", listProducts);
        request.getRequestDispatcher("QuanLyKhuyenMai.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        DiscountDAO discountDAO = new DiscountDAO();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        if (action != null) {
            try {
                if (action.equalsIgnoreCase("add")) {
                    int productID = Integer.parseInt(request.getParameter("productID"));
                    int percentOff = Integer.parseInt(request.getParameter("percentOff"));
                    java.util.Date startDate = sdf.parse(request.getParameter("startDate"));
                    java.util.Date endDate = sdf.parse(request.getParameter("endDate"));
                    boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));

                    Discount discount = new Discount();
                    discount.setProductID(productID);
                    discount.setPercentOff(percentOff);
                    discount.setStartDate(startDate);
                    discount.setEndDate(endDate);
                    discount.setActive(isActive);

                    discountDAO.addDiscount(discount);

                } else if (action.equalsIgnoreCase("edit")) {
                    int discountID = Integer.parseInt(request.getParameter("discountID"));
                    int productID = Integer.parseInt(request.getParameter("productID"));
                    int percentOff = Integer.parseInt(request.getParameter("percentOff"));
                    java.util.Date startDate = sdf.parse(request.getParameter("startDate"));
                    java.util.Date endDate = sdf.parse(request.getParameter("endDate"));
                    boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));

                    Discount discount = new Discount();
                    discount.setDiscountID(discountID);
                    discount.setProductID(productID);
                    discount.setPercentOff(percentOff);
                    discount.setStartDate(startDate);
                    discount.setEndDate(endDate);
                    discount.setActive(isActive);

                    discountDAO.updateDiscount(discount);

                } else if (action.equalsIgnoreCase("delete")) {
                    int discountID = Integer.parseInt(request.getParameter("discountID"));
                    discountDAO.deleteDiscount(discountID);
                }
            } catch (ParseException | NumberFormatException e) {
                e.printStackTrace();
                // Handle error appropriately (e.g., send an error message to the JSP)
            }
        }

        // Redirect back to the discount management page after processing
        response.sendRedirect("quanLyKhuyenMai");
    }
}