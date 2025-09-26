<%@ page import="com.mvc.beans.User,com.mvc.beans.OrderItem" %>
<%@ page import="java.util.List" %>
<%
User user = (User) session.getAttribute("user");
if(user == null) response.sendRedirect("login.jsp");

List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
if(cart == null || cart.isEmpty()) response.sendRedirect("cart.jsp");
%>

<jsp:include page="header.html" />
<h2>Checkout</h2>

<table border="1">
<tr>
    <th>Product</th>
    <th>Quantity</th>
    <th>Price</th>
    <th>Subtotal</th>
</tr>
<%
double total = 0;
for(OrderItem item : cart){
    double subtotal = item.getQuantity() * item.getProductId().getPrice();
    total += subtotal;
%>
<tr>
    <td><%= item.getProductId().getName() %></td>
    <td><%= item.getQuantity() %></td>
    <td>Rs<%= item.getProductId().getPrice() %></td>
    <td>Rs<%= subtotal %></td>
</tr>
<% } %>
<tr>
    <td colspan="3" style="text-align:right"><strong>Total:</strong></td>
    <td>Rs<%= total %></td>
</tr>
</table>

<form action="placeOrder.jsp" method="post">
    <input type="submit" value="Place Order">
</form>

<a href="cart.jsp">Back to Cart</a>
<jsp:include page="footer.html" />
