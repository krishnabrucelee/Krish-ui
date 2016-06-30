<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />


	<div class="row" ui-view data-ng-controller="vpcCtrl">
		<div class="col-lg-12 col-md-12 col-sm-12">
		<div class="panel panel-info">
				<div class="panel-heading">
					<h3 class="panel-title pull-left">
						<i class="fa fa-list-ul"></i>&nbsp;&nbsp;
						<fmt:message key="common.details" bundle="${msg}" />
					</h3>
				<div class="pull-right">
					<a ui-sref-opts="{reload: true}" id="vpc_private_gateway_refresh_button"
						title="<fmt:message key="common.refresh" bundle="${msg}" />"
						ui-sref="vpc.view-vpc.config-vpc.private-gateway.view-private-gateway" class="btn btn-info" href="#"><span
						class="fa fa-refresh fa-lg "></span></a>
				</div>
				<div class="clearfix"></div>
				</div>
				<div class="panel-body">
					<div class="row">
					<div data-ng-show="showLoader" style="margin: 1%">
							<get-loader-image data-ng-show="showLoader"></get-loader-image>
						</div>
						<div data-ng-hide="showLoader" class="col-md-6">
							<table class="table table-condensed table-striped"
								cellspacing="1" cellpadding="1" id="vpc_private_gateway_details_table">
								<tbody>
									<tr>
										<td class="col-md-4 col-sm-4"><b><fmt:message
													key="id" bundle="${msg}" /></b></td>
										<td class="col-md-8 col-sm-8">{{privateGateway.uuid}}</td>
									</tr>
									<tr>
										<td class="col-md-4 col-sm-4"><b><fmt:message
													key="ip.address" bundle="${msg}" /></b></td>
										<td class="col-md-8 col-sm-8">{{privateGateway.ipAddress}}</td>
									</tr>
									<tr>
										<td class="col-md-4 col-sm-4"><b><fmt:message
													key="gateway" bundle="${msg}" /></b></td>
										<td class="col-md-8 col-sm-8">{{privateGateway.gateway}}</td>
									</tr>
									<tr>
										<td><b><fmt:message key="netmask" bundle="${msg}" /></b></td>
										<td>{{privateGateway.netMask}}</td>
									</tr>
									<tr>
										<td><b><fmt:message key="vlan.vni" bundle="${msg}" /></b></td>
										<td>{{privateGateway.vlan}}</td>
									</tr>
									<tr>
										<td><b><fmt:message key="common.state"
													bundle="${msg}" /></b></td>
										<td><b class="text-success text-uppercase">{{privateGateway.status}}</b></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div data-ng-hide="showLoader" class="col-md-6">
							<table class="table table-condensed table-striped"
								cellspacing="1" cellpadding="1" id="vpc_network_name_table_actions">
								<tbody>
								    <tr>
										<td><b> <fmt:message key="common.account"
													bundle="${msg}" /></b></td>
										<td>{{privateGateway.department.userName}}</td>
									</tr>
                                    <tr>
										<td class="col-md-4 col-sm-4"><b><fmt:message
													key="common.zone" bundle="${msg}" /></b></td>
										<td class="col-md-8 col-sm-8">{{privateGateway.zone.name}}</td>
									</tr>
									<tr>
										<td><b> <fmt:message key="common.domain"
													bundle="${msg}" /></b></td>
										<td>{{privateGateway.domain.name}}</td>
									</tr>
									<tr>
										<td><b><fmt:message key="source.nat.supported" bundle="${msg}" /></b></td>
										<td>{{privateGateway.sourceNatSupported}}</td>
									</tr>
									<tr>
										<td><b><fmt:message key="acl.name" bundle="${msg}" /></b></td>
										<td>{{privateGateway.vpcAcl.name}}</td>
									</tr>
									<tr>
										<td><b><fmt:message key="acl.id" bundle="${msg}" /></b></td>
										<td>{{privateGateway.vpcAcl.uuid}}</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

		</div>


	</div>
