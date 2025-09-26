<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.mvc.beans.User" %>
<%
User user = (User) session.getAttribute("user");
if(user == null){
    response.sendRedirect("login.jsp");
    return;
}
%>
<jsp:include page="header.html" />



 <!-- Customer Dashboard Cards -->
    <main class="dashboard-container">
        <h2>Welcome,Customer!</h2>
        <div class="dashboard-cards">
            <div class="card">
                <h3>View Products</h3>
                <p>View All Product</p>
                <a href="products.jsp" class="btn">Go</a>
            </div>
            <div class="card">
                <h3>My Cart</h3>
                <p>Any Unplaced orders are here.</p>
                <a href="cart.jsp" class="btn">Go</a>
            </div>
             <div class="card">
                <h3>MyOrders</h3>
                <p>Ordered Products is here.</p>
                <a href="myOrder.jsp" class="btn">Go</a>
            </div>
            <div class="card">
                <h3>Logout</h3>
                <p>Logout from your customer account safely.</p>
                <a href="logout.jsp" class="btn">Go</a>
            </div>
        </div>
    </main>



<jsp:include page="footer.html" />

    