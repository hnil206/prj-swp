package Controller.Admin;

import Dao.BookDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class ViewBorrowingOfBook extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String book_id =  req.getParameter("book_id");
        String array_id = new BookDao().getBorrowingIdOfBooks(book_id);
        resp.sendRedirect(req.getContextPath() + "/admin/manage-borrow-books?borrow_id=" + array_id);
    }
}
