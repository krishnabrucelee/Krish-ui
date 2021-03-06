<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<!-- This is content container for nested view in UI-Router-->
<!-- You can put here any constant element in app content for example: Page title or breadcrum -->

<!-- Header -->
<div id="header" ng-include="'app/views/common/header.jsp'"></div>

<!-- Navigation -->
<aside id="menu" ng-include="'app/views/common/navigation.jsp'"></aside>

<!-- Main Wrapper -->
<div id="wrapper">
           <div small-header class="normalheader transition ng-scope small-header">
        <div class="hpanel" tour-step order="1" content="Place your page title and breadcrumb. Select small or large header or give the user choice to change the size." placement="bottom">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-left">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a ui-sref="dashboard"><fmt:message key="common.home" bundle="${msg}" /></a></li>
                        <li ng-repeat="state in $state.$current.path" ng-switch="$last || !!state.abstract" ng-class="{active: $last}">
                            <a ng-switch-when="false" href="{{state.url.format($stateParams)}}"><fmt:message key="common.services" bundle="${msg}" /></a>
                            <span ng-switch-when="true"><fmt:message key="common.services" bundle="${msg}" /></span>
                        </li>
                    </ol>
                </div>
                <%-- <h2 class="font-light m-b-xs">
                    <fmt:message key="common.services" bundle="${msg}" />
                </h2>
                <small>{{ $state.current.data.pageDesc }}</small> --%>
            </div>
        </div>
    </div>
    <div class="content" >
        <div class="service-landing-page" ui-view >

                    <div class="row m-l-xs m-b-xs" id="compute-network">
                    <h3> Cloud & Networks</h3>
                        <div class="row m-r-sm">
                            <div class="col-md-3">
                                <a href="#">
                                    <div class="hpanel">
                                        <div class="panel-body">
                                            <div class="stats-icon pull-right">
                                                <div class="service-icon service-icon-ip ver-align-mid m-t-sm m-r-xs"></div>
                                            </div>
                                            <div class="">
                                                <h4 class="text-info">IP Manager</h4>
                                                <small>Centralized IP Managers helps you to manage all your IP resources.</small>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-md-3">
                                <a href="#">
                                    <div class="hpanel">
                                        <div class="panel-body">
                                            <div class="stats-icon pull-right">
                                                <div class="service-icon service-icon-loadbalance ver-align-mid m-t-sm m-r-xs"></div>
                                            </div>
                                            <div class="">
                                                <h4 class="text-info">Load Balancer</h4>
                                                <small>Setup your load-balancing policys on the fly with few clicks.</small>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-md-3">
                                <a href="#">
                                    <div class="hpanel">
                                        <div class="panel-body">
                                            <div class="stats-icon pull-right">
                                                <div class="service-icon service-icon-vpn ver-align-mid m-t-sm m-r-xs"></div>
                                            </div>
                                            <div class="">
                                                <h4 class="text-info">VPN</h4>
                                                <small>VPN manager helps you to setup, track and manage your VPN requirments.</small>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-md-3">
                                <a href="#">
                                    <div class="hpanel">
                                        <div class="panel-body">
                                            <div class="stats-icon pull-right">
                                                <div class="service-icon service-icon-port ver-align-mid m-t-sm m-r-xs"></div>
                                            </div>
                                            <div class="">
                                                <h4 class="text-info">Port Forwarding</h4>
                                                <small>Setup your Port Forwarding policys on the fly with few clicks.</small>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-md-3">
                                <a href="#">
                                    <div class="hpanel">
                                        <div class="panel-body">
                                            <div class="stats-icon pull-right">
                                                <div class="service-icon service-icon-firewall ver-align-mid m-t-sm m-r-xs"></div>
                                            </div>
                                            <div class="">
                                                <h4 class="text-info">Firewall</h4>
                                                <small>Manage all your inbound and outbound traffic with Firewall Manager.</small>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-md-3">
                                <a href="#">
                                    <div class="hpanel">
                                        <div class="panel-body">
                                            <div class="stats-icon pull-right">
                                                <div class="service-icon service-icon-vpc ver-align-mid m-t-sm m-r-xs"></div>
                                            </div>
                                            <div class="">
                                                <h4 class="text-info">VPC</h4>
                                                <small>VPC - lets you launch cloud resources in a private, isolated cloud.</small>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>

                </div>
                     <hr>
                        <div class="row m-l-xs m-b-xs" id="cloud-storage">

                            <h3>Cloud & Storage Service</h3>
                        <div class="row m-r-sm">
                            <div class="col-md-3">
                                <a href="#">
                                    <div class="hpanel">
                                        <div class="panel-body">
                                            <div class="stats-icon pull-right">
                                                <div class="service-icon service-icon-storage ver-align-mid m-t-sm m-r-xs"></div>
                                            </div>
                                            <div class="">
                                                <h4 class="text-info">Storage Container</h4>
                                                <small>On-demand storage and content delivery that is highly scalable to fit your needs.</small>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-md-3">
                                <a href="#">
                                    <div class="hpanel">
                                        <div class="panel-body">
                                            <div class="stats-icon pull-right">
                                                <div class="service-icon service-icon-amazon ver-align-mid m-t-sm m-r-xs"></div>
                                            </div>
                                            <div class="">
                                                <h4 class="text-info">Amazon S3</h4>
                                                <small>On-demand file storage on Amazon elastic Simple Storage Service (S3).</small>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>

                        </div>

                        </div>
                      <hr>
                    <div class="row m-l-xs m-b-xs" id="netscalar">

                        <h3>Netscalar As A Service</h3>
                           <div class="row m-r-sm">
                                <div class="col-md-3">
                                    <a href="#">
                                        <div class="hpanel">
                                            <div class="panel-body">
                                                <div class="stats-icon pull-right">
                                                    <div class="service-icon service-icon-elastic ver-align-mid m-t-sm m-r-xs"></div>
                                                </div>
                                                <div class="">
                                                    <h4 class="text-info">Elastic IP</h4>
                                                    <small>Elastic IP addresses are static IP addresses designed for dynamic cloud computing.</small>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-md-3">
                                    <a href="#">
                                        <div class="hpanel">
                                            <div class="panel-body">
                                                <div class="stats-icon pull-right">
                                                    <div class="service-icon service-icon-scale ver-align-mid m-t-sm m-r-xs"></div>
                                                </div>
                                                <div class="">
                                                    <h4 class="text-info">AutoScale</h4>
                                                    <small>It helps you prepare for high-traffic events and scheduled load changes.</small>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-md-3">
                                    <a href="#">
                                        <div class="hpanel">
                                            <div class="panel-body">
                                                <div class="stats-icon pull-right">
                                                    <div class="service-icon service-icon-loadbalance ver-align-mid m-t-sm m-r-xs"></div>
                                                </div>
                                                <div class="">
                                                    <h4 class="text-info">Load Balancer</h4>
                                                    <small>Setup your load-balancing policys on the fly with few clicks.</small>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-md-3">
                                    <a href="#">
                                        <div class="hpanel">
                                            <div class="panel-body">
                                                <div class="stats-icon pull-right">
                                                    <div class="service-icon service-icon-vpn ver-align-mid m-t-sm m-r-xs"></div>
                                                </div>
                                                <div class="">
                                                    <h4 class="text-info">VPN</h4>
                                                    <small>VPN manager helps you to setup, track and manage your VPN requirments.</small>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-md-3">
                                    <a href="#">
                                        <div class="hpanel">
                                            <div class="panel-body">
                                                <div class="stats-icon pull-right">
                                                    <div class="service-icon service-icon-port ver-align-mid m-t-sm m-r-xs"></div>
                                                </div>
                                                <div class="">
                                                    <h4 class="text-info">Port Forwarding</h4>
                                                    <small>Setup your Port Forwarding policys on the fly with few clicks.</small>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-md-3">
                                    <a href="#">
                                        <div class="hpanel">
                                            <div class="panel-body">
                                                <div class="stats-icon pull-right">
                                                    <div class="service-icon service-icon-firewall ver-align-mid m-t-sm m-r-xs"></div>
                                                </div>
                                                <div class="">
                                                    <h4 class="text-info">Firewall</h4>
                                                    <small>Manage all your inbound and outbound traffic with Firewall Manager.</small>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                           </div>
                    </div>
                </div>



            </div>
            <div id="footer" ng-include="'app/views/common/footer.jsp'"></div>

