<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.mvc.beans.User,com.mvc.beans.OrderItem" %>
<%@ page import="com.mvc.dao.OrderDao" %>
<%@ page import="java.util.List" %>
<%
User user = (User) session.getAttribute("user");
if(user == null) response.sendRedirect("login.jsp");

List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
if(cart == null || cart.isEmpty()) response.sendRedirect("cart.jsp");

// Place the order
OrderDao orderDao = new OrderDao(com.mvc.dao.DbConnect.getConnection());
int orderId = orderDao.createOrder(user.getId(), cart);

// Clear cart
session.removeAttribute("cart");
%>

<jsp:include page="header.html" />
<h2>Order Confirmation</h2>
<p style="color:green;">Your order has been placed successfully! Order ID: <%= orderId %></p>
<a href="home.jsp">Back to Home</a>
<jsp:include page="footer.html" />
