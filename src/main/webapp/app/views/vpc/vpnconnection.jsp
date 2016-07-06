 <%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />
<div ng-controller="vpcCtrl">
 <div data-ng-if="global.webSocketLoaders.vpnconnectionloader" class="overlay-wrapper">
                        <get-show-loader-image data-ng-show="global.webSocketLoaders.vpnconnectionloader"></get-show-loader-image>
                    </div>
                        <div class="panel-heading no-padding" >
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12 ">
                                    <div class="pull-left dashboard-btn-area">
                                    	<a id="vpc_add_button" class="btn btn-info" data-ng-click="createVPNconnection('sm')" has-permission="CREATE_VPC">
											<span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>
											<fmt:message key="common.add" bundle="${msg}" />
										</a>
                                        <a
                                            class="btn btn-info" id="vpn_refresh_button" ui-sref="vpc.view-vpc.config-vpc.view-sitevpn"
                                            title="<fmt:message key="common.refresh" bundle="${msg}" /> "
                                            ui-sref-opts="{reload: true}"><span
                                                class="fa fa-refresh fa-lg"></span>
                                        </a>
                                    </div>
                                    <div class="pull-right dashboard-filters-area">
                                        <form data-ng-submit="searchList(vmSearch)">
                                            <div class="quick-search pull-right">
                                                <div class="input-group">
                                                    <input id="vpn_site_gateway_quick_search" data-ng-model="vmSearch" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
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
                        <div class="col-md-12 col-sm-12 col-xs-12" id="vpn_site_gateway_pagination_container">
                            <div class="white-content">
                                <div class="table-responsive">
                                    <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped" id="vpn_site_gateway_table">
                                        <thead>
                                            <tr>
                                        <th><fmt:message key="common.ips" bundle="${msg}" /></th>
                                        <th><fmt:message key="gateway" bundle="${msg}" /></th>
                                        <th><fmt:message key="common.status" bundle="${msg}" /></th>
                                        <th><fmt:message key="vpn.pre.shared.key" bundle="${msg}" /></th>
                                        <th><fmt:message key="common.ike.policy" bundle="${msg}" /></th>
                                        <th><fmt:message key="common.esp.policy" bundle="${msg}" /></th>
                                        <th><fmt:message key="common.action" bundle="${msg}" /></th>
                                        </tr>
                                        </thead>
                                        <tbody data-ng-hide="vpnconnectionList.length > 0">
                                            <tr>
                                                <td class="col-md-9 col-sm-9" colspan="9"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
                                        </tr>
                                        </tbody>
                                        <tbody data-ng-show="vpnconnectionList.length > 0">
                                            <tr ng-repeat="vpnconnection in vpnconnectionList">
                                                <td>
                                                    {{ vpnconnection.vpnGateway.publicIpAddress}}
                                                </td>
                                                <td>{{vpnconnection.gateway}}</td>
                                                <td><label data-ng-if="vpnconnection.status == 'CONNECTED'" class="label label-success text-center text-white">CONNECTED</label><label data-ng-if="vpnconnection.status == 'DISCONNECTED'" class="label label-danger text-center text-white">DISCONNECTED</label>
                                                <label data-ng-if="vpnconnection.status == ''" class="label label-danger text-center text-white">PENDING</label></td>
                                                <td>{{vpnconnection.ipsecPresharedKey}}</td>
												<td>{{vpnconnection.ikePolicy}}</td>
												<td>{{vpnconnection.espPolicy}} </td>
                                                <td>
                                                    <a class="icon-button test_vpc_delete_button" id="vpn_delete_button_{{vpn.id}}" data-ng-click="viewvpnconnection('lg',vpnconnection.id)"  ><span class="fa fa-eye"></span></a>
                                                    <a has-permission="DELETE_VPC" class="icon-button test_vpc_delete_button" id="vpc_delete_button_{{vpc.id}}" data-ng-click="deletevpnconnection('sm', vpnconnection)"  ><span class="fa fa-trash"></span></a>
                                                	<a class="icon-button test_network_restart_button" id="vpn_connection_restart_button_{{vpn.id}}" has-permission="RESTART_NETWORK" title="<fmt:message key="common.restart" bundle="${msg}" /> " data-ng-click="restartvpnconnection('sm', vpnconnection)">
                                                	<span class="fa fa-rotate-left m-r"></span></a>
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