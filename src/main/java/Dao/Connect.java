package Dao;

import Model.Config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connect {
    public static Connection getConnection(){
        try {
            String serverName = Config.map.get("db_server");
            String databaseName = Config.map.get("db_name");
            String url = "jdbc:sqlserver://" + serverName + ";databaseName=" + databaseName + ";trustServerCertificate=true;";
            String username = Config.map.get("db_username");
            String password = Config.map.get("db_password");
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(url, username, password);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) throws SQLException {
        System.out.println(getConnection().getCatalog());
    }
}
