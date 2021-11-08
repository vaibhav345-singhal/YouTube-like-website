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
        
            String v_code = request.getParameter("v_code");
            String c_code = request.getParameter("c_code");

            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");

            PreparedStatement ps = cn.prepareStatement("Delete from `comments` where video_code='" + v_code + "' and cmt_code ='" + c_code + "' and user ='"+email+"'");

            if (ps.executeUpdate() > 0) {
                out.println("true");
            } else {
                out.println("error");
            }

            cn.close();
        
    } catch (Exception er) {
        out.print(er.getMessage());
    }

%>


