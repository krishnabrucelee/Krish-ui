<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div data-ng-if="global.webSocketLoaders.ipLoader" class="overlay-wrapper">
    <img data-ng-if="global.webSocketLoaders.ipLoader" src="images/loading-bars.svg" class="inner-loading" />
</div>
<div class="panel-heading">
                <div class="row">
                    <div class="pull-right m-t-sm">
                        <div class="quick-search">
                            <div class="input-group">
                                <input data-ng-model="networkSearch" type="text" class="form-control input-medium" placeholder="Quick Search" aria-describedby="quicksearch-go">
                                <span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
                            </div>
                        </div>
                    </div>
                    <div class="pull-left m-t-sm">
                        <span class="pull-right">
                            <a has-permission="ACQUIRE_IP_ADDRESS" class="btn btn-info" data-ng-click="openAddIP('md', network)"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>Acquire new IP</a>
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
                        <th>IPS</th>
                        <th>Zone</th>
                        <th>Vm Name</th>
                        <th>State</th>
                        <th>Action</th>
                    </tr>
                    </thead>
          <tbody>
              <tr ng-repeat="ipaddress in ipList | filter: networkSearch">
                      <td>
                      	<a class="text-info" ui-sref="cloud.list-network.view-network.view-ipaddress({id1:ipaddress.id})"  title="View IP"> {{ ipaddress.publicIpAddress }} <span ng-if="ipaddress.isSourcenat">[Source NAT]</span></a>
                      </td>
                      <td>{{ipaddress.zone.name}} </td>
                      <td>{{ipaddress.vmInstance.name}}</td>
                      <td> <b class="text-success text-uppercase">{{ipaddress.state}}</b></td>
                      <td>
                          <a data-ng-if="ipaddress.isSourcenat && ipaddress.vpnState != 'RUNNING'" class="icon-button" title="Enable VPN" data-ng-click="enableVpn('sm',ipaddress)"><i class="custom-link-icon custom-icon-ip-disabled"></i></a>
                          <a data-ng-if="ipaddress.isSourcenat && ipaddress.vpnState == 'RUNNING'" class="icon-button" title="Disable VPN" data-ng-click="disableVpn('sm',ipaddress)"><i class="custom-link-icon custom-icon-ip"></i></a>
                          <a data-ng-if="!ipaddress.isSourcenat" class="icon-button" title="Release IP" data-ng-click="releaseIP('sm',ipaddress)"><span class="fa fa-chain-broken"></span></a>
                      </td>
              </tr>
          </tbody>
</table>
</form>
</div>