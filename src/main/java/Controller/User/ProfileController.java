package Controller.User;

import Dao.UserDao;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class ProfileController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("session_mess") != null){
            String session_mess = (String) request.getSession().getAttribute("session_mess");
            request.setAttribute(session_mess.split("\\|")[0], session_mess.split("\\|")[1]);
            request.getSession().removeAttribute("session_mess");
        }
        User user = (User) request.getSession().getAttribute("user");
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/view/other/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String current_password = request.getParameter("current_password");
        String new_password = request.getParameter("new_password");
        String re_password = request.getParameter("re_password");
        UserDao userDao = new UserDao();
        String id = ((User) request.getSession().getAttribute("user")).id;
        User user = userDao.getUserById(id);
        if (current_password.equals("") && new_password.equals("") && re_password.equals("")){
            if (userDao.update(name, user.password, user.id)){
                User new_user = userDao.getUserById(user.id);
                request.getSession().setAttribute("user", new_user);
                request.getSession().setAttribute("session_mess", "success|Cập nhật thành công.");
            } else {
                request.getSession().setAttribute("session_mess", "error|Cập nhật thất bại.");
            }
        } else {
            if (current_password.equals(user.password)){
                if (new_password.equals(re_password)){
                    if (userDao.update(name, new_password, user.id)){
                        User new_user = userDao.getUserById(user.id);
                        request.getSession().setAttribute("user", new_user);
                        request.getSession().setAttribute("session_mess", "success|Cập nhật thành công.");
                    } else {
                        request.getSession().setAttribute("session_mess", "error|Cập nhật thất bại.");
                    }
                } else {
                    request.getSession().setAttribute("session_mess", "error|Nhập lại mật khẩu không trùng khớp.");
                }
            } else {
                request.getSession().setAttribute("session_mess", "error|Mật khẩu hiện tại sai.");
            }
        }
        response.sendRedirect(request.getContextPath() + "/user/profile");
    }
}
