/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import dao.DAO;
import entity.Account;
import entity.Cart;
import entity.Category;
import entity.Invoice;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "HoaDonControl", urlPatterns = {"/hoaDon"})
public class HoaDonControl extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
      
        DAO dao = new DAO();
      
        // Handle delete invoice
        String deleteInvoice = request.getParameter("deleteInvoice");
        String maHDStr = request.getParameter("maHD");
        if ("1".equals(deleteInvoice) && maHDStr != null) {
            try {
                int maHD = Integer.parseInt(maHDStr);
                dao.deleteInvoiceById(maHD);
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().println("{\"success\": true, \"message\": \"Đã xóa hóa đơn thành công\"}");
            } catch (Exception e) {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().println("{\"success\": false, \"message\": \"Lỗi: " + e.getMessage() + "\"}");
            }
            return;
        }
        
        double sumCompletedInvoice = dao.sumAllInvoice(); // Chỉ tính đơn hoàn thành
        
        List<Invoice> listAllInvoice = dao.getAllInvoice();
        List<Account> listAllAccount = dao.getAllAccount();
        
        request.setAttribute("listAllInvoice", listAllInvoice);
        request.setAttribute("listAllAccount", listAllAccount);
        request.setAttribute("sumCompletedInvoice", sumCompletedInvoice);
        
      
        request.getRequestDispatcher("HoaDon.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
