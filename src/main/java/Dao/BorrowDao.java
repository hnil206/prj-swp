package Dao;

import Model.Borrow;
import Model.NewBrrow;
import Model.Status;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

public class BorrowDao {

    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    public int getUserId(String borrow_id) {
        try {
            String sql = "select user_id from borrows where id = " + borrow_id;
            connection = Connect.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("user_id");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public ArrayList<Borrow> getAllBorrowOfUser(String user_id) {
        ArrayList<Borrow> arrayList = new ArrayList<>();
        try {
            String sql = "select borrows.*, users.name as username, books.title as book_name from borrows inner join users on borrows.user_id = users.id inner join books on borrows.book_id = books.id where borrows.user_id = ? order by borrows.id desc;";
            connection = Connect.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user_id);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                arrayList.add(new Borrow(
                        resultSet.getString(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        resultSet.getString("status"),
                        resultSet.getString(5),
                        resultSet.getString(11),
                        resultSet.getString("book_name")
                ));
                System.out.println(resultSet.getString("status"));
            }
            return arrayList;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }
    
    public String getLastDateById(String id){
        String date = "";
         try {
            String sql = "SELECT MAX(enddate) AS latest_start_date FROM borrows WHERE book_id = ?";
            connection = Connect.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, id);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                date = resultSet.getString(1);
            } 
        } catch (Exception e) {
            e.printStackTrace();
        }
         
         return date;
    }

    public boolean addBorrow(String user_id, String book_id) {
        try {
            String sql = "insert into borrows(user_id, book_id, status, created_at) VALUES (?, ?, ?, ?)";
            connection = Connect.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user_id);
            preparedStatement.setString(2, book_id);
            preparedStatement.setInt(3, Status.pending.getValue());
            preparedStatement.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            int row = preparedStatement.executeUpdate();
            return row > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean checkBeforeBorrow(String user_id, String book_id) {
        try {
            String sql = "select count(id) from borrows where user_id = ? and book_id = ? and status <> -1";
            connection = Connect.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user_id);
            preparedStatement.setString(2, book_id);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                int result = resultSet.getInt(1);
                System.out.println(result);
                return result == 0;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public ArrayList<Borrow> getAllBorrow() {
        ArrayList<Borrow> arrayList = new ArrayList<>();
        try {
            String sql = "select borrows.*, users.name as username, books.title as book_name from borrows inner join users on borrows.user_id = users.id inner join books on borrows.book_id = books.id order by borrows.id desc;";
            connection = Connect.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                arrayList.add(new Borrow(
                        resultSet.getString(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        resultSet.getString("status"),
                        resultSet.getString(5),
                        resultSet.getString(11),
                        resultSet.getString("book_name")
                ));
            }
            return arrayList;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public ArrayList<NewBrrow> getAllBorrow2() {
        ArrayList<NewBrrow> arrayList = new ArrayList<>();
        try {
            String sql = "select borrows.*, users.name as username, books.title as book_name from borrows inner join users on borrows.user_id = users.id inner join books on borrows.book_id = books.id order by borrows.id desc;";
            connection = Connect.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                arrayList.add(new NewBrrow(
                        resultSet.getInt(1),
                        resultSet.getInt(2),
                        resultSet.getInt(3),
                        resultSet.getInt(4),
                        resultSet.getString(5),
                        resultSet.getString(6),
                        resultSet.getString(7),
                        resultSet.getString(8),
                        resultSet.getInt(9),
                        resultSet.getString(10),
                        resultSet.getString(11),
                        resultSet.getString("book_name")
                ));
            }
            return arrayList;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean updateStatus(String book_id, String status) {
        try {
            String sql = "update borrows set status = ? where id = ?";
            connection = Connect.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, status);
            preparedStatement.setString(2, book_id);
            int row = preparedStatement.executeUpdate();
            BorrowDao bd = new BorrowDao();

            NotifyDao nd = new NotifyDao();
            int userid = bd.getUserId(book_id);
            System.out.println("gay:" + book_id);
            System.out.println("gay:" + userid);
            System.out.println("gay:" + status);
            String statusName = "";
            if(status.equals("-1")){
                statusName = "Hủy";
            }else if(status.equals("1")){
                statusName = "Xác nhận";
            }

            nd.creatNotiUser(userid, statusName, book_id);
            return row > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void createBorrow(int userId, int bookId, int bookTypeId, String startDate, String endDate,
            String userAddress, String paymentStatus, Integer status, Timestamp createdAt) {
        String sql = "INSERT INTO borrows (user_id, book_id, booktypeid, startdate, enddate, useraddress, "
                + "paymentstatus, status, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        connection = Connect.getConnection();
        try (PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);
            statement.setInt(2, bookId);
            statement.setInt(3, bookTypeId);
            statement.setString(4, startDate);
            statement.setString(5, endDate);
            statement.setString(6, userAddress);
            statement.setString(7, paymentStatus);
            statement.setObject(8, status);
            statement.setTimestamp(9, createdAt);

            statement.executeUpdate();
            System.out.println("Borrow record created successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        BorrowDao bd = new BorrowDao();
        System.out.println(bd.getLastDateById("2"));
//        System.out.println(bd.getAllBorrow2().get(0));
    }
}
