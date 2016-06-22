<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
 <c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

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
    <title id="pandaAppPageTitle" page-title></title>
    <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
	<link rel="shortcut icon" type="image/x-icon"  href=""  data-fav-icon-url="" />
    <!-- build:css(.) styles/vendor.css -->
    <!-- bower:css -->
    <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.css" />

    <!-- endbower -->
    <!-- endbuild -->

    <!-- build:css({.tmp,app}) styles/style.css -->
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/login-loader.css">
    <link rel="stylesheet" href="styles/custom-style.css">
    <link rel="stylesheet" href="bower_components/fontawesome/css/font-awesome.css" />
    <!-- endbuild -->

</head>
<body class="blank login-bg" data-ng-controller="loginCtrl" data-ng-style="{'background':(backgroundImage ? 'url('+backgroundImage+')' : '')}">

<div class="login-container">
    <div class="row">
        <div class="col-md-12">
        <div data-ng-bind-html="welcomeContentUser | to_trusted "></div>
            <div class="hpanel hbgblue">
                <div class="panel-body" >

                 <form name="test" method="post" id="loginForm" data-ng-submit="loginFormWithoutCaptcha()" data-ng-if ="!enableCaptcha">

                        <h6 class="alert alert-danger" style="display: none" id="errorMsg"></h6>
                        <div class="form-group">
                            <label class="control-label" for="username"><fmt:message key="common.username" bundle="${msg}" /></label>
                            <input type="text" placeholder="<fmt:message key="common.small.username" bundle="${msg}" />" title="<fmt:message key="please.enter.your.username" bundle="${msg}" />" required="" data-ng-model="user_name" name="user_name" id="user_name" class="form-control">
                        </div>
                        <div class="form-group">
                            <label class="control-label" for="password"><fmt:message key="common.password" bundle="${msg}" /></label>
                            <input type="password" title="<fmt:message key="please.enter.your.password" bundle="${msg}" />" placeholder="******" required="" data-ng-model="user_password" name="user_password" id="user_password" class="form-control">
                        </div>
                        <div class="form-group">
                            <label class="control-label" for="domain"><fmt:message key="common.domain" bundle="${msg}" /></label>
                            <input type="text" placeholder="<fmt:message key="common.small.company" bundle="${msg}" />" title="<fmt:message key="please.enter.your.domain" bundle="${msg}" />" required="" data-ng-model="user_domain" name="user_domain" id="user_domain" class="form-control">
                        </div>
                        <div class="checkboxs">
                            <input data-ng-click="rememberMe()" id="user_remember" data-ng-model="user_remember" name="user_remember" type="checkbox">
                            <label for="remeber_login"><fmt:message key="remember.login" bundle="${msg}" /></label>
                            <p class="small">(<fmt:message key="private.computer" bundle="${msg}" />)</p>
                        </div>

                           <input type="hidden" value="${REQUEST_PROTOCOL}" id="request_protocol" />
                        <input type="hidden" value="${REQUEST_PORT}" id="request_port" />
                        <input type="hidden" value="${REQUEST_FOLDER}" id="request_folder" />
            <input type="hidden" value="${WEBSOCKET}" id="websocket_debug" />
                        <get-login-loader-image data-ng-show="showLoader"></get-login-loader-image>
                        <button data-ng-hide="showLoader" id="login_button" type="submit" class="btn btn-default"><fmt:message key="common.login" bundle="${msg}" /></button>
                    </form>

                 <form name="tests" method="post" id="loginForm" data-ng-submit="loginForm()" data-ng-if ="enableCaptcha">

                        <h6 class="alert alert-danger" style="display: none" id="errorMsgs"></h6>
                        <div class="form-group">
                            <label class="control-label" for="username"><fmt:message key="common.username" bundle="${msg}" /></label>
                            <input type="text" placeholder="<fmt:message key="common.small.username" bundle="${msg}" />" title="<fmt:message key="please.enter.your.username" bundle="${msg}" />" required="" data-ng-model="user_name" name="user_name" id="user_name" class="form-control">
                        </div>
                        <div class="form-group">
                            <label class="control-label" for="password"><fmt:message key="common.password" bundle="${msg}" /></label>
                            <input type="password" title="<fmt:message key="please.enter.your.password" bundle="${msg}" />" placeholder="******" required="" data-ng-model="user_password" name="user_password" id="user_password" class="form-control">
                        </div>
                        <div class="form-group">
                            <label class="control-label" for="domain"><fmt:message key="common.domain" bundle="${msg}" /></label>
                            <input type="text" placeholder="<fmt:message key="common.small.company" bundle="${msg}" />" title="<fmt:message key="please.enter.your.domain" bundle="${msg}" />" required="" data-ng-model="user_domain" name="user_domain" id="user_domain" class="form-control">
                        </div>

                        <div class="row" ng-show ="enableCaptcha" >
                        	<div class="col-md-5 captcha-textbox">
                        		<span class="small"><fmt:message key="enter.captcha.text" bundle="${msg}" /></span>
       							<input type = "text" data-ng-model="answer"  name="answer" required=""  class= form-control>
							</div>
 							<div class="col-md-4 captcha-number no-padding">
								 <iframe src=${pageContext.request.contextPath}/CaptchaServlet id="captchaImg" ></iframe>
							</div>
							<div class="col-md-1 captcha-refresh no-padding text-center">
								<a data-ng-click="refreshCaptcha()"  ><span class="fa fa-refresh fa-lg "></span></a>
 							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-12">
								<div class="checkboxs">
		                            <input data-ng-click="rememberMe()" id="user_remember" data-ng-model="user_remember" name="user_remember" type="checkbox">
		                            <label for="remeber_login"><fmt:message key="remember.login" bundle="${msg}" /></label>
		                            <span class="small">(<fmt:message key="private.computer" bundle="${msg}" />)</span>
		                        </div>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-12">
								<div class="pull-left">
		                        	<button data-ng-hide="showLoader" id="login_button" type="submit" class="btn btn-default"><fmt:message key="common.login" bundle="${msg}" /></button>
		                        </div>
							</div>
                        </div>

                       	<input type="hidden" value="${REQUEST_PROTOCOL}" id="request_protocol" />
                        <input type="hidden" value="${REQUEST_PORT}" id="request_port" />
                        <input type="hidden" value="${REQUEST_FOLDER}" id="request_folder" />
			<input type="hidden" value="${WEBSOCKET}" id="websocket_debug" />
                        <get-login-loader-image data-ng-show="showLoader"></get-login-loader-image>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

        <div class="row">
        <div data-ng-bind-html="footerContent | to_trusted"></div>
    </div>

