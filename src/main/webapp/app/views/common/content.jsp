<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                           <span data-ng-if="state.data.pageTitle === 'common.cloud'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.cloud" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.cloud" bundle="${msg}" /></span>
                            </span>
                             <span data-ng-if="state.data.pageTitle === 'common.organization'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.organization" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.organization" bundle="${msg}" /></span>
                            </span>
                           <span data-ng-if="state.data.pageTitle === 'common.instances'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.instances" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.instances" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'common.snapshot'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.snapshots" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.snapshots" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'common.quota.limit'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.quota.limit" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.quota.limit" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'common.monitor'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.monitor" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.monitor" bundle="${msg}" /></span>
	                    	</span>
                            <span data-ng-if="state.data.pageTitle === 'common.volume'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.volumes" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.volumes" bundle="${msg}" /></span>
                            </span>
                             <span data-ng-if="state.data.pageTitle === 'common.network'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.networks" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.networks" bundle="${msg}" /></span>
                            </span>
                             <span data-ng-if="(state.data.pageTitle === 'view.network')">
	                            <a ng-switch-when="false" ng-href="{{'#/network/list/view/'+state.data.id}}" >{{ state.data.pageName }}</a>
	                            <span ng-switch-when="true">{{ state.data.pageName }}</span>
	                        </span>
                            <span data-ng-if="(state.data.pageTitle === 'view.instance')">
	                            <a ng-switch-when="false" ng-href="{{'#/instance/list/view/'+state.data.id}}">{{ state.data.pageName }}</a>
	                            <span ng-switch-when="true">{{ state.data.pageName }}</span>
	                        </span>
	                        <span data-ng-if="state.data.pageTitle === 'Secondary IP Address'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="secondary.ip.address" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="secondary.ip.address" bundle="${msg}" /></span>
	                   		</span>
	                    	<span data-ng-if="state.data.pageTitle === 'ip.address'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="ip.address" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="ip.address" bundle="${msg}" /></span>
	                   		</span>
                            <span data-ng-if="state.data.pageTitle === 'common.ssh.keys'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.ssh.keys" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.ssh.keys" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'common.affinity.group'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.affinity.group" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.affinity.group" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'common.departments'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.department" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.departments" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'common.applications'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.applications" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.applications" bundle="${msg}" /></span>
                            </span>
                             <span data-ng-if="state.data.pageTitle === 'common.projects'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.projects" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.projects" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'common.host'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.host" bundle="${msg}" /></a>
	                            <a ng-href="{{'#/instance/list/view/'}}" + "{{ $stateParams.id }}" ><span ng-switch-when="true" >{{$stateParams.id}}{{ state.data.pageName }}</span></a>
	                    	</span>
	                    	  <span data-ng-if="state.data.pageTitle === 'quota.limit'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="quota.limit" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="quota.limit" bundle="${msg}" /></span>
                            </span>
                             <span data-ng-if="state.data.pageTitle === 'view.projects'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="view.projects" bundle="${msg}" /></a>
	                            <span ng-switch-when="true">{{ state.data.pageName }}</span>
	                    	</span>
	                    	<span data-ng-if="state.data.pageTitle === 'common.accounts'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.accounts" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.accounts" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'common.roles'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.roles" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.roles" bundle="${msg}" /></span>
                            </span>
                             <span data-ng-if="state.data.pageTitle === 'add.role'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="add.role" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="add.role" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'edit.role'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="edit.role" bundle="${msg}" /></a>
	                            <span ng-switch-when="true">{{ state.data.pageName }}</span>
                            </span>
                        </li>
                    </ol>
                </div>
               <%--  <h2 class="font-light m-b-xs">
                    <span id="instances_page_title" data-ng-if="$state.current.data.pageTitle === 'common.instances'"><fmt:message key="common.instances" bundle="${msg}" /></span>
                </h2>
                <h2 class="font-light m-b-xs">
                    <span id="projects_page_title" data-ng-if="$state.current.data.pageTitle === 'common.projects'"><fmt:message key="common.projects" bundle="${msg}" /></span>
                </h2>
                <h2 class="font-light m-b-xs">
                    <span id="volume_page_title" data-ng-if="$state.current.data.pageTitle === 'common.volume'"><fmt:message key="common.volumes" bundle="${msg}" /></span>
                </h2>
                <h2 class="font-light m-b-xs">
                    <span id="network_page_title" data-ng-if="$state.current.data.pageTitle === 'common.network'"><fmt:message key="common.networks" bundle="${msg}" /></span>
                </h2>
                <h2 class="font-light m-b-xs">
                    <span id="snapshot_page_title" data-ng-if="$state.current.data.pageTitle === 'common.snapshot'"><fmt:message key="common.snapshots" bundle="${msg}" /></span>
                </h2>
                <h2 class="font-light m-b-xs">
                    <span id="ssh_key_page_title" data-ng-if="$state.current.data.pageTitle === 'common.ssh.keys'"><fmt:message key="common.ssh.keys" bundle="${msg}" /></span>
                </h2>
                <h2 class="font-light m-b-xs">
                    <span id="affinity_group_page_title" data-ng-if="$state.current.data.pageTitle === 'common.affinity.group'"><fmt:message key="common.affinity.group" bundle="${msg}" /></span>
                </h2>
                <h2 class="font-light m-b-xs">
                    <span id="quota_limit_page_title" data-ng-if="$state.current.data.pageTitle === 'common.quota.limit'"><fmt:message key="common.quota.limit" bundle="${msg}" /></span>
                </h2>
                <h2 class="font-light m-b-xs">
                    <span id="view_instance_page_title" data-ng-if="$state.current.data.pageTitle === 'view.instance'">{{ $state.current.data.pageName }}</span>
                </h2>
                <h2 class="font-light m-b-xs">
                    <span id="secondary_ip_address_page_title" data-ng-if="$state.current.data.pageTitle === 'Secondary IP Address'"><fmt:message key="secondary.ip.address" bundle="${msg}" /></span>
                </h2>
                <h2 class="font-light m-b-xs">
                    <span id="view_network_page_title" data-ng-if="$state.current.data.pageTitle === 'view.network'">{{ $state.current.data.pageName }}</span>
                </h2>
                <h2 class="font-light m-b-xs">
                    <span id="ip_address_page_title" data-ng-if="$state.current.data.pageTitle === 'ip.address'"><fmt:message key="ip.address" bundle="${msg}" /></span>
                </h2>
                <small>{{ $state.current.data.pageDesc}}</small> --%>
            </div>
        </div>
    </div>
    <div class="content">
        <div ui-view ></div>
    </div>
<div id="footer" ng-include="'app/views/common/footer.jsp'"></div>
</div>