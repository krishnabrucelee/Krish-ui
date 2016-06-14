<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div data-ng-if="global.webSocketLoaders.ipLoader" class="overlay-wrapper">
    <img data-ng-if="global.webSocketLoaders.ipLoader" src="images/loading-bars.svg" class="inner-loading" />
</div>
<div class="hpanel">
<div class="panel-heading">
                <div class="row">
                    <div class="pull-right m-t-sm">
                        <div class="quick-search">
                            <div class="input-group">
                                <input data-ng-model="networkSearch" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
                                <span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
                            </div>
                        </div>
                    </div>
                    <div class="pull-left m-t-sm">
                        <span class="pull-right">
                            <a has-permission="ACQUIRE_IP_ADDRESS" class="btn btn-info" data-ng-click="openAddIP('md', network)"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="acquire.new.ip" bundle="${msg}" /></a>
                       </span>
                    </div>
                                    </div>

               <div class="clearfix"></div>
</div>
<div class="white-content">
<form>
 <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
                    <thead>
                    <tr>
                        <th><fmt:message key="common.ips" bundle="${msg}" /></th>
                        <th><fmt:message key="common.zone" bundle="${msg}" /></th>
                        <th><fmt:message key="common.vm.name" bundle="${msg}" /></th>
                        <th><fmt:message key="common.state" bundle="${msg}" /></th>
                        <th><fmt:message key="action" bundle="${msg}" /></th>
                    </tr>
                    </thead>
          <tbody>
              <tr ng-repeat="ipaddress in ipList | filter: networkSearch">
                      <td>
                      	<a class="text-info" ui-sref="cloud.list-network.view-network.view-ipaddress({id1:ipaddress.id})"  title="<fmt:message key="view.ip" bundle="${msg}" />"> {{ ipaddress.publicIpAddress }} <span ng-if="ipaddress.isSourcenat">[Source NAT]</span></a>
                      </td>
                      <td>{{ipaddress.zone.name}} </td>
                      <td>{{ipaddress.vmInstance.name}}</td>
                      <td> <b class="text-success text-uppercase">{{ipaddress.state}}</b></td>
                      <td>
                          <a data-ng-if="ipaddress.isSourcenat && ipaddress.vpnState != 'RUNNING'" class="icon-button" title="<fmt:message key="enable.vpn" bundle="${msg}" />" data-ng-click="enableVpn('sm',ipaddress)"><i class="custom-link-icon custom-icon-ip-disabled"></i></a>
                          <a data-ng-if="ipaddress.isSourcenat && ipaddress.vpnState == 'RUNNING'" class="icon-button" title="<fmt:message key="disable.vpn" bundle="${msg}" />" data-ng-click="disableVpn('sm',ipaddress)"><i class="custom-link-icon custom-icon-ip"></i></a>
                          <a data-ng-if="!ipaddress.isSourcenat" class="icon-button" title="<fmt:message key="release.ip" bundle="${msg}" />" data-ng-click="releaseIP('sm',ipaddress)"><span class="fa fa-chain-broken"></span></a>
                      </td>
              </tr>
          </tbody>
</table>
</form>
<pagination-content></pagination-content>
</div>
</div>