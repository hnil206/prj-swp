package Dao;

import Model.Book;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BookDao {
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;
    public Book get1BookWithNumber(String book_id){
        String sql = "select books.*, count(borrows.user_id)from books left join borrows on books.id = borrows.book_id and borrows.status = 1\n" +
                "where books.id = ? " +
                "group by books.id, title, description, image, author, genre, quantity, available";
        connection = Connect.getConnection();
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1,book_id);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()){
                return new Book(
                        resultSet.getString(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getString(6),
                        resultSet.getString(7),
                        resultSet.getBoolean(8),
                        resultSet.getString(9)
                );
            } else {
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean addBook(String title, String description, String image, String author, String genre, String quantity, String available) {
        String sql = "insert into books(title, description, image, author, genre, quantity, available)\n" +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        connection = Connect.getConnection();
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, title);
            preparedStatement.setString(2, description);
            preparedStatement.setString(3, image);
            preparedStatement.setString(4, author);
            preparedStatement.setString(5, genre);
            preparedStatement.setString(6, quantity);
            preparedStatement.setString(7, available);
            int row = preparedStatement.executeUpdate();
            return row > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public ArrayList<Book> getTop3Borrows(){
        ArrayList<Book> arrayList = new ArrayList<>();
        String sql = "select top 3 books.*, count(borrows.user_id) as count from books left join borrows on books.id = borrows.book_id and borrows.status = 1\n" +
                "group by books.id, title, description, image, author, genre, quantity, available order by count desc";
        connection = Connect.getConnection();
        try {
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                arrayList.add(new Book(
                        resultSet.getString(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getString(6),
                        resultSet.getString(7),
                        resultSet.getBoolean(8),
                        resultSet.getString(9)
                ));
            }
            return arrayList;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    public ArrayList<Book> getAllBooks(){
        ArrayList<Book> arrayList = new ArrayList<>();
        String sql = "select books.*, count(borrows.user_id)from books left join borrows on books.id = borrows.book_id and borrows.status = 1\n" +
                "group by books.id, title, description, image, author, genre, quantity, available\n" +
                "order by id desc";
        connection = Connect.getConnection();
        try {
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                arrayList.add(new Book(
                        resultSet.getString(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getString(6),
                        resultSet.getString(7),
                        resultSet.getBoolean(8),
                        resultSet.getString(9)
                ));
            }
            return arrayList;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    public Book get1Book(String id){
        String sql = "select * from books where id = ? order by id desc ";
        connection = Connect.getConnection();
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1,id);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()){
                return new Book(
                        resultSet.getString(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getString(6),
                        resultSet.getString(7),
                        resultSet.getBoolean(8)
                );
            } else {
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    public boolean updateBook(String id, String title, String description, String image, String author, String genre, String quantity, String available){
        String sql = "update books set title = ?, description  = ?, image = ?, author = ?, genre = ?, quantity = ?, available = ? where id = ?";
        connection = Connect.getConnection();
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, title);
            preparedStatement.setString(2, description);
            preparedStatement.setString(3, image);
            preparedStatement.setString(4, author);
            preparedStatement.setString(5, genre);
            preparedStatement.setString(6, quantity);
            preparedStatement.setString(7, available);
            preparedStatement.setString(8, id);
            int row = preparedStatement.executeUpdate();
            return row>0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public String getBorrowingIdOfBooks(String book_id){
        String result = "";
        String sql = "select id from borrows where book_id = ?";
        try {
            connection = Connect.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, book_id);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                result += resultSet.getString(1) + "-";
            }
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return result;
        }
    }
}
