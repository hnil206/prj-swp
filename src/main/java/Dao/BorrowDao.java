package Dao;

import Model.Borrow;
import Model.Status;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

public class BorrowDao {
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;
    public ArrayList<Borrow> getAllBorrowOfUser(String user_id){
        ArrayList<Borrow> arrayList = new ArrayList<>();
        try{
            String sql = "select borrows.*, users.name as username, books.title as book_name from borrows inner join users on borrows.user_id = users.id inner join books on borrows.book_id = books.id where borrows.user_id = ? order by borrows.id desc;";
            connection = Connect.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user_id);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                arrayList.add(new Borrow(
                        resultSet.getString(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getString(6),
                        resultSet.getString(7)
                ));
            }
            return arrayList;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
    public boolean addBorrow(String user_id, String book_id){
        try{
            String sql = "insert into borrows(user_id, book_id, status, created_at) VALUES (?, ?, ?, ?)";
            connection = Connect.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user_id);
            preparedStatement.setString(2, book_id);
            preparedStatement.setInt(3, Status.pending.getValue());
            preparedStatement.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            int row = preparedStatement.executeUpdate();
            return row > 0;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
    public boolean checkBeforeBorrow(String user_id, String book_id){
        try{
            String sql = "select count(id) from borrows where user_id = ? and book_id = ? and status <> -1";
            connection = Connect.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user_id);
            preparedStatement.setString(2, book_id);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()){
                int result = resultSet.getInt(1);
                System.out.println(result);
                return result == 0;
            } else {
                return false;
            }
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
    public ArrayList<Borrow> getAllBorrow(){
        ArrayList<Borrow> arrayList = new ArrayList<>();
        try{
            String sql = "select borrows.*, users.name as username, books.title as book_name from borrows inner join users on borrows.user_id = users.id inner join books on borrows.book_id = books.id order by borrows.id desc;";
            connection = Connect.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                arrayList.add(new Borrow(
                        resultSet.getString(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getString(6),
                        resultSet.getString(7)
                ));
            }
            return arrayList;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
    public boolean updateStatus(String book_id, String status){
        try{
            String sql = "update borrows set status = ? where id = ?";
            connection = Connect.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, status);
            preparedStatement.setString(2, book_id);
            int row = preparedStatement.executeUpdate();
            return row > 0;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
}
