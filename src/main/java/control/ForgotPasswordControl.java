package control;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DAO;
import entity.Account;
import entity.Email;
import entity.EmailUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Servlet implementation class ForgotPasswordControl
 */
@WebServlet(name = "ForgotPasswordControl", urlPatterns = {"/forgotPassword"})
public class ForgotPasswordControl extends HttpServlet {
	private static final Logger logger = LoggerFactory.getLogger(ForgotPasswordControl.class);
	private static final SecureRandom secureRandom = new SecureRandom();
	private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
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
			String username = request.getParameter("username");
			
			logger.info("Bắt đầu xử lý yêu cầu khôi phục mật khẩu cho username: {} và email: {}", username, emailAddress);
			
			// Validate input
			if (emailAddress == null || emailAddress.trim().isEmpty()) {
				request.setAttribute("error", "Vui lòng nhập địa chỉ email!");
				request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
				return;
			}
			
			if (username == null || username.trim().isEmpty()) {
				request.setAttribute("error", "Vui lòng nhập tên đăng nhập!");
				request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
				return;
			}
			
			// Validate email format
			if (!EMAIL_PATTERN.matcher(emailAddress).matches()) {
				request.setAttribute("error", "Địa chỉ email không hợp lệ!");
				request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
				return;
			}
			
			DAO dao = new DAO();
			logger.info("Đang kiểm tra tài khoản trong database...");
			Account account = dao.checkAccountExistByUsernameAndEmail(username, emailAddress);
			
			if(account == null) {
				request.setAttribute("error", "Email hoặc tên đăng nhập không tồn tại trong hệ thống!");
				logger.warn("Không tìm thấy tài khoản với username: {} và email: {}", username, emailAddress);
			} else {
				try {
					// Generate new user-friendly password
					String newPassword = generateUserFriendlyPassword();
					logger.info("Đã tạo mật khẩu mới cho user: {}", username);
					
					// Update password in database
					logger.info("Đang cập nhật mật khẩu trong database...");
					dao.updatePassword(account.getId(), newPassword);
					logger.info("Đã cập nhật mật khẩu thành công trong database");
					
					// Send email with new password
					Email email = new Email();
					email.setTo(emailAddress);
					email.setSubject("Khôi phục mật khẩu - Shoes Family");
					
					StringBuilder sb = new StringBuilder();
					sb.append("<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;'>");
					sb.append("<h2 style='color: #333;'>Khôi phục mật khẩu</h2>");
					sb.append("<p>Xin chào <strong>").append(username).append("</strong>,</p>");
					sb.append("<p>Chúng tôi nhận được yêu cầu khôi phục mật khẩu cho tài khoản của bạn.</p>");
					sb.append("<p>Mật khẩu mới của bạn là: <strong style='color: #007bff; font-size: 18px;'>").append(newPassword).append("</strong></p>");
					sb.append("<p style='color: #dc3545;'><strong>Lưu ý quan trọng:</strong></p>");
					sb.append("<ul>");
					sb.append("<li>Vui lòng đăng nhập ngay với mật khẩu mới này</li>");
					sb.append("<li>Đổi mật khẩu mới sau khi đăng nhập để đảm bảo an toàn cho tài khoản</li>");
					sb.append("<li>Không chia sẻ mật khẩu này với bất kỳ ai</li>");
					sb.append("</ul>");
					sb.append("<p>Nếu bạn không yêu cầu khôi phục mật khẩu, vui lòng bỏ qua email này.</p>");
					sb.append("<hr style='border: 1px solid #eee; margin: 20px 0;'>");
					sb.append("<p style='color: #666; font-size: 12px;'>Email này được gửi tự động, vui lòng không trả lời.</p>");
					sb.append("</div>");
					
					email.setContent(sb.toString());
					logger.info("Đang gửi email đến địa chỉ: {}", emailAddress);
					EmailUtils.send(email);
					logger.info("Đã gửi email thành công");
					
					request.setAttribute("mess", "Mật khẩu mới đã được gửi đến email của bạn. Vui lòng kiểm tra hộp thư đến và spam!");
					logger.info("Khôi phục mật khẩu thành công cho user: {}", username);
				} catch (Exception e) {
					logger.error("Lỗi khi gửi email hoặc cập nhật mật khẩu: {}", e.getMessage(), e);
					request.setAttribute("error", "Có lỗi xảy ra khi gửi email. Vui lòng thử lại sau hoặc liên hệ hỗ trợ!");
				}
			}
			
		} catch (Exception e) {
			logger.error("Lỗi không xác định trong quá trình khôi phục mật khẩu: {}", e.getMessage(), e);
			logger.error("Stack trace:", e);
			request.setAttribute("error", "Có lỗi xảy ra trong quá trình khôi phục mật khẩu. Vui lòng thử lại sau hoặc liên hệ hỗ trợ!");
		}
		
		request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
	}
	
	private String generateUserFriendlyPassword() {
		// Generate a more user-friendly password with 8 characters
		// Including uppercase, lowercase, numbers, and special characters
		String upperChars = "ABCDEFGHJKLMNPQRSTUVWXYZ";
		String lowerChars = "abcdefghijkmnpqrstuvwxyz";
		String numbers = "23456789";
		String specialChars = "!@#$%^&*";
		
		StringBuilder password = new StringBuilder();
		
		// Ensure at least one character from each category
		password.append(upperChars.charAt(secureRandom.nextInt(upperChars.length())));
		password.append(lowerChars.charAt(secureRandom.nextInt(lowerChars.length())));
		password.append(numbers.charAt(secureRandom.nextInt(numbers.length())));
		password.append(specialChars.charAt(secureRandom.nextInt(specialChars.length())));
		
		// Fill the rest with random characters
		String allChars = upperChars + lowerChars + numbers + specialChars;
		for (int i = 4; i < 8; i++) {
			password.append(allChars.charAt(secureRandom.nextInt(allChars.length())));
		}
		
		// Shuffle the password
		char[] passwordArray = password.toString().toCharArray();
		for (int i = passwordArray.length - 1; i > 0; i--) {
			int j = secureRandom.nextInt(i + 1);
			char temp = passwordArray[i];
			passwordArray[i] = passwordArray[j];
			passwordArray[j] = temp;
		}
		
		return new String(passwordArray);
	}

}
