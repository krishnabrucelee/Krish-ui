<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="inmodal ">
    <div class="modal-header">
        <panda-modal-header page-icon="fa fa-soundcloud"
			page-title="Add ACL List">
        </panda-modal-header>
    </div>
    <div class="modal-body">
     	<div data-ng-show="showLoader" style="margin: 20%">
		    <get-loader-image data-ng-show="showLoader"></get-loader-image>
		</div>
     	<div data-ng-hide="showLoader">
	        <div class="row form-group">
	            <div class="col-md-6 col-sm-12">
	            	<span class="control-label">ACL List Name <span class="text-danger font-bold" title="* Required">*</span></span>
	            </div>
	            <div class="col-md-6 col-sm-12">
	            	<input class="form-control" type="text"  required="true">
	            </div>
	        </div>
	        <div class="row form-group">
           		<div class="col-md-6 col-sm-12">
           			<span class="control-label">Description <span class="text-danger font-bold" title="* Required">*</span></span>
           		</div>
           		<div class="col-md-6 col-sm-12">
           			<input class="form-control" type="text"  required="true">
           		</div>
           	</div>
           	<div class="row form-group text-center">
           		<a class="btn btn-default" ng-click="cancel()"> Cancel </a>
				<button class="btn btn-info" type="submit">OK</button>
           	</div>
	    </div>
    </div>