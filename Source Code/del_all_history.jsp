    <%@page  import="java.sql.*" %>
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
       

        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
        
        
            try {
            boolean f = false;

            PreparedStatement ps = cn.prepareStatement("Delete from `history` where user='"+email+"'");
            if (ps.executeUpdate() > 0) {
                f = true;
                out.println(f);
            } else {
                out.println(f);
            }

            cn.close();
        } catch (Exception er) {
            out.println(er.getMessage());
        }
  
        
            
           
    } catch (Exception er) {
        out.println(er.getMessage());
    }

%> 