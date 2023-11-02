/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import Model.Notification;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class NotifyDao {

    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    public void createNoti() {
        String sql = "insert into notifications(userId ,title, message) values (?,N'Bạn có thông báo mới',N'Bạn có đơn thuê cần duyệt')";
        connection = Connect.getConnection();
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, 1);
            preparedStatement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(NotifyDao.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void creatNotiUser(int userId, String status, String borrow_id) {
        String title = "Đã " + status;
        String message = "Yêu cầu thuê của bạn đã được" + status + " bởi admin";
        String sql = "insert into notifications(userId ,title, message, OrderId) values (?,?,?,?)";
        connection = Connect.getConnection();
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, userId);
            preparedStatement.setString(2, title);
            preparedStatement.setString(3, message);
            preparedStatement.setString(4, borrow_id);

            preparedStatement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(NotifyDao.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<Notification> getUserNotification(String userID) {
        List<Notification> list = new ArrayList<>();

        try {
            String sql = "select*from [Notifications] where [UserID]= ?";
            connection = Connect.getConnection();

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, Integer.parseInt(userID));
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int notificationID = resultSet.getInt("NotificationID");
                String title = resultSet.getString("Title");
                int userId = resultSet.getInt("userId");
                String message = resultSet.getString("Message");
                Date createAt = resultSet.getDate("CreatedAt");
                Notification notify = new Notification(notificationID, userID, title, message, createAt);
                list.add(notify);
            }
        } catch (Exception e) {
            System.out.println(e);

        }

        return list;
    }

    public void removeUserNotication(int notificationID) {
        String sql = "DELETE FROM Notifications WHERE NotificationID = " + notificationID;
        try {
            connection = Connect.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void removeFeedbackedNotify(int OrderId) {
        String sql = "DELETE FROM Notifications WHERE OrderID = " + OrderId;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Notification getNotiById(int notiId) {
        try {
            String sql = "SELECT NotificationId, title FROM Notifications WHERE NotificationId = " + notiId;
            connection = Connect.getConnection();

            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                int notificationID = resultSet.getInt("NotificationID");
                String title = resultSet.getString("Title");
                Notification notify = new Notification(notificationID, title);
                return notify;
            }
        } catch (Exception e) {
            System.out.println(e);

        }
        return null;
    }

    public static void main(String[] args) {
        NotifyDao nd = new NotifyDao();
//        nd.creatNotiUser("2", "Xác Nhận");
            nd.creatNotiUser(2, "Xác Nhận", "66");
        System.out.println("cc" + nd.getUserNotification("2").get(0).getMessage());;
    }

}
