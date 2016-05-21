<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

        <div  ui-view ng-controller="vpcCtrl">
        <div data-ng-if="global.webSocketLoaders.networkLoader" class="overlay-wrapper">
                		            <img data-ng-if="global.webSocketLoaders.networkLoader" src="images/loading-bars.svg" class="inner-loading" />
            		            </div>
            <div class="row" >
                <div class="col-md-12">
	                <div class="col-md-12 col-sm-12">
	                    <span class="pull-right">
                        	<a class="btn btn-info" has-permission="ADD_ISOLATED_NETWORK" id="config_vpc_create_network_button" data-ng-click="createNetwork('md')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="create.network" bundle="${msg}" /></a>
	                    </span>
	                    <span class="pull-right m-r-xs">
                         <a class="btn btn-info" id="config_vpc_refresh_network_button" ui-sref="vpc.view-vpc.config-vpc" title="<fmt:message key="common.refresh" bundle="${msg}"/>" ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
	                    </span>
                  	</div>
                  	<div data-ng-if="showLoaderOffer" style="margin: 30%">
							<get-loader-image-offer data-ng-show="showLoaderOffer"></get-loader-image-offer>
					</div>
                  	<div data-ng-hide="showLoaderOffer">
                    <div class="col-md-8 col-md-offset-2 col-sm-12 vpc-diagram-area">
                    	<div class="clearfix"></div>
                    	<div class="row">
                        <div class="col-md-6 col-sm-6 pull-left vpc-diagram-router">
                            <div class="hpanel">
                                <div class="v-timeline  vertical-timeline-block">
                                    <div class="vertical-timeline-content" >
                                        <div class="timeline-title router">
                                            <span class="fa fa-exchange "></span> <fmt:message key="router" bundle="${msg}" />
                                        </div>
                                        <div class="p-sm">
                                            <div class="col-md-6 ">
                                                <div class="media-body">
                                                	<!-- <a id="config_vpc_private_gateway" ui-sref="vpc.private-gateway({id: {{ 1}}})"> -->
	                                                    <div class="panel panel-info cursor-notallow">
	                                                        <div class="panel-body config-box p-xxs text-info text-center ">
	                                                            <h3> 0 </h3><fmt:message key="private.gateway" bundle="${msg}" />
	                                                        </div>
	                                                    </div>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="media-body">
                                                	 <a id="config_vpc_public_ip_address" ui-sref="vpc.view-vpc.config-vpc.public-ip">
	                                                    <div class="panel panel-info">
	                                                        <div class="panel-body config-box p-xxs text-info text-center">
	                                                            <h3>{{ipList.length}}</h3><fmt:message key="public.ip.address" bundle="${msg}" />
	                                                        </div>
	                                                    </div>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>

                                            <div class="col-md-6">
                                                <div class="media-body">
                                                	<!-- <a id="config_vpc_site_to_site_vpns" data-ng-click="acquireNewIp('sm')"> -->
	                                                    <div class="panel panel-info cursor-notallow">
	                                                        <div class="panel-body config-box p-xxs text-info text-center">
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
                                                    	<a id="config_vpc_network_acl_lists" ui-sref="vpc.view-vpc.config-vpc.network-acl">
	                                                        <div class="panel-body config-box p-xxs text-info text-center " >
	                                                            <h3> {{aclList.length}}</h3>
	                                                            <fmt:message key="network.acl.lists" bundle="${msg}" />
	                                                        </div>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-6 pull-right vpc-diagram">
                            <div class="hpanel">
                                <div class=" vertical-container" animate-panel child="vertical-timeline-block" >
                                    <div class="v-timeline  vertical-timeline-block" data-ng-class="{'timeline-primary' : network.isDefault == 'YES'}"  data-ng-repeat="network in vpcNetworkList" >
                                        <div class="h-timeline">
                                            <div class="vertical-timeline-content">
                                                <div class="timeline-title">
                                                	<div class="pull-left m-t-xs">{{ network.name }}</div>
                                                    <div class="pull-right"><a class="btn font-bold" id="config_vpc_network_name"
													ui-sref="vpc.view-vpc.config-vpc.view-network({idNetwork: {{ network.id }}, view: 'view'})"
													title="View Network"><span class="fa fa-external-link"></span> View</a></div>
													<div class="clearfix"></div>
                                                </div>
                                                <div class="p-sm">
                                                    <div class="col-md-6">
	                                                    <div class="media">
	                                                        <div class="media-body">
	                                                            <!-- <a id="config_vpc_internal_lb" href="#" class="cursor-notallow"> -->
	                                                                <div class="panel panel-info cursor-notallow">
	                                                                    <div class="panel-body config-box p-xxs text-info text-center">
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
	                                                            <a id="config_vpc_public_lb_ip" ui-sref="vpc.view-vpc.config-vpc.lbip({id3: {{network.id}}})">
	                                                                <div class="panel panel-info">
	                                                                    <div class="panel-body config-box p-xxs text-info text-center">
	                                                                        <h3> {{lbrulesList[$index]}}</h3>
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
	                                                            <a id="config_vpc_static_nats" ui-sref="vpc.view-vpc.config-vpc.natip({id4: {{network.id}}})" >
	                                                                <div class="panel panel-info">
	                                                                    <div class="panel-body config-box p-xxs text-info text-center ">
	                                                                        <h3> {{natList[$index]}}</h3>
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
	                                                          <a id="config_vpc_virtual_machines" ui-sref="vpc.view-vpc.config-vpc.virtual-machines({id2: {{network.id}}})" >
	                                                                <div class="panel panel-info">
	                                                                    <div class="panel-body config-box p-xxs text-info text-center">
	                                                                        <h3>{{networkVMList[$index]}}</h3>
	                                                                        <fmt:message key="virtual.machines" bundle="${msg}" />
	                                                                    </div>
	                                                                </div>
	                                                            </a>
	                                                        </div>
	                                                    </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6"> <div class="m-b-md m-l-md"><fmt:message key="common.cidr" bundle="${msg}" />: {{network.cIDR}}</div></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </div>
                    </div>
                   <%--  <div class="vpc-manager-area">
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
                                                	<!-- <a id="config_vpc_private_gateway" ui-sref="vpc.private-gateway({id: {{ 1}}})"> -->
	                                                    <div class="panel panel-info cursor-notallow">
	                                                        <div class="panel-body config-box p-xxs text-info text-center ">
	                                                            <h3> 0 </h3><fmt:message key="private.gateway" bundle="${msg}" />
	                                                        </div>
	                                                    </div>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="media-body">
                                                	 <a id="config_vpc_public_ip_address" ui-sref="vpc.view-vpc.config-vpc.public-ip">
	                                                    <div class="panel panel-info">
	                                                        <div class="panel-body config-box p-xxs text-info text-center">
	                                                            <h3>{{ipList.length}}</h3><fmt:message key="public.ip.address" bundle="${msg}" />
	                                                        </div>
	                                                    </div>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>

                                            <div class="col-md-6">
                                                <div class="media-body">
                                                	<!-- <a id="config_vpc_site_to_site_vpns" data-ng-click="acquireNewIp('sm')"> -->
	                                                    <div class="panel panel-info cursor-notallow">
	                                                        <div class="panel-body config-box p-xxs text-info text-center">
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
                                                    	<a id="config_vpc_network_acl_lists" ui-sref="vpc.view-vpc.config-vpc.network-acl">
	                                                        <div class="panel-body config-box p-xxs text-info text-center " >
	                                                            <h3> {{aclList.length}}</h3>
	                                                            <fmt:message key="network.acl.lists" bundle="${msg}" />
	                                                        </div>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
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
                                                	<div class="pull-left m-t-xs">{{ network.name }}</div>
                                                    <div class="pull-right"><a class="btn font-bold" id="config_vpc_network_name"
													ui-sref="vpc.view-vpc.config-vpc.view-network({idNetwork: {{ network.id }}, view: 'view'})"
													title="View Network"><span class="fa fa-external-link"></span> View</a></div>
													<div class="clearfix"></div>
                                                </div>
                                                <div class="p-sm">
                                                    <div class="col-md-6">
	                                                    <div class="media">
	                                                        <div class="media-body">
	                                                            <!-- <a id="config_vpc_internal_lb" href="#" class="cursor-notallow"> -->
	                                                                <div class="panel panel-info cursor-notallow">
	                                                                    <div class="panel-body config-box p-xxs text-info text-center">
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
	                                                            <a id="config_vpc_public_lb_ip" ui-sref="vpc.view-vpc.config-vpc.lbip({id3: {{network.id}}})">
	                                                                <div class="panel panel-info">
	                                                                    <div class="panel-body config-box p-xxs text-info text-center">
	                                                                        <h3> {{lbrulesList[$index]}}</h3>
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
	                                                            <a id="config_vpc_static_nats" ui-sref="vpc.view-vpc.config-vpc.natip({id4: {{network.id}}})" >
	                                                                <div class="panel panel-info">
	                                                                    <div class="panel-body config-box p-xxs text-info text-center ">
	                                                                        <h3> {{natList[$index]}}</h3>
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
	                                                          <a id="config_vpc_virtual_machines" ui-sref="vpc.view-vpc.config-vpc.virtual-machines({id2: {{network.id}}})" >
	                                                                <div class="panel panel-info">
	                                                                    <div class="panel-body config-box p-xxs text-info text-center">
	                                                                        <h3>{{networkVMList[$index]}}</h3>
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
                    </div> --%>
                    </div>
                </div>
            </div>
    </div>

