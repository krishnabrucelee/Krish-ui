<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<form name="sshkeyForm" data-ng-submit="save(sshkeyForm, sshkey)" method="post" novalidate="">

	<div class="inmodal">
		<div class="modal-header">
			<panda-modal-header page-icon="fa fa-plus-circle"
				page-title="<fmt:message key="create.ssh.key.pair" bundle="${msg}" />"></panda-modal-header>
		</div>

		<div class="modal-body">
			<div class="row" >
                    <div class="col-md-12 col-sm-12 pull-left m-b-sm">
                    <label><fmt:message key="note" bundle="${msg}" />:</label>
                     <div>(1) <fmt:message key="if.public.key.is.set.panda.will.register.the.public.key.you.can.use.it.through.your.private.key" bundle="${msg}" />.</div>
                    <div>(2) <fmt:message key="if.public.key.is.not.set.panda.will.create.a.new.ssh.key.pair.in.this.case.please.copy.and.save.the.private.key.panda.will.not.keep.it" bundle="${msg}" />.</div>
                    </div>
            </div>
				<div class="row m-t-lg">
				<div class="col-md-12">
					<div class="form-group" ng-class="{'text-danger': sshkeyForm.name.$invalid && formSubmitted}">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.name" bundle="${msg}" /> <span class="text-danger">*</span></label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input required="true" type="text" name="name" data-ng-model="sshkey.name" class="form-control" data-ng-class="{'error': sshkeyForm.name.$invalid && formSubmitted}">
								<i tooltip="<fmt:message key="name.of.the.ssh.key" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
								<div class="error-area" data-ng-show="sshkeyForm.name.$invalid && formSubmitted">
									<i ng-attr-tooltip="{{ sshkeyForm.name.errorMessage || '<fmt:message key="ssh.key.name.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.public.key" bundle="${msg}" />
							</label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input type="text" name="publicKey" data-ng-model="sshkey.publicKey" class="form-control">
								<i tooltip="<fmt:message key="common.public.key" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
							</div>
						</div>
					</div>
					 <div data-ng-if="global.sessionValues.type == 'DOMAIN_ADMIN'">
						<div class="form-group">
							<div class="row">
                            	<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.domain" bundle="${msg}" /><span class="text-danger">*</span></label>
                            	<div class="col-md-6  col-sm-6 col-xs-12">
                                {{ global.sessionValues.domainName }}
                                <input type="hidden" name="domain"  data-ng-model="sshkey.domain" data-ng-init="sshkey.domainId=global.sessionValues.domainId" />
                            	</div>
                        	</div>
                        </div>
	                	</div>

					<div data-ng-if=" global.sessionValues.type == 'ROOT_ADMIN'">
                    <div class="form-group" ng-class="{'text-danger':!sshkey.domain && formSubmitted}">
                        <div class="row">
						    <label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.domain" bundle="${msg}" /> <span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
                               <select required="true" class="form-control input-group" name="domain" data-ng-change="domainChange()" data-ng-model="sshkey.domain" ng-options="domain.name for domain in formElements.domainList" data-ng-class="{'error': !sshkey.domain && formSubmitted}" >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>

                                </select>
                                <i  tooltip="<fmt:message key="choose.domain" bundle="${msg}" /> " class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area" data-ng-show="!sshkey.domain && formSubmitted" ><i  tooltip="<fmt:message key="domain.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>
                    </div>

                    <div data-ng-if="global.sessionValues.type == 'ROOT_ADMIN'">
                        <div class="form-group"ng-class="{'text-danger': !sshkey.department && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.department" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-6 col-xs-12 col-sm-6">
                                    <select required="true" class="form-control input-group" ng-change="getProjectsByDepartment(sshkey.department)"
                                     name="department" data-ng-model="sshkey.department" ng-options="department.userName for department in formElements.departmentList" data-ng-class="{'error': !sshkey.department && formSubmitted}">
                                        <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                    </select>
                                    <i  tooltip="<fmt:message key="department.name" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="!sshkey.department && formSubmitted" >
                                    	<i tooltip="<fmt:message key="department.is.required" bundle="${msg}" />"
												class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </div>
                        <div data-ng-if="global.sessionValues.type == 'DOMAIN_ADMIN'">
                        <div class="form-group"ng-class="{'text-danger': !sshkey.department && formSubmitted}">
                            <div class="row">
                                <label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.department" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-6 col-xs-12 col-sm-6">
                                    <select required="true" class="form-control input-group" ng-change="getProjectsByDepartment(sshkey.department)"
                                     name="department" data-ng-model="sshkey.department" ng-options="department.userName for department in departmentList" data-ng-class="{'error': !sshkey.department && formSubmitted}" >
                                        <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>

                                    </select>
                                    <i  tooltip="<fmt:message key="department.name" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <div class="error-area" data-ng-show="!sshkey.department && formSubmitted" >
                                    	<i tooltip="<fmt:message key="department.is.required" bundle="${msg}" />"
												class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </div>
                        <div data-ng-if="global.sessionValues.type == 'USER'">
                        <div class="form-group">
                            <div class="row">
                                <label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="common.department" bundle="${msg}" /><span class="text-danger">*</span></label>
                                <div class="col-md-6 col-xs-12 col-sm-6">
                                {{ userElement.department.userName }}
                                <input type="hidden" name="department"  data-ng-model="sshkey.department" data-ng-init="sshkey.departmentId=global.sessionValues.departmentId" />
                            	</div>
                            </div>
                        </div>
                        </div>
                        <div class="form-group">
						<div class="row">
							<div data-ng-if="global.sessionValues.type != 'USER'">
								<label class="col-md-3 col-xs-12 col-sm-3 control-label">
									<fmt:message key="common.project" bundle="${msg}" /> <span class="m-l-xs"></span>
								</label>
								<div class="col-md-6 col-xs-12 col-sm-6">
									<select class="form-control input-group" name="project"
										data-ng-model="sshkey.project"
										data-ng-options="options.name for options in options">
										<option value="">
											<fmt:message key="common.select" bundle="${msg}" />
										</option>
									</select>
									<i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"
										tooltip="<fmt:message key="common.project" bundle="${msg}" />">
									</i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<div data-ng-if="global.sessionValues.type == 'USER'">
								<label class="col-md-3 col-xs-12 col-sm-3 control-label">
									<fmt:message key="common.project" bundle="${msg}" /> <span class="m-l-xs"></span>
								</label>
								<div class="col-md-6 col-xs-12 col-sm-6">
									<select class="form-control input-group" name="project"
										data-ng-model="sshkey.project"
										data-ng-options="options.name for options in options">
										<option value="">
											<fmt:message key="common.select" bundle="${msg}" />
										</option>
									</select>
									<i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"
										tooltip="<fmt:message key="common.project" bundle="${msg}" />">
									</i>
								</div>
							</div>
						</div>
					</div>

			</div>
				</div>
		</div>

		<div class="modal-footer">
		    <get-loader-image data-ng-if="showLoader"></get-loader-image>
			<button type="button" data-ng-if="!showLoader" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
			<button class="btn btn-info"  data-ng-if="!showLoader" type="submit"><fmt:message key="common.add" bundle="${msg}" /></button>
		</div>
	</div>
</form>

