<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%
    
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
        Statement st = cn.createStatement();
        
        try {
            String category = request.getParameter("category");
            String code = request.getParameter("code");
           
 
            String query = "Update category set category_name=? where code='"+code+"'";
            PreparedStatement ptst = cn.prepareStatement(query);
            ptst.setString(1, category);

            if (ptst.executeUpdate() > 0) {
                response.sendRedirect("category.jsp?Success=1");
            } else {
                response.sendRedirect("category.jsp?error=1");
            }
            cn.close();
        } catch (Exception er) {
            out.println(er.getMessage());
        }

    } catch (Exception er) {
        out.print(er.getMessage());
    }
%>
