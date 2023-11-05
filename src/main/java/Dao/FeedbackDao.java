/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author DELL
 */
public class FeedbackDao {

    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;
    
    public void createFeedback(int idUser, int idHk, int star, String message){
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
    
    public static void main(String[] args) {
        FeedbackDao fd = new FeedbackDao();
        fd.createFeedback(2, 2, 4, "ngu");
    }
}
