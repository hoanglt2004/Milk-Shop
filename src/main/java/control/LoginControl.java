/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import dao.DAO;
import entity.Account;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import entity.Cart;


@WebServlet(name = "LoginControl", urlPatterns = {"/login"})
public class LoginControl extends HttpServlet {

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
    	//b1 get user,pass from cookie
    	Cookie arr[] = request.getCookies();
    	if(arr != null) {
    		for(Cookie o : arr) {
        		if(o.getName().equals("userC")) {
        			request.setAttribute("username", o.getValue());
        		}
        		if(o.getName().equals("passC")) {
        			request.setAttribute("password", o.getValue());
        		}
        	}
    	}
    	//b2: set user,pass to login form
        request.getRequestDispatcher("Login.jsp").forward(request, response);
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
//        processRequest(request, response);
    	 response.setContentType("text/html;charset=UTF-8");
         String username = request.getParameter("user");
         String password = request.getParameter("pass");
         String remember =request.getParameter("remember");
         
         DAO dao = new DAO();
         Account a = dao.login(username, password);
         if (a == null) {
             request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
             request.getRequestDispatcher("Login.jsp").forward(request, response);
         } else {
             HttpSession session = request.getSession();
             session.setAttribute("acc", a);
             session.setMaxInactiveInterval(60*60*24);
           //luu account len tren cookie
             Cookie u = new Cookie("userC", username);
             Cookie p = new Cookie("passC", password);
             if(remember != null) {
            	 p.setMaxAge(60*60*24);
             }else {
            	 p.setMaxAge(0);
             }
             
             u.setMaxAge(60*60*24*365);//1 nam

             response.addCookie(u);//luu u va p len Chrome
             response.addCookie(p);
             
             // Lấy giỏ hàng từ session
             List<Cart> sessionCart = (List<Cart>) session.getAttribute("cartList");
             if (sessionCart != null && !sessionCart.isEmpty()) {
                 // Chuyển sản phẩm từ session vào database
                 for (Cart cart : sessionCart) {
                     Cart existingCart = dao.checkCartExist(a.getId(), cart.getProductID());
                     if (existingCart != null) {
                         // Nếu sản phẩm đã tồn tại trong giỏ hàng của user, cập nhật số lượng
                         dao.editAmountAndSizeCart(a.getId(), cart.getProductID(), 
                             existingCart.getAmount() + cart.getAmount(), cart.getSize());
                     } else {
                         // Nếu sản phẩm chưa có trong giỏ hàng, thêm mới
                         dao.insertCart(a.getId(), cart.getProductID(), cart.getAmount(), cart.getSize());
                     }
                 }
                 // Xóa giỏ hàng trong session
                 session.removeAttribute("cartList");
             }
             
             request.setAttribute("mess", "Đăng nhập thành công!");
             
             // Debug log for admin permission checking
             System.out.println("=== LOGIN DEBUG ===");
             System.out.println("User: '" + a.getUser() + "'");
             System.out.println("ID: " + a.getId());
             System.out.println("IsAdmin: " + a.getIsAdmin());
             System.out.println("Email: " + a.getEmail());
             System.out.println("FullName: " + a.getFullName());
             System.out.println("Checking admin status...");
             
             if (a.getIsAdmin() == 1) {
                 System.out.println("✅ Admin detected! Redirecting to admin dashboard...");
                 response.sendRedirect("admin");
             } else {
                 System.out.println("👤 Normal user detected! Redirecting to home page...");
                 response.sendRedirect("home");
             }
         }
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
