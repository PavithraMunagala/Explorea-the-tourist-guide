<%@ page import="java.sql.*" %>
<%
    String feedback = request.getParameter("feedback");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/TouristGuide", "root", "saraah");
    String sql = "INSERT INTO SFeedback (feedback) VALUES (?)";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, feedback);
    int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            response.sendRedirect("ShoppingMalls.jsp");//response.sendRedirect("SacredPlaces.jsp"); // Redirect to success page
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
    