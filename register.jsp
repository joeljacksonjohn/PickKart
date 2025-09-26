<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.mvc.dao.*" %>
<%
String msg = "";
if(request.getMethod().equalsIgnoreCase("POST")){
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if(username != null && !username.isEmpty() && password != null && !password.isEmpty()){
        UserDao dao = new UserDao(DbConnect.getConnection());
        if(dao.register(username, password)){
            msg = "Registration successful! <a href='login.jsp'>Login</a>";
        } else {
            msg = "Registration failed! Username might already exist.";
        }
    } else {
        msg = "Please enter both username and password.";
    }
}
%>

<jsp:include page="header.html" />

<h2>Register</h2>
<% if(!msg.isEmpty()) { %>
    <p style="color:green;"><%= msg %></p>
<% } %>

<form method="post">
    Username: <input type="text" name="username" required><br><br>
    Password: <input type="password" name="password" required><br><br>
    <input type="submit" name="register" value="Register">
</form>

<jsp:include page="footer.html" />
