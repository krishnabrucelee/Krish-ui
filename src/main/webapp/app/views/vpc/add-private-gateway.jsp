<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="inmodal ">
    <div class="modal-header">
        <panda-modal-header page-icon="fa fa-soundcloud"
			page-title="<fmt:message key="add.new.gateway" bundle="${msg}" />">
        </panda-modal-header>
    </div>
    <div class="modal-body">
     	<div data-ng-show="showLoader" style="margin: 20%">
		    <get-loader-image data-ng-show="showLoader"></get-loader-image>
		</div>
     	<div data-ng-hide="showLoader">
     		<div class="row form-group">
     			<div class="col-md-12	">
     				<h4><fmt:message key="notification.vpc" bundle="${msg}" />.</h4>
     			</div>
     		</div>
     		<div class="row form-group">
           		<div class="col-md-6 col-sm-12">
           			<span class="control-label"><fmt:message key="physical.network" bundle="${msg}" /></span>
           		</div>
           		<div class="col-md-6 col-sm-12">
           			<select class="form-control" name="account">
		                <option>option 1</option>
		                <option>option 2</option>
		                <option>option 3</option>
		                <option>option 4</option>
		            </select>
           		</div>
           	</div>
	        <div class="row form-group">
	            <div class="col-md-6 col-sm-12">
	            	<span class="control-label"><fmt:message key="vlan.vni" bundle="${msg}" /> <span class="text-danger font-bold" title="<fmt:message key="error.required" bundle="${msg}" />">*</span></span>
	            </div>
	            <div class="col-md-6 col-sm-12">
	            	<input class="form-control" type="text"  required="true">
	            </div>
	        </div>
	        <div class="row form-group">
           		<div class="col-md-6 col-sm-12">
           			<span class="control-label"><fmt:message key="ip.address" bundle="${msg}" /> <span class="text-danger font-bold" title="<fmt:message key="error.required" bundle="${msg}" />">*</span></span>
           		</div>
           		<div class="col-md-6 col-sm-12">
           			<input class="form-control" type="text"  required="true">
           		</div>
           	</div>
           	<div class="row form-group">
           		<div class="col-md-6 col-sm-12">
           			<span class="control-label"><fmt:message key="gateway" bundle="${msg}" /> <span class="text-danger font-bold" title="<fmt:message key="error.required" bundle="${msg}" />">*</span></span>
           		</div>
           		<div class="col-md-6 col-sm-12">
           			<input class="form-control" type="text"  required="true">
           		</div>
           	</div>
           	<div class="row form-group">
           		<div class="col-md-6 col-sm-12">
           			<span class="control-label"><fmt:message key="netmask" bundle="${msg}" /> <span class="text-danger font-bold" title="<fmt:message key="error.required" bundle="${msg}" />">*</span></span>
           		</div>
           		<div class="col-md-6 col-sm-12">
           			<input class="form-control" type="text"  required="true">
           		</div>
           	</div>
           	<div class="row form-group">
           		<div class="col-md-6 col-sm-12">
           			<span class="control-label"><fmt:message key="source.nat" bundle="${msg}" /></span>
           		</div>
           		<div class="col-md-6 col-sm-12">
           			<label> <input icheck type="checkbox" ng-model="main.check2"> </label>
           		</div>
           	</div>
           	<div class="row form-group">
           		<div class="col-md-6 col-sm-12">
           			<span class="control-label"><fmt:message key="acl" bundle="${msg}" /></span>
           		</div>
           		<div class="col-md-6 col-sm-12">
           			<select class="form-control" name="account">
		                <option>option 1</option>
		                <option>option 2</option>
		                <option>option 3</option>
		                <option>option 4</option>
		            </select>
           		</div>
           	</div>
           	<div class="row form-group text-center">
           		<a class="btn btn-default" ng-click="cancel()"> <fmt:message key="common.cancel" bundle="${msg}" /> </a>
				<button class="btn btn-info" type="submit"><fmt:message key="common.ok" bundle="${msg}" /></button>
           	</div>
	    </div>
    </div>