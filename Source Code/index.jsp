
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
                            String code = rs.getString(2);


                %>
                <li id="profile-btn" class="nav-item dropdown no-arrow osahan-right-navbar-user">
                    <a class="nav-link dropdown-toggle user-dropdown-link" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <img alt="Avatar" src="profile/<%=code%>.jpg">


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
                    <div class="top-mobile-search">
                        <div class="row">
                            <div class="col-md-12">   
                                <form class="mobile-search">
                                    <div class="input-group">
                                        <input type="text" placeholder="Search for..." class="form-control">
                                        <div class="input-group-append">
                                            <button type="button" class="btn btn-dark"><i class="fas fa-search"></i></button>
                                        </div>
                                    </div>
                                </form>   
                            </div>
                        </div>
                    </div>
                    <div class="top-category section-padding mb-1">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="main-title">

                                    <h6>Channel Categories</h6>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="owl-carousel owl-carousel-category">
                                    <%                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
                                            Statement st = cn.createStatement();
                                            ResultSet rs = st.executeQuery("select * from category");
                                            while (rs.next()) {
                                                String category_name = rs.getString(3);
                                                String cat_code = rs.getString(2);
                                    %>    
                                    <div  class="item">
                                        <div style="border-radius: 40px;"  class="category-item">
                                            <a href="category.jsp?cat_code=<%=cat_code%>">
                                                <!--<img class="img-fluid" src="img/s1.png" alt="">-->
                                                <h6><%=category_name%></h6>

                                            </a>
                                        </div>
                                    </div>

                                    <%
                                            }
                                            cn.close();
                                        } catch (Exception er) {
                                            out.println(er.getMessage());
                                        }

                                    %>  
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="video-block section-padding">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="main-title">

                                    <h6>Featured Videos</h6>
                                </div>
                            </div>

                            <%  String cat_code = null;
                                String v_code = null;
                                int count = 0;

                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
                                    Statement st = cn.createStatement();
                                    ResultSet rs = st.executeQuery("select * from videos order by RAND()");
                                    while (rs.next()) {

                                        v_code = rs.getString(2);
                                        cat_code = rs.getString(5);
                                        String user = rs.getString(8);
                                        String channel_code = rs.getString(9);
                                        String udate = rs.getString(7);

                                        //for views
                                        PreparedStatement pst3 = cn.prepareStatement("select count(*) from views where video_code='" + v_code + "'");
                                        ResultSet rst3 = pst3.executeQuery();
                                        if (rst3.next()) {

                                            count = rst3.getInt(1);
                                        } else {
                                            count = 0;
                                        }

                                        //for channel name
                                        String c_name = null;
                                        PreparedStatement pst11 = cn.prepareStatement("select c_name from channel where code='" + channel_code + "'");
                                        ResultSet rst11 = pst11.executeQuery();
                                        if (rst11.next()) {

                                            c_name = rst11.getString(1);
                                        }

                            %>

                            <div class="col-xl-3 col-sm-6 mb-2">
                                <div class="video-card">
                                    <div class="video-card-image">
                                        <a href="play_video.jsp?cat_code=<%=cat_code%>&v_code=<%=v_code%>"><video data-play="Hover"  id="videoid" height="100%" width="100%" poster="videos/<%=cat_code%>/<%=v_code%>.jpg" class="img-fluid" muted>
                                                <source src="videos/<%=cat_code%>/<%=v_code%>.mp4" type="video/mp4">

                                                Your browser does not support the video tag.
                                            </video></a>
                                        <span id="video-duration" style="float: right;"></span>
                                    </div>
                                    <div  class="video-card-body">
                                        <div style="float: left;"><img alt="Avatar" src="profile/<%=channel_code%>.jpg" style=" height: 30px; width: 30px; border-radius: 50px;"></div>

                                        <div style="padding-left: 5px;" id="vid-title"   class="video-title">
                                            <a href="play_video.jsp?cat_code=<%=cat_code%>&v_code=<%=v_code%>" style="font-size: 14px;"><%=rs.getString("title")%></a>
                                        </div>

                                        <div  style="padding-left: 35px;" class="video-page text-success">
                                            <a title="" data-placement="top" data-toggle="tooltip" href="all_channel.jsp?channel_code=<%=channel_code%>" data-original-title="Verified"><span style="color:#404040; font-size: 15px"><%=c_name%> &nbsp;</span><i class="fas fa-check-circle text-success"></i></a>
                                        </div>

                                        <div style="padding-left: 35px;" class="video-view">
                                            <a href="play_video.jsp?cat_code=<%=cat_code%>&v_code=<%=v_code%>" ><span style="color: #404040; font-size: 14px"><%=count%><i class="fas fa-eye"></i> &nbsp; <%=udate%></span> &nbsp;<i class="fas fa-calendar-alt"></i></a>
                                        </div>

                                    </div>
                                </div>                          
                            </div>
                            <%
                                    }
                                    cn.close();
                                } catch (Exception er) {
                                    out.println(er.getMessage());
                                }
                            %> 
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
                            <span aria-hidden="true">�</span>
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



        <script type="text/javascript">
            document.addEventListener('mouseover', hoverVideo, false);
            var vid = document.getElementsByTagName("video");

            [].forEach.call(vid, function (item) {
                item.addEventListener('mouseover', hoverVideo, false);
                item.addEventListener('mouseout', hideVideo, false);


            });
            function hoverVideo(e)
            {
                this.play();
            }
            function hideVideo(e)
            {
                this.load();
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