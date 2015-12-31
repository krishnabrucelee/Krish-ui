<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<form name="instanceForm" data-ng-submit=" " method="post" novalidate=""
	data-ng-controller="instanceCtrl">
    <div data-ng-if= "showLoaderDetail" style="margin: 40%">
      <get-loader-image-detail data-ng-show="showLoaderDetail"></get-loader-image-detail>
      </div>
	<div data-ng-if = "!showLoaderDetail" class="m-t-sm">
		<div class="row form-group required"
			ng-class="{ 'text-danger' : instanceTemplateForm.name.$invalid && templateFormSubmitted}">
			<div class="col-md-5 col-xs-5 col-sm-5">
				<span class="control-label"><fmt:message key="instance.name"
						bundle="${msg}" /><span title="<fmt:message key="common.required" bundle="${msg}" />"
					class="text-danger font-bold">*</span></span>
			</div>
			<div class="col-md-6 col-xs-6 col-sm-6">
				<input required="true" type="text" name="name"
					data-ng-model="instance.name" class="form-control col-md-4"
					autofocus
					data-ng-class="{'error': instanceTemplateForm.name.$invalid && templateFormSubmitted}">
				<i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"
					tooltip="<fmt:message key="name.of.the.instance" bundle="${msg}" />"></i>
				<div class="error-area"
					data-ng-show="instanceTemplateForm.name.$invalid && templateFormSubmitted">
					<i tooltip="<fmt:message key="instance.name.is.required" bundle="${msg}" />"
						class="fa fa-warning error-icon"></i>
				</div>
			</div>
		</div>
		<div class="row  form-group required"  data-ng-if="global.sessionValues.type == 'ROOT_ADMIN'"
			ng-class="{ 'text-danger' : !instance.domain && templateFormSubmitted}">
			<div class="col-md-5 col-xs-5 col-sm-5">
				<span class="control-label"><fmt:message
						key="common.domain" bundle="${msg}" /><span title="<fmt:message key="common.required" bundle="${msg}" />"
					class="text-danger font-bold">*</span></span>
			</div>
			<div class="col-md-6 col-xs-6 col-sm-6">
					<div  data-ng-class="{'error': !instance.domain && templateFormSubmitted}" custom-select="t as t.name for t in formElements.domainList | filter: { name: $searchTerm }" data-ng-model="instance.domain">
						<div class="pull-left">
						<strong>{{ t.name }}</strong><br />
						</div>
						<div class="clearfix"></div>
						</div>
				<i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"
					tooltip="<fmt:message key="choose.domain" bundle="${msg}" />"></i>
				<div class="error-area"
					data-ng-show="!instance.domain && templateFormSubmitted">
					<i
						tooltip="<fmt:message key="domain.is.required" bundle="${msg}" />"
						class="fa fa-warning error-icon"></i>
				</div>
			</div>
		</div>

        <div data-ng-if="global.sessionValues.type == 'USER'">
				<div class="form-group" >
				<div class="col-md-5 col-xs-5 col-sm-5">
				<span class="control-label"><fmt:message key="department.name" bundle="${msg}" /></span>
				</div>
				<div class="col-md-6 col-xs-6 col-sm-6">
	                  <span class="control-label font-bold">{{instance.department.userName}}</span>
	             </div>
	          </div>
        </div>
		<div data-ng-if="global.sessionValues.type !== 'USER'">
			<div class="row  form-group required" ng-class="{ 'text-danger' : !instance.department && templateFormSubmitted}">
			<div class="col-md-5 col-xs-5 col-sm-5">
				<span class="control-label"><fmt:message
						key="department.name" bundle="${msg}" /><span title="<fmt:message key="common.required" bundle="${msg}" />"
					class="text-danger font-bold">*</span></span>
			</div>
			<div class="col-md-6 col-xs-6 col-sm-6">
						<div  data-ng-class="{'error': !instance.department && templateFormSubmitted}" custom-select="t as t.userName for t in formElements.departmenttypeList | filter: { name: $searchTerm }" ng-model="instance.department">
						<div class="pull-left">
						<strong>{{ t.userName }}</strong><br />
						</div>
						<div class="clearfix"></div>
						</div>
				<i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"
					tooltip="<fmt:message key="department.name" bundle="${msg}" />"></i>
				<div class="error-area"
					data-ng-show="!instance.department && templateFormSubmitted">
					<i
						tooltip="<fmt:message key="department.name.is.required" bundle="${msg}" />"
						class="fa fa-warning error-icon"></i>
				</div>
			</div>
		</div>
		</div>

		<div data-ng-if="global.sessionValues.type == 'USER'">
				<div class="form-group" >
				<div class="col-md-5 col-xs-5 col-sm-5">
				<span class="control-label"><fmt:message key="instance.owner" bundle="${msg}" /></span>
				</div>
				<div class="col-md-6 col-xs-6 col-sm-6">
	                  <span class="control-label font-bold">{{instance.instanceOwner.userName}}</span>
	             </div>
	          </div>
        </div>
        <div data-ng-if="global.sessionValues.type !== 'USER'">
		<div class="row form-group required"
			ng-class="{ 'text-danger' : !instance.instanceOwner && templateFormSubmitted}">
			<div class="col-md-5 col-xs-5 col-sm-5">
				<span class="control-label"><fmt:message key="instance.owner"
						bundle="${msg}" /><span title="<fmt:message key="common.required" bundle="${msg}" />"
					class="text-danger font-bold">*</span></span>
			</div>
			<div class="col-md-6 col-xs-6 col-sm-6">
					<div  data-ng-class="{'error': !instance.instanceOwner && templateFormSubmitted}" custom-select="t as t.userName for t in formElements.instanceOwnerList | filter: { userName: $searchTerm }" ng-model="instance.instanceOwner">
						<div class="pull-left">
						<strong>{{ t.userName }}</strong><br />
						</div>
						<div class="clearfix"></div>
						</div>
				<li class="selectlist" ng-repeat="item in search.users" style = "list-style:none;padding: 5px;"><a  data-ng-click="setUser(item)" >{{ item.userName }}</a></li>
			</ul>
				<i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"
					tooltip="<fmt:message key="name.of.the.owner" bundle="${msg}" />"></i>
				<div class="error-area"
					data-ng-show="!instance.instanceOwner && templateFormSubmitted">
					<i
						tooltip="<fmt:message key="owner.name.is.required" bundle="${msg}" />"
						class="fa fa-warning error-icon"></i>
				</div>
			</div>
		</div>
		</div>


		<div class="row  form-group required"
			ng-class="{ 'text-danger' : instanceTemplateForm.application.$invalid && templateFormSubmitted}">
			<div class="col-md-5 col-xs-5 col-sm-5">
				<span class="control-label"><fmt:message
						key="application.name" bundle="${msg}" /><span title="<fmt:message key="common.required" bundle="${msg}" />"
					class="text-danger font-bold">*</span></span>

			</div>
			<div class="col-md-6 col-xs-6 col-sm-6">
				<input required="true" type="text" name="application"
					data-ng-model="instance.application" class="form-control col-md-4"
					autofocus
					data-ng-class="{'error': instanceTemplateForm.application.$invalid && templateFormSubmitted}">
				<i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"
					tooltip="<fmt:message key="name.of.the.application" bundle="${msg}" />"></i>
				<div class="error-area"
					data-ng-show="instanceTemplateForm.application.$invalid && templateFormSubmitted">
					<i
						tooltip="<fmt:message key="application.name.is.required" bundle="${msg}" />"
						class="fa fa-warning error-icon"></i>
				</div>
			</div>
		</div>



		<div class="row  form-group required"
			ng-class="{ 'text-danger' : !instance.applicationList && templateFormSubmitted}">
			<div class="col-md-12 col-xs-12 col-sm-12">
				<span class="control-label"><fmt:message key="application.type" bundle="${msg}" /><span
					title="<fmt:message key="common.required" bundle="${msg}" />" class="text-danger font-bold">*</span></span> <i
					class="pe-7s-help1 pe-lg m-r-xs pull-right"
					tooltip="<fmt:message key="type.of.the.application" bundle="${msg}" />"></i>
				<div class="m-t-sm">
				<select required="true" multiple="multiple" class="form-control input-group" name="applicationList" data-ng-model="instance.applicationList" ng-options="applicationList.type for applicationList in formElements.applicationsList" data-ng-class="{'error': instanceTemplateForm.applicationList.$invalid && templateFormSubmitted}" >
                <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                </select>
				</div>
			</div>
		</div>

		<div class="row  form-group">
			<div class="col-md-5 col-xs-5 col-sm-5">

				<span class="control-label"><fmt:message key="project.name" bundle="${msg}" /></span>
			</div>
			<div class="col-md-6 col-xs-6 col-sm-6"><!--
				<input type="text" name="project" data-ng-model="instance.projct"
					class="form-control col-md-4" autofocus autocomplete="off"> -->
						<div  custom-select="t as t.name for t in formElements.projecttypeList | filter: { name: $searchTerm }" data-ng-model="instance.project">
						<div class="pull-left">
						<strong>{{ t.name }}</strong><br />
						</div>
						<div class="clearfix"></div>
						</div>
<!--
				<ul data-ng-show="search.projects.length > 0" style = "padding: 10px; z-index:1000; width: 83%; margin-left:1px; height:150px; overflow:scroll; overflow-x:hidden; background: #FFF none repeat scroll 0% 0%; box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.3); margin-bottom: 30px; position:absolute; margin-top:30px;">
				<li ng-repeat="item in search.projects" style = "list-style:none;padding: 5px;"><a  data-ng-click="setProject(item)" >{{ item.name }}</a></li>
				</ul> -->
				<i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="name.of.the.project" bundle="${msg}" />"></i>

			</div>


		</div>

		<div class="h-90"></div>

		<div class="pull-right">
			<a class="btn btn-default" ng-click="cancel()"> <fmt:message key="common.cancel" bundle="${msg}" /> </a>
			<button type="submit" class="btn btn-info"><fmt:message key="common.next" bundle="${msg}" /></button>
		</div>
	</div>
</form>