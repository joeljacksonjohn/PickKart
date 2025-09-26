<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.mvc.beans.User, com.mvc.beans.OrderItem, com.mvc.beans.Order, com.mvc.dao.OrderDao" %>
<%@ page import="java.util.List" %>
<%
    // Check if user is logged in
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
    }

    // Get orders for logged-in user
    OrderDao orderDao = new OrderDao(com.mvc.dao.DbConnect.getConnection());
    List<Order> orders = orderDao.getOrdersByUser(user.getId());
%>

<jsp:include page="header.html" />

<h2>My Orders</h2>

<% if (orders.isEmpty()) { %>
    <p>You have not placed any orders yet.</p>
<% } else { %>
    <% for (Order order : orders) { %>
        <h3>Order ID: <%= order.getId() %> | Date: <%= order.getOrderDate() %></h3>
        <table border="1">
            <tr>
                <th>Product</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Subtotal</th>
            </tr>
            <%
                List<OrderItem> items = orderDao.getOrderItemsByOrderId(order.getId());
                double total = 0;
                for (OrderItem oi : items) {
                    double subtotal = oi.getQuantity() * oi.getProductId().getPrice();
                    total += subtotal;
            %>
            <tr>
                <td><%= oi.getProductId().getName() %></td>
                <td><%= oi.getQuantity() %></td>
                <td>$<%= oi.getProductId().getPrice() %></td>
                <td>$<%= subtotal %></td>
            </tr>
            <% } %>
            <tr>
                <td colspan="3" style="text-align:right;"><strong>Total:</strong></td>
                <td><strong>$<%= total %></strong></td>
            </tr>
        </table>
        <br>
    <% } %>
<% } %>

<a href="home.jsp">Back to Home</a>

<jsp:include page="footer.html" />
