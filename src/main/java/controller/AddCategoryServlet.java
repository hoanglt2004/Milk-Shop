package controller;

import dao.CategoryDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Category;

@WebServlet(name = "AddCategoryServlet", urlPatterns = {"/addCategory"})
public class AddCategoryServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try {
            String cname = request.getParameter("cname");
            if (cname == null || cname.trim().isEmpty()) {
                request.setAttribute("error", "Tên danh mục không được để trống");
                request.getRequestDispatcher("quanLyDanhMuc").forward(request, response);
                return;
            }
            Category category = new Category();
            category.setCname(cname);
            CategoryDAO categoryDAO = new CategoryDAO();
            categoryDAO.addCategory(category);
            request.setAttribute("mess", "Category Added!");
            request.getRequestDispatcher("quanLyDanhMuc").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("quanLyDanhMuc").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
} 