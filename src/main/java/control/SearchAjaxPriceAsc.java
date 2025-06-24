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

@WebServlet(name = "SearchAjaxPriceAsc", urlPatterns = {"/searchAjaxPriceAsc"})
public class SearchAjaxPriceAsc extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String txtSearch = request.getParameter("txt");
        String cid = request.getParameter("cid");
        DAO dao = new DAO();
        List<Product> list;
        
        if (cid != null && !cid.isEmpty()) {
            // If category is selected, get products by category
            list = dao.getProductByCID(cid);
        } else if (txtSearch != null && !txtSearch.isEmpty()) {
            // If search text exists, get products by search
            list = dao.searchByName(txtSearch);
        } else {
            // If neither category nor search, get all products
            list = dao.getAllProduct();
        }
        
        // Sort the list by price in ascending order
        list.sort((p1, p2) -> Double.compare(p1.getPrice(), p2.getPrice()));
        
        PrintWriter out = response.getWriter();
        for (Product o : list) {
            out.println(utils.ProductCardUtil.generateProductCardHtml(o));
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