package controller;

import dao.CategoryDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Category;

@WebServlet(name = "EditCategoryServlet", urlPatterns = {"/editCategory"})
public class EditCategoryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int cid = Integer.parseInt(request.getParameter("cid"));
            String cname = request.getParameter("cname");
            
            if (cname == null || cname.trim().isEmpty()) {
                request.setAttribute("error", "Tên danh mục không được để trống");
                request.getRequestDispatcher("quanLyDanhMuc").forward(request, response);
                return;
            }

            Category category = new Category();
            category.setCid(cid);
            category.setCname(cname);

            CategoryDAO categoryDAO = new CategoryDAO();
            categoryDAO.updateCategory(category);
            
            request.setAttribute("success", "Cập nhật danh mục thành công");
            response.sendRedirect("quanLyDanhMuc");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID danh mục không hợp lệ");
            request.getRequestDispatcher("quanLyDanhMuc").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("quanLyDanhMuc").forward(request, response);
        }
    }
} 