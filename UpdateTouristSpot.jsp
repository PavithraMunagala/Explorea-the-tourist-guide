<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    // Retrieve form parameters
    String originalTouristSpotName = request.getParameter("OriginalTouristSpotName");
    String newTouristSpotName = request.getParameter("NewTouristSpotName");
    String address = request.getParameter("Address");

    Connection conn = null;
    PreparedStatement pstmtCheck = null;
    PreparedStatement pstmtUpdate = null;

    // Validate if any of the required fields are missing or empty
    if (originalTouristSpotName == null || originalTouristSpotName.trim().isEmpty() ||
        newTouristSpotName == null || newTouristSpotName.trim().isEmpty() ||
        address == null || address.trim().isEmpty()) {
        
        out.println("<h2>Error: All fields are required.</h2>");
    } else {
        try {
            // Load JDBC driver and establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/TouristGuide", "root", "saraah");

            // Step 1: Check if the new tourist spot name already exists in the database
            String checkSql = "SELECT COUNT(*) FROM tourist_spots WHERE Tourist_Spot = ?";
            pstmtCheck = conn.prepareStatement(checkSql);
            pstmtCheck.setString(1, newTouristSpotName);
            ResultSet rsCheck = pstmtCheck.executeQuery();
            
            boolean nameExists = false;
            if (rsCheck.next() && rsCheck.getInt(1) > 0) {
                nameExists = true;
            }
            rsCheck.close();

            // Step 2: Validate name existence and update if valid
            if (nameExists && !originalTouristSpotName.equals(newTouristSpotName)) {
                out.println("<h2>Error: The new tourist spot name already exists. Choose a different name.</h2>");
            } else {
                // SQL to update both Tourist_Spot and Address
                String updateSql = "UPDATE tourist_spots SET Tourist_Spot = ?, Address = ? WHERE Tourist_Spot = ?";
                pstmtUpdate = conn.prepareStatement(updateSql);
                pstmtUpdate.setString(1, newTouristSpotName);
                pstmtUpdate.setString(2, address); // Use the lowercase "address" variable
                pstmtUpdate.setString(3, originalTouristSpotName);

                int rowsAffected = pstmtUpdate.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("tourist-spots.jsp"); // Redirect after successful update
                } else {
                    out.println("<h2>Error: Could not update the tourist spot information.</h2>");
                }
            }
        } catch (SQLException e) {
            out.println("<h2>Database Error: " + e.getMessage() + "</h2>");
        } catch (ClassNotFoundException e) {
            out.println("<h2>JDBC Driver not found: " + e.getMessage() + "</h2>");
        } finally {
            // Close resources in a safe manner
            if (pstmtCheck != null) try { pstmtCheck.close(); } catch (SQLException e) { /* Handle error or log it */ }
            if (pstmtUpdate != null) try { pstmtUpdate.close(); } catch (SQLException e) { /* Handle error or log it */ }
            if (conn != null) try { conn.close(); } catch (SQLException e) { /* Handle error or log it */ }
        }
    }
%>
