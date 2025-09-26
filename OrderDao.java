package com.mvc.dao;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.mvc.beans.Order;
import com.mvc.beans.OrderItem;
import com.mvc.beans.Product;

public class OrderDao {
    private Connection conn;

    public OrderDao(Connection conn) {
        this.conn = conn;
    }

    // Create new order
    public int createOrder(int userId, List<OrderItem> items) {
        int orderId = 0;
        try {
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO orders(user_id) VALUES(?)",
                Statement.RETURN_GENERATED_KEYS
            );
            ps.setInt(1, userId);
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            for (OrderItem item : items) {
                PreparedStatement ps2 = conn.prepareStatement(
                    "INSERT INTO order_items(order_id, product_id, quantity) VALUES(?,?,?)"
                );
                ps2.setInt(1, orderId);
                ps2.setInt(2, item.getProductId().getId()); // ✅ Fixed
                ps2.setInt(3, item.getQuantity());
                ps2.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderId;
    }

    // Get orders by user
    public List<Order> getOrdersByUser(int userId) {
        List<Order> orders = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM orders WHERE user_id=?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orders.add(new Order(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getTimestamp("order_date")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }
    
 // Get all order items for all orders
    public List<OrderItem> getAllOrderItems() {
        List<OrderItem> list = new ArrayList<>();
        try {
            String sql = "SELECT oi.id, oi.order_id, oi.quantity, p.id AS pid, p.name, p.price, p.imageUrl " +
                         "FROM order_items oi " +
                         "JOIN products p ON oi.product_id = p.id";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                    rs.getInt("pid"),
                    rs.getString("name"),
                    rs.getDouble("price"),
                    rs.getString("imageUrl")
                );
                OrderItem oi = new OrderItem(
                    rs.getInt("id"),
                    rs.getInt("order_id"),
                    p,
                    rs.getInt("quantity")
                );
                list.add(oi);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    // Get order items for a specific order
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> list = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT oi.id, oi.quantity, p.id AS pid, p.name, p.price, p.imageUrl " +
                "FROM order_items oi " +
                "JOIN products p ON oi.product_id = p.id " +
                "WHERE oi.order_id = ?"
            );
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                    rs.getInt("pid"),
                    rs.getString("name"),
                    rs.getDouble("price"),
                    rs.getString("imageUrl")
                    
                );
                OrderItem oi = new OrderItem(
                    rs.getInt("id"),
                    orderId,
                    p,
                    rs.getInt("quantity")
                );
                list.add(oi);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
