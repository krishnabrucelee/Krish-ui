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
								<a id="vpc_virtual_machine_create_vm_button" class="btn btn-info" has-permission="CREATE_VM" data-ng-click="openAddInstance('lg')"> <span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="add.instance" bundle="${msg}" /></a>
							</div>
							<div class="pull-right dashboard-filters-area">
							<form data-ng-submit="searchList(vmSearch)">
								<div class="quick-search pull-right">
									<div class="input-group">
										<input id="vpc_virtual_machine_quick_search" data-ng-model="vmSearch" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
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
					<div class="col-md-12 col-sm-12 col-xs-12" id="vpc_virtual_machine_pagination_container">
						<div class="white-content">
							<div data-ng-show="showLoader" style="margin: 1%">
								<get-loader-image data-ng-show="showLoader"></get-loader-image>
							</div>
							<div class="table-responsive">
								<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped" id="vpc_virtual_machine_table">
								    <thead>
								        <tr>
								            <th><fmt:message key="common.name" bundle="${msg}" /></th>
								            <th><fmt:message key="common.internal.name" bundle="${msg}" /></th>
								            <th><fmt:message key="common.display.name" bundle="${msg}" /></th>
								            <th><fmt:message key="zone.name" bundle="${msg}" /></th>
								            <th><fmt:message key="common.state" bundle="${msg}" /></th>
								        </tr>
								    </thead>
								    <tbody data-ng-hide="vpcVmList.length > 0">
			                                <tr>
			                                    <td class="col-md-9 col-sm-9" colspan="9"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
			                                </tr>
			                            </tbody>
								    <tbody data-ng-show="vpcVmList.length > 0">
								        <tr data-ng-repeat="vm in filteredCount = (vpcVmList| filter: quickSearch | orderBy:sort.column:sort.descending)">
								        <td><a id="vpc_virtual_machine_ip_address_button" class="text-info" ui-sref="cloud.list-instance.view-instance({id: {{ vm.vmInstance.id}}})"
											title="View Instance">
										{{vm.vmInstance.name}}</a>
								            </td>
								            <td>{{vm.vmInstance.instanceInternalName}}</td>
								            <td>{{vm.vmInstance.displayName}}</td>
								            <td>{{vm.vmInstance.zone.name}}</td>
								            <td><label class="label label-success"
									data-ng-if="vm.vmInstance.status == 'RUNNING'">{{
										vm.vmInstance.status }}</label> <label class="label label-danger"
									data-ng-if="vm.vmInstance.status == 'STOPPED'">{{
										vm.vmInstance.status }}</label> <input type="hidden"
									data-ng-model="vm.vmInstance.status" value="{{ instance.vmInstance.status }}" />
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
