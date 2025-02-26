<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tourist Spot List</title>
    <style>
        /* Reset some default styles */
        body, h2, h3, p {
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to bottom right, #fce4d6, #f8d3c7); /* Soft rose gold gradient */
        }

        /* Hotel item container */
        .hotel-item {
            position: relative; /* To position the content on top of the overlay */
            background-color: white; /* White background for hotel items */
            border: 1px solid #e8b4a2; /* Light rose gold border */
            border-radius: 10px; /* More rounded corners for elegance */
            padding: 20px;
            margin: 20px auto;
            max-width: 600px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
            z-index: 2; /* Stays above the overlay */
        }

        /* Title styles */
        h2 {
            text-align: center;
            margin: 30px 0;
            font-size: 2.5em;
            color: #c57b6c; /* Rose gold color */
        }

        /* Hotel item name and address styles */
        .hotel-name {
            font-size: 1.8em;
            color: #e76b8a; /* Darker rose gold */
            margin-bottom: 10px;
            font-weight: bold;
        }

        .hotel-address {
            font-size: 1em;
            color: #7f8c8d; /* Muted grey for contrast */
        }

        /* Action buttons container */
        .hotel-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
        }

        /* Button styles */
        .action-btn,
        .update-btn {
            background-color: #e76b8a; /* Rose gold */
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-weight: bold;
        }

        .action-btn:hover,
        .update-btn:hover {
            background-color: #f39c12; /* Lighter gold on hover */
        }

        /* Delete button specific styles */
        .update-btn {
            background-color: #F87A53; /* Red for delete */
        }

        .update-btn:hover {
            background-color: #c0392b; /* Darker red on hover */
        }

        /* Feedback and comments button styles */
        .feedback-btn, 
        .reviews-btn {
            background-color: #CDC1FF; /* Green for feedback */
        }

        .feedback-btn:hover,
        .reviews-btn:hover {
            background-color: #FFCCEA; /* Lighter green on hover */
        }

        /* Add some spacing and improve responsiveness */
        @media (max-width: 600px) {
            .hotel-item {
                padding: 15px;
            }

            .hotel-name {
                font-size: 1.5em;
            }

            .hotel-address {
                font-size: 0.9em;
            }
        }

    </style>
</head>
<body>
    <div class="overlay"></div>
    <h2>Explore Our Tourist Spots</h2>

    <%
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TouristGuide", "root", "saraah");
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT * FROM tourist_spots LIMIT 50"); // Adjust to get only 20 records

        while (rs.next()) {
            String Tourist_Spot = rs.getString("Tourist_Spot");
            String Address = rs.getString("Address");
    %>
    <div class="hotel-item">
        <h3 class="Tourist_Spot-name"><%= Tourist_Spot %></h3>
        <p class="hotel-address"><%= Address %></p>
        <div class="hotel-actions">
            <button class="action-btn feedback-btn">Give Feedback</button>
            <button class="action-btn reviews-btn">Comments</button>

            <!-- Update button with hidden Tourist_Spot input -->
            <form action="TouristEdit.jsp" method="post" style="display:inline;">
                <input type="hidden" name="Tourist_Spot" value="<%= Tourist_Spot %>">
                <button type="submit" class="update-btn">Update</button>
            </form>
        </div>
    </div>
    <%
        }
    } catch (Exception e) {
        out.println("Unable to load tourist spot information at the moment. Error: " + e.getMessage());
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { /* log or ignore */ }
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { /* log or ignore */ }
        if (con != null) try { con.close(); } catch (SQLException e) { /* log or ignore */ }
    }
    %>

</body>
</html>
