
<%@page import="java.text.DateFormat"%>
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
            String v_code = request.getParameter("videos");
        
            PreparedStatement ps = cn.prepareStatement("Delete from videos where code='"+v_code+"' ");

            if (ps.executeUpdate() > 0) {
                response.sendRedirect("upload.jsp?success=1");
            } else {
                response.sendRedirect("upload.jsp?error=1");
            }

            cn.close();
        } catch (Exception er) {
            out.println(er.getMessage());
        }

    } catch (Exception er) {
        out.print(er.getMessage());
    }

%>

