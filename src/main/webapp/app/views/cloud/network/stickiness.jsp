<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<form name="stickinessForm" data-ng-submit="addStickiness(stickinessForm, stickiness)" method="post" novalidate=""  >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header hide-zone="false" page-icon="fa fa-plus-circle" page-title="<fmt:message key="configure.sticky.policy" bundle="${msg}" />"></panda-modal-header>
        </div>
        <div class="modal-body">
            <div class="row"  >
                <div class="col-md-12">
	<div class="row">
                    <div class="form-group">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="stickiness.method" bundle="${msg}" />
							</label>
							<div class="col-md-6 col-xs-12 col-sm-6">
							<select class="form-control input-group" name="stickinessMethod"
											data-ng-model="stickiness.stickinessMethod"
											ng-options="stickinessMethod for (id,stickinessMethod) in formElements.stickinessList">
											<option value=""><fmt:message key="common.select"
													bundle="${msg}" /></option>
										</select>
      							</div>
						</div>
					</div>
                    <div class="form-group" ng-class="{'text-danger': stickinessForm.stickyName.$invalid && formSubmitted}" data-ng-show="stickiness.stickinessMethod == 'SourceBased' || stickiness.stickinessMethod == 'AppCookie'">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="sticky.name" bundle="${msg}" /> <span class="text-danger">*</span></label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input required="true" type="text" name="stickyName" data-ng-model="stickiness.stickinessName" class="form-control" data-ng-class="{'error': stickinessForm.stickyName.$invalid && formSubmitted}">
								<div class="error-area" data-ng-show="stickinessForm.stickyName.$invalid && formSubmitted">
									<i ng-attr-tooltip="{{ stickinessForm.stickyName.errorMessage || '<fmt:message key="sticky.name.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>
					</div>
                     <div class="form-group" data-ng-show="stickiness.stickinessMethod == 'SourceBased'">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="table.size" bundle="${msg}" /></label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input type="text" name="tableSize" data-ng-model="stickiness.stickyTableSize" class="form-control">
							</div>
						</div>
					</div>
					<div class="form-group" data-ng-show="stickiness.stickinessMethod == 'SourceBased'">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="expires" bundle="${msg}" /></label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input type="text" name="expires" data-ng-model="stickiness.stickyExpires" class="form-control">
							</div>
						</div>
					</div>
					<div class="form-group" data-ng-show="stickiness.stickinessMethod == 'LbCookie' || stickiness.stickinessMethod == 'AppCookie'">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="cookie.name" bundle="${msg}" /></label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input type="text" name="cookieName" data-ng-model="stickiness.cookieName" class="form-control">
							</div>
						</div>
					</div>
					<div class="form-group" data-ng-show="stickiness.stickinessMethod == 'LbCookie'  || stickiness.stickinessMethod == 'AppCookie'">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="mode" bundle="${msg}" /></label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input type="text" name="mode" data-ng-model="stickiness.stickyMode" class="form-control">
							</div>
						</div>
					</div>
					<div class="form-group" data-ng-show="stickiness.stickinessMethod == 'AppCookie'">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="length" bundle="${msg}" /></label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input type="text" name="length" data-ng-model="stickiness.stickyLength" class="form-control">
							</div>
						</div>
					</div>
					<div class="form-group" data-ng-show="stickiness.stickinessMethod == 'AppCookie'">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="hold.time" bundle="${msg}" /></label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input type="text" name="holdTime" data-ng-model="stickiness.stickyHoldTime" class="form-control">
							</div>
						</div>
					</div>
					<div class="form-group" data-ng-show="stickiness.stickinessMethod == 'AppCookie'">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="request.learn" bundle="${msg}" /></label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input icheck  data-ng-model="stickiness.stickyRequestLearn" name="requestLearn"  type="checkbox" />
							</div>
						</div>
					</div>
					<div class="form-group" data-ng-show="stickiness.stickinessMethod == 'AppCookie'">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="prefix" bundle="${msg}" /></label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input icheck  data-ng-model="stickiness.stickyPrefix" name="prefix"  type="checkbox" />
							</div>
						</div>
					</div>
					<div class="form-group" data-ng-show="stickiness.stickinessMethod == 'LbCookie' ">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="no.cache" bundle="${msg}" /></label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input icheck  data-ng-model="stickiness.stickyNoCache" name="noCache"  type="checkbox" />
							</div>
						</div>
					</div>
					<div class="form-group" data-ng-show="stickiness.stickinessMethod == 'LbCookie' ">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="indirect" bundle="${msg}" /></label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input icheck  data-ng-model="stickiness.stickyIndirect" name="indirect"  type="checkbox" />
							</div>
						</div>
					</div>
					<div class="form-group" data-ng-show="stickiness.stickinessMethod == 'LbCookie' ">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="post.only" bundle="${msg}" /></label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input icheck  data-ng-model="stickiness.stickyPostOnly" name="postOnly"  type="checkbox" />
							</div>
						</div>
					</div>
					<div class="form-group" data-ng-show="stickiness.stickinessMethod == 'LbCookie' ">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.domain" bundle="${msg}" /></label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input type="text" name="domain" data-ng-model="stickiness.stickyCompany" class="form-control">
							</div>
						</div>
					</div>
                </div>
            </div>
        </div>

        <div class="modal-footer">
            <button type="button" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
            <button class="btn btn-info" data-ng-show="stickiness.stickinessMethod == 'None'" type="button" data-ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.add" bundle="${msg}" /></button>
            <button class="btn btn-info" data-ng-hide="stickiness.stickinessMethod == 'None'" type="submit"><fmt:message key="common.add" bundle="${msg}" /></button>
        </div>
        </div>
        </div>
</form>





