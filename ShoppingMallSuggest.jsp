<%@ page import="java.sql.*" %>
<%
    String ShoppingMallsName = request.getParameter("ShoppingMallsName");
    String Address = request.getParameter("Address");
    String AdditionalInfo = request.getParameter("AdditionalInfo");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/TouristGuide", "root", "saraah");
    String sql = "INSERT INTO suggestshoppingmalls (ShoppingMallsName, Address, AdditionalInfo) VALUES (?, ?, ?)";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, ShoppingMallsName);
    pstmt.setString(2, Address);
    pstmt.setString(3, AdditionalInfo);
    int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            response.sendRedirect("ShoppingMall.jsp"); // Redirect to success page
        } else {
            out.println("<h2>Error in adding ShoppingMall details.</h2>");
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
    