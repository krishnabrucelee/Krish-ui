<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

        <div  ui-view ng-controller="vpcCtrl">
            <div class="row" >
                <div class="col-md-12">
	                <div class="col-md-12 col-sm-12">
	                    <span class="pull-right">
                        	<a class="btn btn-info" data-ng-click="createNetwork('md')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="create.network" bundle="${msg}" /></a>
	                    </span>
                  	</div>
                    <div class="vpc-manager-area">
                        <div class="vpc pull-left">
                            <div class="hpanel">
                                <div class="v-timeline  vertical-timeline-block">
                                    <div class="vertical-timeline-content" >
                                        <div class="timeline-title router">
                                            <span class="fa fa-exchange "></span> <fmt:message key="router" bundle="${msg}" />
                                        </div>
                                        <div class="p-sm">
                                            <div class="col-md-6 ">
                                                <div class="media-body">
                                                	<!-- <a ui-sref="vpc.private-gateway({id: {{ 1}}})"> -->
	                                                    <div class="panel panel-info cursor-notallow">
	                                                        <div class="panel-body p-xxs text-info text-center ">
	                                                            <h3> 0 </h3><fmt:message key="private.gateway" bundle="${msg}" />
	                                                        </div>
	                                                    </div>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="media-body">
                                                	 <a ui-sref="vpc.view-vpc.config-vpc.public-ip">
	                                                    <div class="panel panel-info">
	                                                        <div class="panel-body p-xxs text-info text-center">
	                                                            <h3>{{ipList.length}}</h3><fmt:message key="public.ip.address" bundle="${msg}" />
	                                                        </div>
	                                                    </div>
                                                    </a>
                                                </div>
                                            </div></div>
                                        <div class="p-sm">
                                            <div class="col-md-6">
                                                <div class="media-body">
                                                	<!-- <a data-ng-click="acquireNewIp('sm')"> -->
	                                                    <div class="panel panel-info cursor-notallow">
	                                                        <div class="panel-body p-xxs text-info text-center">
	                                                            <h3> 0</h3>
	                                                            <fmt:message key="site.to.site.vpns" bundle="${msg}" />
	                                                        </div>
	                                                    </div>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="media-body">
                                                    <div class="panel panel-info">
                                                    	<a ui-sref="vpc.view-vpc.config-vpc.network-acl">
	                                                        <div class="panel-body p-xxs text-info text-center" >
	                                                            <h3> 0</h3>
	                                                            <fmt:message key="network.acl.lists" bundle="${msg}" />
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
                                    <div class="v-timeline  vertical-timeline-block" data-ng-class="{'timeline-primary' : network.isDefault == 'YES'}"  data-ng-repeat="network in vpcNetworkList" >
                                        <div class="h-timeline">
                                            <div class="vertical-timeline-content">
                                                <div class="timeline-title">
                                                    {{network.name}}
                                                </div>
                                                <div class="p-sm">
                                                    <div class="col-md-6">
	                                                    <div class="media">
	                                                        <div class="media-body">
	                                                            <!-- <a href="#" class="cursor-notallow"> -->
	                                                                <div class="panel panel-info cursor-notallow">
	                                                                    <div class="panel-body p-xxs text-info text-center">
	                                                                        <h3> 0 </h3>
	                                                                        <fmt:message key="internal.lb" bundle="${msg}" />
	                                                                    </div>
	                                                                </div>
	                                                             </a>
	                                                        </div>
	                                                    </div>
                                                    </div>
                                                    <div class="col-md-6">
														<div class="media">
	                                                        <div class="media-body">
	                                                            <!-- <a ui-sref="vpc.public-lbip({id: {{ 1}}})"> -->
	                                                                <div class="panel panel-info cursor-notallow">
	                                                                    <div class="panel-body p-xxs text-info text-center">
	                                                                        <h3> 0 </h3>
	                                                                        <fmt:message key="public.lb.ip" bundle="${msg}" />
	                                                                    </div>
	                                                                </div>
                                                               	</a>
	                                                        </div>
                                                    	</div>
                                                    </div>
                                                    <div class="col-md-6">
	                                                    <div class="media">
	                                                        <div class="media-body">
	                                                            <!-- <a ui-sref="vpc.static-nat({id: {{1}}})"> -->
	                                                                <div class="panel panel-info">
	                                                                    <div class="panel-body p-xxs text-info text-center cursor-notallow">
	                                                                        <h3> 0 </h3>
	                                                                        <fmt:message key="static.nats" bundle="${msg}" />
	                                                                    </div>
	                                                                </div>
	                                                            </a>
	                                                        </div>
	                                                    </div>
                                                    </div>
                                                    <div class="col-md-6">
	                                                    <div class="media">
	                                                        <div class="media-body">
	                                                          <a  ui-sref="vpc.view-vpc.config-vpc.virtual-machines({id2: {{network.id}}})" >
	                                                                <div class="panel panel-info">
	                                                                    <div class="panel-body p-xxs text-info text-center">
	                                                                        <h3> 0 </h3>
	                                                                        <fmt:message key="virtual.machines" bundle="${msg}" />
	                                                                    </div>
	                                                                </div>
	                                                            </a>
	                                                        </div>
	                                                    </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6"> <div class="p-sm"><fmt:message key="common.cidr" bundle="${msg}" />: {{network.cIDR}}</div></div>
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

