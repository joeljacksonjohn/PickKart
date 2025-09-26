<%@ page import="com.mvc.dao.OrderDao,com.mvc.beans.OrderItem,com.mvc.beans.User" %>
<%@ page import="java.util.List" %>
<%
User user = (User) session.getAttribute("user");
if(user == null || !"admin".equals(user.getRole())) response.sendRedirect("login.jsp");

OrderDao orderDao = new OrderDao(com.mvc.dao.DbConnect.getConnection());
List<OrderItem> orders = orderDao.getAllOrderItems(); // 0 for all orders
%>
<jsp:include page="header.html" />
<h2>Orders</h2>
<table border="1">
<tr>
    <th>Order ID</th>
    <th>Product</th>
    <th>Quantity</th>
    <th>Price</th>
    <th>Subtotal</th>
</tr>
<%
for(OrderItem oi : orders){
    double subtotal = oi.getQuantity()*oi.getProductId().getPrice();
%>
<tr>
    <td><%= oi.getOrderId() %></td>
    <td><%= oi.getProductId().getName() %></td>
    <td><%= oi.getQuantity() %></td>
    <td>Rs<%= oi.getProductId().getPrice() %></td>
    <td>Rs<%= subtotal %></td>
</tr>
<%
}
%>
</table>
<a href="adminHome.jsp">Back to Dashboard</a>
<jsp:include page="footer.html" /> 