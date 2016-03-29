<!-- This is content container for nested view in UI-Router-->
<!-- You can put here any constant element in app content for example: Page title or breadcrum -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- Header -->
<div id="header" ng-include="'app/views/common/header.jsp'"></div>

<!-- Navigation -->
<aside id="menu" ng-include="'app/views/common/navigation.jsp'"></aside>

<!-- Main Wrapper -->
<div id="wrapper">
    <div small-header class="normalheader transition ng-scope small-header">
        <div class="hpanel" tour-step order="1" title="Page header" content="Place your page title and breadcrumb. Select small or large header or give the user choice to change the size." placement="bottom">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a ui-sref="dashboard"><fmt:message key="common.home" bundle="${msg}" /></a></li>
                        <li ng-repeat="state in $state.$current.path" ng-switch="$last || !!state.abstract" ng-class="{active: $last}">
                            <a ng-switch-when="false" href="{{state.url.format($stateParams)}}">{{state.data.pageTitle}}</a>
                            <span ng-switch-when="true">{{state.data.pageTitle}}</span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    {{ $state.current.data.pageTitle}}
                </h2>
                <small>{{ $state.current.data.pageDesc}}</small>
            </div>
        </div>
    </div>
    <div class="content">
    <form name="profileForm" method="POST">
        <div ui-view >
            <div class="row panel-body" ng-controller="profileCtrl">
                <input class="hidden" type="checkbox" ng-model="oneAtATime">
                <accordion close-others="false">
                    <accordion-group is-open="status.basic">
                        <accordion-heading>
                            <fmt:message key="basic.information" bundle="${msg}" /><i class="pull-right glyphicon" ng-class="{'glyphicon-chevron-down': status.basic, 'glyphicon-chevron-right': !status.basic}"></i>
                        </accordion-heading>
                        <div class="row">
                            <div class="col-md-7 col-sm-7 col-xs-7">
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right"><fmt:message key="common.username" bundle="${msg}" />:</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                           <!--  <input  type="text" name="user" data-ng-model="profile.userName" class="form-control" focus/> -->
											<label>{{profile.userName || '-' }}</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right"><fmt:message key="common.email" bundle="${msg}" />:</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <!-- <input  type="text" name="email" data-ng-model="profile.email" class="form-control" readonly/> -->
											<label>{{profile.email || '-' }}</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right"><fmt:message key="common.telephone" bundle="${msg}" />:</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <!-- <input  type="text" name="telephone" data-ng-model="profile.domain.phone" class="form-control" readonly/> -->
											<label>{{profile.domain.phone || '-' }}</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right"><fmt:message key="common.name" bundle="${msg}" />:</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <!-- <input  type="text" name="name" data-ng-model="profile.firstName" class="form-control" focus/> -->
											<label>{{profile.firstName || '-'}} {{profile.lastName || '-'}}</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right"><fmt:message key="common.company" bundle="${msg}" />:</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <!-- <input  type="text" name="company" data-ng-model="profile.domain.companyNameAbbreviation" class="form-control" /> -->
											<label>{{profile.domain.companyNameAbbreviation}}</label>
                                        </div>
                                    </div>
                                </div>
