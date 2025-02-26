<%@ page import="java.sql.*" %>
<%
String touristSpot = request.getParameter("Tourist_Spot");

if (touristSpot != null) {
    Connection con = null;
    PreparedStatement pstmt = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TouristGuide", "root", "saraah");

        // Delete query
        String query = "DELETE FROM touristspotsuggestion WHERE Tourist_Spot = ?";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, touristSpot);
        int rows = pstmt.executeUpdate();

        if (rows > 0) {
            out.println("<script>alert('Tourist spot declined and removed from suggestions!'); window.location.href='touristRequest.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to remove the tourist spot.'); window.history.back();</script>");
        }
    } catch (Exception e) {
        out.println("<script>alert('Error: " + e.getMessage() + "'); window.history.back();</script>");
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { /* log or ignore */ }
        if (con != null) try { con.close(); } catch (SQLException e) { /* log or ignore */ }
    }
} else {
    out.println("<script>alert('Invalid data!'); window.history.back();</script>");
}
%>
