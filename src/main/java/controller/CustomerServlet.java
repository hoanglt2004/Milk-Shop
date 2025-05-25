package controller;

import dao.CustomerDAO;
import dao.InvoiceDAO;
import entity.Customer;
import entity.Invoice;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "CustomerServlet", urlPatterns = {"/customer"})
public class CustomerServlet extends HttpServlet {

    private CustomerDAO customerDAO;
    private InvoiceDAO invoiceDAO;

    @Override
    public void init() throws ServletException {
        customerDAO = new CustomerDAO();
        invoiceDAO = new InvoiceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            // Default action: show all customers
            List<Customer> customers = customerDAO.getAllCustomers();
            request.setAttribute("customerList", customers);
            request.getRequestDispatcher("customer.jsp").forward(request, response);
        } else {
            switch (action) {
                case "edit":
                    handleEdit(request, response);
                    break;
                case "delete":
                    handleDelete(request, response);
                    break;
                case "orders":
                    handleViewOrders(request, response);
                    break;
                default:
                    response.sendRedirect("customer");
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
                response.sendRedirect("customer");
        }
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Customer customer = new Customer();
            customer.setFullName(request.getParameter("fullName"));
            customer.setEmail(request.getParameter("email"));
            customer.setPhone(request.getParameter("phone"));
            customer.setAddress(request.getParameter("address"));
            customer.setDateOfBirth(Date.valueOf(request.getParameter("dateOfBirth")));
            customer.setGender(request.getParameter("gender"));
            customer.setAccountID(Integer.parseInt(request.getParameter("accountID")));
            
            customerDAO.addCustomer(customer);
            response.sendRedirect("customer");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi thêm khách hàng: " + e.getMessage());
            request.getRequestDispatcher("customer.jsp").forward(request, response);
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Customer customer = new Customer();
            customer.setCustomerID(Integer.parseInt(request.getParameter("customerID")));
            customer.setFullName(request.getParameter("fullName"));
            customer.setEmail(request.getParameter("email"));
            customer.setPhone(request.getParameter("phone"));
            customer.setAddress(request.getParameter("address"));
            customer.setDateOfBirth(Date.valueOf(request.getParameter("dateOfBirth")));
            customer.setGender(request.getParameter("gender"));
            customer.setAccountID(Integer.parseInt(request.getParameter("accountID")));
            
            customerDAO.updateCustomer(customer);
            response.sendRedirect("customer");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi cập nhật khách hàng: " + e.getMessage());
            request.getRequestDispatcher("customer.jsp").forward(request, response);
        }
    }

    private void handleEdit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Customer customer = customerDAO.getCustomerByID(id);
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("customer.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Lỗi khi lấy thông tin khách hàng: " + e.getMessage());
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            customerDAO.deleteCustomer(id);
            response.sendRedirect("customer");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi xóa khách hàng: " + e.getMessage());
            request.getRequestDispatcher("customer.jsp").forward(request, response);
        }
    }

    private void handleViewOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("id"));
            List<Invoice> orders = invoiceDAO.getInvoicesByCustomerID(customerId);
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("customer_orders.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Lỗi khi lấy lịch sử đơn hàng: " + e.getMessage());
        }
    }
} 