<%@ page import="java.sql.*" %>
<%
    String HotelName = request.getParameter("HotelName");
    String Address = request.getParameter("Address");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        // Establish the connection
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/TouristGuide", "root", "saraah");

        // Prepare the SQL statement
        String sql = "INSERT INTO Hotel (HotelName, Address) VALUES (?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, HotelName);
        pstmt.setString(2, Address);

        // Execute the update
        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            response.sendRedirect("hotel.jsp"); // Redirect to success page
        } else {
            out.println("<h2>Error in adding hotel details.</h2>");
        }
    } catch (SQLException e) {
        out.println("<h2>Database Error: " + e.getMessage() + "</h2>");
    } catch (ClassNotFoundException e) {
        out.println("<h2>JDBC Driver not found: " + e.getMessage() + "</h2>");
    } finally {
        // Close resources
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("<h2>Error closing resources: " + e.getMessage() + "</h2>");
        }
    }
%>
