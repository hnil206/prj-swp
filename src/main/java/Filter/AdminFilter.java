package Filter;

import Model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class AdminFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        if (((User)request.getSession().getAttribute("user")).isAdmin()){
            filterChain.doFilter(request, response);
        } else {
            request.getSession().setAttribute("login_mess", "Vui lòng đăng nhập bằng tài khoản admin.");
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}
