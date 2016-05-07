<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- Header -->

    <div class="content" ui-view>
    	<div data-ng-controller="vpcCtrl">
    	<div data-ng-if="global.webSocketLoaders.vpcLoader" class="overlay-wrapper">
                		            <img data-ng-if="global.webSocketLoaders.vpcLoader" src="images/loading-bars.svg" class="inner-loading" />
 </div>
    	<form name="addvpcForm" data-ng-submit="update(addvpcForm)"	method="post" novalidate="">
            <div class="row" >
                <div class="col-md-8">
                    <div class="panel panel-default">
                    	<div class="panel-heading">
							<h3 class="panel-title">VPC Details</h3>
						</div>
						<div class="panel-body p-md">
							<table cellspacing="1" cellpadding="1" class="table table-condensed table-striped">
								<tbody>
									<tr>
										<td><b> Name</b></td>
										<td><label data-ng-if="type != 'edit'">{{vpc.name}}</label><div data-ng-if="type == 'edit'" class="form-group"
												ng-class="{'text-danger': addvpcForm.name.$invalid && formSubmitted}">
												<input type="text" name="name" data-ng-model="vpc.name"
													class="form-control editedinput "
													data-ng-class="{'error': addvpcForm.name.$invalid && formSubmitted}">
											</div></td>
									</tr>
									<tr>
										<td><b> Description</b></td>
										<td><label data-ng-if="type != 'edit'">{{vpc.description}}</label><input data-ng-if="type == 'edit'" type="text"
											name="description" data-ng-model="vpc.description"
											class="form-control editedinput"
											data-ng-class="{'error': addvpcForm.description.$invalid && formSubmitted}">
									</td>
									</tr>
									<tr>
										<td><b> Department</b></td>
										<td>{{vpc.department.userName}}</td>
									</tr>
									<tr>
										<td><b>Domain</b></td>
										<td>{{vpc.domain.name}}</td>
									</tr>
									<tr>
										<td><b>Zone</b></td>
										<td>{{vpc.zone.name}}</td>
									</tr>
									<tr>
										<td><b>CIDR</b></td>
										<td>{{vpc.cIDR}}</td>
									</tr>
									<tr>
										<td><b>Network Domain</b></td>
										<td>{{vpc.networkDomain}}</td>
									</tr>
									<tr>
										<td><b>State</b></td>
										<td><b data-ng-if="vpc.status =='ENABLED'" class="text-success text-uppercase">ENABLED</b> <b data-ng-if="!vpc.status || vpc.status =='INACTIVE' " class="text-danger text-uppercase">INACTIVE</b></td>									</tr>
									<tr>
										<td><b>Persistent </b></td>
										<td>NO</td>
									</tr>
									<tr>
										<td><b>Redundant VPC</b></td>
										<td><span data-ng-if="vpc.redundantVPC">YES</span><span data-ng-if="!vpc.redundantVPC">NO</span></td>
									</tr>
									<tr>
										<td><b>Restart required</b></td>
										<td>NO</td>
									</tr>
									<tr>
										<td><b>ID</b></td>
										<td>{{vpc.uuid}}</td>
									</tr>
								</tbody>
							</table>

					<div class="pull-right">
						<get-loader-image data-ng-show="showLoader"></get-loader-image>
						<button class="btn btn-info" data-ng-hide="showLoader"
							data-ng-if="type == 'edit'"
							ng-disabled="form.configForm.$invalid" type="submit">
							<fmt:message key="common.update" bundle="${msg}" />
						</button>
						<button type="button" class="btn btn-default "
							data-ng-hide="showLoader" data-ng-if="type == 'edit'"
							ui-sref="vpc.list">
							<fmt:message key="common.cancel" bundle="${msg}" />
						</button>
					</div>
						</div>
					</div>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-4">
					<div class="panel panel-info">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bolt"></i>&nbsp;&nbsp;
								Quick Actions
							</h3>
						</div>
						<div class="panel-body no-padding">
							<ul class="list-group">
							<li class="list-group-item"><a href="javascript:void(0);" title="restart vpc "
								data-ng-click="restart('md', vpc)"
							><span class="fa-repeat fa font-bold m-xs"></span>Restart VPC</a></li>
							<li class="list-group-item"><a has-permission="DELETE_VPC" href="javascript:void(0);" title=" delete vpc"
								data-ng-click="delete('sm', vpc)"
							><span class="fa-trash fa font-bold m-xs"></span> Remove VPC</a></li>
							<li data-ng-if="type != 'edit'" class="list-group-item"><a has-permission="EDIT_VPC"
								title=" <fmt:message key="edit.network" bundle="${msg}" />" href="#/vpc/edit/{{ vpc.id}}"
							> <span class="fa fa-edit font-bold m-xs"></span> EDIT VPC
							</a></li>
							<li class="list-group-item"><a class="btn btn-info" ui-sref="vpc.config-vpc({id: {{ 1}}})"><span
									class="fa fa-cog"
								> </span> Configure</a></li>
						</ul>
						</div>
					</div>
				</div>
        	</div>
    	</div>
    </div>
    <div id="footer" ng-include="'app/views/common/footer.jsp'"></div>