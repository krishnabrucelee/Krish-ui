<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<form name="domainForm" data-ng-submit="update(domainForm)" method="post" novalidate="">
	<div class="inmodal" >
	<div class="modal-header">
		<panda-modal-header page-icon="fa fa-user-plus" hide-zone="false" page-title='Add Domain'></panda-modal-header>
	</div>
	<div class="modal-body">
	<div class="row"  >
	<div class="col-md-12">
			<div class="col-md-6 col-sm-6">
				<div class="form-group" ng-class="{'text-danger': domainForm.name.$invalid && formSubmitted}">
					<div class="row">
						<label class="col-md-4 col-sm-4 control-label">Company Name<span class="text-danger">*</span></label>
							<div class="col-md-6 col-sm-6">
								<input required="true" type="text" name="name" data-ng-model="domain.name" class="form-control" data-ng-class="{'error': domainForm.name.$invalid && formSubmitted}">
								<i tooltip="Name of the company" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
									<div class="error-area" data-ng-show="domainForm.name.$invalid && formSubmitted" >
										<i ng-attr-tooltip="{{ domainForm.name.errorMessage || 'Name required' }}" class="fa fa-warning error-icon"></i>
								</div>
							</div>
					</div>
				</div>

                <div class="form-group" ng-class="{'text-danger': domainForm.companyNameAbb.$invalid && formSubmitted}">
                	<div class="row">
						<label class="col-md-4 col-sm-4 control-label">Company Name Abbreviation <span class="text-danger">*</span></label>
							<div class="col-md-6 col-sm-6">
								<input required="true" type="text" name="companyNameAbb" data-ng-model="domain.companyNameAbbreviation" class="form-control" data-ng-class="{'error': domainForm.companyNameAbb.$invalid && formSubmitted}">
								<i tooltip="Abbreviation of the company name" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
									<div class="error-area" data-ng-show="domainForm.companyNameAbb.$invalid && formSubmitted" >
										<i ng-attr-tooltip="{{ domainForm.companyNameAbb.errorMessage || 'company Name Abbreviation required' }}" class="fa fa-warning error-icon"></i>
								</div>
							</div>
					</div>
                        </div>

                    <div class="form-group" >
                	<div class="row">
						<label class="col-md-4 col-sm-4 control-label">Portal User Name<span class="text-danger">*</span></label>
							<div class="col-md-6 col-sm-6">
								<i tooltip="Name of the portal user" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
									{{domain.hod.userName}}
							</div>
					</div>
                    </div>



                    <div class="form-group" ng-class="{'text-danger': domainForm.cityHeadquarter.$invalid && formSubmitted}">
                	<div class="row">
						<label class="col-md-4 col-sm-4 control-label">City of Headquarters<span class="text-danger">*</span></label>
							<div class="col-md-6 col-sm-6">
								<input required="true" type="text" name="cityHeadquarter" data-ng-model="domain.cityHeadquarter" class="form-control" data-ng-class="{'error': domainForm.cityHeadquarter.$invalid && formSubmitted}">
								<i tooltip="City head quarter of the company" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
									<div class="error-area" data-ng-show="domainForm.cityHeadquarter.$invalid && formSubmitted" >
										<i ng-attr-tooltip="{{ domainForm.cityHeadquarter.errorMessage || 'City head quarter required' }}" class="fa fa-warning error-icon"></i>
								</div>
							</div>
					</div>
                    </div>
                    	<div class="form-group" ng-class="{'text-danger': domainForm.companyAddress.$invalid && formSubmitted}">
                	<div class="row">
						<label class="col-md-4 col-sm-4 control-label">Company Address<span class="text-danger">*</span></label>
							<div class="col-md-6 col-sm-6">
								<input type="text" name="companyAddress" data-ng-model="domain.companyAddress" class="form-control" data-ng-class="{'error': domainForm.companyAddress.$invalid && formSubmitted}">
								<i tooltip="Company address of the company" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
									<div class="error-area" data-ng-show="domainForm.companyAddress.$invalid && formSubmitted" >
										<i ng-attr-tooltip="{{ domainForm.companyAddress.errorMessage || 'Company Address required' }}" class="fa fa-warning error-icon"></i>
								</div>
							</div>
					</div>
                    </div>

                    </div>

				<!-- Second column -->

                <div class="col-md-6 col-sm-6">



                <div class="form-group" >
                	<div class="row">
						<label class="col-md-4 col-sm-4 control-label">Primary Contact First Name</label>
							<div class="col-md-6 col-sm-6">
								<i tooltip="Primary first name of the company" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
									{{domain.hod.firstName}}

							</div>
					</div>
                    </div>

                    <div class="form-group">
                	<div class="row">
						<label class="col-md-4 col-sm-4 control-label">Last Name</label>
							<div class="col-md-6 col-sm-6">
								<i tooltip="Last name of the company" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
								{{domain.hod.lastName}}
							</div>
					</div>
                    </div>

                    <div class="form-group" ng-class="{'text-danger': domainForm.email.$invalid && formSubmitted}">
                	<div class="row">
						<label class="col-md-4 col-sm-4 control-label">Email<span class="text-danger">*</span></label>
							<div class="col-md-6 col-sm-6">
								<i tooltip="Email of the company" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
									{{domain.hod.email}}
							</div>
					</div>
                    </div>

                    <div class="form-group" ng-class="{'text-danger': domainForm.phone.$invalid && formSubmitted}">
                	<div class="row">
						<label class="col-md-4 col-sm-4 control-label">Phone<span class="text-danger">*</span></label>
							<div class="col-md-6 col-sm-6">
								<input required="true" type="text" name="phone" data-ng-model="domain.phone" class="form-control" data-ng-class="{'error': domainForm.phone.$invalid && formSubmitted}">
								<i tooltip="Phone of the company" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
									<div class="error-area" data-ng-show="domainForm.phone.$invalid && formSubmitted" >
										<i ng-attr-tooltip="{{ domainForm.phone.errorMessage || 'Phone required' }}" class="fa fa-warning error-icon"></i>
								</div>
							</div>
					</div>
                    </div>

                    <div class="form-group" ng-class="{'text-danger': domainForm.secondaryContact.$invalid && formSubmitted}">
                	<div class="row">
						<label class="col-md-4 col-sm-4 control-label">Secondary Contact<span class="text-danger">*</span></label>
							<div class="col-md-6 col-sm-6">
								<input type="text" name="secondaryContact" data-ng-model="domain.secondaryContact" class="form-control" data-ng-class="{'error': domainForm.secondaryContact.$invalid && formSubmitted}">
								<i tooltip="Secondary contact of the company" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
									<div class="error-area" data-ng-show="domainForm.secondaryContact.$invalid && formSubmitted" >
										<i ng-attr-tooltip="{{ domainForm.secondaryContact.errorMessage || 'Secondary contact required' }}" class="fa fa-warning error-icon"></i>
								</div>
							</div>
					</div>
                    </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="modal-footer">

            <a class="btn btn-default"  data-ng-click="cancel()"><fmt:message key="common.cancel" bundle="${msg}" /></a>
            <button class="btn btn-info" type="submit"><fmt:message key="common.add" bundle="${msg}" /></button>
        </div>

    </div>
</form>