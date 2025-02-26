<%@ page import="java.sql.*" %>
<%
String touristSpot = request.getParameter("Tourist_Spot");
String address = request.getParameter("Address");

if (touristSpot != null && address != null) {
    Connection con = null;
    PreparedStatement insertStmt = null;
    PreparedStatement deleteStmt = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TouristGuide", "root", "saraah");

        // ? Insert into accepted table
        String insertQuery = "INSERT INTO tourist_spots (Tourist_Spot, Address) VALUES (?, ?)";
        insertStmt = con.prepareStatement(insertQuery);
        insertStmt.setString(1, touristSpot);
        insertStmt.setString(2, address);
        int insertedRows = insertStmt.executeUpdate();  // ? Variable corrected

        // ? Delete only if inserted successfully
        if (insertedRows > 0) {
            String deleteQuery = "DELETE FROM touristspotsuggestion WHERE Tourist_Spot = ? AND Address = ?";
            deleteStmt = con.prepareStatement(deleteQuery);
            deleteStmt.setString(1, touristSpot);
            deleteStmt.setString(2, address);
            int deletedRows = deleteStmt.executeUpdate();

            if (deletedRows > 0) {
                out.println("<script>alert('Tourist spot accepted and removed from the suggestions!'); window.location.href='touristRequest.jsp';</script>");
            } else {
                out.println("<script>alert('Failed to remove the spot from suggestions.'); window.history.back();</script>");
            }
        } else {
            out.println("<script>alert('Error accepting tourist spot!'); window.history.back();</script>");
        }
    } catch (Exception e) {
        out.println("<script>alert('Error: " + e.getMessage() + "'); window.history.back();</script>");
    } finally {
        if (insertStmt != null) insertStmt.close();
        if (deleteStmt != null) deleteStmt.close();
        if (con != null) con.close();
    }
} else {
    out.println("<script>alert('Invalid data!'); window.history.back();</script>");
}
%>
