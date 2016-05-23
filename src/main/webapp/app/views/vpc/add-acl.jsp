<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="networkAclForm" method="POST" data-ng-submit="save(networkAclForm, networkAcl)" novalidate >
<div class="inmodal ">
    <div class="modal-header">
        <panda-modal-header page-icon="fa fa-soundcloud"
			page-title="<fmt:message key="add.acl.list" bundle="${msg}" />">
        </panda-modal-header>
    </div>
    <div class="modal-body">
     	<div data-ng-show="showLoader" style="margin: 20%">
		    <get-loader-image data-ng-show="showLoader"></get-loader-image>
		</div>
     	<div data-ng-hide="showLoader">
	        <%-- <div class="row form-group">
	            <div class="col-md-6 col-sm-12">
	            	<span class="control-label"><fmt:message key="acl.list.name" bundle="${msg}" /> <span class="text-danger font-bold" title="<fmt:message key="error.required" bundle="${msg}" />">*</span></span>
	            </div>
	            <div class="col-md-6 col-sm-12">
	            	<input class="form-control" type="text"  required="true">
	            </div>
	        </div> --%>

	        <div class="form-group" data-ng-class="{ 'text-danger' : networkAclForm.name.$invalid && formSubmitted}">
                        <div class="row">
                            <label  class="col-md-3 col-xs-12 col-sm-2 control-label"><fmt:message key="acl.list.name" bundle="${msg}" />
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <input required="true" type="text" name="name" data-ng-model="networkAcl.name" class="form-control" data-ng-class="{'error': networkAclForm.name.$invalid && formSubmitted}" >
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="common.name" bundle="${msg}" />" ></i>
                                <div class="error-area" data-ng-show="networkAclForm.name.$invalid && formSubmitted" >
                                <i ng-attr-tooltip="{{ networkAclForm.name.errorMessage || '<fmt:message key="network.acl.list.name.is.required" bundle="${msg}" />' }}"
									class="fa fa-warning error-icon">
								</i>
							</div>
                            </div>
                        </div>
                    </div>
<div class="form-group" data-ng-class="{ 'text-danger' : networkAclForm.description.$invalid && formSubmitted}">
                        <div class="row">
                            <label  class="col-md-3 col-xs-12 col-sm-2 control-label"><fmt:message key="common.description" bundle="${msg}" />
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <input required="true" type="text" name="description" data-ng-model="networkAcl.description" class="form-control" data-ng-class="{'error': networkAclForm.description.$invalid && formSubmitted}" >
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="common.description" bundle="${msg}" />" ></i>
                                <div class="error-area" data-ng-show="networkAclForm.description.$invalid && formSubmitted" >
                                <i ng-attr-tooltip="{{ networkAclForm.description.errorMessage || '<fmt:message key="network.acl.list.description.is.required" bundle="${msg}" />' }}"
									class="fa fa-warning error-icon">
								</i>
							</div>
                            </div>
                        </div>
                    </div>

<%-- 	        <div class="row form-group">
           		<div class="col-md-6 col-sm-12">
           			<span class="control-label"><fmt:message key="common.description" bundle="${msg}" /><span class="text-danger font-bold" title="<fmt:message key="error.required" bundle="${msg}" />">*</span></span>
           		</div>
           		<div class="col-md-6 col-sm-12">
           			<input class="form-control" type="text"  required="true">
           		</div>
           	</div> --%>
           	<div class="row form-group text-center">
           		<a class="btn btn-default" ng-click="cancel()"> <fmt:message key="common.cancel" bundle="${msg}" /> </a>
				<%-- <button class="btn btn-info" type="submit"><fmt:message key="common.ok" bundle="${msg}" /></button> --%>
				<button class="btn btn-info" data-ng-hide="showLoader" type="submit"><fmt:message key="common.add" bundle="${msg}" /></button>
           	</div>
	    </div>
    </div>
   </div>
</form>