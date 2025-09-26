<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.mvc.dao.ProductDao,com.mvc.beans.Product" %>
<%
    com.mvc.beans.User user = (com.mvc.beans.User) session.getAttribute("user");
    if(user == null || !"admin".equals(user.getRole())) response.sendRedirect("login.jsp");

    ProductDao dao = new ProductDao(com.mvc.dao.DbConnect.getConnection());

    String idStr = request.getParameter("id");
    Product product = null;
    if(idStr != null){
        int id = Integer.parseInt(idStr);
        product = dao.getProductById(id);  // You need to add getProductById(int id) in your DAO if not present
    }

    // Handle update submission
    String name = request.getParameter("name");
    String priceStr = request.getParameter("price");
    String imageUrl = request.getParameter("image");
    if(name != null && priceStr != null && imageUrl != null){
        double price = Double.parseDouble(priceStr);
        int id = Integer.parseInt(idStr);
        dao.updateProduct(id, name, price, imageUrl);  // You need updateProduct() in DAO
        response.sendRedirect("manageProducts.jsp");
    }
%>

<jsp:include page="header.html" />
<main class="dashboard-container">
    <h2>Edit Product</h2>
    <form method="post">
        <input type="hidden" name="id" value="<%= product != null ? product.getId() : "" %>">
        
        <label>Name:</label>
        <input type="text" name="name" value="<%= product != null ? product.getName() : "" %>" required><br><br>
        
        <label>Price:</label>
        <input type="number" step="0.01" name="price" value="<%= product != null ? product.getPrice() : "" %>" required><br><br>
        
        <label>Image URL:</label>
        <input type="text" name="image" value="<%= product != null ? product.getImageUrl() : "" %>" required><br><br>
        
        <input type="submit" value="Update Product">
    </form>
    <br>
    <a href="manageProducts.jsp">Back to Manage Products</a>
</main>
<jsp:include page="footer.html" />
