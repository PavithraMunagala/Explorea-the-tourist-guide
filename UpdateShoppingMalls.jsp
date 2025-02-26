<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    String originalShoppingMallsName = request.getParameter("OriginalShoppingMallsName");
    String newShoppingMallsName = request.getParameter("NewShoppingMallsName");
    String Address = request.getParameter("Address");

    Connection conn = null;
    PreparedStatement pstmtCheck = null;
    PreparedStatement pstmtUpdate = null;

    if (originalShoppingMallsName == null || originalShoppingMallsName.trim().isEmpty() ||
        newShoppingMallsName == null || newShoppingMallsName.trim().isEmpty() ||
        Address == null || Address.trim().isEmpty()) {
        
        out.println("<h2>Error: All fields are required.</h2>");
    } else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/TouristGuide", "root", "saraah");

            // Check if the new hotel name already exists in the database
            String checkSql = "SELECT COUNT(*) FROM shoppingmalls WHERE ShoppingMallsName = ?";
            pstmtCheck = conn.prepareStatement(checkSql);
            pstmtCheck.setString(1, newShoppingMallsName);
            ResultSet rsCheck = pstmtCheck.executeQuery();
            
            boolean nameExists = false;
            if (rsCheck.next() && rsCheck.getInt(1) > 0) {
                nameExists = true;
            }
            rsCheck.close();

            if (nameExists && !originalShoppingMallsName.equals(newShoppingMallsName)) {
                out.println("<h2>Error: The newShoppingMallsName name already exists. Choose a different name.</h2>");
            } else {
                // SQL to update both HotelName and Address
                String updateSql = "UPDATE shoppingmalls SET ShoppingMallsName = ?, Address = ? WHERE ShoppingMallsName = ?";
                pstmtUpdate = conn.prepareStatement(updateSql);
                pstmtUpdate.setString(1, newShoppingMallsName);
                pstmtUpdate.setString(2, Address);
                pstmtUpdate.setString(3, originalShoppingMallsName);

                int rowsAffected = pstmtUpdate.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("ShoppingMalls.jsp"); // Redirect to the hotels list after updating
                } else {
                    out.println("<h2>Error: Could not update the hotel information.</h2>");
                }
            }
        } catch (SQLException e) {
            out.println("<h2>Database Error: " + e.getMessage() + "</h2>");
        } catch (ClassNotFoundException e) {
            out.println("<h2>JDBC Driver not found: " + e.getMessage() + "</h2>");
        } finally {
            if (pstmtCheck != null) try { pstmtCheck.close(); } catch (SQLException e) { /* log or ignore */ }
            if (pstmtUpdate != null) try { pstmtUpdate.close(); } catch (SQLException e) { /* log or ignore */ }
            if (conn != null) try { conn.close(); } catch (SQLException e) { /* log or ignore */ }
        }
    }
%>
