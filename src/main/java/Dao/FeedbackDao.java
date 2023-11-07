/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import Model.Feedback;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author DELL
 */
public class FeedbackDao {

    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    public void createFeedback(int idUser, int idHk, int star, String message) {
        try {
            String sql = "insert into feedbacks (idUser, idHk, star, message) values(?,?,?,?)";
            connection = Connect.getConnection();
            preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setInt(1, idUser);
            preparedStatement.setInt(2, idHk);
            preparedStatement.setInt(3, star);
            preparedStatement.setString(4, message);

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public ArrayList<Feedback> getFeedbackByHkId(int hkId) {
        ArrayList<Feedback> list = new ArrayList<>();
        try {
            String sql = "select * from feedbacks where idHk = ?";
            connection = Connect.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, hkId);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
 
                String id = resultSet.getString("id");
                System.out.println(resultSet.getString(5));
                String userId = resultSet.getString("idUser");
                String hk = resultSet.getString("idHk");
                System.out.println("start while");
                int star = resultSet.getInt("star");
                                           
                String message = resultSet.getString("message");
                String date = resultSet.getString("createAt");
                System.out.println("check");
                System.out.println(id + userId + hk + star + message + date);
                Feedback feedback = new Feedback();
                feedback.setId(id);
                feedback.setUserId(userId);
                feedback.setHkId(hk);
                feedback.setStar(star);
                feedback.setMessage(message);
                feedback.setCreateAt(date);
                list.add(feedback);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public static void main(String[] args) {
        FeedbackDao fd = new FeedbackDao();
        System.out.println(fd.getFeedbackByHkId(2).get(0).getUserOfFeedback().getAvatar());
    }
}
