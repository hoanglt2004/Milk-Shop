package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebFilter(filterName = "JSPFilter", urlPatterns = {"*.jsp"})
public class JSPFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        
        String servletPath = req.getServletPath();
        
        // Cho phép truy cập trực tiếp vào một số JSP cần thiết
        if (servletPath.equals("/Menu.jsp") || 
            servletPath.equals("/Footer.jsp") || 
            servletPath.equals("/Left.jsp")) {
            chain.doFilter(request, response);
            return;
        }
        
        // Chuyển hướng các request JSP khác về servlet tương ứng
        if (servletPath.equals("/Home.jsp")) {
            resp.sendRedirect(req.getContextPath() + "/home");
        } else if (servletPath.equals("/Shop.jsp")) {
            resp.sendRedirect(req.getContextPath() + "/shop");
        } else if (servletPath.equals("/Cart.jsp")) {
            resp.sendRedirect(req.getContextPath() + "/cart");
        } else {
            // Chuyển hướng về trang chủ nếu không có mapping
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }

    @Override
    public void destroy() {
    }
} 