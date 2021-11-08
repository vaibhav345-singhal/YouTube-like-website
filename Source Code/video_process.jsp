
<%@page contentType="text/html" import="java.io.*,java.sql.*" pageEncoding="UTF-8"%>
<%

    String cat_code=request.getParameter("cat_code"); 
    String v_code = request.getParameter("v_code");
    Cookie c[] = request.getCookies();
        String email = null;
        for (int i = 0; i < c.length; i++) {
            if (c[i].getName().equals("user")) {

                email = c[i].getValue();
                break;
            }
        }
        int sn = 0;
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
        Statement st = cn.createStatement();
        ResultSet rs = st.executeQuery("select sn from videos where code='"+v_code+"'");
        if(rs.next()){
            sn=rs.getInt(1);
        }
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
//    saveFile = file.substring(file.indexOf("filename=\"") + 10);
//    saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
//    saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));
       saveFile = v_code+".mp4";
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
        FileOutputStream fileOut = new FileOutputStream(request.getRealPath("videos/")+"/"+cat_code+"/"+saveFile);


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
      response.sendRedirect("upload_videos.jsp?error=1");
}
          
  response.sendRedirect("thumbnail.jsp?cat_code="+cat_code+"&v_code="+v_code+"&success=1");
  
  %>

