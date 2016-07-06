<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />
<div data-ng-if="global.webSocketLoaders.sitevpnloader" class="overlay-wrapper">
    <get-show-loader-image data-ng-show="global.webSocketLoaders.sitevpnloader"></get-show-loader-image>
</div>
<div class="hpanel">
	<div class="panel-heading no-padding">
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12 ">
				<div class="pull-left dashboard-btn-area">
					<a class="btn btn-info" id="vpn_refresh_button"
						ui-sref="vpc.view-vpc.config-vpc.view-sitevpn"
						title="<fmt:message key="common.refresh" bundle="${msg}" /> "
						ui-sref-opts="{reload: true}"><span
						class="fa fa-refresh fa-lg"></span> </a>
				</div>
				<div class="pull-right dashboard-filters-area">
					<form data-ng-submit="searchList(vmSearch)">
						<div class="quick-search pull-right">
							<div class="input-group">
								<input id="vpn_site_gateway_quick_search"
									data-ng-model="vmSearch" type="text"
									class="form-control input-medium"
									placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />"
									aria-describedby="quicksearch-go"> <span
									class="input-group-addon" id="quicksearch-go"><span
									class="pe-7s-search pe-lg font-bold"></span></span>
							</div>
						</div>
						<div class="clearfix"></div>
						<span class="pull-right m-l-sm m-t-sm"> </span>
					</form>
				</div>
			</div>
		</div>
		<div class="clearfix"></div>
	</div>
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12"
			id="vpn_site_gateway_pagination_container">
			<div class="white-content">

				<div class="table-responsive">
					<table cellspacing="1" cellpadding="1"
						class="table table-bordered table-striped"
						id="vpn_site_gateway_table">
						<thead>
							<tr>
								<th><fmt:message key="common.ips" bundle="${msg}" /></th>
								<th><fmt:message key="common.department" bundle="${msg}" /></th>
								<th><fmt:message key="common.company" bundle="${msg}" /></th>
								<th><fmt:message key="common.action" bundle="${msg}" /></th>
							</tr>
						</thead>
						<tbody data-ng-hide="sitevpnList.length > 0">
							<tr>
								<td class="col-md-9 col-sm-9" colspan="9"><fmt:message
										key="common.no.records.found" bundle="${msg}" />!!</td>
							</tr>
						</tbody>
						<tbody data-ng-show="sitevpnList.length > 0">
							<tr ng-repeat="vpn in sitevpnList">
								<td>{{ vpn.publicIpAddress}}</td>
								<td>{{vpn.department.userName}}</td>
								<td>{{vpn.domain.name}}</td>
								<td><a class="icon-button test_vpc_delete_button"
									id="vpn_delete_button_{{vpn.id}}"
									data-ng-click="viewsitevpn('sm')"><span class="fa fa-eye"></span></a>
									<a has-permission="DELETE_VPC"
									class="icon-button test_vpc_delete_button"
									id="vpc_delete_button_{{vpc.id}}"
									data-ng-click="deletevpn('sm', vpn)"><span
										class="fa fa-trash"></span></a></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<pagination-content></pagination-content>
		</div>
	</div>
</div>
