<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    String originalSacredPlaces = request.getParameter("originalSacredPlaces");
    String newSacredPlaceName = request.getParameter("newSacredPlaceName");
    String address = request.getParameter("address");

    // Debugging output
    out.println("Original Sacred Places: " + originalSacredPlaces);
    out.println("New Sacred Place Name: " + newSacredPlaceName);
    out.println("Address: " + address);

    Connection conn = null;
    PreparedStatement pstmtCheck = null;
    PreparedStatement pstmtUpdate = null;

    if (originalSacredPlaces == null || originalSacredPlaces.trim().isEmpty() ||
        newSacredPlaceName == null || newSacredPlaceName.trim().isEmpty() ||
        address == null || address.trim().isEmpty()) {
        
        out.println("<h2>Error: All fields are required.</h2>");
        return; // Stop processing
    } else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/TouristGuide", "root", "saraah");

            // Check if the new sacred place name already exists in the database
            String checkSql = "SELECT COUNT(*) FROM sacredplaces WHERE sacredplaces = ?";
            pstmtCheck = conn.prepareStatement(checkSql);
            pstmtCheck.setString(1, newSacredPlaceName);
            ResultSet rsCheck = pstmtCheck.executeQuery();
            
            boolean nameExists = false;
            if (rsCheck.next() && rsCheck.getInt(1) > 0) {
                nameExists = true;
            }
            rsCheck.close();

            if (nameExists && !originalSacredPlaces.equals(newSacredPlaceName)) {
                out.println("<h2>Error: The new sacred place name already exists. Choose a different name.</h2>");
            } else {
                // SQL to update both sacred place name and address
                String updateSql = "UPDATE sacredplaces SET sacredplaces = ?, address = ? WHERE sacredplaces = ?";
                pstmtUpdate = conn.prepareStatement(updateSql);
                pstmtUpdate.setString(1, newSacredPlaceName);
                pstmtUpdate.setString(2, address);
                pstmtUpdate.setString(3, originalSacredPlaces);

                int rowsAffected = pstmtUpdate.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("SacredPlaces.jsp"); // Redirect to the sacred places list after updating
                    return; // Prevent further processing
                } else {
                    out.println("<h2>Error: Could not update the sacred place information. Please verify the original name and try again.</h2>");
                }
            }
        } catch (SQLException e) {
            out.println("<h2>Database Error: " + e.getMessage() + "</h2>");
            e.printStackTrace(); // For debugging
        } catch (ClassNotFoundException e) {
            out.println("<h2>JDBC Driver not found: " + e.getMessage() + "</h2>");
        } finally {
            if (pstmtCheck != null) try { pstmtCheck.close(); } catch (SQLException e) { /* log or ignore */ }
            if (pstmtUpdate != null) try { pstmtUpdate.close(); } catch (SQLException e) { /* log or ignore */ }
            if (conn != null) try { conn.close(); } catch (SQLException e) { /* log or ignore */ }
        }
    }
%>
