<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> IP </title>
    <style>
        hr{
    background-color: rgb(139, 0, 0);
    border-top-color: rgb(139, 0, 0);
    border-right-color: rgb(139, 0, 0);
    border-bottom-color: rgb(139, 0, 0);
    border-left-color: rgb(139, 0, 0);
    border-style: solid;
   }
   mt{
    font-size:1cm; 
    font-family: 'Times New Roman', Times, serif; 
    color: rgb(90, 44, 255);
   }
   mt1{
    color: brown;
   }
    p{
         font-size: 0.5cm; 
         font-family: 'Times New Roman', Times, serif; 
         color: rgb(60, 136, 126);
        }
    </style>
</head>
    <body style = "background-color: rgb(240, 201, 150); "> 
        <hr>
        <mt>  Book Collection  </mt>  
    <br>
    <hr >
    <p>
        Explore various Types of Books including some major genres in Fiction and Non-Fiction Books with famous authors.
    <br><br> 
    Login below!!
    <hr >
    <form >
            <label>Name: </label>
                <input type="text" name="n"/>
                <input type="submit" value="SUBMIT"/>
        </form>
    <%-- start web service invocation --%><hr/>
    <%
    try {
	com.sfr.Jfw_Service service = new com.sfr.Jfw_Service();
	com.sfr.Jfw port = service.getJfwPort();
	 // TODO initialize WS operation arguments here
	String name = request.getParameter("n");
	// TODO process result here
	java.lang.String result = port.hello(name);
	out.println("Result = "+result);
    
     String JDBC_DRIVER = "com.mysql.jdbc.Driver";
String DB_URL = "jdbc:mysql://localhost:3307/book";

// Database credentials
String USER = "root";
String PASS = "";

// Set response content type
response.setContentType("text/html");
PrintWriter out1 = response.getWriter();


String title = "Database Result ";

if ( name.length() > 0)
{
out1.println( "<html>\n");
out1.println(   "<head> ");
 out1.println("</head>\n"); 
 out1.println("<body bgcolor = \"#f0f0f0\">\n");
   out1.println("<br>");
 out1.println("<h1> "+ result +"</h1>");
   out1.println("<hr>");

    out1.println( "<center><h1 > "+title +"</h1></center>");

    // Register JDBC driver
    Class.forName(JDBC_DRIVER);

    // Open a connection
    Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);

    // Execute SQL query
    Statement stmt = conn.createStatement();
    String sql;
    sql = "SELECT * FROM profile;";
    ResultSet rs = stmt.executeQuery(sql);

   
    out1.println(" <style> th, td { ");
        out1.println("padding-top: 10px;");
        out1.println(" padding-bottom: 20px;");
        out1.println("padding-left: 30px;");
        out1.println("padding-right: 40px;");
        out1.println("} </style><center><div><table border = 1 >");
    
    out1.println("<center><div><table border = 1 >");
    out1.println("<tr><td> Name </td>'");
    out1.println("<td> Author </td>");
    out1.println("<td> Release</td>");
    out1.println("<td> Price </td></tr>");

    // Extract data from result set
    while (rs.next()) {
        // Retrieve by column name
        String Name = rs.getString("name");
        String author = rs.getString("author");
        String release = rs.getString("release");
        String price = rs.getString("price");

        // Display values
        out1.println("<tr> <td>" + Name + " </td>");
        out1.println("<td>" + author + "</td>");
        out1.println("<td>" + release + "</td>");
        out1.println("<td >" + price + "</td>");
        out1.println("</tr> ");    
    }

    out1.println("</table></div></center>");
    out1.println("<br>");
    out1.println("</body></html>");

    rs.close();
    stmt.close();
    conn.close();
} 
    }
catch (Exception e) {
        }
    %>
    
    <%-- end web service invocation --%><hr/>
    </body>
</html>