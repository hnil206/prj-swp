package Dao;

import Model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Objects;

public class UserDao {
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;
    public boolean adminUpdate(String id, String name, String email, String address, String tel, String birthday, String password, String admin){
        try {
            if (Objects.equals(password, "")){
                String sql = "update users set name = ?, email = ?, address = ?, tel = ?, birthday = ?, is_admin = ? where id = ?";
                connection = Connect.getConnection();
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, name);
                preparedStatement.setString(2, email);
                preparedStatement.setString(3, address);
                preparedStatement.setString(4, tel);
                preparedStatement.setString(5, birthday);
                preparedStatement.setString(6, admin);
                preparedStatement.setString(7, id);
                int row = preparedStatement.executeUpdate();
                return row>0;
            } else {
                String sql = "update users set name = ?, email = ?, address = ?, tel = ?, birthday = ?, is_admin = ?, password = ? where id = ?";
                connection = Connect.getConnection();
                preparedStatement.setString(1, name);
                preparedStatement.setString(2, email);
                preparedStatement.setString(3, address);
                preparedStatement.setString(4, tel);
                preparedStatement.setString(5, birthday);
                preparedStatement.setString(6, admin);
                preparedStatement.setString(7, password);
                preparedStatement.setString(8, id);
                int row = preparedStatement.executeUpdate();
                return row>0;
            }

        }catch (SQLException e){
            e.printStackTrace();
            return false;
        }
    }
    public ArrayList<User> getAllUsers(){
        ArrayList<User> users = new ArrayList<>();
        try {
            String sql = "select * from users";
            connection = Connect.getConnection();
            preparedStatement=connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                users.add(
                        new User(
                                resultSet.getString("id"),
                                resultSet.getString("name"),
                                resultSet.getString("email"),
                                resultSet.getString("address"),
                                resultSet.getString("tel"),
                                resultSet.getString("birthday"),
                                resultSet.getString("password"),
                                resultSet.getString("avatar"),
                                resultSet.getString("verify_key"),
                                resultSet.getBoolean("is_admin"),
                                resultSet.getBoolean("is_verified")
                        )
                );
            }
            return users;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    public boolean updateAvatar(String id, String path){
        try {
            String sql = "update users set avatar = ? where id = ?";
            connection = Connect.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, path);
            preparedStatement.setString(2, id);
            int row = preparedStatement.executeUpdate();
            return row>0;
        }catch (SQLException e){
            e.printStackTrace();
            return false;
        }
    }
    public boolean update(String name, String password, String id){
        try {
            String sql = "update users set name = ?, password = ? where id = ?";
            connection = Connect.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, password);
            preparedStatement.setString(3, id);
            int row = preparedStatement.executeUpdate();
            return row>0;
        }catch (SQLException e){
            e.printStackTrace();
            return false;
        }
    }
    public User getUserById(String id){
        try {
            String sql = "select * from users where id = ?";
            connection = Connect.getConnection();
            preparedStatement=connection.prepareStatement(sql);
            preparedStatement.setString(1,id);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()){
                return new User(
                        resultSet.getString("id"),
                        resultSet.getString("name"),
                        resultSet.getString("email"),
                        resultSet.getString("address"),
                        resultSet.getString("tel"),
                        resultSet.getString("birthday"),
                        resultSet.getString("password"),
                        resultSet.getString("avatar"),
                        resultSet.getString("verify_key"),
                        resultSet.getBoolean("is_admin"),
                        resultSet.getBoolean("is_verified")
                );
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }
    public boolean changePassword(String key, String password){
        String sql = "update users set password = ? where verify_key = ?";
        connection = Connect.getConnection();
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, password);
            preparedStatement.setString(2, key);
            int row = preparedStatement.executeUpdate();
            return row > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean checkValidKey(String key){
        String sql = "select * from users where verify_key = ?";
        connection = Connect.getConnection();
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, key);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()){
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean deleteKey(String key){
        String sql = "update users set verify_key = '' where verify_key = ?";
        connection = Connect.getConnection();
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1,key);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean updateUUIDbyMail(String email, String uuid){
        String sql = "update users set verify_key = ? where email = ?";
        connection = Connect.getConnection();
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1,uuid);
            preparedStatement.setString(2,email);
            preparedStatement.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean checkMailAndTel(String email, String tel){
        String sql = "select * from users where email = ? and tel = ?";
        connection = Connect.getConnection();
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, tel);
            resultSet =  preparedStatement.executeQuery();
            if (resultSet.next()){
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return true;
        }
    }
    public boolean register(String name, String email, String address, String tel, String dob, String password, String ver_key){
        String sql = "insert into users(name, email, address, tel, birthday, password,avatar, verify_key, is_admin, is_verified) values ( ?, ?, ?, ?,?, ?, ?, ?, ?, ?)";
        connection = Connect.getConnection();
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1,name);
            preparedStatement.setString(2,email);
            preparedStatement.setString(3,address);
            preparedStatement.setString(4,tel);
            preparedStatement.setString(5,dob);
            preparedStatement.setString(6,password);
            preparedStatement.setString(7,"uploads/default-avatar.webp");
            preparedStatement.setString(8,ver_key);
            preparedStatement.setBoolean(9,false);
            preparedStatement.setBoolean(10,false);
            preparedStatement.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public User login(String email, String password){
        String sql = "select * from users where email = ? and password = ?";
        connection = Connect.getConnection();
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);
            resultSet =  preparedStatement.executeQuery();
            if (resultSet.next()){
                return new User(
                        resultSet.getString("id"),
                        resultSet.getString("name"),
                        resultSet.getString("email"),
                        resultSet.getString("address"),
                        resultSet.getString("tel"),
                        resultSet.getString("birthday"),
                        resultSet.getString("password"),
                        resultSet.getString("avatar"),
                        resultSet.getString("verify_key"),
                        resultSet.getBoolean("is_admin"),
                        resultSet.getBoolean("is_verified")
                );
            } else {
                return new User();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    public int checkUserInfoDuplicate(String email, String tel){
        String sql = "DECLARE @outputCode INT;\n" +
                "    EXEC CheckDuplicates @mail = ?, @tel = ?, @result_code = @outputCode OUTPUT;\n" +
                "SELECT @outputCode AS result_code;";
        connection = Connect.getConnection();
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, tel);
            resultSet = preparedStatement.executeQuery();
            int result = -1;
            if (resultSet.next())
                result = resultSet.getInt("result_code");
            return result;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public User findUserBy_key(String key){
        try {
            String sql = "select * from users where verify_key = ?";
            connection = Connect.getConnection();
            preparedStatement=connection.prepareStatement(sql);
            preparedStatement.setString(1,key);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()){
                return new User(
                        resultSet.getString("id"),
                        resultSet.getString("name"),
                        resultSet.getString("email"),
                        resultSet.getString("address"),
                        resultSet.getString("tel"),
                        resultSet.getString("birthday"),
                        resultSet.getString("password"),
                        resultSet.getString("avatar"),
                        resultSet.getString("verify_key"),
                        resultSet.getBoolean("is_admin"),
                        resultSet.getBoolean("is_verified")
                );
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }
    public boolean activeById(int id){
        String sql = "update users set is_verified = 1, verify_key = '' where id = ?";
        connection = Connect.getConnection();
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1,id);
            int row = preparedStatement.executeUpdate();
            return row>0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
