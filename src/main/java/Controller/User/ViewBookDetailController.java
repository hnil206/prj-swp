package Controller.User;

import Dao.BookDao;
import Dao.FeedbackDao;
import Model.Book;
import Model.Feedback;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class ViewBookDetailController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Book book = new BookDao().get1Book(req.getParameter("book_id"));
        FeedbackDao fd = new FeedbackDao();
        int intId = Integer.parseInt(book.getId());
        List<Feedback> listFb = fd.getFeedbackByHkId(intId);
//
//            for (Feedback feedback : listFb) {
//    System.out.println("User: " + feedback.getUserOfFeedback().getName());
//    System.out.println("Posted on: " + feedback.getCreateAt());
//    System.out.println("Message: " + feedback.getMessage());
//    System.out.println("------------------------");
//            }
        System.out.println(listFb);
        req.setAttribute("book", book);
        req.setAttribute("listFb", listFb);
        req.getRequestDispatcher("/WEB-INF/view/user/view-book-detail.jsp").forward(req, resp);
    }
}
