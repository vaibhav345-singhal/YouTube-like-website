<%@page contentType="text/html" import="java.util.*,java.util.Date,java.sql.*" pageEncoding="UTF-8"%>
<%

    try {
        Cookie ck[] = request.getCookies();
        String email = null;
        for (int i = 0; i < ck.length; i++) {
            if (ck[i].getName().equals("user")) {

                email = ck[i].getValue();
                break;
            }
        }
       
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
       

        try {

            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String v_code = request.getParameter("v_code");
            String cat_code = request.getParameter("category");

        
            PreparedStatement ps = cn.prepareStatement("update videos set title=?, description=?, category=? where code='"+v_code+"' ");
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3,cat_code);
            

            if (ps.executeUpdate() > 0) {
                response.sendRedirect("edit_videos.jsp?success=1");
//                out.println(v_code);
//                out.println(title);
            } else {
                response.sendRedirect("edit_videos.jsp?error=1");
            }

            cn.close();
        } catch (Exception er) {
            out.println(er.getMessage());
        }

    } catch (Exception er) {
        out.print(er.getMessage());
    }

%>

