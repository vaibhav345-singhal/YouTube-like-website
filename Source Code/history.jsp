<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
    try {
        Cookie c[] = request.getCookies();
        String email = null;
        for (int i = 0; i < c.length; i++) {
            if (c[i].getName().equals("user")) {

                email = c[i].getValue();
                break;
            }
        }
        if (email != null && session.getAttribute(email) != null) {


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




                <%                    try {
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
            <div id="content-wrapper" class="load-history">
                <div class="container-fluid ">
                    <div class="video-block section-padding">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="main-title">
                                    <div class="float-right">
                                        <button type="button" id="del-all" style="border-radius: 10px" class="btn btn-danger border-none">Delete All</button>

                                    </div>
                                    <br>
                                    <h6>Watch History</h6>
                                </div>
                            </div>

                            <%  String v_code = null;
                                String channel_code = null;
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
                                    Statement st = cn.createStatement();
                                    ResultSet rs = st.executeQuery("select * from history where user= '" + email + "'");
                                    while (rs.next()) {
                                        v_code = rs.getString(2);

                                        PreparedStatement pst = cn.prepareStatement("select * from `videos` where code='" + v_code + "'");
                                        ResultSet rst = pst.executeQuery();
                                        if (rst.next()) {
                                            String cat_code = rst.getString(5);
                                            String user = rst.getString(8);
                                            String title = rst.getString(3);
                                            channel_code = rst.getString(9);
                            %>

                            <div class="col-xl-3 col-sm-6 mb-3">
                                <div class="video-card">
                                    <div class="video-card-image">
                                        <a class="play-icon" href="play_video.jsp?cat_code=<%=cat_code%>&v_code=<%=v_code%>" ><i class="fas fa-play-circle"></i></a>
                                        <a href="#" ><img class="img-fluid" src="videos/<%=cat_code%>/<%=v_code%>.jpg" alt="" style="height: 150px ;width: 300px"></a>

                                    </div>
                                    <div class="video-card-body">
                                        <div style="height: 50px;"  class="video-title">
                                            <a href="play_video.jsp?cat_code=<%=cat_code%>&v_code=<%=v_code%>"><%=title%></a>
                                        </div>

                                        <div class="video-page text-success">
                                            <a title="" data-placement="top" data-toggle="tooltip" href="channel.jsp?channel_code=<%=channel_code%>" data-original-title="Verified"><strong><span style="color: green; font-size: 15px"><%=user%> &nbsp;</span></strong><i class="fas fa-check-circle text-success"></i></a>
                                        </div>
                                        <br>
                                        <!--                                        <div class="video-view">
                                                                                    <div class="channels-card-image-btn"><button  type="button" id="del-history" class="btn btn-warning btn-sm border-none"><span>Remove from histroy</span> &nbsp;<i  class="fas fa-times-circle"></i></button></div>
                                                                                </div>-->

                                    </div>
                                </div>
                            </div>
                            <%}
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
            $(document).ready(function () {

                console.log("ready....");
                $(" #del-all").click(function () {
                    const d = {
                        v_code: '<%=v_code%>'
                    };

                    $.ajax({
                        url: "del_all_history.jsp",
                        data: d,
                        type: 'post',

                        success: function (data, textStatus, jqXHR) {


                            if (data.trim() === 'true') {

                                $(".load-history").load(" .load-history");
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(data);
                        }
                    });
                });
            });
        </script>


    </body>

</html>
<%        } else {
            response.sendRedirect("login.jsp");
        }
    } catch (Exception er) {
        out.print(er.getMessage());
    }
%> 