<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.mvc.beans.User" %>
<%
User user = (User) session.getAttribute("user");
if(user == null || !"admin".equals(user.getRole())){
    response.sendRedirect("login.jsp");
}
%>
<jsp:include page="header.html" />

<h2>Admin Dashboard</h2>

 <!-- Admin Dashboard Cards -->
    <main class="dashboard-container">
        <h2>Welcome, Admin!</h2>
        <div class="dashboard-cards">
            <div class="card">
                <h3>Manage Products</h3>
                <p>Add, update, or delete products in your store.</p>
                <a href="manageProducts.jsp" class="btn">Go</a>
            </div>
            <div class="card">
                <h3>View Orders</h3>
                <p>Check all user orders and their status.</p>
                <a href="viewOrders.jsp" class="btn">Go</a>
            </div>
            <div class="card">
                <h3>Logout</h3>
                <p>Logout from your admin account safely.</p>
                <a href="logout.jsp" class="btn">Go</a>
            </div>
        </div>
    </main>
    
   
<jsp:include page="footer.html" />    