<!--                                 <div class="row">
                                    <div class="col-md-4 col-sm-4 col-xs-4"></div>
                                    <div class="col-md-6 col-sm-6 col-xs-6">
                                        <input  type="submit"   class="btn btn-info" value="Update"/>
                                    </div>
                                </div> -->

                            </div>


                        </div>
                    </accordion-group>
                    <accordion-group is-open="status.password">
                        <accordion-heading>
                            <fmt:message key="update.password" bundle="${msg}" /> <i class="pull-right glyphicon" ng-class="{'glyphicon-chevron-down': status.password, 'glyphicon-chevron-right': !status.password}"></i>
                        </accordion-heading>
                        <div class="row">
                            <div class="col-md-7 col-sm-7 col-xs-7">
                                <div class="form-group" data-ng-class="{ 'text-danger' : !profile.oldPassword && formSubmitted}">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right"><fmt:message key="old.password" bundle="${msg}" /><span class="text-danger">*</span></span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input  required="true" placeholder="password" type="password" name="oldPassword" data-ng-model="profile.oldPassword" class="form-control" data-ng-class="{'error': !profile.oldPassword && formSubmitted}"/>
                                <div class="error-area" data-ng-show="!profile.oldPassword && formSubmitted" >
                                <i ng-attr-tooltip="{{ profileForm.oldPassword.errorMessage || '<fmt:message key="old.password.is.required" bundle="${msg}" />' }}"
									class="fa fa-warning error-icon">
								</i>
							</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group" data-ng-class="{ 'text-danger' : !profile.newPassword && formSubmitted}">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right"><fmt:message key="new.password" bundle="${msg}" /><span class="text-danger">*</span></span>
                                        </label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input  required="true" type="password" name="newpassword" data-ng-model="profile.newPassword" class="form-control" data-ng-class="{'error': !profile.newPassword && formSubmitted}"/>
                                <div class="error-area" data-ng-show="!profile.newPassword && formSubmitted" >
                                <i ng-attr-tooltip="{{ profileForm.newpassword.errorMessage || '<fmt:message key="new.password.is.required" bundle="${msg}" />' }}"
									class="fa fa-warning error-icon">
								</i>
							</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group" data-ng-class="{ 'text-danger' : !profile.confirmPassword && formSubmitted}">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right"><fmt:message key="confirm.password" bundle="${msg}" /><span class="text-danger">*</span></span>
                                        </label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input  required="true" type="password" name="confirmPassword" data-ng-model="profile.confirmPassword" class="form-control"  data-ng-class="{'error': !profile.confirmPassword && formSubmitted}"/>
                                <div class="error-area" data-ng-show="!profile.confirmPassword && formSubmitted" >
                                <i ng-attr-tooltip="{{ profileForm.confirmPassword.errorMessage || '<fmt:message key="confirm.password.is.required" bundle="${msg}" />' }}"
									class="fa fa-warning error-icon">
								</i>
							</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4 col-sm-4 col-xs-4"></div>
                                    <div class="col-md-6 col-sm-6 col-xs-6">
                                        <button type="button"  data-ng-click="updatePassword(profileForm, profile)"  class="btn btn-info" value="Update"><fmt:message key="common.update" bundle="${msg}" /></button>
                                    </div>
                                </div>

                            </div>


                        </div> </accordion-group>
                        <accordion-group is-open="status.password">
                        <accordion-heading>
                            <fmt:message key="language.preference" bundle="${msg}" /> <i class="pull-right glyphicon" ng-class="{'glyphicon-chevron-down': status.password, 'glyphicon-chevron-right': !status.password}"></i>
                        </accordion-heading>
                        <div class="row">
                            <div class="col-md-7 col-sm-7 col-xs-7">
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right">Email Language</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <select class="form-control input-group" name="language" data-ng-model="profile.language" ng-options="language for (id, language) in formElements.LanguageList">
                                            <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                            </select>
							            </div>
                                        </div>
                                    </div>
                                <div class="row">
                                    <div class="col-md-4 col-sm-4 col-xs-4"></div>
                                    <div class="col-md-6 col-sm-6 col-xs-6">
                                    	<get-loader-image data-ng-if="showLoader"></get-loader-image>
                                        <button type="button" data-ng-if="!showLoader" data-ng-click="updateLanguage(profile)" class="btn btn-info" value="Update"><fmt:message key="common.update" bundle="${msg}" /></button>
                                    </div>
                                </div>

                            </div>


                        </div> </accordion-group>
                    <accordion-group is-open="status.api">
                        <accordion-heading>
                           <fmt:message key="api.information" bundle="${msg}" /> <i class="pull-right glyphicon" ng-class="{'glyphicon-chevron-down': status.api, 'glyphicon-chevron-right': !status.api}"></i>
                        </accordion-heading>
                        <div class="row">
                            <div class="col-md-7 col-sm-7 col-xs-7">
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right"><fmt:message key="common.apikey" bundle="${msg}" />:</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <label>{{profile.apiKey || '-' }}</label>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right"><fmt:message key="common.secretkey" bundle="${msg}" />:</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                           <label> {{profile.secretKey || '-' }}</label>

                                        </div>
                                    </div>
                                </div>

                                <div class="row">
<!--                                    <a class="btn btn-info">Download</a>
                                    <div class="col-md-4 col-sm-4 col-xs-4"></div>
                                    <div class="col-md-6 col-sm-6 col-xs-6">
                                        <input  type="submit"   class="btn btn-info" value="Update"/>
                                    </div>-->
                                </div>

                            </div>


                        </div> </accordion-group>
                </accordion>



            </div>
        </div>
</form>
    </div>
</div>
