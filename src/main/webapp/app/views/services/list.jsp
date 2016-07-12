<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<!-- Header -->
<div id="header" ng-include="'app/views/common/header.jsp'"></div>

<!-- Navigation -->
<aside id="menu" ng-include="'app/views/common/navigation.jsp'"></aside>
<div id="wrapper">
<div small-header class="normalheader transition ng-scope small-header">
        <div class="hpanel" tour-step order="1" content="Place your page title and breadcrumb. Select small or large header or give the user choice to change the size." placement="bottom">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-left">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a ui-sref="dashboard"><fmt:message key="common.home" bundle="${msg}" /></a></li>
                        <li ng-repeat="state in $state.$current.path" ng-switch="$last || !!state.abstract" ng-class="{active: $last}">
                            <span data-ng-if="state.data.pageTitle === 'Services'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.services" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.services" bundle="${msg}" /></span>
                            </span>

                        </li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

<div class="content"  ui-view>
    <div class="hpanel">
        <div class="row m-l-sm m-r-sm panel-body" ng-controller="servicesCtrl">
            <ul class="nav nav-tabs">
                <li data-ng-class="{'active' : activitytab == 'service'}"><a
                        data-ng-click="getservice('service')" data-toggle="tab"> <i
                            class="fa fa-list-ul"></i> <fmt:message key="common.services"
                            bundle="${msg}" /></a></li>
                <li data-ng-class="{'active' : activitytab == 'myservices'}" ><a
                        data-ng-click="getmyservice('myservice')" data-toggle="tab">
                        <i class="fa fa-list-alt"></i> <fmt:message
                            key="common.my.service" bundle="${msg}" />
                    </a></li>
            </ul>
            <div class="tab-content">
                <div  class="tab-pane"
                     data-ng-class="{'active' : activitytab == 'service'}" data-ng-include src="'app/views/services/index.jsp'"
                     id="events">
                </div>
                <div class="tab-pane "
                     data-ng-class="{'active' : activitytab == 'myservice'}" data-ng-include src="'app/views/services/myservice.jsp'"
                     id="alerts">
                </div>
            </div>
        </div>
    </div>
    <div id="footer" ng-include="'app/views/common/footer.jsp'"></div>

</div>
</div>
