
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
<!DOCTYPE HTML>
<html>
    <head>
        <title>Admin: Block</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="keywords" content="Pooled Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
              Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.min.css" rel='stylesheet' type='text/css' />
        <!-- Custom CSS -->
        <link href="css/style.css" rel='stylesheet' type='text/css' />
        <link rel="stylesheet" href="css/morris.css" type="text/css"/>
        <!-- Graph CSS -->
        <link href="css/font-awesome.css" rel="stylesheet"> 
        <!-- jQuery -->
        <script src="js/jquery-2.1.4.min.js"></script>
        <!-- //jQuery -->
        <link href='//fonts.googleapis.com/css?family=Roboto:700,500,300,100italic,100,400' rel='stylesheet' type='text/css'/>
        <link href='//fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
        <!-- lined-icons -->
        <link rel="stylesheet" href="css/icon-font.min.css" type='text/css' />
        <!-- //lined-icons -->
        <link rel="stylesheet" type="text/css" href="css/table-style.css" />
        <link rel="stylesheet" type="text/css" href="css/basictable.css" />
        <script type="text/javascript" src="js/jquery.basictable.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#table').basictable();

                $('#table-breakpoint').basictable({
                    breakpoint: 768
                });

                $('#table-swap-axis').basictable({
                    swapAxis: true
                });

                $('#table-force-off').basictable({
                    forceResponsive: false
                });

                $('#table-no-resize').basictable({
                    noResize: true
                });

                $('#table-two-axis').basictable();

                $('#table-max-height').basictable({
                    tableWrapper: true
                });
            });
        </script>
        
    </head> 
    <body>
        <div class="page-container">
            <!--/content-inner-->
            <div class="left-content">
                <div class="mother-grid-inner">
                    <!--header start here-->
                    <div class="header-main">

                        <div class="logo-w3-agile">
                            <h1><a href="block_user.jsp">Block User</a></h1>
                        </div>



                        <div class="profile_details w3l">		
                            <ul>
                                <li class="dropdown profile_details_drop">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <div class="profile_img">	
                                            <span class="prfil-img"><img src="images/in5.jpg" alt=""> </span> 
                                            <div class="user-name">
                                                <p>Vaibhav</p>
                                                <span>Administrator</span>
                                            </div>
                                            <i class="fa fa-angle-down"></i>
                                            <i class="fa fa-angle-up"></i>
                                            <div class="clearfix"></div>	
                                        </div>	
                                    </a>
                                    <ul class="dropdown-menu drp-mnu"> 
                                        <li> <a href="logout.jsp"><i class="fa fa-sign-out"></i> Logout</a> </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>

                        <div class="clearfix"> </div>	
                    </div>
                    <!--heder end here-->
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="block_user.jsp">Users</a> <i class="fa fa-angle-right"></i></li>
                    </ol>
                    <!--four-grids here-->
                    <div>