</body>

<script src="bower_components/jquery/dist/jquery.min.js"></script>
<script src="bower_components/angular/angular.min.js"></script>
<script src="bower_components/sanitize/angular-sanitize.min.js"></script>
<script src="scripts/controllers/loginController.js"></script>
<script src="scripts/factories/rememberMeService.js"></script>
<script src="scripts/constants/appConstants.js"></script>
<script src="scripts/factories/globalConfig.js"></script>
<script src="bower_components/angular/angular-cookies.js"></script>
<script src="bower_components/angular-local-storage/dist/angular-local-storage.js"></script>
<script src="scripts/directives/directives.js"></script>
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
<script type="text/javascript">
    var REQUEST_PROTOCOL = document.getElementById("request_protocol").value;
    if(REQUEST_PROTOCOL == "" || typeof(REQUEST_PROTOCOL) == "undefined" || REQUEST_PROTOCOL == null) {
        REQUEST_PROTOCOL = "http";
    }

    var REQUEST_PORT = document.getElementById("request_port").value;
    if(REQUEST_PORT != "" && typeof(REQUEST_PORT) != "undefined" && REQUEST_PORT != null) {
        REQUEST_PORT = ":" + REQUEST_PORT;
    }

    var REQUEST_FOLDER = document.getElementById("request_folder").value;
    if(REQUEST_FOLDER == "" || typeof(REQUEST_FOLDER) == "undefined" || REQUEST_FOLDER == null) {
        REQUEST_FOLDER = "/";
    }
    var WEBSOCKET_DEBUG = document.getElementById("websocket_debug").value;
    if(WEBSOCKET_DEBUG == "" || typeof(WEBSOCKET_DEBUG) == "undefined" || WEBSOCKET_DEBUG == null) {
        WEBSOCKET_DEBUG = false;
    }
    var USER_CONTEXT_PATH = "<%=request.getContextPath()%>";
</script>
</html>
