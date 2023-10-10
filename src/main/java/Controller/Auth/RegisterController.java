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

public class RegisterController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/view/auth/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String re_password = req.getParameter("re_password");
        String address = req.getParameter("address");
        String tel = req.getParameter("tel");
        String birthday = req.getParameter("birthday");
        String uuid = UUID.randomUUID().toString();
        int check =new UserDao().checkUserInfoDuplicate(email, tel);
        if (check == 1){
            req.setAttribute("error", "Email đã tồn tại.");
        }else if (check ==2){
            req.setAttribute("error", "Số điện thoại đã tồn tại.");
        } else if (check == 0){
            if (!password.equals(re_password)){// pass khasc
                req.setAttribute("error", "Nhập lại mật khẩu không trùng khớp.");
            } else { // tiến hành đk
                if (new UserDao().register(name, email, address, tel, birthday, password, uuid)){
                    String host = Mail.getHost(req);
                    ExecutorService executorService = Executors.newSingleThreadExecutor();
                    executorService.submit(() -> {
                        try {
                            String html = "<h1>Hello " + name + ", chào mừng bạn đến với CleanHouse. Để kích hoạt tài khoản vui lòng nhấn vào <a href='" + host + "/active/" + uuid + "'>đây.</a></h1>";
                            Mail.send(email, "Xác nhận tài khoản", html);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    });
                    executorService.shutdown();
                    req.setAttribute("success", "Đăng kí thành công, vui lòng kiểm tra email.");
                } else {
                    req.setAttribute("error", "Đã có lỗi xảy ra.");
                }
            }
        }
        req.getRequestDispatcher("/WEB-INF/view/auth/register.jsp").forward(req, resp);
    }
}
