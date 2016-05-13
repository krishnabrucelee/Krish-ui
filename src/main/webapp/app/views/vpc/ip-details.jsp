
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="row" data-ng-controller="vpcCtrl"  >
<div data-ng-if="global.webSocketLoaders.ipLoader" class="overlay-wrapper">
    <img data-ng-if="global.webSocketLoaders.ipLoader" src="images/loading-bars.svg" class="inner-loading" />
</div>
    <div class="col-lg-6 col-md-6 col-sm-12">
        <div class="row ">
            <div class="p-sm pull-right">
			<a data-ng-click="staticNat('md',ipDetails)"  data-ng-show="type =='source'" class="btn btn-info" title="Enable VPN"><span class="custom-icon custom-nat font-bold m-xs"></span> Enable VPN</a>
			<a data-ng-click="disableNat('md',ipDetails)" data-ng-show="type =='source'" class="btn btn-info" title="Disable VPN"><span class="custom-icon custom-nat font-bold m-xs"></span> Disable VPN</a>

    	    <a data-ng-click="staticNat('md',ipDetails)" data-ng-show="type !='source'" data-ng-if="!ipDetails.isStaticnat && !ipDetails.isSourcenat" class="btn btn-info" title="Enable Static NAT"><span class="custom-icon custom-nat font-bold m-xs"></span> Enable Static NAT</a>
			<a data-ng-click="disableNat('md',ipDetails)" data-ng-show="type !='source'" data-ng-if="ipDetails.isStaticnat && !ipDetails.isSourcenat" class="btn btn-info" title="Disable Static NAT"><span class="custom-icon custom-nat font-bold m-xs"></span> Disable Static NAT</a>
<!--                 <a data-ng-click="releaseIP('sm', ipDetails)" class="btn btn-info" title="Delete IP"><span class="fa-trash fa font-bold m-xs"></span> Delete IP </a>
 -->            </div>

        </div>

        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="custom-icon custom-icon-ip"></i>&nbsp;&nbsp;IP Address Details</h3>
            </div>
            <div class="panel-body">
                <div class="row">
                    <table class="table table-condensed table-striped" cellspacing="1" cellpadding="1">
                        <tbody>
                            <tr >
                                <td><b>IP Address</b></td>
                                <td>{{ipDetails.publicIpAddress}}</td>
                            </tr>
                            <tr>
                                <td class="col-md-4 col-sm-4"><b>ID</b></td>
                                <td class="col-md-8 col-sm-8">{{ipDetails.uuid}}</td>
                            </tr>
                            <tr>
                                <td class="col-md-4 col-sm-4"><b>VPC Name</b></td>
                                <td class="col-md-8 col-sm-8">{{ipDetails.vpc.name}}</td>
                            </tr>
                            <tr>
                                <td class="col-md-4 col-sm-4"><b>VPC ID</b></td>
                                <td class="col-md-8 col-sm-8">{{ipDetails.vpc.uuid}}</td>
                            </tr>
                            <tr>
                                <td class="col-md-4 col-sm-4"><b>Network Name</b></td>
                                <td class="col-md-8 col-sm-8"><span data-ng-if="ipDetails.network">{{ipDetails.network.name}}</span><span data-ng-if="!ipDetails.network">-</span></td>
                            </tr>
                            <tr>
                                <td><b>VLAN</b></td>
                                <td>{{ipDetails.vlan}}</td>
                            </tr>
                            <tr>
                                <td><b>Source NAT</b></td>
                                <td><span class="text-success font-bold text-uppercase" data-ng-if="ipDetails.isSourcenat">Yes</span><span class="text-danger text-uppercase" data-ng-if="!ipDetails.isSourcenat">No</span></td>
                            </tr>
                            <tr>
                                <td><b>Static NAT</b></td>
                                <td><span class="text-success font-bold text-uppercase" data-ng-if="ipDetails.isStaticnat">Yes</span><span class="text-danger text-uppercase" data-ng-if="!ipDetails.isStaticnat">No</span></td>
                            </tr>
                            <tr>
                                <td><b>State</b></td>
                                <td><b class="text-success text-uppercase">{{ipDetails.state}}</b></td>
                            </tr>

                            <tr>
                                <td class="col-md-4 col-sm-4"><b>Zone</b></td>
                                <td class="col-md-8 col-sm-8">{{ipDetails.zone.name}}</td>
                            </tr>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

     <div class="col-md-6 col-sm-12" >
            <div class="cloud-diagram1 without-firewall center-block">
                <div class="main-title">Internet<span>{{ipDetails.publicIpAddress}}</span></div>
                <div class="firewall">
                    <del>Firewall</del>
                </div>
                 <div class="child-left pull-left" data-ng-if = "!ipDetails.isStaticnat && !ipDetails.isSourcenat" >
                    Port Forwarding
                    <a href="javascript:void(0)" data-ng-click="portRulesLists(1)" class="btn-diagram"><span>View</span></a>
                </div>
                <div class="child-left pull-left" data-ng-if = "ipDetails.isStaticnat || ipDetails.isSourcenat" >
                    <del>Port Forwarding</del>
                </div>
                <div class="child-right pull-right" data-ng-if = "!ipDetails.isStaticnat && !ipDetails.isSourcenat">
                    Load Balancing
                    <a href="javascript:void(0)" data-ng-click="selectTab('loadBalance')" class="btn-diagram"><span>View</span></a>
                </div>
                <div class="child-right pull-right" data-ng-if = "ipDetails.isStaticnat || ipDetails.isSourcenat">
                    <del>Load Balancing</del>
                </div>
            </div>
    </div>


</div>

