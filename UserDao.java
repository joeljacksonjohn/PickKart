package com.mvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.mvc.beans.User;


public class UserDao {
    private Connection conn;

    public UserDao(Connection conn) {
        this.conn = conn;
    }

    public User login(String username, String password) {
        try {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT * FROM users WHERE username=? AND password=?"
            );
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                return new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("role")
                );
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean register(String username, String password) {
        try {
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO users(username,password,role) VALUES(?,?,?)"
            );
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, "customer");
            int i = ps.executeUpdate();
            return i>0;
        } catch(Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