<!--                        <form method="post" action="block_process.jsp">
                            <div class="form-group">
                                <input type="text" class="form-control" name="email" id="exampleInputEmail1" placeholder="Enter category">
                            </div>


                            <button type="submit" class="btn btn-default">Submit</button>
                        </form>-->

                        <div>

                            <div>
                                <div class="agile-tables">
                                    <div class="w3l-table-info">
                                        <h2>Users List</h2>
                                        <table id="table">
                                            <thead>
                                                <tr>
                                                    <th>User Name</th>
                                                    <th>Email</th>
                                                    <th>Block user</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    String user_name = null;
                                                    String uemail = null;
                                                   
                                                    Class.forName("com.mysql.jdbc.Driver");
                                                    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
                                                    Statement st = cn.createStatement();
                                                    ResultSet rs = st.executeQuery("select * from users");
                                                    while (rs.next()) {
                                                        user_name = rs.getString(3) + " " + rs.getString(4);
                                                        uemail = rs.getString(5);

                                                %>    

                                                <tr>
                                                    <td><%=user_name%></td>
                                                    <td><%=uemail%></td>
                                                   
                                                    <td><button class="btn btn-default" onclick="blk('<%=uemail%>')"><i class="fa fa-ban" style="color: green;"></i></button></td>
                                                   
                                                    </tr>
                                                
                                                <%
                                                   
                                                    }
                                                %>  

                                            </tbody>
                                        </table>
                                    </div>

                                </div>
                            </div>
                            
                            <script>
                                $(document).ready(function () {
                                    var navoffeset = $(".header-main").offset().top;
                                    $(window).scroll(function () {
                                        var scrollpos = $(window).scrollTop();
                                        if (scrollpos >= navoffeset) {
                                            $(".header-main").addClass("fixed");
                                        } else {
                                            $(".header-main").removeClass("fixed");
                                        }
                                    });

                                });
                            </script>
                            <!-- /script-for sticky-nav -->
                            <!--inner block start here-->
                            <div class="inner-block">

                            </div>
                            <!--inner block end here-->
                            <!--copy rights start here-->

                            <!--COPY rights end here-->
                        </div>
                    </div>
                    <!--//content-inner-->
                    <!--/sidebar-menu-->
                    <div class="sidebar-menu">
                        <header class="logo1">
                            <a href="#" class="sidebar-icon"> <span class="fa fa-bars"></span> </a> 
                        </header>
                        <div style="border-top:1px ridge rgba(255, 255, 255, 0.15)"></div>
                        <div class="menu">
                            <ul id="menu" >										
                                <li id="menu-academico" ><a href="category.jsp"><i class="fa fa-folder-open-o"></i><span>Category</span><div class="clearfix"></div></a></li>
                                <li id="menu-academico" ><a href="logout.jsp"><i class="fa fa-sign-out"></i><span>Logout</span><div class="clearfix"></div></a></li>
                                <li id="menu-academico" ><a href="block_user.jsp"><i class="fa fa-ban"></i><span>Block</span><div class="clearfix"></div></a></li>

                            </ul>
                        </div>
                    </div>
                    <div class="clearfix"></div>		
                </div>
                <script>
                    var toggle = true;

                    $(".sidebar-icon").click(function () {
                        if (toggle)
                        {
                            $(".page-container").addClass("sidebar-collapsed").removeClass("sidebar-collapsed-back");
                            $("#menu span").css({"position": "absolute"});
                        } else
                        {
                            $(".page-container").removeClass("sidebar-collapsed").addClass("sidebar-collapsed-back");
                            setTimeout(function () {
                                $("#menu span").css({"position": "relative"});
                            }, 400);
                        }

                        toggle = !toggle;
                    });
                </script>
                <!--js -->
                <script src="js/jquery.nicescroll.js"></script>
                <script src="js/scripts.js"></script>
                <!-- Bootstrap Core JavaScript -->
                <script src="js/bootstrap.min.js"></script>
                <!-- /Bootstrap Core JavaScript -->	   
                <!-- morris JavaScript -->	
                <script src="js/raphael-min.js"></script>
                <script src="js/morris.js"></script>

                <!-- Sweet alert-->
                <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
                <script>
                    $(document).ready(function () {
                        //BOX BUTTON SHOW AND CLOSE
                        jQuery('.small-graph-box').hover(function () {
                            jQuery(this).find('.box-button').fadeIn('fast');
                        }, function () {
                            jQuery(this).find('.box-button').fadeOut('fast');
                        });
                        jQuery('.small-graph-box .box-close').click(function () {
                            jQuery(this).closest('.small-graph-box').fadeOut(200);
                            return false;
                        });

                        //CHARTS
                        function gd(year, day, month) {
                            return new Date(year, month - 1, day).getTime();
                        }

                        graphArea2 = Morris.Area({
                            element: 'hero-area',
                            padding: 10,
                            behaveLikeLine: true,
                            gridEnabled: false,
                            gridLineColor: '#dddddd',
                            axes: true,
                            resize: true,
                            smooth: true,
                            pointSize: 0,
                            lineWidth: 0,
                            fillOpacity: 0.85,
                            data: [
                                {period: '2014 Q1', iphone: 2668, ipad: null, itouch: 2649},
                                {period: '2014 Q2', iphone: 15780, ipad: 13799, itouch: 12051},
                                {period: '2014 Q3', iphone: 12920, ipad: 10975, itouch: 9910},
                                {period: '2014 Q4', iphone: 8770, ipad: 6600, itouch: 6695},
                                {period: '2015 Q1', iphone: 10820, ipad: 10924, itouch: 12300},
                                {period: '2015 Q2', iphone: 9680, ipad: 9010, itouch: 7891},
                                {period: '2015 Q3', iphone: 4830, ipad: 3805, itouch: 1598},
                                {period: '2015 Q4', iphone: 15083, ipad: 8977, itouch: 5185},
                                {period: '2016 Q1', iphone: 10697, ipad: 4470, itouch: 2038},
                                {period: '2016 Q2', iphone: 8442, ipad: 5723, itouch: 1801}
                            ],
                            lineColors: ['#ff4a43', '#a2d200', '#22beef'],
                            xkey: 'period',
                            redraw: true,
                            ykeys: ['iphone', 'ipad', 'itouch'],
                            labels: ['All Visitors', 'Returning Visitors', 'Unique Visitors'],
                            pointSize: 2,
                            hideHover: 'auto',
                            resize: true
                        });


                    });
                </script>

                <script>
                    function blk(uemail) {
                      
                        $.ajax({
                            url: 'block_process.jsp',
                            type: 'POST',
                            data: {email: uemail},
                            success: function (data, textStatus, jqXHR) {
                                if (data.trim() === "1") {
                                    swal("added into blocklist");
                                }
                                if (data.trim() === "2") {
                                    
                                    swal("Removed from blocklist");
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                console.log(data);
                                if (data.trim() === "0") {
                                    swal("Something went wrong");
                                }
                            }
                        });
                    };

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