<%@page import="java.sql.*"%>
<%
    Cookie c[] = request.getCookies();
    String email = null;
    for (int i = 0; i < c.length; i++) {
        if (c[i].getName().equals("user")) {

            email = c[i].getValue();
            break;
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="Askbootstrap">
        <meta name="author" content="Askbootstrap">
        <title>VTube</title>
        <!-- Favicon Icon -->
        <link rel="icon" type="image/png" href="img/favicon.png">
        <!-- Bootstrap core CSS-->
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom fonts for this template-->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <!-- Custom styles for this template-->
        <link href="css/osahan.css" rel="stylesheet">
        <!-- Owl Carousel -->
        <link rel="stylesheet" href="vendor/owl-carousel/owl.carousel.css">
        <link rel="stylesheet" href="vendor/owl-carousel/owl.theme.css">




        <style>

            #vid-title{
                white-space: nowrap; 

                overflow: hidden;
                text-overflow: ellipsis; 

            }

            #mcmt{
                white-space: pre-wrap;
                overflow: visible;
                /*overflow-style:marquee-block;*/
                padding-left: 40px;
                padding-right: 10px;

            }
            #abtid{
                white-space: pre-wrap;
                overflow: visible;
                /*overflow-style:marquee-block;*/

            }

        </style>



    </head>
    <body id="page-top">
        <nav class="navbar navbar-expand navbar-light bg-white static-top osahan-nav sticky-top">
            &nbsp;&nbsp; 
            <button class="btn btn-link btn-sm text-secondary order-1 order-sm-0" id="sidebarToggle">
                <i class="fas fa-bars"></i>
            </button> &nbsp;&nbsp;
            <a class="navbar-brand mr-1" href="index.jsp"><img class="img-fluid" alt="" src="img/logo.png"></a>
            <!-- Navbar Search -->
            <form method="post" action="search.jsp" class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-5 my-2 my-md-0 osahan-navbar-search">
                <div class="input-group">
                    <input type="text" class="form-control" name="search" placeholder="Search for...">
                    <div class="input-group-append">
                        <button class="btn btn-light" type="button" id="searchid">
                            <i class="fas fa-search"></i> 
                        </button>
                    </div>
                </div>
            </form>
            <!-- Navbar -->
            <ul class="navbar-nav ml-auto ml-md-0 osahan-right-navbar">

                <li class="nav-item mx-1">
                    <a class="nav-link" href="upload.jsp">

                        <i class="fas fa-plus-circle fa-fw"></i>
                        Upload Video
                    </a>
                </li>

                <%if (email == null) {%>
                <li id="register-btn" class="nav-link">
                    <a href="register.jsp"   type="button" class="btn btn-primary border-none">Register</a>
                </li>

                <li id="login-btn" class="nav-link">
                    <a href="login.jsp"   type="button" class="btn btn-primary border-none">Login</a>
                </li>
                <%
                } else {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
                        Statement st = cn.createStatement();
                        ResultSet rs = st.executeQuery("select * from users where email = '" + email + "'");
                        if (rs.next()) {
                            String name = rs.getString(3) + " " + rs.getString(4);
                            String channel_code = rs.getString(2);
                %>
                <li id="profile-btn" class="nav-item dropdown no-arrow osahan-right-navbar-user">
                    <a class="nav-link dropdown-toggle user-dropdown-link" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <img alt="Avatar" src="profile/<%=channel_code%>.jpg">

                    </a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                        <a class="dropdown-item" href="account.jsp"><i class="fas fa-fw fa-user-circle"></i> &nbsp; <b><%=name%></b></a>
                        <a class="dropdown-item" href="channel.jsp"><i class="fas fa-fw fa-address-card"></i> &nbsp; My channel</a>
                        <a class="dropdown-item" href="subscription.jsp"><i class="fas fa-fw fa-video"></i> &nbsp; Subscriptions</a>
                        <a class="dropdown-item" href="upload.jsp"><i class="fas fa-fw fa-cog"></i> &nbsp; Upload Video</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal"><i class="fas fa-fw fa-sign-out-alt"></i> &nbsp; Logout</a>
                    </div>
                </li>
                <%
                            }
                            cn.close();
                        } catch (Exception e) {
                            out.println(e.getMessage());
                        }
                    }
                %>
            </ul>
        </nav>
        <div id="wrapper">
            <!-- Sidebar -->
            <!-- Sidebar -->
            <ul class="sidebar navbar-nav">
                <li class="nav-item active">
                    <a class="nav-link" href="index.jsp">
                        <i class="fas fa-fw fa-home"></i>
                        <span>Home</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="channel.jsp">
                        <i class="fas fa-fw fa-users"></i>
                        <span>Channel</span>
                    </a>
                </li>


                <li class="nav-item">
                    <a class="nav-link" href="upload.jsp">
                        <i class="fas fa-fw fa-cloud-upload-alt"></i>
                        <span>Upload Video</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="history.jsp">
                        <i class="fas fa-fw fa-history"></i>
                        <span>History Page</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="subscription.jsp">
                        <i class="fas fa-fw fa-clone"></i>
                        <span>Your Subscriptions</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="liked_videos.jsp">
                        <i class="fas fa-fw fa-thumbs-up"></i>
                        <span>Liked Videos</span>
                    </a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fas fa-fw fa-folder"></i>
                        <span>More</span>
                    </a>
                    <div class="dropdown-menu">
                        <h6 class="dropdown-header">Login Screens:</h6>
                        <a class="dropdown-item" href="reset-password.jsp">Reset Password</a>
                        <div class="dropdown-divider"></div>
                    </div>
                </li>

            </ul>
            <div id="content-wrapper">
                <div class="container-fluid pb-0">
                    <div class="video-block section-padding">
                        <div class="row">

                            <%
                                String v_code = request.getParameter("v_code");
                                String cat_code = request.getParameter("cat_code");
                                String channel_code = null;
                                int count = 0;
                                int u_count = 0;

                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");

                                    PreparedStatement ps = cn.prepareStatement("select * from videos where code='" + v_code + "'");
                                    ResultSet rs = ps.executeQuery();
                                    if (rs.next()) {
                                        channel_code = rs.getString(9);

                                        //To insert history in database
                                        if (email != null) {

                                            int h_sn = 0;

                                            PreparedStatement pst5 = cn.prepareStatement("select MAX(sn) from history");
                                            ResultSet rst5 = pst5.executeQuery();
                                            if (rst5.next()) {
                                                h_sn = rst5.getInt(1);
                                            }
                                            h_sn++;

                                            PreparedStatement pst1 = cn.prepareStatement("insert into history values(?,?,?)");
                                            pst1.setInt(1, h_sn);
                                            pst1.setString(2, v_code);
                                            pst1.setString(3, email);
                                            pst1.executeUpdate();
                                        }

                                        //To insert view count in view table 
//                                        PreparedStatement pst2 = cn.prepareStatement("select count from views where video_code='" + v_code + "'");
//                                        ResultSet rst1 = pst2.executeQuery();
//                                        if (rst1.next()) {
//                                            count = rst1.getInt(1);
//                                            count++;
//                                            PreparedStatement pst3 = cn.prepareStatement("update views set count=? where video_code='" + v_code + "' ");
//                                            pst3.setInt(1, count);
//                                            pst3.executeUpdate();
//                                        } else {
//                                            count = 1;
//
//                                            int v_sn = 0;
//                                            PreparedStatement pst6 = cn.prepareStatement("select MAX(sn) from views");
//                                            ResultSet rst6 = pst6.executeQuery();
//                                            if (rst6.next()) {
//                                                v_sn = rst6.getInt(1);
//                                            }
//                                            v_sn++;
//                                            PreparedStatement pst4 = cn.prepareStatement("insert into views values (?,?,?)");
//                                            pst4.setInt(1, v_sn);
//                                            pst4.setString(2, v_code);
//                                            pst4.setInt(3, count);
//                                            
//                                            pst4.executeUpdate();
//
//                                        }
                                        //To insert views 
                                        if (email != null) {
                                            PreparedStatement pst2 = cn.prepareStatement("select * from views where email = '" + email + "' and video_code = '" + v_code + "'");
                                            ResultSet rst2 = pst2.executeQuery();
                                            if (rst2.next() == false) {
                                                PreparedStatement pst3 = cn.prepareStatement("insert into views values (?,?)");
                                                pst3.setString(1, v_code);
                                                pst3.setString(2, email);
                                                pst3.executeUpdate();
                                            }
                                        }

                                        // To get view count of a video
                                        PreparedStatement pst7 = cn.prepareStatement("select count(*) from views where video_code = '" + v_code + "'");
                                        ResultSet rst7 = pst7.executeQuery();
                                        if (rst7.next()) {
                                            u_count = rst7.getInt(1);
                                        } else {
                                            u_count = 0;
                                        }


                            %>  

                            <div class="col-md-8">
                                <div class="single-video-left">
                                    <div class="single-video">
                                        <video  width="100%" height="100%" style="display: block" poster="videos/<%=cat_code%>/<%=v_code%>.jpg" autoplay controls>
                                            <source src="videos/<%=cat_code%>/<%=v_code%>.mp4" type="video/mp4">
                                            Your browser does not support HTML video.
                                        </video>

                                    </div>
                                    <div class="single-video-title box mb-3">
                                        <h2><strong><%=rs.getString("title")%></strong></h2>
                                        <p class="mb-0"><i class="fas fa-eye"></i> <%=u_count%> views</p>
                                    </div>
                                    <div class="single-video-author box mb-3">
                                        <img alt="Avatar" src="profile/<%=channel_code%>.jpg">
                                        <a href="all_channel.jsp?channel_code=<%=channel_code%>"><p><strong style="color: black;"><%=rs.getString(8)%></strong><span title data-placement="top" data-toggle="tooltip" data-original-title="Verified">&nbsp;<i class="fas fa-check-circle text-success"></i></span></p></a>
                                        <small>Published on <%=rs.getString("udate")%></small>

                                        <%
                                            PreparedStatement ptst = cn.prepareStatement("SELECT * FROM `subscribe` where channel_code='" + channel_code + "' and user='" + email + "' ");
                                            ResultSet rst = ptst.executeQuery();
                                            if (rst.next()) {

                                        %>
                                        <div class="float-right"><button id="subs-btn" class="btn btn-danger" type="button">Unsubscrib</button></div>
                                        <%} else {%>
                                        <div class="float-right"><button id="subs-btn" class="btn btn-primary" type="button">Subscribe</button></div>
                                        <%}%> 

                                        <%
                                            PreparedStatement ps1 = cn.prepareStatement("select * from `like` where video_code='" + v_code + "' and user='" + email + "'");
                                            ResultSet rs1 = ps1.executeQuery();
                                            if (rs1.next()) {
                                        %>
                                        <div class="float-right"><button id="like-btn" class="btn btn-danger" type="button"><i  class="far fa-thumbs-up"></i></button></div> &nbsp;&nbsp;
                                                <%} else {%>
                                        <div class="float-right"><button id="like-btn" class="btn btn-primary" type="button"><i  class="far fa-thumbs-up"></i></button></div> &nbsp;&nbsp;
                                                <%}%>

                                        <%
                                            PreparedStatement pst = cn.prepareStatement("select * from `dislike` where video_code='" + v_code + "' and user='" + email + "'");
                                            ResultSet rs2 = pst.executeQuery();
                                            if (rs2.next()) {
                                        %>
                                        <div class="float-right"><button id="dislike-btn" class="btn btn-danger" type="button"><i  class="far fa-thumbs-down"></i></button></div> &nbsp;&nbsp;
                                                <%} else {%>
                                        <div class="float-right"><button id="dislike-btn" class="btn btn-primary" type="button"><i class="far fa-thumbs-down"></i></button></div> &nbsp;&nbsp;
                                                <%}%> 

                                        <br>&nbsp;

                                        <hr>
                                        <h6>About :</h6>
                                        <pre id="abtid"><%=rs.getString(4)%></pre><hr><br>
                                        <%                                        }
                                                cn.close();
                                            } catch (Exception er) {
                                                out.println(er.getMessage());
                                            }
                                        %> 

                                        <h6>Add Comments:</h6>

                                        <textarea  maxlength="10000" rows="3" id="e2" name="comment" class="form-control msgs" placeholder="Description" style="resize:none;" ></textarea>
                                        <br><input type="submit" id="cmt" class="btn btn-danger" value="submit"/>
                                        <hr><br>
                                        <h6>Comments:</h6><br>

                                        <div class="load-cmt">
                                            <%
                                                String msg = null;
                                                String user_name = null;
                                                String u_code = null;
                                                String cdate = null;
                                                String c_code = null;
                                                try {

                                                    Class.forName("com.mysql.jdbc.Driver");
                                                    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");

                                                    PreparedStatement pst10 = cn.prepareStatement("select * from comments where video_code='" + v_code + "' order by RAND()");
                                                    ResultSet rst10 = pst10.executeQuery();

                                                    while (rst10.next()) {
                                                        msg = rst10.getString(4);
                                                        u_code = rst10.getString(5);
                                                        cdate = rst10.getString(6);
                                                        c_code = rst10.getString(7);

                                                        PreparedStatement pst11 = cn.prepareStatement("select * from users where code ='" + u_code + "'");
                                                        ResultSet rst11 = pst11.executeQuery();
                                                        if (rst11.next()) {
                                                            user_name = rst11.getString(3) + " " + rst11.getString(4);
                                                        }


                                            %>
                                            <div id="load-cmt">
                                                <div><img src="profile/<%=u_code%>.jpg" style="border-radius: 50px; " /></div>
                                                <button class="btn btn-outline-light del-button" onclick="del_function('<%=v_code%>', '<%=c_code%>')" style="float: right;"><i class="fas fa-trash" style="color: red;"></i></button>
                                                <h6><%=user_name%>: &nbsp;<span style="font-weight: lighter; font-size: 12px;"><%=cdate%></span></h6>
                                                <pre id="mcmt"><%=msg%></pre>

                                                <hr style="height: 4px;">

                                            </div>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <%
                                    cn.close();
                                } catch (Exception er) {
                                    out.println(er.getMessage());
                                }
                            %>    
                            <div class="col-md-4">
                                <div class="single-video-right">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="main-title">
                                                <h6>Up Next</h6>
                                            </div>
                                        </div>
                                        <%
                                            //To get count of every video in up next section
                                            int v_count = 0;
                                            try {
                                                Class.forName("com.mysql.jdbc.Driver");
                                                Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
                                                Statement st = cn.createStatement();
                                                ResultSet rs = st.executeQuery("select * from videos where code!='" + v_code + "' order by RAND()");
                                                while (rs.next()) {
                                                    String vd_code = rs.getString(2);
                                                    String channel_name = rs.getString(8);
                                                    String udate = rs.getString(7);

                                                    PreparedStatement pst9 = cn.prepareStatement("select count(*) from views where video_code='" + vd_code + "'");
                                                    ResultSet rst9 = pst9.executeQuery();
                                                    if (rst9.next()) {
                                                        v_count = rst9.getInt(1);
                                                    }
                                        %>
                                        <div class="col-md-12">
                                            <div class="video-card video-card-list mb-auto">
                                                <div class="video-card-image">
                                                    <a class="play-icon" href="play_video.jsp?cat_code=<%=rs.getString("category")%>&v_code=<%=rs.getString("code")%>"><i class="fas fa-play-circle"></i></a>
                                                    <img class="img-fluid" src="videos/<%=rs.getString("category")%>/<%=rs.getString("code")%>.jpg" alt="">
                                                    <div class="time">3:50</div>
                                                </div>
                                                <div class="video-card-body">

                                                    <div id="vid-title" class="video-title">
                                                        <a href="play_video.jsp?cat_code=<%=rs.getString("category")%>&v_code=<%=rs.getString("code")%>"><%=rs.getString("title")%></a>
                                                    </div>
                                                    <div class="video-page text-success">
                                                        <a title="" data-placement="top" data-toggle="tooltip" href="all_channel.jsp?channel_code=<%=channel_code%>" data-original-title="Verified"><strong style="color: black;"><%=channel_name%> </strong>&nbsp;<i class="fas fa-check-circle text-success"></i></a>
                                                    </div>
                                                    <div class="video-view">
                                                        <%=v_count%> views &nbsp;<i class="fas fa-calendar-alt"></i> <%=udate%>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%                                                   }
                                                cn.close();
                                            } catch (Exception er) {
                                                out.println(er.getMessage());
                                            }


                                        %>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->
                <!-- Sticky Footer -->

            </div>
            <!-- /.content-wrapper -->
        </div>
        <!-- /#wrapper -->
        <!-- Scroll to Top Button-->
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>
        <!-- Logout Modal-->
        <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">Leaving so soon!!.</div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                        <a class="btn btn-primary" href="logout.jsp">Logout</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap core JavaScript-->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- Core plugin JavaScript-->
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
        <!-- Owl Carousel -->
        <script src="vendor/owl-carousel/owl.carousel.js"></script>
        <!-- Custom scripts for all pages-->
        <script src="js/custom.js"></script>
        <!-- Sweet alert-->
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <script>
                                                    $(document).ready(function () {
                                                        $("#searchid").click(function (e) {
                                                            e.preventDefault();
                                                            var search = $("input").val();

                                                            $.ajax({
                                                                url: 'search_process.jsp',
                                                                type: 'POST',
                                                                data: {search: search},
                                                                success: function (data, textStatus, jqXHR) {
                                                                    if (data.trim() === 'true') {
                                                                        window.location.replace("search.jsp?query=" + search + " ");
                                                                    }
                                                                    if (data.trim() === 'false') {
                                                                        swal("No results found");
//                                window.location.replace("search.jsp?query=" + search + " ");
                                                                    }
                                                                },
                                                                error: function (jqXHR, textStatus, errorThrown) {

                                                                }
                                                            });
                                                        });
                                                    });
        </script>



        <script>
            var email = '<%=email%>';
            $(document).ready(function () {
                console.log("ready....");
                $("#like-btn").click(function () {
                    if (email === 'null') {
                        swal("Please login to like");
                    } else {
                        const d = {
                            v_code: '<%=v_code%>',
                            email: '<%=email%>'
                        };
                        $.ajax({
                            url: "like.jsp",
                            type: 'post',
                            data: d,
                            success: function (data, textStatus, jqXHR) {
                                console.log(data);
                                if (data.trim() === '1') {

                                    $("#like-btn").removeClass("btn btn-danger");
                                    $("#like-btn").addClass("btn btn-primary");


                                }
                                if (data.trim() === '2') {
                                    $("#like-btn").removeClass("btn btn-primary");
                                    $("#like-btn").addClass("btn btn-danger");

                                    $("#dislike-btn").removeClass("btn btn-danger");
                                    $("#dislike-btn").addClass("btn btn-primary");
                                }

                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                console.log(data);
                            }
                        });
                    }
                });
            });
            $(document).ready(function () {
                console.log("ready....");
                $("#dislike-btn").click(function () {
                    if (email === 'null') {
                        swal("Please login to dislike");
                    } else {
                        const d = {
                            v_code: '<%=v_code%>',
                            email: '<%=email%>'
                        };
                        $.ajax({
                            url: "dislike.jsp",
                            type: 'post',
                            data: d,
                            success: function (data, textStatus, jqXHR) {
                                console.log(data);
                                if (data.trim() === '1') {

                                    $("#dislike-btn").removeClass("btn btn-danger");
                                    $("#dislike-btn").addClass("btn btn-primary");

                                }
                                if (data.trim() === '2') {
                                    $("#dislike-btn").removeClass("btn btn-primary");
                                    $("#dislike-btn").addClass("btn btn-danger");

                                    $("#like-btn").removeClass("btn btn-danger");
                                    $("#like-btn").addClass("btn btn-primary");
                                }

                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                console.log(data);
                            }
                        });
                    }
                });
            });
            $(document).ready(function () {
                console.log("ready....");
                $("#subs-btn").click(function () {
                    if (email === 'null') {
                        swal("Please login to subscribe");
                    } else {
                        const d = {
                            channel_code: '<%=channel_code%>',
                            email: '<%=email%>'
                        };
                        $.ajax({
                            url: "subscribe.jsp",
                            type: 'post',
                            data: d,
                            success: function (data, textStatus, jqXHR) {

                                if (data.trim() === '1') {
                                    $("#subs-btn").removeClass("btn btn-danger");
                                    $("#subs-btn").addClass("btn btn-primary");
                                    $("#subs-btn").text("subscribe");
                                }
                                if (data.trim() === '2') {
                                    $("#subs-btn").removeClass("btn btn-primary");
                                    $("#subs-btn").addClass("btn btn-danger");
                                    $("#subs-btn").text("Unsubscribe");
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                console.log(data);
                            }
                        });
                    }
                });
            });
            $(document).ready(function () {
                console.log("ready....");
                $("#cmt").click(function () {

                    var msg = $("textarea").val();

                    if (email === 'null') {
                        swal("Please login to comment");
                    } else {
                        if (msg === ' ') {
                            swal("Write something before pressing the submit button");
                        } else {

                            const d = {
                                v_code: '<%=v_code%>',
                                msg: msg
                            };
                            $.ajax({
                                url: "comment_process.jsp",
                                type: 'post',
                                data: d,
                                success: function (data, textStatus, jqXHR) {

                                    if (data.trim() === 'true') {

                                        $(" .load-cmt").load(" .load-cmt");
                                        $("textarea").val(" ");


                                    }

                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    if (data.trim() === 'false') {
                                        swal("oops!something went wrong try again....");
                                    }
                                }
                            });
                        }
                    }
                });
            });
        </script>


        <script>
            function del_function(v_code, c_code) {
                if (email === null) {
                    swal("please login to delete comment");
                } else {
                    $.ajax({
                        url: "del_cmt.jsp",
                        type: 'post',
                        data: {v_code: v_code,
                            c_code: c_code
                        },
                        success: function (data, textStatus, jqXHR) {

                            if (data.trim() === 'true') {

                                $(" .load-cmt").load(" .load-cmt");
                                swal("Deleted Succesfully");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {

                        }
                    });

                }
            }
        </script>
        <script>
            $(document).ready(function () {
                $("#searchid").click(function (e) {
                    e.preventDefault();
                    var search = $("input").val();

                    $.ajax({
                        url: 'search_process.jsp',
                        type: 'POST',
                        data: {search: search},
                        success: function (data, textStatus, jqXHR) {
                            if (data.trim() === 'true') {
                                window.location.replace("search.jsp?query=" + search + " ");
                            }
                            if (data.trim() === 'false') {
                                swal("No results found");
//                                window.location.replace("search.jsp?query=" + search + " ");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {

                        }
                    });
                });
            });
        </script>

    </body>

</html>