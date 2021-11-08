
<%@page  import="java.sql.*" %>
<%
    try {
        String channel_code = request.getParameter("channel_code");
        String email = request.getParameter("email");
        
      
        int sn = 0;
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
        PreparedStatement ps = cn.prepareStatement("SELECT MAX(sn) FROM `subscribe`");
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            sn = rs.getInt(1);
        }
        sn++;
        try {
            int  flag = 0;
            
            PreparedStatement ptst = cn.prepareStatement("SELECT * FROM `subscribe`where channel_code='"+channel_code+"' and user='"+email+"' ");
            ResultSet rs1 = ptst.executeQuery();
            if(rs1.next()){
                PreparedStatement ptst1 = cn.prepareStatement("Delete from `subscribe` where channel_code='"+channel_code+"' and user='"+email+"' ");
                if(ptst1.executeUpdate()>0){
                    flag = 1;
                    out.println(flag);
                }
                
            }
            else{

                PreparedStatement ps2 = cn.prepareStatement("INSERT INTO `subscribe` values(?,?,?)");
                ps2.setInt(1, sn);
                ps2.setString(2, channel_code);
                ps2.setString(3, email);
                if (ps2.executeUpdate() > 0) {
                    flag = 2;
                    out.println(flag);
                } else {
                    out.println(flag);
                }
            
            cn.close();
            }
        } catch (Exception er) {
            out.println(er.getMessage());
        }
        
    }catch (Exception er) {
        out.println(er.getMessage());
    }
%>