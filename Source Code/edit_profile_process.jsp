<%@page contentType="text/html" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<%

    try {
        Cookie c[] = request.getCookies();
        String email = null;
        for (int i = 0; i < c.length; i++) {
            if (c[i].getName().equals("user")) {

                email = c[i].getValue();
                break;
            }
        }
        
        try {
            
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String country = request.getParameter("country");
        
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");

            PreparedStatement ps = cn.prepareStatement("update users set first_name=?, last_name=?, country=? where email='"+email+"' ");
            ps.setString(1, fname);
            ps.setString(2, lname);
            ps.setString(3, country);
            

            if (ps.executeUpdate() > 0) {
                response.sendRedirect("account.jsp?&success=1");
            } else {
                response.sendRedirect("edit_profile.jsp?error=1");
            }

            cn.close();
        } catch (Exception er) {
            out.println(er.getMessage());
        }

    } catch (Exception er) {
        out.print(er.getMessage());
    }

%>

