package Controller.User;

import Dao.BorrowDao;
import Model.Borrow;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

//hien thi ben
public class ViewBorrows extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String user_id = ((User) req.getSession().getAttribute("user")).id;
        ArrayList<Borrow> arrayList =new BorrowDao().getAllBorrowOfUser(user_id);
        req.setAttribute("borrows",arrayList);
        req.getRequestDispatcher("/WEB-INF/view/user/your-borrow.jsp").forward(req, resp);
    }
}
