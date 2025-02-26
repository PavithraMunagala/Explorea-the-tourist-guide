<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    String originalSacredPlaces = request.getParameter("sacredplaces");
    String newSacredPlaceName = originalSacredPlaces; // This seems incorrect; it should be updated by the user input
    String currentAddress = "";
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    if (originalSacredPlaces == null || originalSacredPlaces.trim().isEmpty()) {
        out.println("<h2>Error: Sacred place name is required.</h2>");
    } else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/TouristGuide", "root", "saraah");

            // Fetch the sacred place details
            String sql = "SELECT * FROM sacredplaces WHERE sacredplaces = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, originalSacredPlaces);
                rs = pstmt.executeQuery();

            if (rs.next()) {
                currentAddress = rs.getString("address"); // Ensure your DB column name matches
            } else {
                out.println("<h2>Error: Sacred place not found.</h2>");
            }
        } catch (SQLException e) {
            out.println("<h2>Database Error: " + e.getMessage() + "</h2>");
        } catch (ClassNotFoundException e) {
            out.println("<h2>JDBC Driver not found: " + e.getMessage() + "</h2>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { /* log or ignore */ }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { /* log or ignore */ }
            if (conn != null) try { conn.close(); } catch (SQLException e) { /* log or ignore */ }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Sacred Places Information</title>
    <style>
        /* General reset for consistency */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #f8e1d4, #f2d1c1);
            color: #333;
            display: flex;
            height: 100vh;
            justify-content: center;
            align-items: center;
        }

        .form-container {
            background: #fff;
            border-radius: 15px;
            padding: 40px;
            width: 100%;
            max-width: 500px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #e76b8a;
            font-size: 1.8em;
            margin-bottom: 20px;
            font-weight: bold;
        }

        label {
            display: block;
            margin: 15px 0 5px;
            font-weight: 600;
            color: #555;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s;
        }

        input[type="text"]:focus {
            border-color: #e76b8a;
            outline: none;
            box-shadow: 0 0 5px rgba(231, 107, 138, 0.2);
        }

        button {
            width: 100%;
            background: #e76b8a;
            color: white;
            padding: 12px;
            font-size: 1em;
            border: none;
            border-radius: 8px;
            margin-top: 20px;
            cursor: pointer;
            transition: background 0.3s;
        }

        button:hover {
            background: #d46682;
        }

        @media (max-width: 600px) {
            .form-container {
                padding: 20px;
            }

            h2 {
                font-size: 1.6em;
            }

            label {
                font-size: 0.9em;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Update Sacred Places Information</h2>
        <form action="UpdateSacredPlace.jsp" method="post">
            <input type="hidden" name="originalSacredPlaces" value="<%= originalSacredPlaces %>">
            
            <label for="newSacredPlaceName">Sacred Place Name:</label>
            <input type="text" id="newSacredPlaceName" name="newSacredPlaceName" value="<%= newSacredPlaceName %>"> <!-- Should allow editing -->
            
            <label for="address">Address:</label>
            <input type="text" id="address" name="address" value="<%= currentAddress %>">
            
            <button type="submit">Update</button>
        </form>
    </div>
</body>
</html>
