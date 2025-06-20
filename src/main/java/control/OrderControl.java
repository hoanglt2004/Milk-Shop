package control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DAO;

import entity.Account;
import entity.Email;
import entity.EmailUtils;
import entity.Cart;
import entity.Product;
import entity.SoLuongDaBan;
import entity.TongChiTieuBanHang;

/**
 * Servlet implementation class ForgotPasswordControl
 */
@WebServlet(name = "OrderControl", urlPatterns = {"/order"})
public class OrderControl extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		HttpSession session = request.getSession();
		Account a = (Account) session.getAttribute("acc");
		if(a == null) {
			response.sendRedirect("login");
			return;
		}
		int accountID = a.getId();
		DAO dao = new DAO();
		List<Cart> list = dao.getCartByAccountID(accountID);
		List<Product> list2 = dao.getAllProduct();
		double totalMoney=0;
		for(Cart c : list) {
			for(Product p : list2) {
				if(c.getProductID()==p.getId()) {
					totalMoney=totalMoney+(p.getPrice()*c.getAmount());
				}
			}
		}
		double totalMoneyVAT=totalMoney+totalMoney*0.1;
		
		double tongTienBanHangThem=0;
		int sell_ID;
		for (Cart c : list) {
			for (Product p : list2) {
				if (c.getProductID() == p.getId()) {
					tongTienBanHangThem = 0;
					sell_ID = dao.getSellIDByProductID(p.getId());
					tongTienBanHangThem = tongTienBanHangThem + (p.getPrice() * c.getAmount());
					TongChiTieuBanHang t2 = dao.checkTongChiTieuBanHangExist(sell_ID);
					if (t2 == null) {
						dao.insertTongChiTieuBanHang(sell_ID, 0, tongTienBanHangThem);
					} else {
						dao.editTongBanHang(sell_ID, tongTienBanHangThem);
					}
				}
			}
		}
		
		
		for(Cart c : list) {
			for(Product p : list2) {
				if(c.getProductID()==p.getId()) {
					SoLuongDaBan s = dao.checkSoLuongDaBanExist(p.getId());
					if(s == null) {
						dao.insertSoLuongDaBan(p.getId(), c.getAmount());
					}
					else {
						dao.editSoLuongDaBan(p.getId(), c.getAmount());
					}	
				}
			}
		}
		
		dao.insertInvoice(accountID, totalMoneyVAT);
		TongChiTieuBanHang t = dao.checkTongChiTieuBanHangExist(accountID);
		if(t==null) {
			dao.insertTongChiTieuBanHang(accountID,totalMoneyVAT,0);
		}
		else {
			dao.editTongChiTieu(accountID, totalMoneyVAT);
		}
		
		
		request.getRequestDispatcher("DatHang.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		try {
			String emailAddress = request.getParameter("email");
			String name = request.getParameter("name");
			String phoneNumber = request.getParameter("phoneNumber");
			String deliveryAddress = request.getParameter("deliveryAddress");
			
			HttpSession session = request.getSession();
			Account a = (Account) session.getAttribute("acc");
			if(a == null) {
				response.sendRedirect("login");
				return;
			}
			int accountID = a.getId();
			DAO dao = new DAO();
			List<Cart> list = dao.getCartByAccountID(accountID);
			List<Product> list2 = dao.getAllProduct();
				
			double totalMoney=0;
			for(Cart c : list) {
				for(Product p : list2) {
					if(c.getProductID()==p.getId()) {
						totalMoney=totalMoney+(p.getPrice()*c.getAmount());
					}
				}
			}
			double totalMoneyVAT=totalMoney+totalMoney*0.1;
			
			
			//old code
			Email email =new Email();
			email.setTo(emailAddress);
			email.setSubject("Đặt hàng thành công - Fashion Family");
			StringBuilder sb = new StringBuilder();
			sb.append("<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;'>");
			sb.append("<div style='text-align: center; margin-bottom: 30px;'>");
			sb.append("<h2 style='color: #28a745;'>Đặt hàng thành công!</h2>");
			sb.append("<p style='color: #666;'>Cảm ơn bạn đã đặt hàng tại Fashion Family</p>");
			sb.append("</div>");
			
			sb.append("<div style='background-color: #f8f9fa; padding: 20px; border-radius: 5px; margin-bottom: 20px;'>");
			sb.append("<h3 style='color: #333; margin-bottom: 15px;'>Thông tin đơn hàng</h3>");
			sb.append("<p><strong>Người nhận:</strong> ").append(name).append("</p>");
			sb.append("<p><strong>Địa chỉ:</strong> ").append(deliveryAddress).append("</p>");
			sb.append("<p><strong>Số điện thoại:</strong> ").append(phoneNumber).append("</p>");
			sb.append("</div>");
			
			sb.append("<div style='margin-bottom: 20px;'>");
			sb.append("<h3 style='color: #333; margin-bottom: 15px;'>Chi tiết sản phẩm</h3>");
			sb.append("<table style='width: 100%; border-collapse: collapse;'>");
			sb.append("<tr style='background-color: #f8f9fa;'>");
			sb.append("<th style='padding: 10px; text-align: left; border-bottom: 1px solid #ddd;'>Sản phẩm</th>");
			sb.append("<th style='padding: 10px; text-align: right; border-bottom: 1px solid #ddd;'>Số lượng</th>");
			sb.append("<th style='padding: 10px; text-align: right; border-bottom: 1px solid #ddd;'>Đơn giá</th>");
			sb.append("<th style='padding: 10px; text-align: right; border-bottom: 1px solid #ddd;'>Thành tiền</th>");
			sb.append("</tr>");
			
			for(Cart c : list) {
				for(Product p : list2) {
					if(c.getProductID()==p.getId()) {
						sb.append("<tr>");
						sb.append("<td style='padding: 10px; border-bottom: 1px solid #ddd;'>").append(p.getName()).append("</td>");
						sb.append("<td style='padding: 10px; text-align: right; border-bottom: 1px solid #ddd;'>").append(c.getAmount()).append("</td>");
						sb.append("<td style='padding: 10px; text-align: right; border-bottom: 1px solid #ddd;'>").append(String.format("%,.0f", p.getPrice()).replace(",", ".")).append(" VNĐ</td>");
						sb.append("<td style='padding: 10px; text-align: right; border-bottom: 1px solid #ddd;'>").append(String.format("%,.0f", p.getPrice() * c.getAmount()).replace(",", ".")).append(" VNĐ</td>");
						sb.append("</tr>");
					}
				}
			}
			sb.append("</table>");
			sb.append("</div>");
			
			sb.append("<div style='background-color: #f8f9fa; padding: 20px; border-radius: 5px;'>");
			sb.append("<h3 style='color: #333; margin-bottom: 15px;'>Tổng thanh toán</h3>");
			sb.append("<p style='text-align: right; font-size: 18px;'><strong>Tổng tiền hàng:</strong> ").append(String.format("%,.0f", totalMoney).replace(",", ".")).append(" VNĐ</p>");
			sb.append("<p style='text-align: right; font-size: 18px;'><strong>VAT (10%):</strong> ").append(String.format("%,.0f", totalMoney * 0.1).replace(",", ".")).append(" VNĐ</p>");
			sb.append("<p style='text-align: right; font-size: 20px; color: #28a745;'><strong>Tổng thanh toán:</strong> ").append(String.format("%,.0f", totalMoneyVAT).replace(",", ".")).append(" VNĐ</p>");
			sb.append("</div>");
			
			sb.append("<div style='margin-top: 30px; text-align: center; color: #666;'>");
			sb.append("<p>Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất để xác nhận đơn hàng.</p>");
			sb.append("<p>Mọi thắc mắc xin vui lòng liên hệ hotline: 1900-xxxx</p>");
			sb.append("</div>");
			
			sb.append("</div>");
			
			email.setContent(sb.toString());
			EmailUtils.send(email);
			request.setAttribute("mess", "Đặt hàng thành công! Vui lòng kiểm tra email của bạn.");
			
			dao.deleteCartByAccountID(accountID);
			
			
			//new code
	//			request.setAttribute("email", emailAddress);
	//			request.getRequestDispatcher("ThongTinDatHang.jsp").forward(request, response);
			
		
		} catch (Exception e) {
			request.setAttribute("error", "Đặt hàng thất bại!");
			e.printStackTrace();
		}
	
		request.getRequestDispatcher("DatHang.jsp").forward(request, response);
	}

}
