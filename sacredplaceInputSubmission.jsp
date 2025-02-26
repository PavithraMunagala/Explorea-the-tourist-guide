<%@ page import="java.sql.*" %>
<%
    String sacredplaces = request.getParameter("sacredplaces");
    String address = request.getParameter("address"); // changed variable name to lowercase for consistency

    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/TouristGuide", "root", "saraah");
         PreparedStatement pstmt = conn.prepareStatement("INSERT INTO sacredplaces (sacredplaces, address) VALUES (?, ?)")) {

        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Set parameter values
        pstmt.setString(1, sacredplaces);
        pstmt.setString(2, address);

        // Execute the update
        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            response.sendRedirect("SacredPlaces.jsp"); // Redirect to success page
        } else {
            out.println("<h2>Error: Unable to add sacred place.</h2>");
        }
    } catch (SQLException e) {
        out.println("<h2>Database Error: " + e.getMessage() + "</h2>");
    } catch (ClassNotFoundException e) {
        out.println("<h2>JDBC Driver not found: " + e.getMessage() + "</h2>");
    }
%>
