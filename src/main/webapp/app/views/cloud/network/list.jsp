<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div ui-view ng-controller="networksCtrl">

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
                                <a class="btn btn-info" data-ng-click="openAddIsolatedNetwork('md')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="add.isolated.network" bundle="${msg}" /></a>
                                <a ui-sref-opts="{reload: true}" title="<fmt:message key="common.refresh" bundle="${msg}" />"  data-ng-click="selectedNetwork(network.networkView.name)" class="btn btn-info"><span class="fa fa-refresh fa-lg "></span></a>

                            </span>
                        </div>

                    </div>
                </div>
                <div class="clearfix"></div>
            </div>

            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12 ">
                    <div class="white-content">
                        <div class="table-responsive">

                            <div data-ng-show="network.networkView.name == 'Guest Networks' || network.networkView.name == null" data-ng-include src="'app/views/cloud/network/guest-networks.jsp'"></div>

                            <div data-ng-show="network.networkView.name == 'Security Groups'" data-ng-include src="'app/views/cloud/network/asecurity-groups.jsp'"></div>

                            <div data-ng-show="network.networkView.name == 'VPC'" data-ng-include src="'app/views/cloud/network/avpc.jsp'"></div>

                            <div data-ng-show="network.networkView.name == 'VPN Customer Gateway'" data-ng-include src="'app/views/cloud/network/avpn.jsp'"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>