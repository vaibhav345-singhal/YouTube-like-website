<%@page import="java.text.DateFormat"%>
<%@page contentType="text/html" import="java.util.*,java.util.Date,java.sql.*" pageEncoding="UTF-8"%>
<%

    try {
        int sn = 0;
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
        Statement st = cn.createStatement();
        ResultSet rs = st.executeQuery("select MAX(sn) from users");
        if (rs.next()) {
            sn = rs.getInt(1);
        }
        sn++;

        Date currentDate = new Date();  
        String mdate = DateFormat.getDateInstance().format(currentDate); 
        
        try {

            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String country = request.getParameter("country");

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
            
            PreparedStatement pst = cn.prepareStatement("select email from users where email = '"+email+"'");
            ResultSet rst = pst.executeQuery();
            if(rst.next()){
                response.sendRedirect("register.jsp?error=1");
            }
            else{

            PreparedStatement ps = cn.prepareStatement("insert into users values(?,?,?,?,?,?,?)");
            ps.setInt(1, sn);
            ps.setString(2, code);
            ps.setString(3, fname);
            ps.setString(4, lname);
            ps.setString(5, email);
            ps.setString(6, password);
            ps.setString(7, country);

            
            if (ps.executeUpdate() > 0) {
                PreparedStatement ps1 = cn.prepareStatement("insert into channel(sn,code,c_name,email,mdate) values(?,?,?,?,?)");
                ps1.setInt(1, sn);
                ps1.setString(2, code);
                ps1.setString(3, fname + " " + lname);
                ps1.setString(4, email);
                ps1.setString(5, mdate);
               

                if (ps1.executeUpdate() > 0) {
                    response.sendRedirect("upload_pimage.jsp?code="+code+"&success=1");
                } else {
                    response.sendRedirect("register.jsp?error=1");
                }
            } else {
                response.sendRedirect("register.jsp?error=1");
            }

            cn.close();
            }
        } catch (Exception er) {
            out.println(er.getMessage());
        }

    } catch (Exception er) {
        out.print(er.getMessage());
    }

%>
