<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="addvpcForm"
	data-ng-submit="save(addvpcForm, vpc)" method="post"
	novalidate="">
<div class="inmodal ">
    <div class="modal-header">
        <panda-modal-header id="add_vpc_page_title" page-icon="fa fa-soundcloud"
			page-title="<fmt:message key="add.vpc" bundle="${msg}" />">
        </panda-modal-header>
    </div>
    <div class="modal-body">
     	<div>
	           	<div class="form-group"
						ng-class="{'text-danger':addvpcForm.name.$invalid && formSubmitted}">
						<div class="row">
							<label
								class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message key="common.name" bundle="${msg}" /><span class="text-danger">*</span></label>
							<div class="col-md-6  col-sm-6 col-xs-12">
								<input type="text" id="add_vpc_name" name="name" data-ng-model="vpc.name" required="true" class="form-control"
									data-ng-class="{'error': addvpcForm.name.$invalid && formSubmitted}"> <i tooltip="<fmt:message key="enter.name.of.the.vpc" bundle="${msg}" /> "
									class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
								<div class="error-area"
									data-ng-show="addvpcForm.name.$invalid && formSubmitted">
									<i tooltip="<fmt:message key="name.is.required" bundle="${msg}" />"
										class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>
					</div>
           	<div class="form-group"
						ng-class="{'text-danger':addvpcForm.description.$invalid && formSubmitted}">
						<div class="row">
							<label
								class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message key="common.description" bundle="${msg}" /><span class="text-danger">*</span></label>
							<div class="col-md-6  col-sm-6 col-xs-12">
								<input class="form-control" id="add_vpc_description" type="text" name="description" data-ng-model="vpc.description"  required="true" data-ng-class="{'error': addvpcForm.description.$invalid && formSubmitted}"> <i tooltip="<fmt:message key="enter.description.of.the.vpc" bundle="${msg}" />"
									class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
								<div class="error-area"
									data-ng-show="addvpcForm.description.$invalid && formSubmitted">
									<i tooltip="<fmt:message key="description.is.required" bundle="${msg}" />"
										class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>
					</div>
          <div class="form-group"
						ng-class="{'text-danger':addvpcForm.zone.$invalid && formSubmitted}">
						<div class="row">
							<label
								class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message
									key="common.zone" bundle="${msg}" /><span class="text-danger">*</span></label>
							<div class="col-md-6  col-sm-6 col-xs-12">
								<select required="true" id="add_vpc_zone" class="form-control input-group"
									name="zone" data-ng-model="vpc.zone"
									ng-options="zone.name for zone in zoneList"
									data-ng-class="{'error': addvpcForm.zone.$invalid && formSubmitted}">
									<option value=""><fmt:message key="common.select"
											bundle="${msg}" /></option>
								</select> <i tooltip="<fmt:message key="choose.zone" bundle="${msg}" /> "
									class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
								<div class="error-area"
									data-ng-show="addvpcForm.zone.$invalid && formSubmitted">
									<i
										tooltip="<fmt:message key="zone.is.required" bundle="${msg}" />"
										class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group"
						ng-class="{'text-danger':addvpcForm.cIDR.$invalid && formSubmitted}">
						<div class="row">
							<label
								class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message key="super.cidr" bundle="${msg}" /><span class="text-danger">*</span></label>
							<div class="col-md-6  col-sm-6 col-xs-12">
								<input class="form-control" id="add_vpc_cIDR" type="text" name="cIDR" data-ng-model="vpc.cIDR" required="true" data-ng-class="{'error': addvpcForm.cIDR.$invalid && formSubmitted}"> <i tooltip="<fmt:message key="enter.super.cidr" bundle="${msg}" />"
									class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
								<div class="error-area"
									data-ng-show="addvpcForm.cIDR.$invalid && formSubmitted">
									<i tooltip="<fmt:message key="super.cidr.is.required" bundle="${msg}" />"
										class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<label
								class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message key="dns.domain" bundle="${msg}" /></label>
							<div class="col-md-6  col-sm-6 col-xs-12">
								<input class="form-control" id="add_vpc_network_domain" type="text" name="networkDomain" data-ng-model="vpc.networkDomain" > <i tooltip="<fmt:message key="enter.dns.for.guest.networks" bundle="${msg}" /> "
									class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>

							</div>
						</div>
					</div>
           	<!-- <div class="row form-group">
           		<div class="col-md-6 col-sm-12">
           			<span class="control-label">Public Load Balancer Provider</span>
           		</div>
           		<div class="col-md-6 col-sm-12">
           			<select class="form-control" name="account">
		                <option>option 1</option>
		                <option>option 2</option>
		                <option>option 3</option>
		                <option>option 4</option>
		            </select>
           		</div>
           	</div> -->
           	<div class="form-group"
						ng-class="{'text-danger':addvpcForm.vpcoffering.$invalid && formSubmitted}">
						<div class="row">
							<label
								class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message key="vpc.offering" bundle="${msg}" /><span
								class="text-danger">*</span></label>
							<div class="col-md-6  col-sm-6 col-xs-12">
								<select required="true" class="form-control input-group" id="add_vpc_vpc_offering"
									name="vpcoffering" data-ng-model="vpc.vpcoffering"
									ng-options="vpcoffering.displayText for vpcoffering in networkOfferList"
									data-ng-class="{'error': addvpcForm.vpcoffering.$invalid && formSubmitted}">
									<option value=""><fmt:message key="common.select"
											bundle="${msg}" /></option>
								</select> <i
									tooltip="<fmt:message key="choose.vpc.offering" bundle="${msg}" />"
									class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
								<div class="error-area"
									data-ng-show="addvpcForm.vpcoffering.$invalid && formSubmitted">
									<i
										tooltip="<fmt:message key="vpc.offering.is.required" bundle="${msg}" />"
										class="fa fa-warning error-icon"></i>
								</div>
							</div>
						</div>
			</div>
           	<div class="form-group">
						<div class="row" ng-class="{'text-danger':addvpcForm.domain.$invalid && formSubmitted}"
						 data-ng-if="global.sessionValues.type != 'USER'">
							<label
								class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message
									key="common.domain" bundle="${msg}" /><span
								class="text-danger">*</span></label>
							<div class="col-md-6  col-sm-6 col-xs-12">
								<select required="true" class="form-control input-group" name="domain" id="add_vpc_domain"
									data-ng-model="vpc.domain" data-ng-change="changedomain(vpc.domain)" data-ng-class="{'error': addvpcForm.domain.$invalid && formSubmitted}"

									ng-options="domain.name for domain in domainList">
									<option value=""><fmt:message key="common.select"
											bundle="${msg}" /></option>
								</select>
								<div class="error-area"
									data-ng-show="addvpcForm.domain.$invalid && formSubmitted">
									<i
										ng-attr-tooltip="{{ addvpcForm.company.errorMessage || '<fmt:message key="company.is.required" bundle="${msg}" />' }}"
										class="fa fa-warning error-icon"></i>
								</div>
								 <i
									tooltip="<fmt:message key="choose.domain" bundle="${msg}" /> "
									class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row"
							ng-class="{'text-danger':addvpcForm.department.$invalid && formSubmitted}"
							data-ng-show="global.sessionValues.type != 'USER'"
							data-ng-if="vpc.domain">
							<label
								class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message
									key="common.department" bundle="${msg}" /><span
								class="text-danger">*</span></label>
							<div class="col-md-6  col-sm-6 col-xs-12">
								<select required="true" class="form-control input-group" id="add_vpc_department"
									name="department" data-ng-model="vpc.department"
									data-ng-class="{'error': addvpcForm.department.$invalid && formSubmitted}"
									ng-options="department.userName for department in formElements.departmenttypeList">
									<option value=""><fmt:message key="common.select"
											bundle="${msg}" /></option>
								</select>
								<div class="error-area"
									data-ng-show="addvpcForm.department.$invalid && formSubmitted">
									<i
										ng-attr-tooltip="{{ addvpcForm.department.errorMessage || '<fmt:message key="department.is.required" bundle="${msg}" />' }}"
										class="fa fa-warning error-icon"></i>
								</div>
								<i
									tooltip="<fmt:message key="common.department" bundle="${msg}" /> "
									class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
							</div>
						</div>
						<div class="row"
							data-ng-show="global.sessionValues.type == 'USER'">
							<label
								class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message
									key="common.department" bundle="${msg}" /> </label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<label>{{vpc.department.userName}}</label>
								<input type="hidden" name="department" id="add_vpc_department"  data-ng-model="vpc.department" data-ng-init="vpc.departmentId=global.sessionValues.departmentId" />
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<label
								class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message
									key="common.project" bundle="${msg}" /></label>
							<div class="col-md-6  col-sm-6 col-xs-12">
								<select class="form-control input-group" name="project" id="add_vpc_project"
									data-ng-model="vpc.project"
									ng-options="project.name for project in projectList">
									<option value=""><fmt:message key="common.select"
											bundle="${msg}" /></option>
								</select> <i
									tooltip="<fmt:message key="choose.project" bundle="${msg}" /> "
									class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
							</div>
						</div>
					</div>
	    </div>
    </div>
    <div class="modal-footer">
			<get-loader-image data-ng-show="showLoader"></get-loader-image>
			<button type="button" data-ng-hide="showLoader" id="add_vpc_cancel_button"
				class="btn btn-default " ng-click="cancel()" data-dismiss="modal">
				<fmt:message key="common.cancel" bundle="${msg}" />
			</button>
			<button class="btn btn-info" id="add_vpc_add_button" data-ng-hide="showLoader" type="submit">
				<fmt:message key="common.add" bundle="${msg}" />
			</button>
		</div>
		</div>
		</form>