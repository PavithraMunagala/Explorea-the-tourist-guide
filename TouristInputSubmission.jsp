<%@ page import="java.sql.*" %>
<%
    String Tourist_Spot = request.getParameter("Tourist_Spot");
    String Address = request.getParameter("Address");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        // Establish the connection
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/TouristGuide", "root", "saraah");

        // Prepare the SQL statement
        String sql = "INSERT INTO tourist_spots (Tourist_Spot, Address) VALUES (?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, Tourist_Spot);
        pstmt.setString(2, Address);

        // Execute the update
        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            response.sendRedirect("tourist-spots.jsp"); // Redirect to success page
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
