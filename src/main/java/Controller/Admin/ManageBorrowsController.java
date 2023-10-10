package Controller.Admin;

import Dao.BookDao;
import Dao.BorrowDao;
import Model.Book;
import Model.Borrow;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Objects;

public class ManageBorrowsController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("session_mess") != null){
            String session_mess = (String) req.getSession().getAttribute("session_mess");
            req.setAttribute(session_mess.split("\\|")[0], session_mess.split("\\|")[1]);
            req.getSession().removeAttribute("session_mess");
        }
        ArrayList<Borrow> arrayList = new BorrowDao().getAllBorrow();
        req.setAttribute("borrows", arrayList);
        req.getRequestDispatcher("/WEB-INF/view/admin/manage-borrows.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String borrow_id = req.getParameter("borrow_id");
        String status = req.getParameter("status");
        String book_id = req.getParameter("book_id");
        if (status.equals("1")){
            Book book = new BookDao().get1BookWithNumber(book_id);
            if (Objects.equals(book.getBorrowing(), book.getQuantity())){
                req.getSession().setAttribute("session_mess", "warning|Số người đang mượn đã bằng với số lượng sách.");
            } else {
                if (new BorrowDao().updateStatus(borrow_id,status)){
                    req.getSession().setAttribute("session_mess", "success|Cập nhật thành công.");
                }else {
                    req.getSession().setAttribute("session_mess", "error|Đã có lỗi ở hệ thống.");
                }
            }
        } else {
            if (new BorrowDao().updateStatus(borrow_id,status)){
                req.getSession().setAttribute("session_mess", "success|Cập nhật thành công.");
            }else {
                req.getSession().setAttribute("session_mess", "error|Đã có lỗi ở hệ thống.");
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/manage-borrow-books");

    }
}
