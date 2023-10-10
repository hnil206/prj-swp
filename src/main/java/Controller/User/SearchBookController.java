package Controller.User;

import Dao.BookDao;
import Model.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

public class SearchBookController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("session_mess") != null){
            String session_mess = (String) req.getSession().getAttribute("session_mess");
            req.setAttribute(session_mess.split("\\|")[0], session_mess.split("\\|")[1]);
            req.getSession().removeAttribute("session_mess");
        }
        if (req.getSession().getAttribute("session_mess") != null){
            String session_mess = (String) req.getSession().getAttribute("session_mess");
            req.setAttribute(session_mess.split("\\|")[0], session_mess.split("\\|")[1]);
            req.getSession().removeAttribute("session_mess");
        }
        ArrayList<Book> arrayList = new BookDao().getAllBooks();
        req.setAttribute("books", arrayList);
        req.getRequestDispatcher("/WEB-INF/view/user/search-books.jsp").forward(req, resp);
    }
}
