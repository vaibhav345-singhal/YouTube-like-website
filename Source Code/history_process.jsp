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
        String v_code = request.getParameter("v_code");
                
        int sn = 0;
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
        PreparedStatement ps = cn.prepareStatement("SELECT MAX(sn) FROM `history`");
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            sn = rs.getInt(1);
        }
        sn++;
        try {
            
            PreparedStatement ps2 = cn.prepareStatement("INSERT INTO `history` values(?,?,?)");
            ps2.setInt(1, sn);
            ps2.setString(2, v_code);
            ps2.setString(3, email);
            
            cn.close();
        } catch (Exception er) {
            out.println(er.getMessage());
        }
    }catch (Exception er) {
        out.println(er.getMessage());
    }
%>