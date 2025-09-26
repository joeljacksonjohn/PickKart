package com.mvc.dao;

import java.sql.Connection;
import java.sql.DriverManager;



public class DbConnect {
    private static Connection conn;
    
    public static Connection getConnection() {
        try {
            if(conn == null) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/pickkart", "root", "Joel@2001"
                );
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
