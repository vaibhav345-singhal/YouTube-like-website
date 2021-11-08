<%@page import="java.sql.*"%>
<%
    try {
        int flag = 0;
        String email = request.getParameter("email").trim() ;
        String npassword = request.getParameter("npassword").trim();
        String rpassword = request.getParameter("rpassword").trim();

        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
        PreparedStatement pst = cn.prepareStatement("select * from users where email = '"+email+"'");
        ResultSet rst = pst.executeQuery();
        if (rst.next()) {
                PreparedStatement ptst = cn.prepareStatement("update users set password=? where email ='"+email+"'");
                ptst.setString(1, npassword);
                if(ptst.executeUpdate()>0){
                    flag = 1;
                    out.println(flag);
                }else{
                    out.println(flag);
                }
            } else {
             flag = 2;
                out.println(2);
            }
        cn.close();
    } catch (Exception e) {
        out.println(e.getMessage());
    }
%>