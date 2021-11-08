<%@page import="java.text.DateFormat"%>
<%@page  import="java.util.*,java.util.Date,java.sql.*" pageEncoding="UTF-8"%>

<%    String email = null;
    Cookie ck[] = request.getCookies();

    for (int i = 0; i < ck.length; i++) {
        if (ck[i].getName().equals("user")) {

            email = ck[i].getValue();
            break;
        }
    }

    String video_code = request.getParameter("v_code");
    String msg = request.getParameter("msg");
    String user_code = null;
    
    Date currentDate = new Date();  
    String cdate = DateFormat.getDateInstance().format(currentDate);  

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
        Statement st = cn.createStatement();
        ResultSet rs = st.executeQuery("select* from users where email='" + email + "' ");
        if (rs.next()) {
            user_code = rs.getString(2);
        }

        int sn = 0;

        PreparedStatement pst = cn.prepareStatement("SELECT MAX(sn) FROM `comments`");
        ResultSet rst = pst.executeQuery();
        if (rst.next()) {
            sn = rst.getInt(1);
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
            String c_code = "";
            for (int i = 0; i <= 6; i++) {
                c_code = c_code + l.get(i);
            }
            c_code = c_code + "_" + sn;

        boolean f = false;
        PreparedStatement pst2 = cn.prepareStatement("INSERT INTO `comments` values(?,?,?,?,?,?,?)");
        pst2.setInt(1, sn);
        pst2.setString(2, video_code);
        pst2.setString(3, email);
        pst2.setString(4, msg);
        pst2.setString(5, user_code);
        pst2.setString(6, cdate);
        pst2.setString(7, c_code);

        if (pst2.executeUpdate() > 0) {
            f = true;
            out.print(f);
        } else {
            out.print(f);
        }

        cn.close();
    } catch (Exception er) {
        out.println(er.getMessage());
    }

%>