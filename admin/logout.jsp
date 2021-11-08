<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Cookie c[] = request.getCookies();
            String email = null;
            for(int i=0;i<c.length ;i++){
                if(c[i].getName().equals("user")){
                  
                      email =  c[i].getValue();
                      break;
                }
            }
             Cookie ct = new Cookie("user",null);
                ct.setMaxAge(0);
                response.addCookie(ct);
            session.removeAttribute(email);
            
            response.sendRedirect("login.jsp");

%>