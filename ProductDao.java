package com.mvc.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.mvc.beans.Product;

public class ProductDao {
    private Connection conn;

    public ProductDao(Connection conn){ this.conn = conn; }

    public List<Product> getAllProducts(){
        List<Product> list = new ArrayList<>();
        try{
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM products");
            while(rs.next()){
                list.add(new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getDouble("price"),
                    rs.getString("imageUrl")
                    
                ));
            }
        }catch(Exception e){ e.printStackTrace(); }
        return list;
    }

    public List<Product> searchProducts(String keyword){
        List<Product> list = new ArrayList<>();
        try{
            PreparedStatement ps = conn.prepareStatement(
                "SELECT * FROM products WHERE name LIKE ?"
            );
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                list.add(new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getDouble("price"),
                    rs.getString("imageUrl")
                ));
            }
        }catch(Exception e){ e.printStackTrace(); }
        return list;
    }
    
 // In ProductDao.java
    public Product getProductById(int id) {
        Product product = null;
        try {
            String sql = "SELECT * FROM products WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setImageUrl(rs.getString("image"));
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return product;
    }


    public boolean addProduct(String name, double price, String imageUrl){
        try{
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO products(name,price,imageUrl) VALUES(?,?,?)"
            );
            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setString(3, imageUrl);
            return ps.executeUpdate() > 0;
        }catch(Exception e){ e.printStackTrace(); }
        return false;
    }

    public boolean updateProduct(int id, String name, double price, String imageUrl){
        try{
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE products SET name=?, price=?, imageUrl=? WHERE id=?"
            );
            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setString(3, imageUrl);
            ps.setInt(4, id);
            return ps.executeUpdate() > 0;
        }catch(Exception e){ e.printStackTrace(); }
        return false;
    }

    public boolean deleteProduct(int id){
        try{
            PreparedStatement ps = conn.prepareStatement(
                "DELETE FROM products WHERE id=?"
            );
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }catch(Exception e){ e.printStackTrace(); }
        return false;
    }
}
