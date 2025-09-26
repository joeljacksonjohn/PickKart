<%@ page import="com.mvc.dao.ProductDao,com.mvc.beans.Product" %>
<%@ page import="java.util.List" %>
<%
com.mvc.beans.User user = (com.mvc.beans.User) session.getAttribute("user");
if(user == null || !"admin".equals(user.getRole())) response.sendRedirect("login.jsp");

ProductDao dao = new ProductDao(com.mvc.dao.DbConnect.getConnection());

// Add product
String name = request.getParameter("name");
String priceStr = request.getParameter("price");
String imageUrl = request.getParameter("image");
if(name != null && priceStr != null && imageUrl != null){
    double price = Double.parseDouble(priceStr);
    dao.addProduct(name, price, imageUrl);
    response.sendRedirect("manageProducts.jsp");
}

// Delete product
String deleteId = request.getParameter("deleteId");
if(deleteId != null){
    dao.deleteProduct(Integer.parseInt(deleteId));
    response.sendRedirect("manageProducts.jsp");
}

// Get all products
List<Product> products = dao.getAllProducts();
%>
<jsp:include page="header.html" />
<h2>Manage Products</h2>
<form method="get">
    Name: <input type="text" name="name" required>
    Price: <input type="number" step="0.01" name="price" required>
    Image URL: <input type="text" name="image" required>
    <input type="submit" value="Add Product">
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
   <td><img src="<%= request.getContextPath() + "/images/" + p.getImageUrl() %>"height="80" width="80"/></td>
   

    <td><%= p.getName() %></td>
    <td>Rs<%= p.getPrice() %></td>
    <td>
        <a href="edit.jsp?id=<%=p.getId()%>">Edit</a> |
        <a href="delete.jsp?id=<%=p.getId()%>">Delete</a>
    </td>
</tr>
<%
}
%>
</table>
<a href="adminHome.jsp">Back to Dashboard</a>

<jsp:include page="footer.html" /> 