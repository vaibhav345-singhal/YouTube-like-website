<%@page import="java.sql.*" %>
<%
    try {
        String email = request.getParameter("email");
        int flag = 0;

        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
        PreparedStatement pst = cn.prepareStatement("select * from `block_user` where email = '" + email + "'");
        ResultSet rst = pst.executeQuery();
        if (rst.next()) {
            PreparedStatement ptst = cn.prepareStatement("Delete from `block_user` where email = '" + email + "' ");
            if (ptst.executeUpdate() > 0) {
                flag = 2;
                out.println(flag);
            } else {
                out.println(flag);
            }
        } else {

            int sn = 0;

            PreparedStatement p = cn.prepareStatement("select MAX(sn) from `block_user` ");
            ResultSet r = p.executeQuery();
            if (r.next()) {
                sn = r.getInt(1);
            }
            sn++;

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

            PreparedStatement ps = cn.prepareStatement("insert into `block_user` values(?,?,?)");
            ps.setInt(1, sn);
            ps.setString(2, code);
            ps.setString(3, email);

            if (ps.executeUpdate() > 0) {
                flag = 1;
                out.println(flag);
            } else {
                out.println(flag);
            }

        }
        cn.close();
    } catch (Exception e) {
        out.println(e.getMessage());
    }
%>
