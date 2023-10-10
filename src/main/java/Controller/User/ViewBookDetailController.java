package Controller.User;

import Dao.BookDao;
import Model.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class ViewBookDetailController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Book book = new BookDao().get1Book(req.getParameter("book_id"));
        req.setAttribute("book", book);
        req.getRequestDispatcher("/WEB-INF/view/user/view-book-detail.jsp").forward(req, resp);
    }
}
