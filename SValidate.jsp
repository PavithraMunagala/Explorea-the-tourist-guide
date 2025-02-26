<%@ page import="java.sql.*" %>
<%
    // Get username and password from the login form
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Establish a connection to the database
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/TouristGuide", "root", "saraah");
        
        // SQL query to check if the username and password match a record in the database
        String sql = "SELECT * FROM Tsignup WHERE username = ? AND password = ?";
        
        // Prepare the SQL statement
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        
        // Execute the query
        rs = pstmt.executeQuery();
        
        // If a record is found, login is successful
        if (rs.next()) {
            // Redirect to feedback page
            response.sendRedirect("SFeedback.html");
        } else {
            // If no matching record is found, show an error message
            out.println("<h2>Invalid username or password. Please try again.</h2>");
        }
    } catch (SQLException e) {
        out.println("<h2>Database Error: " + e.getMessage() + "</h2>");
    } catch (ClassNotFoundException e) {
        out.println("<h2>JDBC Driver not found: " + e.getMessage() + "</h2>");
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("<h2>Error closing resources: " + e.getMessage() + "</h2>");
        }
    }
%>
