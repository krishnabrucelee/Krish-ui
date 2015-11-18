<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- This is content container for nested view in UI-Router-->
<!-- You can put here any constant element in app content for example: Page title or breadcrum -->

<!-- Header -->
<div id="header" ng-include="'app/views/common/header.jsp'"></div>

<!-- Navigation -->
<aside id="menu" ng-include="'app/views/common/navigation.jsp'"></aside>

<!-- Main Wrapper -->
<div id="wrapper">
    <div small-header class="normalheader transition ng-scope small-header">
        <div class="hpanel" tour-step order="1" title="Page header" content="Place your page title and breadcrumb. Select small or large header or give the user choice to change the size." placement="bottom">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a ui-sref="dashboard"><fmt:message key="common.home" bundle="${msg}" /></a></li>
                        <li ng-repeat="state in $state.$current.path" ng-switch="$last || !!state.abstract" ng-class="{active: $last}">
                           <span data-ng-if="state.data.pageTitle === 'common.cloud'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.cloud" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.cloud" bundle="${msg}" /></span>
                            </span>
                           <span data-ng-if="state.data.pageTitle === 'common.instances'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.instances" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.instances" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'common.snapshot'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.snapshot" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.snapshot" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'common.volume'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.volume" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.volume" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'common.network'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.network" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.network" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'common.department'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.department" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.department" bundle="${msg}" /></span>
                            </span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    <span data-ng-if="$state.current.data.pageTitle === 'common.instances'"><fmt:message key="common.instances" bundle="${msg}" /></span>
                </h2>
                <h2 class="font-light m-b-xs">
                    <span data-ng-if="$state.current.data.pageTitle === 'common.volume'"><fmt:message key="common.volume" bundle="${msg}" /></span>
                </h2>
                <small>{{ $state.current.data.pageDesc}}</small>
            </div>
        </div>
    </div>
    <div class="content">
        <div ui-view ></div>
    </div>

</div>