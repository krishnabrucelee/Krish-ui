<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="hpanel">
    <div class="row m-l-sm m-r-sm panel-body" ng-controller="projectCtrl">
      <div data-ng-if= "showLoader" style="margin: 30%">
      <get-loader-image data-ng-if="showLoader"></get-loader-image>
      </div>
        <div class="tab-content" data-ng-if="!showLoader" >
               <div class="row" >

                    <div class="col-lg-9 col-md-8 col-sm-12">
                    <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa-folder fa"></i>&nbsp;&nbsp;<fmt:message key="project.summary" bundle="${msg}" /></h3>
                            </div>
                        <accordion close-others="false"> <accordion-group is-open="status.basic"> <accordion-heading>
							<fmt:message key="project.information" bundle="${msg}" /><i class="pull-right glyphicon"
								ng-class="{'glyphicon-chevron-down': status.basic, 'glyphicon-chevron-right': !status.basic}"></i>
							</accordion-heading>
							<div class="row">
								<div class="col-md-7 col-sm-7 col-xs-7">
									<div class="form-group">

										<div class="row">
											<label class="col-md-4 col-sm-4 control-label"> <span
												class="pull-right"><fmt:message key="project.name" bundle="${msg}" /></span></label>
											<div class="col-md-6 col-sm-6 col-xs-6"> {{projectInfo.name}}</div>
										</div>
									</div>
									<div class="form-group">
										<div class="row">
											<label class="col-md-4 col-sm-4 control-label"> <span
												class="pull-right"><fmt:message key="project.id" bundle="${msg}" /></span></label>
											<div class="col-md-6 col-sm-6 col-xs-6">{{projectInfo.id}}</div>
										</div>
									</div>
									<div class="form-group">
										<div class="row">
											<label class="col-md-4 col-sm-4 control-label"> <span
												class="pull-right"><fmt:message key="project.status" bundle="${msg}" /></span></label>
											<div class="col-md-6 col-sm-6 col-xs-6"><label class="badge badge-success p-xs" data-ng-if="projectInfo.isActive"
													class="text-success">Active</label> <label class="badge badge-danger p-xs"
													data-ng-hide="projectInfo.isActive"
													class="text-danger">In Active</label></div>
										</div>
									</div>
									<div class="form-group">
										<div class="row">
											<label class="col-md-4 col-sm-4 control-label"> <span
												class="pull-right"><fmt:message key="project.owner" bundle="${msg}" /></span></label>
											<div class="col-md-6 col-sm-6 col-xs-6">{{projectInfo.projectOwner.userName}}</div>
										</div>
									</div>
									<div class="form-group">
										<div class="row">
											<label class="col-md-4 col-sm-4 control-label"> <span
												class="pull-right"><fmt:message key="common.department" bundle="${msg}" /></span></label>
											<div class="col-md-6 col-sm-6 col-xs-6">{{projectInfo.department.userName}}</div>
										</div>
									</div>
									<div class="form-group">
										<div class="row">
											<label class="col-md-4 col-sm-4 control-label"> <span
												class="pull-right"><fmt:message key="created.on" bundle="${msg}" /></span></label>
											<div class="col-md-6 col-sm-6 col-xs-6">{{projectInfo.createdDateTime*1000  | date:'yyyy-MM-dd HH:mm:ss'}}
											</div>
										</div>
									</div>
								</div>
							</div>
							</accordion-group > <accordion-group is-open="status.password"> <accordion-heading>
							<fmt:message key="users.and.roles" bundle="${msg}" /><i class="pull-right glyphicon"
								ng-class="{'glyphicon-chevron-down': status.password, 'glyphicon-chevron-right': !status.password}"></i>
							</accordion-heading>
							<div class="row">
								<div ng-include="'app/views/project/users.jsp'"></div>

							</div>
							</accordion-group> </accordion>
							</div>
                    </div>
                    <div class="col-lg-3 col-md-4 col-sm-5">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-bolt"></i>&nbsp;&nbsp;<fmt:message key="quick.actions" bundle="${msg}" /></h3>
                            </div>
                            <div class="panel-body no-padding">
                                <ul class="list-group">
								<li class="list-group-item">
								<a has-permission="PROJECT_RESOURCE_QUOTA_MODIFICATION" class="fa font-bold pe-7s-edit m-r-md"
									ui-sref="projects.quotalimit({id: projectInfo.id, quotaType: 'project-quota'})"
									><span class="m-l-sm" >
									<fmt:message key="common.edit.quota" bundle="${msg}" />
									</span>
								</a>
								</li>

							</ul>
                            </div>
                        </div>
                    </div>
                </div>



        </div>


    </div>
</div>
