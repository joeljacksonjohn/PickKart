<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="com.mvc.dao.*,com.mvc.beans.*" %>
<%
String msg = "";
if(request.getParameter("login") != null){
    String user = request.getParameter("username");
    String pass = request.getParameter("password");
    UserDao dao = new UserDao(DbConnect.getConnection());
    User u = dao.login(user, pass);

    if(u != null){
        session.setAttribute("user", u);
        if("admin".equals(u.getRole())){
            response.sendRedirect("adminHome.jsp");
        } else {
            response.sendRedirect("home.jsp");
        }
    } else {
        msg = "Invalid login!";
    }
}
%>
<jsp:include page="header.html" />
<h2>Login</h2>
<form method="post">
    Username: <input type="text" name="username"><br><br>
    Password: <input type="password" name="password"><br><br>
    <input type="submit" name="login" value="Login">
</form>
<div class="login-footer">
    <% if(msg != null && !msg.isEmpty()) { %>
        <div class="error-msg"><%= msg %></div>
    <% } %>
    <div class="register-link">
        Don't have an account? <a href="register.jsp">Register here</a>
    </div>
</div>

    