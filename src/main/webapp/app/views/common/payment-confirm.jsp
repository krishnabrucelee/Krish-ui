<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html data-ng-app="homer">
<head>
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
				</div>
				<div class="panel-body" data-ng-controller="paymentController">
					<div class="row" data-ng-show="showLoader">
						<div class="col-md-12 text-center">
							<h1>Payment - Processing..</h1>
							<p>Cloud Management Portal</p>
							<img src="images/loading-bars.svg" width="64" height="64" />
						</div>
					</div>
					<p ng-bind-html="data"></p>
				</div>
			</div>
		</div>
	</div>
</body>
<script src="bower_components/jquery/dist/jquery.min.js"></script>
<script src="bower_components/angular/angular.min.js"></script>
<script src="scripts/controllers/paymentController.js"></script>
<script src="scripts/factories/rememberMeService.js"></script>
<script src="scripts/factories/globalConfig.js"></script>
</html>