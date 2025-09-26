
<%@ page import="com.mvc.beans.User,com.mvc.beans.OrderItem" %>
<%@ page import="java.util.List" %>
<%
User user = (User) session.getAttribute("user");
if(user == null){ response.sendRedirect("login.jsp"); }

List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
if(cart == null) { cart = new java.util.ArrayList<>(); session.setAttribute("cart", cart); }

// Update quantity
String updateId = request.getParameter("updateId");
String qtyStr = request.getParameter("quantity");
if(updateId != null && qtyStr != null){
    int pid = Integer.parseInt(updateId);
    int qty = Integer.parseInt(qtyStr);
    for(OrderItem item : cart){
        if(item.getProductId().getId() == pid) { item.setQuantity(qty); break; }
    }
}

// Remove item
String removeId = request.getParameter("removeId");
if(removeId != null){
    int pid = Integer.parseInt(removeId);
    cart.removeIf(item -> item.getProductId().getId()==pid);
}
%>
<jsp:include page="header.html" />
<h2>My Cart</h2>
<%
if(cart.isEmpty()){
%>
<p>Your cart is empty!</p>
<%
} else {
%>
<form method="get">
<table border="1">
<tr>
    <th>Product</th>
    <th>Price</th>
    <th>Quantity</th>
    <th>Subtotal</th>
    <th>Action</th>
</tr>
<%
double total = 0;
for(OrderItem item : cart){
    double subtotal = item.getQuantity() * item.getProductId().getPrice();
    total += subtotal;
%>
<tr>
    <td><%= item.getProductId().getName() %></td>
    <td>Rs<%= item.getProductId().getPrice() %></td>
    <td>
        <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1">
        <input type="hidden" name="updateId" value="<%= item.getProductId().getId() %>">
        <input type="submit" value="Update">
    </td>
    <td>Rs<%= subtotal %></td>
    <td><a href="cart.jsp?removeId=<%=item.getProductId().getId()%>">Remove</a></td>
</tr>
<%
}
%>
<tr>
    <td colspan="3">Total</td>
    <td colspan="2">Rs<%= total %></td>
</tr>
</table>
</form>
<a href="checkout.jsp">Checkout</a>
<%
}
%>
<br><a href="products.jsp">Continue Shopping</a>
<jsp:include page="footer.html" /> 