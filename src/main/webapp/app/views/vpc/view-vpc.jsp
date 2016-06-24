<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />
<!-- Header -->

<div class="content">
	<div ui-view>
		<div class="hpanel">
			<div class="hpanel">
				<div class="row m-l-sm m-r-sm panel-body" ng-controller="vpcCtrl">
					<ul class="nav nav-tabs">
						<li data-ng-class="{'active' : activity.category == 'details'}"><a
							data-ng-click="getDetails('details')" data-toggle="tab"> <i
								class="fa fa-list-ul"></i> <fmt:message key="common.details"
									bundle="${msg}" /></a></li>
						<li data-ng-class="{'active' : activity.category == 'vpcrouter'}"><a
							data-ng-click="getVpcrouter('vpcrouter')" data-toggle="tab">
								<i class="fa fa-list-alt"></i> <fmt:message
									key="vpc.router.details" bundle="${msg}" />
						</a></li>
					</ul>
					<div class="tab-content">
						<div data-ng-show="showLoader" style="margin: 1%">
							<get-loader-image data-ng-show="showLoader"></get-loader-image>
						</div>
						<div data-ng-hide="showLoader" class="tab-pane"
							data-ng-class="{'active' : activity.category == 'details'}"
							id="events">
							<div data-ng-if="global.webSocketLoaders.vpcLoader"
								class="overlay-wrapper">
								<!-- <img data-ng-if="global.webSocketLoaders.vpcLoader"
									src="images/loading-bars.svg" class="inner-loading" /> -->
									    <get-show-loader-image data-ng-show="global.webSocketLoaders.vpcLoader"></get-show-loader-image>
							</div>


							<form name="addvpcForm" data-ng-submit="update(addvpcForm)"
								method="post" novalidate="">
								<div class="row">
									<div class="col-md-8">
										<div class="panel panel-default">
											<div class="panel-heading">
												<h3 class="panel-title">
													<fmt:message key="vpc.details" bundle="${msg}" />
												</h3>
											</div>
											<div class="panel-body p-md">
												<table cellspacing="1" cellpadding="1"
													class="table table-condensed table-striped"
													id="vpc_view_vpc_table">
													<tbody>
														<tr>
															<td><b> <fmt:message key="common.name"
																		bundle="${msg}" /></b></td>
															<td><label data-ng-if="type != 'edit'">{{vpc.name}}</label>
															<div data-ng-if="type == 'edit'" class="form-group"
																	ng-class="{'text-danger': addvpcForm.name.$invalid && formSubmitted}">
																	<input type="text" name="name" data-ng-model="vpc.name"
																		id="vpc_view_vpc_name"
																		class="form-control editedinput "
																		data-ng-class="{'error': addvpcForm.name.$invalid && formSubmitted}">
																</div></td>
														</tr>
														<tr>
															<td><b> <fmt:message key="common.description"
																		bundle="${msg}" /></b></td>
															<td><label data-ng-if="type != 'edit'">{{vpc.description}}</label><input
																data-ng-if="type == 'edit'" type="text"
																id="vpc_view_vpc_description" name="description"
																data-ng-model="vpc.description"
																class="form-control editedinput"
																data-ng-class="{'error': addvpcForm.description.$invalid && formSubmitted}">
															</td>
														</tr>
														<tr>
															<td><b> <fmt:message key="common.department"
																		bundle="${msg}" /></b></td>
															<td>{{vpc.department.userName}}</td>
														</tr>
														<tr>
															<td><b><fmt:message key="common.company"
																		bundle="${msg}" /></b></td>
															<td>{{vpc.domain.name}}</td>
														</tr>
														<tr>
															<td><b><fmt:message key="common.zone"
																		bundle="${msg}" /></b></td>
															<td>{{vpc.zone.name}}</td>
														</tr>
														<tr>
															<td><b><fmt:message key="common.cidr"
																		bundle="${msg}" /></b></td>
															<td>{{vpc.cIDR}}</td>
														</tr>
														<tr>
															<td><b><fmt:message key="networkdomain"
																		bundle="${msg}" /></b></td>
															<td>{{vpc.networkDomain}}</td>
														</tr>
														<tr>
															<td><b><fmt:message key="common.state"
																		bundle="${msg}" /></b></td>
															<td><b data-ng-if="vpc.status =='ENABLED'"
																class="text-success text-uppercase">ENABLED</b> <b
																data-ng-if="!vpc.status || vpc.status =='INACTIVE' "
																class="text-danger text-uppercase">INACTIVE</b></td>
														</tr>
														<tr>
															<td><b><fmt:message key="common.persistent"
																		bundle="${msg}" /></b></td>
															<td>NO</td>
														</tr>
														<tr>
															<td><b><fmt:message key="redundant.vpc"
																		bundle="${msg}" /></b></td>
															<td><span data-ng-if="vpc.redundantVPC">YES</span><span
																data-ng-if="!vpc.redundantVPC">NO</span></td>
														</tr>
														<tr>
															<td><b><fmt:message key="restart.required"
																		bundle="${msg}" /></b></td>
															<td>NO</td>
														</tr>
														<tr>
															<td><b><fmt:message key="id" bundle="${msg}" /></b></td>
															<td>{{vpc.uuid}}</td>
														</tr>
													</tbody>
												</table>

												<div class="pull-right">
													<get-loader-image data-ng-show="showLoader"></get-loader-image>
													<button class="btn btn-info" data-ng-hide="showLoader"
														id="vpc_view_vpc_update_button"
														data-ng-if="type == 'edit'"
														ng-disabled="form.configForm.$invalid" type="submit">
														<fmt:message key="common.update" bundle="${msg}" />
													</button>
													<button type="button" class="btn btn-default"
														id="vpc_view_vpc_cancel_button" data-ng-hide="showLoader"
														data-ng-if="type == 'edit'" ui-sref="vpc">
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
													<fmt:message key="quick.actions" bundle="${msg}" />
												</h3>
											</div>
											<div class="panel-body no-padding">
												<ul class="list-group">
													<li class="list-group-item"><a
														has-permission="RESTART_VPC"
														id="vpc_view_vpc_restart_vpc_button"
														href="javascript:void(0);"
														title="<fmt:message key="restart.vpc" bundle="${msg}" />"
														data-ng-click="restart('md', vpc.id)"><span
															class="fa-repeat fa font-bold m-xs"></span>
														<fmt:message key="restart.vpc" bundle="${msg}" /></a></li>
													<li class="list-group-item"><a
														has-permission="DELETE_VPC"
														id="vpc_view_vpc_delete_vpc_button"
														href="javascript:void(0);"
														title=" <fmt:message key="delete.vpc" bundle="${msg}" />"
														data-ng-click="delete('sm', vpc.id)"><span
															class="fa-trash fa font-bold m-xs"></span> <fmt:message
																key="remove.vpc" bundle="${msg}" /></a></li>
													<li data-ng-if="type != 'edit'" class="list-group-item"><a
														has-permission="EDIT_VPC"
														id="vpc_view_vpc_edit_vpc_button"
														title=" <fmt:message key="edit.vpc" bundle="${msg}" />"
														href="#/vpc/edit/{{ vpc.id}}"> <span
															class="fa fa-edit font-bold m-xs"></span> <fmt:message
																key="edit.vpc" bundle="${msg}" />
													</a></li>
													<li class="list-group-item"><a
														id="vpc_view_vpc_configure_button" class="btn btn-info"
														href="#/vpc/view/{{vpc.id}}/config-vpc"> <span
															class="fa fa-cog"> </span> <fmt:message key="configure"
																bundle="${msg}" /></a></li>
												</ul>
											</div>
										</div>
									</div>
								</div>
							</form>
						</div>
						<div data-ng-hide="showLoader" class="tab-pane row "
							data-ng-class="{'active' : activity.category == 'vpcrouter'}"
							id="alerts">
							<div class=" col-md-8">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h3 class="panel-title">
											<fmt:message key="vpc.router.details" bundle="${msg}" />
										</h3>
									</div>
									<div class="panel-body p-md ">
										<table cellspacing="1" cellpadding="1"
											class="table table-condensed table-striped"
											id="vpc_view_vpc_table">
											<tbody>
												<tr>
													<td><b> <fmt:message key="common.name"
																bundle="${msg}" /></b></td>
													<td>{{vpcrouter.name}}</td>
												</tr>
												<tr>
													<td><b> <fmt:message key="common.id"
																bundle="${msg}" /></b></td>
													<td>{{vpcrouter.uuid}}</td>
												</tr>
												<tr>
													<td><b><fmt:message key="common.zone"
																bundle="${msg}" /></b></td>
													<td>{{vpcrouter.zone.name}}</td>
												</tr>
												<tr>
													<td><b><fmt:message key="common.dns"
																bundle="${msg}" /></b></td>
													<td>{{vpcrouter.dns}}</td>
												</tr>
												<tr>
													<td><b><fmt:message key="gateway" bundle="${msg}" /></b></td>
													<td>{{vpcrouter.gateway}}</td>
												</tr>
												<tr>
													<td><b><fmt:message key="common.public.ip.address"
																bundle="${msg}" /></b></td>
													<td>{{vpcrouter.publicIpAddress}}</td>
												</tr>
												<tr>
													<td><b><fmt:message
																key="common.link.local.ipaddress" bundle="${msg}" /></b></td>
													<td>{{vpcrouter.linkLocalIpAddress}}</td>
												</tr>
												<tr>
													<td><b><fmt:message key="common.state"
																bundle="${msg}" /></b></td>
													<td><b data-ng-if="vpcrouter.status =='RUNNING'"
														class="text-success text-uppercase">RUNNING</b> <b
														data-ng-if="!vpcrouter.status || vpcrouter.status =='STOPPED' "
														class="text-danger text-uppercase">STOPPED</b></td>
												</tr>
												<tr>
													<td><b><fmt:message key="common.service.offering"
																bundle="${msg}" /></b></td>
													<td>{{vpcrouter.serviceOffering}}</td>
												</tr>
												<tr>
													<td><b><fmt:message key="redundant.router"
																bundle="${msg}" /></b></td>
													<td><span data-ng-if="vpcrouter.redundantRouter">YES</span><span
														data-ng-if="!vpcrouter.redundantRouter">NO</span></td>
												</tr>
												<tr>
													<td><b> <fmt:message key="common.department"
																bundle="${msg}" /></b></td>
													<td>{{vpcrouter.department.userName}}</td>
												</tr>
												<tr>
													<td><b><fmt:message key="common.company"
																bundle="${msg}" /></b></td>
													<td>{{vpcrouter.domain.name}}</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="footer" ng-include="'app/views/common/footer.jsp'"></div>

