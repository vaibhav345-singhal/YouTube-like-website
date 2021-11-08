<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
    String search_val = request.getParameter("search");  
   
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
        PreparedStatement p = cn.prepareStatement("select * from videos where title LIKE '%" + search_val + "%' ");
        ResultSet r = p.executeQuery();
        if (r.next()) {
            out.println("true");
        } else {
            out.println("false");
        }
    } catch (Exception e) {
        out.println(e.getMessage());
    }
%>