package Controller;

import Dao.BookDao;
import Model.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

public class HomePageController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ArrayList<Book> arrayList = new BookDao().getTop3Borrows();
        req.setAttribute("books", arrayList);
        req.getRequestDispatcher("/WEB-INF/view/other/index.jsp").forward(req, resp);
    }
}
