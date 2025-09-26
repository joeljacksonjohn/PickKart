package com.mvc.beans;

public class OrderItem {
    private int id;
    private int orderId;
    private Product product;
    private int quantity;

    // Constructor
    public OrderItem(int id, int orderId, Product product, int quantity) {
        this.id = id;
        this.orderId = orderId;
        this.product = product;
        this.quantity = quantity;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public Product getProductId() { return product; }
    public void setProductId(Product product) { this.product = product; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
}
