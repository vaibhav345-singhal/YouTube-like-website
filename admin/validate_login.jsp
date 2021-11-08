<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    String email = null;
    String pass = null;

    Cookie c[] = request.getCookies();

    for (int i = 0; i < c.length; i++) {
        if (c[i].getName().equals("user")) {

            email = c[i].getValue();
            break;
        }
    }
    if (email == null) {
        if (request.getParameter("email").trim().length() > 0) {
            email = request.getParameter("email");
        } else {
            response.sendRedirect("login.jsp");
        }
    }
    if (request.getParameter("password").trim().length() == 0) {
        response.sendRedirect("login.jsp");
    } else {
        pass = request.getParameter("password").trim();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery("select * from admin where email='" + email + "'");
            if (rs.next()) {
                if (rs.getString("password").equals(pass)) {
                    Cookie ct = new Cookie("user", email);
                    ct.setMaxAge(3600);
                    response.addCookie(ct);

                    session.setAttribute(email, pass);
                    session.setMaxInactiveInterval(60);

                    response.sendRedirect("category.jsp");
                } else {
                    response.sendRedirect("login.jsp?invalid_pass=1");
                }
            } else {
                response.sendRedirect("login.jsp?invalid_email=1");
            }
            cn.close();
        } catch (Exception er) {
            out.print(er.getMessage());
        }

    }

%>
