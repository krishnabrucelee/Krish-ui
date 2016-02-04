<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="panel-heading" ui-view>
                <div class="row">
                    <div class="col-md-3 col-sm-3 col-xs-3 ">
                        <div class="quick-search">
                            <div class="input-group">
                                <input data-ng-model="networkSearch" type="text" class="form-control input-medium" placeholder="Quick Search" aria-describedby="quicksearch-go">
                                <span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-9 col-sm-9 col-xs-9">
                        <span class="pull-right">
                            <a class="btn btn-info" data-ng-click="openAddIP('md', network)"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>Acquire new IP</a>
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
                        <th>State</th>
                        <th>Action</th>
                    </tr>
                    </thead>
          <tbody>
              <tr ng-repeat="ipaddress in ipList">
                      <td>
                      	<a class="text-info"  ui-sref="cloud.list-network.view-network.view-ipaddress({id1:ipaddress.id})"  title="View IP"> {{ ipaddress.publicIpAddress }} <span ng-if="ipaddress.isSourcenat">[Source NAT]</span></a>
                      </td>
                      <td>{{ipaddress.zone.name}} </td>
                      <td> <b class="text-success text-uppercase">{{ipaddress.state}}</b></td>
                      <td>
                            <!-- <a class="icon-button" title="Enable VPN">
                                <i class="custom-link-icon custom-vpn-ip"></i>
                            </a> -->
                            <a data-ng-if="!ipaddress.isSourcenat" class="icon-button" title="Release IP" data-ng-click="releaseIP('sm',ipaddress)"><span class="fa fa-chain-broken"></span></a>
                      </td>
              </tr>
          </tbody>
</table>
</form>
</div>