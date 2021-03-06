<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div ui-view>
	    <div ng-controller="vpcCtrl">
			<div class="hpanel">
				<div class="panel-heading no-padding">
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12 ">
							<div class="pull-right dashboard-filters-area">
							<form data-ng-submit="searchList(vmSearch)">
								<div class="quick-search pull-right">
									<div class="input-group">
										<input id="vpc_private_gateway_quick_search" data-ng-model="vmSearch" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
									   	<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
									</div>
								</div>
								<div class="clearfix"></div>
								<span class="pull-right m-l-sm m-t-sm">
								</span>
							</form>
							</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="row">
					<div class="col-md-12 col-sm-12 col-xs-12" id="vpc_private_gateway_ip_pagination_container">
						<div class="white-content">
							<div data-ng-show="showLoader" style="margin: 1%">
								<get-loader-image data-ng-show="showLoader"></get-loader-image>
							</div>
							<div class="table-responsive">
								<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped" id="vpc_private_gateway_table">
								    <thead>
								        <tr>
								            <th><fmt:message key="ip.address" bundle="${msg}" /></th>
								            <th><fmt:message key="gateway" bundle="${msg}" /></th>
								            <th><fmt:message key="netmask" bundle="${msg}" /></th>
								            <th><fmt:message key="vlan.vni" bundle="${msg}" /></th>
								        </tr>
								    </thead>
								    <tbody data-ng-hide="privateGatewayList.length > 0">
			                                <tr>
			                                    <td class="col-md-9 col-sm-9" colspan="9"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
			                                </tr>
			                        </tbody>
								    <tbody data-ng-show="privateGatewayList.length > 0">
								        <tr ng-repeat="privateGateway in privateGatewayList">
								        <td>
								            <a class="text-info" ui-sref="vpc.view-vpc.config-vpc.private-gateway.view-private-gateway({id5: {{ privateGateway.id }}, view: 'view'})">{{privateGateway.ipAddress}}</a>
								        </td>
                      					<td>{{privateGateway.gateway}}</td>
                      					<td>{{privateGateway.netMask}}</td>
                      					<td>{{privateGateway.vlan}}</td>
              							</tr>

								    </tbody>
								</table>
							</div>
						</div>
						<pagination-content></pagination-content>
					</div>
				</div>
			</div>
		</div>
</div>