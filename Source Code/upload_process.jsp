
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
        int sn = 0;
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
        PreparedStatement ps = cn.prepareStatement("select MAX(sn) from videos");
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            sn = rs.getInt(1);
        }
        sn++;
        
        String user = "";
        String channel_code = "";
        PreparedStatement ps1 = cn.prepareStatement("select * from channel where email='"+email+"'");
        ResultSet rs1 = ps1.executeQuery();
         if(rs1.next()){
              user = rs1.getString(3);
              channel_code = rs1.getString(2);
         }
        try {

            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String category = request.getParameter("category");

            LinkedList l = new LinkedList();
            for (char c = 'A'; c <= 'Z'; c++) {
                l.add(c + "");
            }
            for (char c = 'a'; c <= 'z'; c++) {
                l.add(c + "");
            }
            for (int i = 0; i <= 9; i++) {
                l.add(i + "");
            }
            Collections.shuffle(l);
            String code = "";
            for (int i = 0; i <= 6; i++) {
                code = code + l.get(i);
            }
            code = code + "_" + sn;



             Date currentDate = new Date();  
             String dateToStr = DateFormat.getDateInstance().format(currentDate);  

        
            PreparedStatement ps3 = cn.prepareStatement("insert into videos values(?,?,?,?,?,?,?,?,?)");
            ps3.setInt(1, sn);
            ps3.setString(2, code);
            ps3.setString(3, title);
            ps3.setString(4, description);
            ps3.setString(5, category);
            ps3.setString(6, email);
            ps3.setString(7, dateToStr);
            ps3.setString(8, user);
            ps3.setString(9, channel_code);

            if (ps3.executeUpdate() > 0) {
                response.sendRedirect("upload_video.jsp?cat_code=" + category + "&v_code=" + code + "&success=1");
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


