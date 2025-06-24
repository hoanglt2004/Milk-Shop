package control;

import entity.Email;
import entity.EmailUtils;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "SupportServlet", urlPatterns = {"/support"})
public class SupportServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        String referer = request.getHeader("Referer");

        try {
            String name = request.getParameter("name");
            String fromEmail = request.getParameter("email");
            String subject = request.getParameter("subject");
            String message = request.getParameter("message");

            Email email = new Email();
            
            // The admin's email is retrieved from email.properties by EmailUtils
            email.setFrom(fromEmail); 
            email.setFromPassword("dummy_password"); // Not needed when sending through admin's account
            email.setTo(email.getTo()); // Already configured in EmailUtils to send to admin
            
            email.setSubject("Support Request: " + subject);

            StringBuilder sb = new StringBuilder();
            sb.append("You have a new support request from your website.<br><br>");
            sb.append("<b>From:</b> ").append(name).append("<br>");
            sb.append("<b>Email:</b> ").append(fromEmail).append("<br>");
            sb.append("<b>Subject:</b> ").append(subject).append("<br>");
            sb.append("<b>Message:</b><br>");
            sb.append("--------------------<br>");
            sb.append(message.replace("\n", "<br>"));
            sb.append("<br>--------------------<br>");
            
            email.setContent(sb.toString());
            
            EmailUtils.sendEmail(email);
            
            session.setAttribute("supportMessageStatus", "success");
            session.setAttribute("supportMessage", "Your message has been sent successfully! We will get back to you shortly.");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("supportMessageStatus", "error");
            session.setAttribute("supportMessage", "There was an error sending your message. Please try again later.");
        }
        
        response.sendRedirect(referer != null ? referer : "home");
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
        return "Handles support request emails from users to admin";
    }
} 