<%@page contentType="text/html" import="java.io.*,java.sql.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%
    String code = null;
    code=request.getParameter("code"); 
    
//        try {
//           Class.forName("com.mysql.jdbc.Driver");
//           Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/wedding","root","");
//           Statement st = cn.createStatement();
//           ResultSet rs = st.executeQuery("select code from users where email='"+email+"'");
//           if(rs.next()){   
//                 code = rs.getString(1);
//            }
//        cn.close();
//      
//        }      
//             
//        catch(Exception e){
//             out.print(e.getMessage());
//        }
             
        String contentType = request.getContentType();

        String imageSave=null;
        byte dataBytes[]=null;
        String saveFile=null;
    if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)){
        DataInputStream in = new DataInputStream(request.getInputStream());
        int formDataLength = request.getContentLength();
        dataBytes = new byte[formDataLength];
        int byteRead = 0;
        int totalBytesRead = 0;
        while (totalBytesRead < formDataLength){
            byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
            totalBytesRead += byteRead;
        }


        String file = new String(dataBytes);
    /*saveFile = file.substring(file.indexOf("filename=\"") + 10);
    saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
    saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));*/
       saveFile = code+".jpg";
    // out.print(dataBytes);
       int lastIndex = contentType.lastIndexOf("=");
       String boundary = contentType.substring(lastIndex + 1, contentType.length());
    // out.println(boundary);
        int pos;
        pos = file.indexOf("filename=\"");
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;
        int boundaryLocation = file.indexOf(boundary, pos) - 4;
        int startPos = ((file.substring(0, pos)).getBytes()).length;
        int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
    try{
        FileOutputStream fileOut = new FileOutputStream(request.getRealPath("/")+"/profile/"+saveFile);


    // fileOut.write(dataBytes);
        fileOut.write(dataBytes, startPos, (endPos - startPos));
        fileOut.flush();
        fileOut.close();
        imageSave="Success";
    }
    catch (Exception e){

       imageSave="Failure";
    }
   
}

 


else{
      response.sendRedirect("upload_pimage.jsp?cd="+code+"&error=1");
}
          
  response.sendRedirect("login.jsp?success=1");
  //out.println(code);
  %>

