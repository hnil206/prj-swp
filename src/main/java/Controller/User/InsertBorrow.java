/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.User;

import Dao.BorrowDao;
import Dao.NotifyDao;
import Model.Borrow;
import Model.Notification;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author uchih
 */
public class InsertBorrow extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet InsertBorrow</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InsertBorrow at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BorrowDao bd = new BorrowDao();
        String id = request.getParameter("bookid");
        String startdate = request.getParameter("startdate");
        String lastDate = bd.getLastDateById(id);

        String startdateString = request.getParameter("startdate");
        String lastDateString = bd.getLastDateById(id);

// Parse the strings as Date objects using SimpleDateFormat
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date startingdate = null;
        Date lastingDate = null;

        try {
            startingdate = dateFormat.parse(startdateString);
            lastingDate = dateFormat.parse(lastDateString);
        } catch (java.text.ParseException e) {
            // Handle the parsing exception, if any
            e.printStackTrace();
        }

// Compare the dates using the compareTo method
        if (startingdate != null && lastingDate != null && startingdate.compareTo(lastingDate) < 0) {
            request.getSession().setAttribute("session_mess", "warning|Người này đã được đặt đến "+ lastDate);
        } else {

            String enddate = request.getParameter("enddate");
            String address = request.getParameter("address");
            String booktype = request.getParameter("booktype");
            log(booktype + id + startdate + enddate);
            String thanhtoan = request.getParameter("thanhtoan");
            int ibooktype = Integer.parseInt(booktype);
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            int userid = Integer.parseInt(user.getId());
//        String userid = ((User) request.getSession().getAttribute("user")).id;
            int iid = Integer.parseInt(id);
            Date date = new Date();
            Timestamp timestamp2 = new Timestamp(date.getTime());
            BorrowDao borrow = new BorrowDao();
            NotifyDao nd = new NotifyDao();
            try {
                borrow.createBorrow(userid, iid, ibooktype, startdate, enddate, address, thanhtoan, 0, timestamp2);
                nd.createNoti();
                request.getSession().setAttribute("session_mess", "success|Gửi yêu cầu thành công. Chờ admin xác nhận.");
            } catch (Exception e) {
                //request.getSession().setAttribute("session_mess", "error|Đã có lỗi xảy ra.");
            }

        }
        response.sendRedirect(request.getContextPath() + "/view-all-books");

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("bookid");
        String startdate = request.getParameter("startdate");
        String enddate = request.getParameter("enddate");
        String address = request.getParameter("address");
        String booktype = request.getParameter("getbooktype");
        log(booktype + id + startdate + enddate);
        String thanhtoan = request.getParameter("thanhtoan");
        int ibooktype = Integer.parseInt(booktype);
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int userid = Integer.parseInt(user.getId());
        //String userid = ((User) request.getSession().getAttribute("user")).id;
        int iid = Integer.parseInt(id);
        Date date = new Date();
        Timestamp timestamp2 = new Timestamp(date.getTime());
        BorrowDao borrow = new BorrowDao();
        borrow.createBorrow(userid, iid, ibooktype, startdate, enddate, address, thanhtoan, 1, timestamp2);
        response.sendRedirect("/mavenproject2/");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
