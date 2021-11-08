<%@page  import="java.sql.*" %>
<%
    try {
        String v_code = request.getParameter("v_code");
        String email = request.getParameter("email");

        try {
            int flag = 0;
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");

            PreparedStatement p = cn.prepareStatement("select * from `dislike` where video_code='"+v_code+"' and user = '"+email+"' ");
            ResultSet rs2 = p.executeQuery();
            if (rs2.next()) {
				PreparedStatement ptst1 = cn.prepareStatement("Delete from `dislike` where video_code='"+v_code+"' and user = '"+email+"' ");
				if(ptst1.executeUpdate()>0){
					flag = 1;
					out.println(flag);
			    }

            } else {
                int sn = 0;

                PreparedStatement ps = cn.prepareStatement("SELECT MAX(sn) FROM `dislike`");
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    sn = rs.getInt(1);
                }
                sn++;
                PreparedStatement pst = cn.prepareStatement("insert into `dislike` values(?,?,?)");
                pst.setInt(1, sn);
                pst.setString(2, v_code);
                pst.setString(3, email);

                if (pst.executeUpdate() > 0) {
					flag = 2;
					out.println(flag);
                    Statement st = cn.createStatement();
                    ResultSet rs1 = st.executeQuery("select * from `like` where video_code='"+v_code+"' and user = '"+email+"'");
                    if (rs1.next()) {
                        PreparedStatement ptst = cn.prepareStatement("delete from `like` where video_code='"+v_code+"' and user = '"+email+"'");
                        ptst.executeUpdate();
                    }
                } else {
                    out.println(flag);
                }
                cn.close();
            }
        } catch (Exception er) {
            out.println(er.getMessage());
        }

    } catch (Exception er) {
        out.println(er.getMessage());
    }
%>