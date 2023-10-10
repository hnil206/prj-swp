package Controller.Admin;

import Dao.UserDao;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class UpdateUsersController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String user_id = req.getParameter("user_id");
        User user = new UserDao().getUserById(user_id);
        req.setAttribute("user1", user);
        req.getRequestDispatcher("/WEB-INF/view/admin/update-user.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String address = req.getParameter("address");
        String tel = req.getParameter("tel");
        String birthday = req.getParameter("birthday");
        String admin = req.getParameter("admin");
        UserDao userDao = new UserDao();
        if (userDao.adminUpdate(id, name, email, address, tel, birthday, password, admin)){
            req.getSession().setAttribute("session_mess", "success|Cập nhật thành công.");
        } else {
            req.getSession().setAttribute("session_mess", "error|Cập nhật không thành công.");
        }
        resp.sendRedirect(req.getContextPath() + "/admin/manage-users");
    }
}
