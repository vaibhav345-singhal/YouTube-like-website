<%@page import="java.io.*"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%
    try {

        int sn = 0;

        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
        Statement st = cn.createStatement();
        ResultSet rs = st.executeQuery("select MAX(sn) from Category");
        if (rs.next()) {
            sn = rs.getInt(1);
        }
        sn++;
        try {
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
            String query = "insert into Category(sn,code,category_name) values(?,?,?)";
            PreparedStatement ptst = cn.prepareStatement(query);

            ptst.setInt(1, sn);
            ptst.setString(2, code);
            ptst.setString(3, category);
            
            String path = "C:/Users/ankit/Documents/NetBeansProjects/YouTube/build/web/videos/"+code;
            File f = new File(path);
            f.mkdir();
            if (ptst.executeUpdate() > 0) {
                response.sendRedirect("category.jsp?Success=1");
            } else {
                response.sendRedirect("register.jsp?error=1");
            }

            cn.close();
        } catch (Exception er) {
            out.println(er.getMessage());
        }

    } catch (Exception er) {
        out.print(er.getMessage());
    }
%>
