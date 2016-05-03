<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

    <div class="content" ui-view>
        <div ng-controller="vpcCtrl">
            <div class="row" >
                <div class="col-md-12">
	                <div class="col-md-12 col-sm-12">
	                    <span class="pull-right">
                        	<a class="btn btn-info" data-ng-click="createNetwork('md')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>Create Network</a>
	                    </span>
                  	</div>
                    <div class="vpc-manager-area">
                        <div class="vpc pull-left">
                            <div class="hpanel">
                                <div class="v-timeline  vertical-timeline-block"  >
                                    <div class="vertical-timeline-content" >
                                        <div class="timeline-title router">
                                            <span class="fa fa-exchange "></span> Router
                                        </div>
                                        <div class="p-sm">
                                            <div class="col-md-6 ">
                                                <div class="media-body">
                                                	<a ui-sref="vpc.private-gateway({id: {{ 1}}})">
	                                                    <div class="panel panel-info">
	                                                        <div class="panel-body p-xxs text-info text-center ">
	                                                            <h3> 0 </h3>PRIVATE GATEWAY
	                                                        </div>
	                                                    </div>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="media-body">
                                                	<a ui-sref="vpc.public-ip({id: {{ 1}}})">
	                                                    <div class="panel panel-info">
	                                                        <div class="panel-body p-xxs text-info text-center">
	                                                            <h3> 1</h3>PUBLIC IP ADDRESS
	                                                        </div>
	                                                    </div>
                                                    </a>
                                                </div>
                                            </div></div>
                                        <div class="p-sm">
                                            <div class="col-md-6">
                                                <div class="media-body">
                                                	<a data-ng-click="acquireNewIp('sm')">
	                                                    <div class="panel panel-info">
	                                                        <div class="panel-body p-xxs text-info text-center">
	                                                            <h3> 0</h3>
	                                                            SITE TO SITE VPNS
	                                                        </div>
	                                                    </div>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="media-body">
                                                    <div class="panel panel-info">
                                                    	<a href="#" ui-sref="vpc.network-acl({id: {{ 1}}})">
	                                                        <div class="panel-body p-xxs text-info text-center" >
	                                                            <h3> 2</h3>NETWORK ACL LISTS
	                                                        </div>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="vpc-manager pull-right">
                            <div class="hpanel">
                                <div class=" vertical-container" animate-panel child="vertical-timeline-block" >
                                    <div class="v-timeline  vertical-timeline-block" data-ng-class="{'timeline-primary' : network.isDefault == 'YES'}"  data-ng-repeat="network in networkList" >
                                        <div class="h-timeline">
                                            <div class="vertical-timeline-content">
                                                <div class="timeline-title">
                                                    {{network.name}}
                                                </div>
                                                <div class="p-sm">
                                                    <div class="col-md-6">
	                                                    <div class="media">
	                                                        <div class="media-body">
	                                                            <a href="#" class="cursor-notallow">
	                                                                <div class="panel panel-info">
	                                                                    <div class="panel-body p-xxs text-info text-center">
	                                                                        <h3> 0 </h3>
	                                                                        INTERNAL LB
	                                                                    </div>
	                                                                </div> 
	                                                             </a>
	                                                        </div>
	                                                    </div>
                                                    </div>
                                                    <div class="col-md-6">
														<div class="media">
	                                                        <div class="media-body">
	                                                            <a ui-sref="vpc.public-lbip({id: {{ 1}}})">
	                                                                <div class="panel panel-info">
	                                                                    <div class="panel-body p-xxs text-info text-center">
	                                                                        <h3> 0 </h3>
	                                                                        PUBLIC LB IP
	                                                                    </div>
	                                                                </div>
                                                               	</a>
	                                                        </div>
                                                    	</div>
                                                    </div>
                                                    <div class="col-md-6">
	                                                    <div class="media">
	                                                        <div class="media-body">
	                                                            <a ui-sref="vpc.static-nat({id: {{1}}})">
	                                                                <div class="panel panel-info">
	                                                                    <div class="panel-body p-xxs text-info text-center" >
	                                                                        <h3> 0 </h3>
	                                                                        STATIC NATS
	                                                                    </div>
	                                                                </div>
	                                                            </a>
	                                                        </div>
	                                                    </div>
                                                    </div> 
                                                    <div class="col-md-6">
	                                                    <div class="media">
	                                                        <div class="media-body">
	                                                            <a href="#" ui-sref="vpc.virtual-machines({id: {{1}}})">
	                                                                <div class="panel panel-info">
	                                                                    <div class="panel-body p-xxs text-info text-center">
	                                                                        <h3> 0 </h3>
	                                                                        VIRTUAL MACHINES
	                                                                    </div>
	                                                                </div>
	                                                            </a>
	                                                        </div>
	                                                    </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6"> <div class="p-sm">CIDR: {{network.CIDR}}</div></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>




