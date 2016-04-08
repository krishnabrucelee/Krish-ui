<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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