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
        product = dao.getProductById(id);  // Same: you need this in DAO
    }

    // Handle delete submission
    String confirm = request.getParameter("confirm");
    if("yes".equals(confirm)){
        dao.deleteProduct(Integer.parseInt(idStr));
        response.sendRedirect("manageProducts.jsp");
    }
%>

<jsp:include page="header.html" />
<main class="dashboard-container">
    <h2>Delete Product</h2>
    <% if(product != null){ %>
        <p>Are you sure you want to delete <strong><%= product.getName() %></strong>?</p>
        <form method="post">
            <input type="hidden" name="id" value="<%= product.getId() %>">
            <button type="submit" name="confirm" value="yes">Yes, Delete</button>
            <a href="manageProducts.jsp" class="btn">Cancel</a>
        </form>
    <% } else { %>
        <p>Product not found!</p>
    <% } %>
</main>
<jsp:include page="footer.html" />
