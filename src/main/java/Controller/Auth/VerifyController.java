package Controller.Auth;

import Dao.UserDao;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class VerifyController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String key = req.getRequestURI().split("/")[3];
        UserDao userDao = new UserDao();
        User user = userDao.findUserBy_key(key);
        if (user == null){
            req.setAttribute("message", "Key không tồn tại.");
        } else {
            if (user.isVerified()){
                req.setAttribute("message", "Tài khoản này đã được xác thực.");
            } else {
                if (userDao.activeById(Integer.parseInt(user.id))){
                    req.setAttribute("message", "Xác thực tài khoản thành công, <a href='/mavenproject2/login'>Đăng nhập</a> để trải nghiệm hệ thống.");
                }else {
                    req.setAttribute("message", "Xác thực tài khoản thất bại, vui lòng liên hệ admin.");
                }
            }
        }
        req.getRequestDispatcher("/WEB-INF/view/auth/confirm-email.jsp").forward(req, resp);

    }
}
