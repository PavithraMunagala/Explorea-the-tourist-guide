<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Smart City Guide</title>
  <style>
    /* Add styling here */
    /* Basic reset and styling */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      background-image: url(Images/sacred.jpeg);
      font-family: Arial, sans-serif;
      line-height: 1.6;
      overflow-x: hidden;
      height: 100%; /* You must set a specified height */
      background-position: right; /* right the image */
      background-repeat: no-repeat; /* Do not repeat the image */
      background-size: cover;
    }

      /* Navigation Bar */
      .navbar {
        background: rgb(251,251,251);
        background: linear-gradient(90deg, rgba(251,251,251,1) 0%, rgba(212,246,255,1) 50%, rgba(198,231,255,1) 100%);
        color: #fff;
        padding: 0;
        position: fixed;
        width: 100%;
        top: 0;
        z-index: 10;
      }
      
      .nav-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
      }
      
      .logo {
          padding-left: 20px;
          height: 80px; /* Set the height of the logo */
          width: auto;  /* Maintain aspect ratio */
          margin-right: 1em; /* Space between the logo and navigation links */
      }
      
      .nav-links {
        display: flex;
        list-style: none;
        flex-wrap: wrap;
      }
      
      .nav-links li {
        margin-left: 1em;
        position: relative;
      }
      
      .nav-links a {
        color: #121111;
        text-decoration: none;
        padding: 0.5em;
        cursor: pointer;
      }
      
      .dropdown {
          position: relative;
        }
        
        .dropdown-menu {
          margin-top: 27px;
          position: absolute;
          background: linear-gradient(90deg, rgba(251, 251, 251, 1) 0%, rgba(212, 246, 255, 1) 50%, rgba(198, 231, 255, 1) 100%);
          list-style: none;
          top: 100%;
          left: 0;
          min-width: 200px;
          padding: 2px 0;
          border-radius: 5px;
          box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
          opacity: 0;
          visibility: hidden;
          transform: translateY(10px);
          transition: opacity 0.3s ease, transform 0.3s ease, visibility 0s 0.3s;
          z-index: 15;
        }
        
        .dropdown:hover .dropdown-menu,
        .dropdown-menu:hover {
          opacity: 1;
          visibility: visible;
          transform: translateY(0);
          transition: opacity 0.3s ease, transform 0.3s ease, visibility 0s;
        }
        
        .dropdown-menu li {
          padding: 10px 20px;
          
          color: linear-gradient(90deg, #FFCCEA 0%, #CDC1FF 100%);
          transition: background 0.3s ease, color 0.3s ease;
        }
        
        .dropdown-menu li:hover {
          background: linear-gradient(90deg, #FFCCEA 0%, #CDC1FF 100%);
          color: #fff;
          cursor: pointer;
          border-top-left-radius: 10px; /* Curves on the top-left */
          border-bottom-left-radius: 10px; /* Curves on the bottom-left */
        }
        .menu-toggle {
            display: none; /* Hidden by default */
            font-size: 2em;
            background: none;
            border: none;
            color: #fff;
            cursor: pointer;
        }

    /* Sidebar Styling */
    .sidebar {
      width: 19%;
      background-color: rgba(51, 51, 51, 0.7); /* Adjust the last value (0.7) for transparency */
      color: #fff;
      color: #fff;
      padding: 1em;
      height: 100vh;
      position: fixed;
      top: 50px;
      left: 0;
      display: flex;
      flex-direction: column;
      gap: 1em;
    }

    .sidebar h2 {
      margin-top: 30px;
      font-size: 1.5em;
      color: #fff;
    }

    .sidebar button {
      padding: 0.7em 1em;
      background-color: #555;
      color: #fff;
      border: none;
      border-radius: 5px;
      font-size: 1em;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    .sidebar button:hover {
      background-color: #777;
    }

    /* Main Content */
    .main-content {
      margin-left: 20%;
      width: 80%;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    /* Top Section */
    .top-section {
      width: 100%;
      background: url('hotel-background.jpg') center/cover no-repeat; /* Background image */
      display: flex;
      justify-content: space-between;
      align-items: center;
      color: #fff;
      padding: 1em;
      position: relative;
    }
    
    .top-section img{
        position: absolute;
        top: 150px;
        left: 40%;
        width: 650px;
        height: 200px;
        opacity: 1.0;
        color: #fff;
    }
    .top-section h1 {
      font-size: 2.5em;
      color: #120707;
    }

    .sign-in-btn {
      padding: 0.7em 1.5em;
      background-color: #333;
      color: #fff;
      border: none;
      border-radius: 5px;
      font-size: 1em;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    .sign-in-btn:hover {
      background-color: #555;
    }

    /* Bottom Content */
    .bottom-content {
      margin-top: 350px;
      width: 100%;
      padding: 2em;
      color: #fff;
    }

    .hotel-item {
      display: flex;
      flex-direction: column;
      padding: 1em;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      background-color: rgba(51, 51, 51, 0.7); /* Adjust the last value (0.7) for transparency */
      color: #641c1c;
      transition: transform 0.3s, box-shadow 0.3s;
      margin-bottom: 1em;
    }

    .hotel-item:hover {
      transform: scale(1.03);
      box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
    }

    .hotel-name {
      font-size: 1.3em;
      color: #fff;
      margin-bottom: 0.5em;
    }

    .hotel-address {
      color: #fff;
      margin-bottom: 0.5em;
    }

    .hotel-actions {
      display: flex;
      gap: 1em;
    }

    .action-btn {
      padding: 0.5em 1em;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s;
      font-size: 0.9em;
    }

    .feedback-btn {
      background-color: #28a745;
      color: #fff;
    }

    .feedback-btn:hover {
      background-color: #218838;
    }

    .reviews-btn {
      background-color: #17a2b8;
      color: #fff;
    }

    .reviews-btn:hover {
      background-color: #138496;
    }
     /* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Fixed position for centering */
  left: 0;
  top: 50px;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  justify-content: center;
  align-items: center;
  padding-top: 60px;
}

/* Modal Content/Box */
.modal-content {
  background-color: #fefefe;
  margin: auto;
  border-radius: 10px;
  width: 90%; /* More adaptable width */
  max-width: 500px; /* Limit width on larger screens */
  /* box-shadow: 5px 5px 9px #5e687049, -5px -5px 9px #5e687049; */
box-shadow: 
    inset 20px 20px 20px rgba(0, 0, 0, 0.05), /* Soft inset shadow */
    4px 4px 10px rgba(0, 0, 0, 0.2), /* Slight top-left shadow for depth */
    inset 4px 4px 6px rgba(0, 0, 0, 0.1); /* Gentle inner shadow for subtle depth */

  animation: animatezoom 0.6s;
  overflow: hidden;
}
.animate {
  -webkit-animation: animatezoom 0.6s;
  animation: animatezoom 0.6s
}

@-webkit-keyframes animatezoom {
  from {-webkit-transform: scale(0)} 
  to {-webkit-transform: scale(1)}
}
  
@keyframes animatezoom {
  from {transform: scale(0)} 
  to {transform: scale(1)}
}
/* The Close Button (x) */
.close {
  position: absolute;
  right: 20px;
  top: 10px;
  color: #000;
  font-size: 30px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #f44336;
  cursor: pointer;
}

/* Full-width input fields */
input[type="text"],
input[type="password"] {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  border-radius: 10px;
  box-sizing: border-box;
  box-shadow: inset 20px 20px 20px rgba(0, 0, 0, 0.05),
              4px 4px 10px rgba(0, 0, 0, 0.2),
              -4px -4px 10px rgba(255, 255, 255, 0.7),
              6px 6px 20px rgba(255, 255, 255, 0.7),
              inset 4px 4px 6px rgba(0, 0, 0, 0.1);
}

/* Button styles */
.button{
  background-color: #5696ab;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border-radius: 10px;
  cursor: pointer;
  width: 100%;
  box-shadow: 1px 1px 7px rgba(0, 0, 0, 0.2),
              -1px -1px 7px rgba(255, 255, 255, 0.7),
              3px 3px 17px rgba(255, 255, 255, 0.7),
              inset 4px 4px 6px rgba(0, 0, 0, 0.1);
}

.cancelbtn {
  background-color: #5696ab;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border-radius: 10px;
  cursor: pointer;
  width: 20%;
  box-shadow: 1px 1px 7px rgba(0, 0, 0, 0.2),
              -1px -1px 7px rgba(255, 255, 255, 0.7),
              3px 3px 17px rgba(255, 255, 255, 0.7),
              inset 4px 4px 6px rgba(0, 0, 0, 0.1);
}

.button:hover,
.cancelbtn:hover {
  opacity: 0.9;
}

.container {
  padding: 16px;
}
.line{
    display: flex;
    flex: inline;
    gap: 10px;
}
  </style>
</head>
<body>
  <!-- Navigation Bar -->
  <nav class="navbar">
    <div class="nav-container">
      <img class="logo" src="Images/logo.png" alt="City Guide Logo">
      <ul class="nav-links">
        <!-- Navigation Links as per the original code -->
         <li><a href="index.html">Home</a></li>
        <li class="dropdown"><a href="AboutCity.html">About City</a></li>
         <li class="dropdown" style="color: #121111;">Explore
          <ul class="dropdown-menu">
          <li><a href="tourist-spots.jsp">Tourist Spots</a></li>
          <li><a href="SacredPlaces.jsp">Sacred Places</a></li>
          <li><a href="hotel.jsp">Hotels</a></li>
          <li><a href="ShoppingMalls.jsp">Shopping</a></li>
          </ul>
        </li>
        <li class="dropdown"><a href="Transport.html">Transportation</a>
        </li>
        <li class="dropdown"><a href="AdminLogin.html">Admin Login</a>
        <li class="dropdown"><a href="Contact.html">Contact Us</a></li>
      </ul>
    </div>
  </nav>

  <div class="sidebar">
    <h2>Explore Our Sacred Places</h2>
    <button onclick="SacredPlacesSuggestion()">Suggest Sacred Places</button>
  </div>

  <div class="main-content">
    <div class="top-section">
        
    </div>

    <div class="bottom-content">
      <h2 style="font-size: 50px; margin-bottom: 10px;">Explore Spots</h2>
      <%
      Connection con = null;
      Statement stmt = null;
      ResultSet rs = null;
      try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TouristGuide", "root", "saraah");
          stmt = con.createStatement();
          rs = stmt.executeQuery("SELECT * FROM sacredplaces LIMIT 50"); // Adjust to get only 20 records

          while (rs.next()) {
              String  sacredplaces = rs.getString("sacredplaces");
              String address = rs.getString("address");
      %>
          <div class="hotel-item">
            <h3 class="hotel-name"><%=sacredplaces %></h3>
            <p class="hotel-address"><%=address %></p>
            <div class="hotel-actions">
                 <button class="action-btn reviews-btn" onclick="document.getElementById('id01').style.display='block'">Give Feedback</button>
            </div>
          </div>
      <%
          }
      } catch (Exception e) {
          out.println("Unable to load hotel information at the moment.");
      } finally {
          if (rs != null) try { rs.close(); } catch (SQLException e) { /* log or ignore */ }
          if (stmt != null) try { stmt.close(); } catch (SQLException e) { /* log or ignore */ }
          if (con != null) try { con.close(); } catch (SQLException e) { /* log or ignore */ }
      }
      %>
    </div>
            <div id="id01" class="modal">
  <form class="modal-content animate" action="SacValidate.jsp" method="post">
    <div class="imgcontainer">
      <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>

    </div>
    <div class="container">
      <label for="username"><b>Username</b></label>
      <input type="text" placeholder="Enter Username" name="username" id="username" required>
      <label for="password"><b>Password</b></label>
      <input type="password" placeholder="Enter Password" name="password" id="password" required>
      <button type="submit" class="button">Login</button>
    </div>
    <div class="container" style="background-color:#f1f1f1">
        <div class='line'>
      <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn" class="button">Cancel</button>
      <p style="margin-top: 20px;">Don't have account? <b><a href="SacRegister.html">Register</a></b></p>
      </div>
    </div>
  </form>
</div>
    
            <div id="id01" class="modal">
  <form class="modal-content animate" action="SacValidate.jsp" method="post">
    <div class="imgcontainer">
      <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>

    </div>
    <div class="container">
      <label for="username"><b>Username</b></label>
      <input type="text" placeholder="Enter Username" name="username" id="username" required>
      <label for="password"><b>Password</b></label>
      <input type="password" placeholder="Enter Password" name="password" id="password" required>
      <button type="submit" class="button">Login</button>
    </div>
    <div class="container" style="background-color:#f1f1f1">
        <div class='line'>
      <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn" class="button">Cancel</button>
      <p style="margin-top: 20px;">Don't have account? <b><a href="SacRegister.html">Register</a></b></p>
      </div>
    </div>
  </form>
</div>
  </div>
    <script>
 var modal = document.getElementById('id01');
        window.onclick = function(event) {
          if (event.target == modal) {
          modal.style.display = "none";
         }
        function feedback() {
             window.location.href = "TouristAddLogin.html";
        }}
        function SacredPlacesSuggestion() {
            window.location.href = "SacredPlacesSuggest.html";
        }
    </script>

</body>
</html>
