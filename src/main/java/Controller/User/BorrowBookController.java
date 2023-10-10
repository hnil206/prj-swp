package Controller.User;

import Dao.BorrowDao;
import Model.Borrow;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class BorrowBookController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String book_id = req.getParameter("book_id");
        String user_id = ((User) req.getSession().getAttribute("user")).id;
        if (!new BorrowDao().checkBeforeBorrow(user_id, book_id)){
            req.getSession().setAttribute("session_mess", "warning|Bạn đang yêu cầu hoặc đang thuê người này rồi.");
        } else {
            if (new BorrowDao().addBorrow(user_id, book_id)){
                req.getSession().setAttribute("session_mess", "success|Gửi yêu cầu thành công. Chờ admin xác nhận.");
            } else {
                req.getSession().setAttribute("session_mess", "error|Đã có lỗi xảy ra.");
            }
        }
        resp.sendRedirect(req.getContextPath() + "/view-all-books");
    }
}
