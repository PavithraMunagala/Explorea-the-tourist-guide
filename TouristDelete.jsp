<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
    String Tourist_Spot = request.getParameter("Tourist_Spot");
    
    Connection conn = null;
    PreparedStatement pstmt = null;

    if (Tourist_Spot == null || Tourist_Spot.trim().isEmpty()) {
        out.println("<h2>Error: Tourist Spot name is required.</h2>");
    } else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/TouristGuide", "root", "saraah");

            // SQL to delete the hotel by primary key (HotelName)
            String sql = "DELETE FROM tourist_spots WHERE Tourist_Spot = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, Tourist_Spot);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("tourist-spots.jsp"); // Redirect back to the hotels list
            } else {
                out.println("<h2>Error: Tourist Spots could not be deleted. It may not exist.</h2>");
            }
        } catch (SQLException e) {
            out.println("<h2>Database Error: " + e.getMessage() + "</h2>");
            // Ideally log this error for debugging purposes
        } catch (ClassNotFoundException e) {
            out.println("<h2>JDBC Driver not found: " + e.getMessage() + "</h2>");
            // Log this error for debugging
        } finally {
            // Close resources in the reverse order of their creation
            if (pstmt != null) {
                try { pstmt.close(); } catch (SQLException e) { /* log or ignore */ }
            }
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { /* log or ignore */ }
            }
        }
    }
%>
