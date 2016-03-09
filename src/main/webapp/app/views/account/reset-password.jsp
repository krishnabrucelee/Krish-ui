<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<form name="profileForm" data-ng-submit="updatePassword(profileForm, profile)" method="post" novalidate="">
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-user" hide-zone="false"  page-title="<fmt:message key="reset.password" bundle="${msg}" />"></panda-modal-header>
        </div>
        <div class="modal-body">
            <div class="row"  >
                <div class="col-md-12">
					<div class="form-group"
						data-ng-class="{ 'text-danger' : profileForm.newpassword.$invalid && formSubmitted}">
						<div class="row">
							<label class="col-md-4 col-sm-4 control-label"> <span
								class="pull-right"><fmt:message key="new.password"
										bundle="${msg}" /><span class="text-danger">*</span></span>
							</label>
							<div class="col-md-6 col-sm-6 col-xs-6">
								<input required="true" type="password" name="newpassword"
									data-ng-model="profile.newPassword" class="form-control"
									data-ng-class="{'error': profileForm.newpassword.$invalid && formSubmitted}" />
								<div class="error-area"
									data-ng-show="profileForm.newpassword.$invalid && formSubmitted">
									<i
										ng-attr-tooltip="{{ profileForm.newpassword.errorMessage || '<fmt:message key="new.password.is.required" bundle="${msg}" />' }}"
										class="fa fa-warning error-icon"> </i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group"
						data-ng-class="{ 'text-danger' : profileForm.confirmPassword.$invalid && formSubmitted}">
						<div class="row">
							<label class="col-md-4 col-sm-4 control-label"> <span
								class="pull-right"><fmt:message key="confirm.password"
										bundle="${msg}" /><span class="text-danger">*</span></span>
							</label>
							<div class="col-md-6 col-sm-6 col-xs-6">
								<input required="true" type="password" name="confirmPassword"
									data-ng-model="profile.confirmPassword" class="form-control"
									data-ng-class="{'error': profileForm.confirmPassword.$invalid && formSubmitted}" />
								<div class="error-area"
									data-ng-show="profileForm.confirmPassword.$invalid && formSubmitted">
									<i
										ng-attr-tooltip="{{ profileForm.confirmPassword.errorMessage || '<fmt:message key="confirm.password.is.required" bundle="${msg}" />' }}"
										class="fa fa-warning error-icon"> </i>
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