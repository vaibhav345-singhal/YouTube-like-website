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
            String channel_code = null;
            String title = request.getParameter("title");
            String about = request.getParameter("description");
        
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");

            PreparedStatement ps = cn.prepareStatement("update channel set c_name=?, about=? where email='"+email+"' ");
            ps.setString(1, title);
            ps.setString(2, about);
            
            
            PreparedStatement ptst = cn.prepareStatement("update videos set user=? where email='"+email+"' ");
            ptst.setString(1, title);
            ptst.executeUpdate();

            if (ps.executeUpdate() > 0) {
                response.sendRedirect("channel.jsp?success=1");
            } else {
                response.sendRedirect("edit_channel.jsp?error=1");
            }

            cn.close();
        } catch (Exception er) {
            out.println(er.getMessage());
        }

    } catch (Exception er) {
        out.print(er.getMessage());
    }

%>

