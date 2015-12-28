<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div  ui-view ng-controller="networksCtrl">
    <div data-ng-hide="viewContent">
        <div class="hpanel">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12 ">
                        <div class="pull-left">
                            <div class="dashboard-box pull-left">
                                <span class="pull-right"><fmt:message key="total.network" bundle="${msg}" /></span>
                                <div class="clearfix"></div>
                                <span class="pull-left m-t-xs"><img src="images/network-icon.png"></span>
                                <b class="pull-right">{{networkList.Count}}</b>
                                <div class="clearfix"></div>
                            </div>
                            <div class="dashboard-box pull-left">
                                <span class="pull-right"><fmt:message key="isolated.network" bundle="${msg}" /></span>
                                <div class="clearfix"></div>
                                <span class="pull-left m-t-xs"><img src="images/network-icon.png"></span>
                                <b class="pull-right">{{networkList.Count}}</b>
                                <div class="clearfix"></div>
                            </div>
                            <div class="dashboard-box pull-left">
                                <span class="pull-right"><fmt:message key="shared.network" bundle="${msg}" /></span>
                                <div class="clearfix"></div>
                                <span class="pull-left m-t-xs"><img src="images/network-icon.png"></span>
                                <b class="pull-right">0</b>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="pull-right">
								<panda-quick-search></panda-quick-search>
                            <span class="pull-right m-r-sm">
                                <select  class="form-control input-group col-xs-5" name="networkView" data-ng-init="network.networkView = dropnetworkLists.views[0]" data-ng-model="network.networkView" data-ng-change="selectView(network.networkView.name)" data-ng-options="networkView.name for networkView in dropnetworkLists.views"></select>
                            </span>
                            <div class="clearfix"></div>
                            <span class="pull-right m-l-sm m-t-sm">
                                <a class="btn btn-info" has-permission="ADD_ISOLATED_NETWORK" data-ng-click="openAddIsolatedNetwork('md')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="add.isolated.network" bundle="${msg}" /></a>
                                <a class="btn btn-info" ui-sref="cloud.list-network" title="<fmt:message key="common.refresh" bundle="${msg}" /> " ui-sref-opts="{reload: true}" ><span class="fa fa-refresh fa-lg"></span></a>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12 ">
                   <pagination-content></pagination-content>





					<div class="white-content">

                        <div class="table-responsive">

                        	<!--  Fix added for the pagination issue and commented the include guest-networks.jsp script  -->
							<div
								data-ng-show="network.networkView.name == 'Guest Networks' || network.networkView.name == null">
								<div data-ng-show="showLoader" style="margin: 1%">
									<get-loader-image data-ng-show="showLoader"></get-loader-image>
								</div>

								<div data-ng-hide="showLoader"
									class="table-responsive col-12-table">
									<table cellspacing="1" cellpadding="1"
										class="table table-bordered table-striped">
										<thead>
											<tr>
												<th><fmt:message key="common.name" bundle="${msg}" /></th>
												<th><fmt:message key="common.account" bundle="${msg}" /></th>
												<th><fmt:message key="common.type" bundle="${msg}" /></th>
												<th><fmt:message key="common.cidr" bundle="${msg}" /></th>
												<th><fmt:message key="gateway" bundle="${msg}" /></th>
												<th><fmt:message key="common.action" bundle="${msg}" /></th>
											</tr>
										</thead>
										<tbody>
											<tr
												data-ng-repeat="network in filteredCount = (networkList | filter: quickSearch)">
												<td><a class="text-info"
													ui-sref="cloud.list-network.view-network({id: {{ network.id }}, view: 'view'})"
													title="View Network">{{ network.name }}</a></td>
												<td>{{ network.department.userName}}</td>
												<td>{{ network.networkType }}</td>
												<td>{{ network.cIDR }}</td>
												<td>{{ network.gateway}}</td>
												<td><a class="icon-button"
													has-permission="EDIT_NETWORK"
													title="<fmt:message key="common.edit" bundle="${msg}" />"
													ui-sref="cloud.list-network.view-network({id: {{ network.id }}, view: 'edit'})">
														<span class="fa fa-edit m-r"> </span>
												</a> <a class="icon-button"
													title="<fmt:message key="common.restart" bundle="${msg}" /> "><span
														class="fa fa-rotate-left m-r"></span></a> <a
													class="icon-button" has-permission="DELETE_NETWORK"
													title="<fmt:message key="common.delete" bundle="${msg}" /> "
													data-ng-click="delete('sm', network)"><span
														class="fa fa-trash"></span></a></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<!--  Fix code completed here -->
							<!-- <div data-ng-show="network.networkView.name == 'Guest Networks' || network.networkView.name == null" data-ng-include src="'app/views/cloud/network/guest-networks.jsp'"></div> -->

                            <div data-ng-show="network.networkView.name == 'Security Groups'" data-ng-include src="'app/views/cloud/network/asecurity-groups.jsp'"></div>

                            <div data-ng-show="network.networkView.name == 'VPC'" data-ng-include src="'app/views/cloud/network/avpc.jsp'"></div>

                            <div data-ng-show="network.networkView.name == 'VPN Customer Gateway'" data-ng-include src="'app/views/cloud/network/avpn.jsp'"></div>
                        </div>

                    </div>
                    <pagination-content></pagination-content>
                </div>
            </div>
        </div>
    </div>
</div>