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
<aside id="menu" ng-include="'app/views/common/billingpanel.jsp'"></aside>

<!-- Main Wrapper -->
<div id="wrapper">
    <div small-header class="normalheader transition ng-scope small-header">
        <div class="hpanel" tour-step order="1" content="Place your page title and breadcrumb. Select small or large header or give the user choice to change the size." placement="bottom">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-left">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a ui-sref="dashboard"><fmt:message key="common.home" bundle="${msg}" /></a></li>
                        <li ng-repeat="state in $state.$current.path" ng-switch="$last || !!state.abstract" ng-class="{active: $last}">
                            <span data-ng-if="state.data.pageTitle === 'Billing'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.billing" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.billing" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'Current Usage'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="current.usage" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="current.usage" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'Invoices'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="invoice" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="invoice" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'Usage statistics'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="usage.statistics" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="usage.statistics" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'Payments'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="payments" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="payments" bundle="${msg}" /></span>
                            </span>
                        </li>
                    </ol>
                </div>
               <%--  <h2 class="font-light m-b-xs">
                    <span id="instances_page_title" data-ng-if="$state.current.data.pageTitle === 'Current Usage'"><fmt:message key="current.usage" bundle="${msg}" /></span>
                </h2>
                <h2 class="font-light m-b-xs">
                    <span id="instances_page_title" data-ng-if="$state.current.data.pageTitle === 'Invoices'"><fmt:message key="invoice" bundle="${msg}" /></span>
                </h2>
                <h2 class="font-light m-b-xs">
                    <span id="instances_page_title" data-ng-if="$state.current.data.pageTitle === 'Usage statistics'"><fmt:message key="usage.statistics" bundle="${msg}" /></span>
                </h2>
                <h2 class="font-light m-b-xs">
                    <span id="instances_page_title" data-ng-if="$state.current.data.pageTitle === 'Payments'"><fmt:message key="payments" bundle="${msg}" /></span>
                </h2>
                <small>{{ $state.current.data.pageDesc }}</small> --%>
            </div>
        </div>
    </div>
    <div class="content no-margins no-padding">
        <div ui-view class="p-xxs"></div>
    </div>
<div id="footer" ng-include="'app/views/common/footer.jsp'"></div>
</div>