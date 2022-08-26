

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sorry something went wrong</title>
        
        <!--  css  -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    

        </style>
    </head>
    <body>
        <div class="container text-center">
            <img src="images/error.png" class="img-fluid">
            <h3 class="display-3">Sorry ! Something went wrong.</h3>
            <br>
            <%= exception%>
            <br>
            <a href="index.jsp" class="btn btn-primary btn-lg text-white mt-3" >Home</a>
            
        </div>
    </body>
</html>
