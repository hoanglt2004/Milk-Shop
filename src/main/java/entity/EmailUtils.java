package entity;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class EmailUtils {
	private static final Logger logger = LoggerFactory.getLogger(EmailUtils.class);
	
	public static void send(Email email) throws Exception {
		Properties prop = new Properties();
		
		// Cấu hình cơ bản
		prop.put("mail.smtp.host", EmailConfig.getEmailHost());
		prop.put("mail.smtp.port", EmailConfig.getEmailPort());
		prop.put("mail.smtp.auth", "true");
		
		// Cấu hình TLS
		prop.put("mail.smtp.starttls.enable", "true");
		prop.put("mail.smtp.starttls.required", "true");
		
		// Cấu hình SSL
		prop.put("mail.smtp.ssl.enable", "true");
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		prop.put("mail.smtp.ssl.protocols", "TLSv1.2");
		
		// Cấu hình socket
		prop.put("mail.smtp.socketFactory.port", EmailConfig.getEmailPort());
		prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		prop.put("mail.smtp.socketFactory.fallback", "false");
		
		// Cấu hình timeout
		prop.put("mail.smtp.timeout", "5000");
		prop.put("mail.smtp.connectiontimeout", "5000");
		
		// Debug mode
		prop.put("mail.debug", "true");
		
		logger.info("Đang thiết lập kết nối email với host: {} và port: {}", 
				   EmailConfig.getEmailHost(), EmailConfig.getEmailPort());
		
		Session session = Session.getInstance(prop, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				logger.info("Đang xác thực với email: {}", EmailConfig.getEmailFrom());
				return new PasswordAuthentication(EmailConfig.getEmailFrom(), EmailConfig.getEmailPassword());
			}
		});
		
		try {
			Message message = new MimeMessage(session);
			
			message.setFrom(new InternetAddress(EmailConfig.getEmailFrom()));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email.getTo()));
			message.setSubject(email.getSubject());
			message.setContent(email.getContent(), "text/html; charset=utf-8");
			
			logger.info("Đang gửi email đến: {}", email.getTo());
			Transport.send(message);
			logger.info("Gửi email thành công đến: {}", email.getTo());
			
		} catch (Exception e) {
			logger.error("Lỗi khi gửi email đến: {}. Chi tiết lỗi: {}", email.getTo(), e.getMessage(), e);
			throw e;
		}
	}
}
