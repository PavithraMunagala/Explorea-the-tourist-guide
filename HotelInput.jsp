<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Input Form</title>
    <style>
        /* Overall background styling */
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(135deg, #c3ecb2, #7a9cf2);
            font-family: Arial, sans-serif;
            color: #333;
            margin: 0;
        }

        /* Container for centering the form */
        .form-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 350px;
            text-align: center;
        }

        /* Header styling */
        .form-container h1 {
            font-size: 1.8em;
            margin-bottom: 20px;
            color: #333;
        }

        /* Styling for form fields */
        .form-container input[type="text"],
        .form-container input[type="submit"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 1em;
            outline: none;
        }

        /* Submit button styling */
        .form-container input[type="submit"] {
            background-color: #7a9cf2;
            color: #fff;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        /* Button hover effect */
        .form-container input[type="submit"]:hover {
            background-color: #5a82e0;
        }

        /* Subtle styling for input focus */
        .form-container input[type="text"]:focus {
            border-color: #7a9cf2;
            box-shadow: 0 0 5px rgba(122, 156, 242, 0.5);
        }
    </style>
</head>
<body>
    <div class="form-container">
       <h1>Enter Hotel Details</h1>
<form action="hotelInputSubmission.jsp" method="post">
    <label for="hotelname">Hotel Name:</label>
    <input type="text" name="HotelName" placeholder="Enter hotel name" required>
    
    <label for="address">Address:</label>
    <input type="text" id="ASddress" name="Address" placeholder="Enter address" required /><br/>
    
    <input type="submit" value="Submit" />
</form>

    </div>
</body>
</html>
