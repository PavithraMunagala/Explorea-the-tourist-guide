<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    if(username != null && password != null && username.equals("Admin") && password.equals("bvrit@"))
    {
        session.setAttribute("user", username);
        response.sendRedirect("Admin.html");
    } 
    else
    {
        out.print("Validation failed..!");
    }   
%>
