package Controller.Auth;

import Dao.UserDao;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class LoginController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("login_mess") != null){
            String login_mess = (String) req.getSession().getAttribute("login_mess");
            req.setAttribute("login_mess", login_mess);
            req.getSession().removeAttribute("login_mess");
        }
        req.getRequestDispatcher("/WEB-INF/view/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        User user = new UserDao().login(email, password);
        if (user == null){
            req.setAttribute("error", "Đã có lỗi.");
            req.getRequestDispatcher("/WEB-INF/view/auth/login.jsp").forward(req, resp);
        } else if (user.id == null){
            req.setAttribute("error", "Sai Email hoặc mật khẩu.");
            req.getRequestDispatcher("/WEB-INF/view/auth/login.jsp").forward(req, resp);
        } else {
            if (user.isVerified()){
                
//                user.getNotifications();
                req.getSession().setAttribute("user", user);
                resp.sendRedirect(req.getContextPath());
            } else {
                req.setAttribute("error", "Tài khoản của bạn chưa được xác minh.");
                req.getRequestDispatcher("/WEB-INF/view/auth/login.jsp").forward(req, resp);
            }
        }
    }
}
