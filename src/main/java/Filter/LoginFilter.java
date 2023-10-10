package Filter;

import Model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class LoginFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        User user = (User) request.getSession().getAttribute("user");
        if (user != null){
            filterChain.doFilter(request, response);
        } else {
            request.getSession().setAttribute("login_mess", "Vui lòng đăng nhập.");
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}
