✨ Features

👤 Customer

User Registration & Login
Browse Products
Search Products
Add to Cart
Checkout & Place Orders
View Order History

🔑 Admin

Login as Admin
Manage Products (Add, Edit, Delete)
View All Customer Orders

🛠️ Tech Stack

Frontend: JSP, HTML, CSS
Backend: Java (Servlets & JSP), JDBC
Database: MySQL
Server: Apache Tomcat

📂 Project Structure

PickKart/
│── src/com/mvc/beans/ # Java Beans (User, Product, Order, OrderItem)
│── src/com/mvc/dao/ # DAO classes (UserDao, ProductDao, OrderDao)
│── WebContent/
│ ├── css/ # Stylesheets
│ ├── images/ # Product Images
│ ├── header.html # Common Header
│ ├── footer.html # Common Footer
│ ├── home.jsp # Home Page
│ ├── login.jsp # Login Page
│ ├── register.jsp # Registration Page
│ ├── products.jsp # Product Listing
│ ├── cart.jsp # Shopping Cart
│ ├── checkout.jsp # Checkout
│ ├── myOrders.jsp # Customer Order History
│ ├── adminHome.jsp # Admin Dashboard
│ ├── manageProducts.jsp # Admin Manage Products
│ ├── viewOrders.jsp # Admin View Orders
│ └── error.jsp # Error Page

🚀 How to Run

Clone the repo:
git clone https://github.com/your-username/PickKart.git
Import project into Eclipse/IntelliJ as a Dynamic Web Project.
Configure Tomcat server in IDE.
Create the database in MySQL using the above schema.
Update your database connection in DbConnect.java:
private static final String URL = "jdbc:mysql://localhost:3306/pickkart";
private static final String USER = "root";
private static final String PASSWORD = "yourpassword";
Run the project on Tomcat.
Access the app at:
Customer: http://localhost:8080/PickKart/home.jsp
Admin: http://localhost:8080/PickKart/adminHome.jsp

🔑 Default Login

Admin:
Username: admin
Password: admin
Customer: Register through the app.

📌 Future Enhancements

Add Payment Gateway Integration
Improve UI with Bootstrap
Add Category & Filters
Implement JWT-based authentication

👨‍💻 Author

Developed by Joel Jackson (PickKart Project)
