package control;

import dao.DAO;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Comparator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SortByNameAZ", urlPatterns = {"/sortByNameAZ"})
public class SortByNameAZ extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String txtSearch = request.getParameter("txt");
        String cid = request.getParameter("cid");
        DAO dao = new DAO();
        List<Product> list;
        if (cid != null && !cid.isEmpty()) {
            list = dao.getProductByCID(cid);
        } else if (txtSearch != null && !txtSearch.isEmpty()) {
            list = dao.searchByName(txtSearch);
        } else {
            list = dao.getAllProduct();
        }
        list.sort(Comparator.comparing(Product::getName, String.CASE_INSENSITIVE_ORDER));
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
                    + "                    <p><span class=\"mr-1\"><strong>" + String.format("%,.0f", o.getPrice()).replace(",", ".") + " VNĐ</strong></span></p>\n"
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