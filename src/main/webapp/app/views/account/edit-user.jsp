<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<form name="userForm" data-ng-submit="saveUser(user)" method="post" novalidate="">
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-user" hide-zone="false"  page-title="<fmt:message key="edit.user" bundle="${msg}" />"></panda-modal-header>
        </div>
        <div class="modal-body">
            <div class="row"  >
                <div class="col-md-12">
              	<div class="form-group" ng-class="{'text-danger': userForm.username.$invalid && formSubmitted}">
					<div class="row">
						<label class="col-md-4 col-sm-4 control-label"><fmt:message key="user.name" bundle="${msg}" /><span class="text-danger">*</span></label>
							<div class="col-md-6 col-sm-6">
								<input required="true" type="text" name="username" data-ng-model="user.userName" class="form-control" data-ng-class="{'error': userForm.username.$invalid && formSubmitted}">
								<i tooltip="<fmt:message key="user.name.of.the.user" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
									<div class="error-area" data-ng-show="userForm.username.$invalid && formSubmitted" >
										<i ng-attr-tooltip="{{ userForm.username.errorMessage || '<fmt:message key="user.name.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
								</div>
							</div>
					</div>
				</div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
        	                       									<get-loader-image data-ng-show="showLoader"></get-loader-image>
        	
            <a class="btn btn-default"  data-ng-hide="showLoader" data-ng-click="cancel()"><fmt:message key="common.cancel" bundle="${msg}" /></a>
            <button class="btn btn-info"data-ng-hide="showLoader"  type="submit"><fmt:message key="common.update" bundle="${msg}" /></button>
        </div>
    </div>

</form>