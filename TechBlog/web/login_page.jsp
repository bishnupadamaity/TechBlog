<%@page import="com.drream.gadddi.entities.Message"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 90%, 67% 93%, 26% 90%, 0 95%, 0 0);
            }

        </style>

    </head>
    <body>


        <!--  Navbar  -->
        <%@include file = "normal_navbar.jsp" %>

        <main class="d-flex align-items-center primary-background text-white " style="height: 80vh;">
            <div class="container mb-4">
                <div class="row">
                    <div class="col-md-4 offset-md-4">
                        <div class="card">
                            <div class="card-header primary-background text-white text-center">
                                <span class="fa fa-user-circle fa-2x"></span>
                                <br>
                                <p>Login here !</p>

                            </div>

                            <%
                                Message m = (Message) session.getAttribute("msg");
                            if (m != null) {
                            %>

                            <div class="alert <%= m.getCssClass()%>" role="alert">
                                <%= m.getContent() %>
                            </div>

                            <%
                                session.removeAttribute("msg");
                                }
                            %>




                            <div class="card-body">
                                <form class="pb-3" action="LoginServlet" method="POST">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1" class="form-text text-muted">Email address</label>
                                        <input name="email" required type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                        <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputPassword1" class="form-text text-muted">Password</label>
                                        <input name="password" type="password" class="form-control" id="exampleInputPassword1">
                                    </div>
                                    <div class="container text-center">
                                        <button type="submit" class="btn btn-primary">Submit</button>

                                    </div>
                                </form> 
                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </main>




        <!--  JavaScript  -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
    </body>
</html>
