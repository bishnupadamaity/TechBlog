
<%@page import="java.util.ArrayList"%>
<%@page import="com.drream.gadddi.entities.Category"%>
<%@page import="com.drream.gadddi.dao.PostDao"%>
<%@page import="com.dream.gadddi.helper.ConnectionProvider"%>
<%@page import="com.drream.gadddi.entities.Message"%>
<%@page import="com.drream.gadddi.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <!--  css  -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 99% 88%, 67% 94%, 26% 90%, 0 95%, 0 0);
            }

        </style> 


    </head>
    <body>


        <!--navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" href="index.jsp"><span class="fa fa-car"></span> Dream Gadddi</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">About</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">
                            Categories
                        </a>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="#">Action</a>
                            <a class="dropdown-item" href="#">Another</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Categories</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal">Do Post</a>
                    </li>


                </ul>
                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link " href="#!" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle"></span> <%= user.getName()%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link " href="LogoutServlet"><span class="fa fa-user-plus"></span> LogOut</a>
                    </li>
                </ul>
            </div>
        </nav>



        <%
            Message m = (Message) session.getAttribute("msg");
            if (m != null) {
        %>

        <div class="alert <%= m.getCssClass()%>" role="alert">
            <%= m.getContent()%>
        </div>

        <%
                session.removeAttribute("msg");
            }
        %>


        <!--end_of_navbar-->


        <!--  profile modal  -->
        <!-- Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-header primary-background text-white">
                        <h5 class="modal-title" id="exampleModalLabel"><%= user.getName()%></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                        <div class="container text-center">
                            <img src="pics/<%= user.getProfile()%>" class="img-fluid" style="border-radius:50%;max-width: 100px;"/>
                            <br>
                            <h5 class="modal-title mt-3" id="exampleModalLabel"><%= user.getName()%></h5>

                            <div id="profile-detail">
                                <!--// details-->
                                <table class="table">

                                    <tbody>
                                        <tr>
                                            <th scope="row">id :</th>
                                            <td><%= user.getId()%></td>
                                        </tr>  
                                        <tr>
                                            <th scope="row">E-mail :</th>
                                            <td><%= user.getEmail()%></td>

                                        </tr>                                   
                                        <tr>
                                            <th scope="row">Gender :</th>
                                            <td><%= user.getGender()%></td>

                                        </tr>                                   
                                        <tr>
                                            <th scope="row">Status :</th>
                                            <td><%= user.getAbout()%></td>

                                        </tr>                                   
                                        <tr>
                                            <th scope="row">Register On :</th>
                                            <td><%= user.getDateTime().toString()%></td>

                                        </tr>                                   
                                    </tbody>
                                </table>
                            </div>

                            <!--profile edit-->

                            <div id="profile-edit" style="display: none;">
                                <h2>Please Edit Carefully</h2>
                                <form action="EditServlet" method="POST" enctype="multipart/form-data">
                                    <table class="table">
                                        <tr>
                                            <th scope="row">id :</th>
                                            <td><%= user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Email :</th>
                                            <td><input class="form-control" type="email" name="user_email" value="<%= user.getEmail()%>"></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Name :</th>
                                            <td><input class="form-control" type="text" name="user_name" value="<%= user.getName()%>"></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Password :</th>
                                            <td><input class="form-control" type="Password" name="user_password" value="<%= user.getPassword()%>"></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">id :</th>
                                            <td><%= user.getGender().toUpperCase()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">About :</th>
                                            <td>
                                                <textarea class="form-control" name="user_about" rows="4" ><%= user.getAbout()%>
                                                </textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row">New Profile :</th>
                                            <td>
                                                <input type="file" name="image" class="form-control">
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="container">
                                        <button type="submit" class="btn btn-outline-primary">Save</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="edit-profile-button">Edit</button>
                    </div>
                </div>
            </div>
        </div>
        <!--  end of profile modal  --> 

        <!-- do post modal start -->


        <div class="modal fade" id="add-post-modal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="staticBackdropLabel">Provide Post Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form id="add-post-form" action="AddPostServlet" method="POST">
                            <div class="form-group">
                                <select class="form-control" name="cid">
                                    <option selected disabled>--- Select Category ---</option>
                                    <%
                                        PostDao postD = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Category> list = postD.getAllCategories();
                                        for (Category c : list) {
                                    %>
                                    <option value="<%= c.getCid()%>"><%= c.getName()%></option>

                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-group">
                                <input name="pTitle" type="text" placeholder="Enter Post Title" class="form-control">

                            </div>
                            <div class="form-group">
                                <textarea name="pContent" class="form-control" placeholder="Enter Your Content"style="height:200px;"></textarea>                                   
                            </div>
                            <div class="form-group">
                                <textarea name="pCode" class="form-control" placeholder="Enter Your Program (if any)"style="height:100px;"></textarea>                                   
                            </div>
                            <div class="form-group">
                                <label>Select Your Pic</label>
                                <br>
                                <input type="file" name="pic" >                                   
                            </div>

                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-primary">Post</button>
                            </div>

                        </form>


                    </div>

                </div>
            </div>
        </div>

        <!-- end of do post modal  -->






        <!--  JavaScript  -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>


        <script>
            $(document).ready(function () {
                let editStatus = false;
                $('#edit-profile-button').click(function () {
                    if (editStatus === false) {
                        $(this).text("Back");
                        $('#profile-detail').hide();
                        $('#profile-edit').show();
                        editStatus = true;
                    } else {
                        editStatus = false;
                        $(this).text("Edit");
                        $('#profile-detail').show();
                        $('#profile-edit').hide();
                    }

                });
            });
        </script>

        <!--  now add post js  -->
        <script>
            $(documet).ready(function (e) {

                //
                $("#add-post-form").on("submit",function(event) {
                    // this form called when form is submitted
                    event.preventDefault();
                    

                    let form = new FormData(this);

                    //now requesting to server
                    $.ajax({
                        url: "AddPostServlet",
                        type: "POST",
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            // success..
                            
                            


                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            // error..
                        },
                        processData: false,
                        contentType: false
                    });
                });

            });
        </script>

    </body>
</html>
