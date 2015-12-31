<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<form name="addnetworkForm" data-ng-submit="update(addnetworkForm)" method="post" novalidate="" >

    <div class="row" >
        <div class="col-lg-9 col-md-9 col-sm-12">
            <div class="hpanel">
                <div class="pull-right">
                    <a ui-sref-opts="{reload: true}" title="<fmt:message key="common.refresh" bundle="${msg}" />" ui-sref="cloud.list-network" class="btn btn-info" href="#"><span class="fa fa-refresh fa-lg "></span></a>
                </div>
                <div class="pull-right m-r-sm">
                    <select  class="form-control" name="actions" data-ng-init="network.actions = networkElements.actions[3].name" data-ng-model="network.actions" ng-options="actions.name for actions in networkElements.actions" >
                        <option value="">Minutes</option>
                    </select>
                </div>
                <div class="clearfix"></div>
                <div class="chart">
                    <canvas linechart options="lineOptions" data="lineData" width="800" height="150"></canvas>
                </div>
                <table >
                    <tbody>
                        <tr>
                            <td class="legendColorBox p-xs">
                                <div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #E56919;overflow:hidden"></div></div>
                            </td>
                            <td class="legendLabel">B/W IN</td>
                            <td class="legendColorBox p-xs"><div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #16658D;overflow:hidden"></div></div>
                            </td>
                            <td class="legendLabel">B/W OUT</td>
                        </tr></tbody></table>
            </div>
        </div>
        <div class="col-lg-3 col-md-3 col-sm-4">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="fa fa-bolt"></i>&nbsp;&nbsp;<fmt:message key="quick.actions" bundle="${msg}" /></h3>
                </div>
                <div class="panel-body no-padding">
                    <ul class="list-group">
                       <%--  <li class="list-group-item">
                            <a href="javascript:void(0);" title=" <fmt:message key="restart.network" bundle="${msg}" />"><span class="fa-repeat fa font-bold m-xs"></span><fmt:message key="restart.network" bundle="${msg}" /></a>
                        </li> --%>
                        <li class="list-group-item">
                            <a has-permission="DELETE_NETWORK" href="javascript:void(0);" title=" <fmt:message key="delete.network" bundle="${msg}" />" data-ng-click="delete('sm', network)"><span class="fa-trash fa font-bold m-xs"></span> <fmt:message key="delete.network" bundle="${msg}" /></a>
                        </li>
                        <li class="list-group-item">
                            <a  has-permission="EDIT_NETWORK"  title=" <fmt:message key="edit.network" bundle="${msg}" />" href="#/network/list/edit/{{ network.id}}" >
                                <span class="fa fa-edit font-bold m-xs"></span> <fmt:message key="edit.network" bundle="${msg}" />
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-lg-12 col-md-12 col-sm-8">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="fa fa-sitemap"></i>&nbsp;&nbsp; <fmt:message key="network.details" bundle="${msg}" /></h3>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-6">
                            <table class="table table-condensed table-striped" cellspacing="1" cellpadding="1">
                                <tbody>
                                    <tr>
                                        <td><b> <fmt:message key="common.name" bundle="${msg}" /></b></td>
                                        <td>
                                            <label data-ng-if="type != 'edit'"  >{{network.name}}</label>
                                            <div   data-ng-if="type == 'edit'" class="form-group" ng-class="{'text-danger': addnetworkForm.name.$invalid && formSubmitted}">
                                                <input type="text"  name="name" data-ng-model="network.name"  class="form-control editedinput " data-ng-class="{'error': addnetworkForm.name.$invalid && formSubmitted}">
                                            </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-md-4 col-sm-4"><b><fmt:message key="id" bundle="${msg}" /></b></td>
                                        <td class="col-md-8 col-sm-8">{{network.uuid}}</td>
                                    </tr>
                                    <tr>
                                        <td class="col-md-4 col-sm-4"><b><fmt:message key="common.zone" bundle="${msg}" /></b></td>
                                        <td class="col-md-8 col-sm-8">{{network.zone.name}}</td>
                                    </tr>
                                    <tr>
                                        <td><b><fmt:message key="common.description" bundle="${msg}" /></b></td>
                                        <td>
                                            <label data-ng-if="type != 'edit'"  >{{network.displayText}}</label>
                                            <input data-ng-if="type == 'edit'"  type="text" name="displayText" data-ng-model="network.displayText" class="form-control editedinput" data-ng-class="{'error': addnetworkForm.displayText.$invalid && formSubmitted}">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b><fmt:message key="common.type" bundle="${msg}" /></b></td>
                                        <td>{{network.networkType}}</td>
                                    </tr>
                                    <tr>
                                        <td><b><fmt:message key="common.state" bundle="${msg}" /></b></td>
                                        <td><b class="text-success text-uppercase">{{network.status}}</b></td>
                                    </tr>
                                    <tr>
                                        <td><b><fmt:message key="vpc.id" bundle="${msg}" /></b></td>
                                        <td>{{network.vpc}}</td>
                                    </tr>
                                    <tr>
                                        <td><b><fmt:message key="common.persistent" bundle="${msg}" /></b></td>
                                        <td>{{network.persistent}} </td>
                                    </tr>
                                    <tr>
                                        <td><b> <fmt:message key="common.domain" bundle="${msg}" /></b></td>
                                        <td>{{network.domain.name}}</td>
                                    </tr>
                                    <tr>
                                        <td><b> <fmt:message key="common.account" bundle="${msg}" /></b></td>
                                        <td>{{network.department.userName}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="col-md-6">
                            <table class="table table-condensed table-striped" cellspacing="1" cellpadding="1">
                                <tbody>
                                    <tr>
                                        <td class="col-md-4 col-sm-4"><b><fmt:message key="restart.required" bundle="${msg}" /></b></td>
                                        <td class="col-md-8 col-sm-8">{{network.restart}}</td>
                                    </tr>
                                    <tr>
                                        <td><b><fmt:message key="vlan.vni.id" bundle="${msg}" /></b></td>
                                        <td>{{network.VLAN}}</td>
                                    </tr>
                                    <tr>
                                        <td><b><fmt:message key="broadcast.uri" bundle="${msg}" /></b></td>
                                        <td>{{network.broadcasturi}}</td>
                                    </tr>
                                    <tr>
                                        <td><b><fmt:message key="common.network.offering" bundle="${msg}" /></b></td>
                                        <td>
                                            <label data-ng-if="type != 'edit'"  >{{network.networkOffering.name}}</label>
                                            <select  data-ng-if="type == 'edit'"  class="form-control input-group editedinput" name="networkoffering" data-ng-init="" data-ng-model="network.networkOffering" ng-options="networkoffering.displayText for networkoffering in networkOfferList" data-ng-class="{'error': addnetworkForm.networkoffering.$invalid && formSubmitted}" >
                                                <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b><fmt:message key="common.cidr" bundle="${msg}" /></b></td>
                                        <td>
                                            <label data-ng-if="type != 'edit'"  >{{network.cIDR}}</label>
                                            <input data-ng-if="type == 'edit'"  type="text" name="cidr" valid-cidr data-ng-model="network.cIDR" class="form-control editedinput" data-ng-class="{'error': addnetworkForm.cidr.$invalid && formSubmitted}">
                                    </tr>
                                    <tr>
                                        <td><b><fmt:message key="network.cidr" bundle="${msg}" /></b></td>
                                        <td>{{network.networkCIDR}}</td>
                                    </tr>
                                    <tr>
                                        <td><b><fmt:message key="ipv6.gateway" bundle="${msg}" /></b></td>
                                        <td>{{network.ipv6gateway}}</td>
                                    </tr>
                                    <tr>
                                        <td><b><fmt:message key="ipv6.cidr" bundle="${msg}" /></b></td>
                                        <td>{{network.ipv6CIDR}}</td>
                                    </tr>
                                    <tr>
                                        <td><b><fmt:message key="reserved.ip.range" bundle="${msg}" /></b></td>
                                        <td>{{network.ipRange}}</td>
                                    </tr>
                                    <tr>
                                        <td><b><fmt:message key="networkdomain" bundle="${msg}" /></b></td>
                                        <td>
                                            <label data-ng-if="type != 'edit'"  >{{network.networkDomain}}</label>
                                            <input data-ng-if="type == 'edit'"  type="text" name="networkDomain" data-ng-model="network.networkDomain" class="form-control editedinput" data-ng-class="{'error': addnetworkForm.networkDomain.$invalid && formSubmitted}">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="pull-right">
                        <get-loader-image data-ng-show="showLoader"></get-loader-image>
                        <button class="btn btn-info" data-ng-hide="showLoader" data-ng-if="type == 'edit'" ng-disabled="form.configForm.$invalid" type="submit"><fmt:message key="common.update" bundle="${msg}" /></button>
                        <button type="button" class="btn btn-default " data-ng-hide="showLoader"  data-ng-if="type == 'edit'" ui-sref="cloud.list-network"  ><fmt:message key="common.cancel" bundle="${msg}" /></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>