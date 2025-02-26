<%@ page import="java.sql.*" %>

<%
    String originalTouristSpot = request.getParameter("OriginalTouristSpot");
    String newTouristSpotName = request.getParameter("NewTouristSpotName");
    String newAddress = request.getParameter("Address");

    if (originalTouristSpot == null || originalTouristSpot.trim().isEmpty() ||
        newTouristSpotName == null || newTouristSpotName.trim().isEmpty() ||
        newAddress == null || newAddress.trim().isEmpty()) {
        out.println("<h2>Error: All fields must be filled out.</h2>");
    } else {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/TouristGuide", "root", "saraah");

            // Update the tourist spot details
            String sql = "UPDATE tourist_spots SET Tourist_Spot = ?, Address = ? WHERE Tourist_Spot = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newTouristSpotName);
            pstmt.setString(2, newAddress);
            pstmt.setString(3, originalTouristSpot);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("tourist-spots.jsp");
            } else {
                out.println("<h2>Error: Tourist spot not found or update failed.</h2>");
            }
        } catch (SQLException e) {
            out.println("<h2>Database Error: " + e.getMessage() + "</h2>");
        } catch (ClassNotFoundException e) {
            out.println("<h2>JDBC Driver not found: " + e.getMessage() + "</h2>");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { /* log or ignore */ }
            if (conn != null) try { conn.close(); } catch (SQLException e) { /* log or ignore */ }
        }
    }
%>
