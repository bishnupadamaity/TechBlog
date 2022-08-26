<%-- 
    Document   : register_page
    Created on : 19-Aug-2022, 1:39:45 am
    Author     : dibya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>

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

        <!--  Navbar  -->
        <%@include file = "normal_navbar.jsp" %>

        <main class="primary-background  banner-background" style="padding-bottom:80px;">
            <div class="container">
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-header primary-background text-white text-center">
                            <span class="fa fa-user-circle fa-2x"></span>
                            <br>
                            <p>Register here !</p> 
                        </div>
                        <div class="card-body">
                            <form id="reg_form" action="RegisterServlet" method="POST">


                                <div class="form-group">
                                    <label for="exampleInputEmail1">User Name</label>
                                    <input name="user_name" type="text" class="form-control" id="user_name" aria-describedby="emailHelp" placeholder="Enter name">
                                </div>


                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter e-mail">
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>


                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input name="user_password" type="password" class="form-control" id="exampleInputPassword1">
                                </div>

                                <div class="form-group">
                                    <label for="gender">Select Gender</label>
                                    <br>
                                    <input type="radio" id="gender" name="gender" value="male"> Male 
                                    <input type="radio" id="gender" name="gender" value="female"> Female 
                                </div>


                                <div class="form-group">
                                    <textarea name="about" class="form-control" id="" cols="30" rows="5" placeholder="Enter something about yourself !"></textarea>
                                </div>


                                <div class="form-group form-check">
                                    <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                    <label  class="form-check-label" for="exampleCheck1">Agree terms & conditions.</label>
                                </div>

                                <br><!-- comment -->
                                <div class="container text-center " id="loader" style="display:none;">

                                    <span class="fa fa-refresh fa-spin fa-2x" ></span>
                                    <h4>Please wait... </h4>

                                </div>
                                <button id="submit_btn" type="submit" class="btn btn-primary">Submit</button>
                            </form> 
                        </div>
                    </div>
                </div>
            </div>
        </main>




        <!--  JavaScript  -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <script>
            $(document).ready(function () {
                console.log("loaded...");
            });

            $("#reg_form").on("submit", function (event) {

                event.preventDefault();

                let form = new FormData(this);

                $("#submit_btn").hide();
                $("loader").show();



                // send register servlet
                $.ajax({
                    url: "RegisterServlet",
                    data: form,
                    type: "POST",
                    success: function (data, textStatus, jqXHR) {
                        $("#submit_btn").show();
                        $("loader").hide();
                        console.log(data);
                        if(data.trim() === 'done'){
                            swal("Register successfully.")
                                .then((value) => {
                                    window.location="login_page.jsp"
                                });
                        }else{
                            swal(data);
                        }
                        
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $("#submit_btn").show();
                        $("loader").hide();
                        console.log(jqXHR);
                        console.log("Error...");
                        
                        swal("Something went wrong.");

                    },
                    processData: false,
                    contentType: false
                });


            });
        </script>
    </body>
</html>
