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
							<div class="pull-left dashboard-btn-area">
								<a id="vpc_acquire_public_ip_button" class="btn btn-info" data-ng-click="openAddIP('md', vpc)"> <span class="pe-7s-plus pe-lg font-bold m-r-xs"></span> <fmt:message key="acquire.new.public.ip" bundle="${msg}" /></a>
								<a
								class="btn btn-info" id="vpc_refresh_button" ui-sref="vpc.view-vpc.config-vpc.public-ip"
								title="<fmt:message key="common.refresh" bundle="${msg}" /> "
								ui-sref-opts="{reload: true}"><span
								class="fa fa-refresh fa-lg"></span>
							</a>
							</div>
							<div class="pull-right dashboard-filters-area">
							<form data-ng-submit="searchList(vmSearch)">
								<div class="quick-search pull-right">
									<div class="input-group">
										<input id="vpc_public_ip_quick_search" data-ng-model="vmSearch" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
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
					<div class="col-md-12 col-sm-12 col-xs-12" id="vpc_public_ip_pagination_container">
						<div class="white-content">
							<div data-ng-show="showLoader" style="margin: 1%">
								<get-loader-image data-ng-show="showLoader"></get-loader-image>
							</div>
							<div class="table-responsive">
								<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped" id="vpc_ip_address_table">
								    <thead>
								        <tr>
								            <th><fmt:message key="common.public.ips" bundle="${msg}" /></th>
								            <th><fmt:message key="common.zone" bundle="${msg}" /></th>
								            <th><fmt:message key="network.name" bundle="${msg}" /></th>
								            <th><fmt:message key="common.state" bundle="${msg}" /></th>
								            <th><fmt:message key="common.action" bundle="${msg}" /></th>
								        </tr>
								    </thead>
								    <tbody data-ng-hide="ipList.length > 0">
			                                <tr>
			                                    <td class="col-md-9 col-sm-9" colspan="9"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
			                                </tr>
			                        </tbody>
								    <tbody data-ng-show="ipList.length > 0">
								        <tr ng-repeat="ipaddress in ipList">
                      					<td>
                      						<a id="vpc_public_ip_name_button" class="text-info" ui-sref="vpc.view-vpc.config-vpc.public-ip.ip-view({id1:ipaddress.id})"  title="<fmt:message key="view.ip" bundle="${msg}" />"> {{ ipaddress.publicIpAddress }} <span ng-if="ipaddress.isSourcenat">[Source NAT]</span></a>
                      					</td>
                      					<td>{{ipaddress.zone.name}} </td>
                      					<td>{{ipaddress.network.name}}</td>
                      					<td> <b class="text-success text-uppercase">{{ipaddress.state}}</b></td>
                      					<td>
                          					<a id="vpc_enable_vpc_button" data-ng-if="ipaddress.isSourcenat && ipaddress.vpnState != 'RUNNING'" class="icon-button" title="<fmt:message key="enable.vpn" bundle="${msg}" />" data-ng-click="enableVpn('md',ipaddress)"><i class="custom-link-icon custom-icon-ip-disabled"></i></a>
                          					<a id="vpc_disable_vpc_button" data-ng-if="ipaddress.isSourcenat && ipaddress.vpnState == 'RUNNING'" class="icon-button" title="<fmt:message key="disable.vpn" bundle="${msg}" />" data-ng-click="disableVpn('sm',ipaddress)"><i class="custom-link-icon custom-icon-ip"></i></a>
                         					<a id="vpc_release_ip_button" data-ng-if="!ipaddress.isSourcenat" class="icon-button" title="<fmt:message key="release.ip" bundle="${msg}" />" data-ng-click="releaseIP('sm',ipaddress)"><span class="fa fa-chain-broken"></span></a>
                      					</td>
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

