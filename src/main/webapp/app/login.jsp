<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html data-ng-app="homer">
<head>
    <!-- Redirect to login when passing the wrong URL -->
    <script>
        var pageUrl = window.location.href;
        if(pageUrl.indexOf("index#/login") > -1 || pageUrl.endsWith("index#/")) {
            var contextPath = '<%= request.getContextPath() %>';
            var baseUrl = window.location.protocol + "//" + window.location.host + contextPath + '/login';
            window.location = baseUrl;
        }
    </script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Page title set in pageTitle directive -->
    <title page-title></title>
    <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
    <link rel="shortcut icon" type="image/x-icon" href="favicon.ico" />

    <!-- build:css(.) styles/vendor.css -->
    <!-- bower:css -->
    <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.css" />

    <!-- endbower -->
    <!-- endbuild -->

    <!-- build:css({.tmp,app}) styles/style.css -->
    <link rel="stylesheet" href="styles/style.css">
    <!-- endbuild -->

</head>
<body class="blank" data-ng-controller="loginCtrl">


<div class="login-container">
    <div class="row">
        <div class="col-md-12">
            <div class="text-center m-b-md">
                <h4 class="font-bold text-primary">Please Login To Panda User Console</h4>
                <small>Cloud Management Portal</small>
            </div>
            <div class="hpanel hbgblue">
                <div class="panel-body" >
                    <form name="test" method="post" id="loginForm" data-ng-submit="loginForm()">
                        <h6 class="alert alert-danger" style="display: none" id="errorMsg"></h6>
                        <div class="form-group">
                            <label class="control-label" for="username">Username</label>
                            <input type="text" placeholder="username" title="Please enter you username" required="" data-ng-model="user_name" name="user_name" id="user_name" class="form-control">
                        </div>
                        <div class="form-group">
                            <label class="control-label" for="password">Password</label>
                            <input type="password" title="Please enter your password" placeholder="******" required="" data-ng-model="user_password" name="user_password" id="user_password" class="form-control">
                        </div>
                        <div class="form-group">
                            <label class="control-label" for="domain">Company</label>
                            <input type="text" placeholder="Company" title="Please enter you domain" required="" data-ng-model="user_domain" name="user_domain" id="user_domain" class="form-control">
                        </div>
                        <div class="checkboxs">
                            <input data-ng-click="rememberMe()" id="user_remember" data-ng-model="user_remember" name="user_remember" type="checkbox">
                            <label for="remeber_login">Remember login</label>
                            <p class="small">(if this is a private computer)</p>
                        </div>
                        <button id="login_button" type="submit" class="btn btn-default">Login</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 text-center">
        Panda Cloud Management Portal<br/> Copyright © 2015 BlueTek Co.Ltd, All rights reserved.
        </div>
    </div>
</div>


</body>

<script src="bower_components/jquery/dist/jquery.min.js"></script>
<script src="bower_components/angular/angular.min.js"></script>
<script src="scripts/controllers/loginController.js"></script>
<script src="scripts/factories/rememberMeService.js"></script>
<script src="scripts/factories/globalConfig.js"></script>
<script type="text/javascript">
    function loginForm() {
        var username = document.getElementById("username").value;
        var password = document.getElementById("password").value;
        if (username == "user" && password == "user")
        {
            window.location.href = "index.html#/dashboard";
        } else {
            var target = document.getElementById("errorMsg");
            target.innerHTML = "Invalid Username or Password";
            target.style.display = 'block';
            target.style["margin-bottom"] = '10px';
        }
    }
</script>
</html>
