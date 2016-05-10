<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

    <div class="content" ui-view>
	    <div ng-controller="vpcCtrl">
			<div class="hpanel">
				<div class="panel-heading no-padding">
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12 ">
							<div class="pull-left dashboard-btn-area">
								<a class="btn btn-info" data-ng-click="acquireNewIp('sm')"> <span class="pe-7s-plus pe-lg font-bold m-r-xs"></span> <fmt:message key="acquire.new.ip" bundle="${msg}" /></a>
							</div>
							<div class="pull-right dashboard-filters-area">
							<form data-ng-submit="searchList(vmSearch)">
								<div class="quick-search pull-right">
									<div class="input-group">
										<input data-ng-model="vmSearch" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
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
					<div class="col-md-12 col-sm-12 col-xs-12 ">
						<div class="white-content">
							<div data-ng-show="showLoader" style="margin: 1%">
								<get-loader-image data-ng-show="showLoader"></get-loader-image>
							</div>
							<div class="table-responsive">
								<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
								    <thead>
								        <tr>
								            <th><fmt:message key="common.ips" bundle="${msg}" /></th>
								            <th><fmt:message key="common.zone" bundle="${msg}" /></th>
								            <th><fmt:message key="network.name" bundle="${msg}" /></th>
								            <th><fmt:message key="common.state" bundle="${msg}" /></th>
								            <th><fmt:message key="common.action" bundle="${msg}" /></th>
								        </tr>
								    </thead>
								    <tbody>
								        <tr>
								            <td>
								                192.168.1.184 [Source NAT]
								            </td>
								            <td>devpanda-zone</td>
								            <td>-</td>
								            <td><label class="label label-success text-center text-white">ALLOCATED</label></td>
								            <td>
								                <a class="icon-button" title="Enable Remote Access VPN" data-ng-click="acquireNewIp('sm')"><span class="fa fa-desktop"></span></a>
								            </td>
								        </tr>
								        <tr>
								            <td>
								                192.168.1.184 [Source NAT]
								            </td>
								            <td>devpanda-zone</td>
								            <td>-</td>
								            <td><label class="label label-success text-center text-white">ALLOCATED</label></td>
								            <td>
								                <a class="icon-button" title="Enable Remote Access VPN" data-ng-click="acquireNewIp('sm')"><span class="fa fa-desktop"></span></a>
								            </td>
								        </tr>
								        <tr>
								            <td>
								                192.168.1.184 [Source NAT]
								            </td>
								            <td>devpanda-zone</td>
								            <td>-</td>
								            <td><label class="label label-success text-center text-white">ALLOCATED</label></td>
								            <td>
								                <a class="icon-button" title="Enable Remote Access VPN" data-ng-click="acquireNewIp('sm')"><span class="fa fa-desktop"></span></a>
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
