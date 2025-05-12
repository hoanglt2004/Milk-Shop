package control;

import dao.DAO;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "LoadAllProducts", urlPatterns = {"/loadAllProducts"})
public class LoadAllProducts extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAO dao = new DAO();
        List<Product> list = dao.getAllProduct();
        PrintWriter out = response.getWriter();
        
        for (Product o : list) {
            out.println("<div class=\"col-md-4 mb-5\">\n"
                    + "                <div class=\"\">\n"
                    + "                  <div class=\"view zoom overlay rounded z-depth-2\">\n"
                    + "                    <img class=\"img-fluid w-100\"\n"
                    + "                      src=\"" + o.getImage() + "\" alt=\"Sample\">\n"
                    + "                    <a href=\"detail?pid=" + o.getId() + "\">\n"
                    + "                      <div class=\"mask\">\n"
                    + "                        <img class=\"img-fluid w-100\"\n"
                    + "                          src=\"" + o.getImage() + "\">\n"
                    + "                        <div class=\"mask rgba-black-slight\"></div>\n"
                    + "                      </div>\n"
                    + "                    </a>\n"
                    + "                  </div>\n"
                    + "                  <div class=\"text-center pt-4\">\n"
                    + "                    <h5 class=\"product-name\">" + o.getName() + "</h5>\n"
                    + "                    <p><span class=\"mr-1\"><strong>" + o.getPrice() + "$</strong></span></p>\n"
                    + "                  </div>\n"
                    + "                </div>\n"
                    + "              </div>");
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