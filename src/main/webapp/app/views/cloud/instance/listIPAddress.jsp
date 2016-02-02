<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="hpanel" >
			<div  ng-controller="secondaryIpCtrl">
				<div class="hpanel">
					<div class="panel-heading">
						<div class="row">
							<div class="col-md-12 col-sm-12 col-xs-12 ">
								<div class="pull-left">
									<div class="pull-left"></div>
								</div>
								<div class="pull-right">
									<panda-quick-search></panda-quick-search>
										<div class="clearfix"></div>
									<span class="pull-right m-l-sm m-t-sm">
									<a class="btn btn-info" has-permission="ACQUIRE_SECONDARY_IP_ADDRESS" ng-click="acquireNewIP('md')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>
									<fmt:message key="acquire.new.secondary.ip" bundle="${msg}" /></a> <a class="btn btn-info" ui-sref="cloud.list-instance.view-instance.view-ipAddress" title="<fmt:message key="common.refresh" bundle="${msg}" />" ui-sref-opts="{reload: true}">
									<span class="fa fa-refresh fa-lg"></span></a>
									</span>
								</div>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12 ">
							<div class="white-content">
							<div data-ng-hide = "showLoader" style="margin: 1%">
      						</div>
								<div data-ng-hide="showLoader" class="table-responsive">
									<table cellspacing="1" cellpadding="1"
										class="table table-bordered dataTable table-striped">
										<thead>
											<tr>
												<th class="col-md-3 col-sm-4"  data-ng-click="changeSorting('vm.name')" data-ng-class="sort.descending && sort.column =='vm.name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.vm.name" bundle="${msg}" /></th>
												<th class="col-md-3 col-sm-4"  data-ng-click="changeSorting('ips')" data-ng-class="sort.descending && sort.column =='ips'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.ips" bundle="${msg}" /></th>
												<th class="col-md-3 col-sm-4"><fmt:message key="common.action" bundle="${msg}" /></th>
											</tr>
										</thead>
										<tbody>
											<tr data-ng-show="nic.nicId==nicip" data-ng-repeat=" nic in filteredCount = (nicIPLists| filter: quickSearch | orderBy:sort.column:sort.descending)">
												<td>{{ nic.vmInstance.name }}</td>
												<td>{{ nic.guestIpAddress}}</td>

												<td><a  class="icon-button" title="<fmt:message key="common.delete" bundle="${msg}" />"  data-ng-click="deleteIP('sm', nic)"><span class="fa fa-trash"></span></a>
												</td>
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