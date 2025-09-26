<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>
<jsp:include page="header.html" />

<div style="max-width: 600px; margin: 60px auto; text-align: center;">
    <h1 style="font-size: 3em; color: #ff4d4f; margin-bottom: 20px;">Oops!</h1>
    <p style="font-size: 1.2em; color: #333; margin-bottom: 30px;">
        Something went wrong while processing your request.
    </p>
    <a href="home.jsp" style="
        display: inline-block;
        padding: 12px 30px;
        background-color: #ff9900;
        color: #fff;
        font-weight: bold;
        border-radius: 5px;
        text-decoration: none;
        transition: background-color 0.3s;
    ">Go Back to Home</a>

    <%-- Optional: Show error message for debugging --%>
    <%
        if(exception != null){
    %>
        <p style="color:red; margin-top: 20px;">Error Details: <%= exception.getMessage() %></p>
    <% } %>
</div>
<a href="login.jsp">Back to Login</a>

<jsp:include page="footer.html" />
