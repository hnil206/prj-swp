package Controller.Auth;

import Dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.UUID;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ForgotPasswordController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/view/auth/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String tel = req.getParameter("tel");
        UserDao userDao = new UserDao();
        if (userDao.checkMailAndTel(email, tel)){
            String uuid = UUID.randomUUID().toString();
            if (userDao.updateUUIDbyMail(email, uuid)){
                String host  = Mail.getHost(req);
                ExecutorService executorService = Executors.newSingleThreadExecutor();
                executorService.submit(() -> {
                    try {
                        String html = "<h1>Nhấp vào <a href = '" + host + "/reset-password?key=" + uuid + "' target='_blank'>đây</a> để lấy lại mật khẩu</h1>";
                        Mail.send(email, "Lấy lại mật khẩu", html);
                    }catch (Exception e){
                        e.printStackTrace();
                    }
                });
                executorService.shutdown();
                req.setAttribute("success", "Vui lòng kiểm tra email của bạn.");
            }
        } else {
            req.setAttribute("error", "Số điện thoại và email không khớp với tài khoản nào.");
        }
        req.getRequestDispatcher("/WEB-INF/view/auth/forgot-password.jsp").forward(req, resp);
    }
}
