<%@ page import="com.mvc.dao.ProductDao,com.mvc.beans.Product,com.mvc.beans.User,com.mvc.beans.OrderItem" %>
<%@ page import="java.util.List,java.util.ArrayList" %>
<%
User user = (User) session.getAttribute("user");
if(user == null){
    response.sendRedirect("login.jsp");
}

ProductDao dao = new ProductDao(com.mvc.dao.DbConnect.getConnection());

String keyword = request.getParameter("search");
List<Product> products;
if(keyword != null && !keyword.isEmpty()){
    products = dao.searchProducts(keyword);
} else {
    products = dao.getAllProducts();
}

// Cart stored in session
List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
if(cart == null){
    cart = new ArrayList<>();
    session.setAttribute("cart", cart);
}

// Add to cart logic
String addId = request.getParameter("addId");
if(addId != null){
    int pid = Integer.parseInt(addId);
    int qty = 1;
    Product p = products.stream().filter(pr -> pr.getId()==pid).findFirst().orElse(null);
    if(p != null){
        // Check if already in cart
        boolean found = false;
        for(OrderItem item : cart){
            if(item.getProductId().getId()==pid){
                item.setQuantity(item.getQuantity()+1);
                found = true;
                break;
            }
        }
        if(!found){
            cart.add(new OrderItem(0,0,p,qty));
        }
    }
    response.sendRedirect("products.jsp"); // prevent resubmission
}
%>
<jsp:include page="header.html" />
<h2>Products</h2>
<form method="get">
    Search: <input type="text" name="search" value="<%= (keyword!=null)?keyword:"" %>">
    <input type="submit" value="Search">
</form>
<br>
<table border="1">
<tr>
    <th>Image</th>
    <th>Name</th>
    <th>Price</th>
    <th>Action</th>
</tr>
<%
for(Product p : products){
%>
<tr>
    <td><img src="<%= request.getContextPath() %>/images/<%= p.getImageUrl() %>" 
                     height="80" width="80" alt="<%= p.getName() %>"/></td>
    <td><%= p.getName() %></td>
    <td>Rs<%= p.getPrice() %></td>
    <td><a href="products.jsp?addId=<%=p.getId()%>">Add to Cart</a></td>
</tr>
<%
}
%>
</table>
<br>
<a href="cart.jsp">View Cart (<%= cart.size() %>)</a> | <a href="home.jsp">Home</a>
<jsp:include page="footer.html" /> 