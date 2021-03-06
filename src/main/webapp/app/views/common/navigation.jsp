<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div id="navigation">
    <ul side-navigation class="nav" id="side-menu">
        <li data-ng-if="global.sessionValues.userStatus != 'SUSPENDED'" class="" ng-class="{active: $state.includes('home')}">
            <a ui-sref="dashboard" id="home_navigation_button">
                <span class="pe-7s-home pe-2x nav-menu-icons"></span>
                <span class="nav-label"><fmt:message key="common.home" bundle="${msg}" /> </span>
            </a>
        </li>
        <li  ng-class="{active: $state.includes('organization')}" >
            <a href="#" id="cloud_navigation_button"><span class="pe-7s-culture pe-2x nav-menu-icons"></span> <span class="nav-label"><fmt:message key="common.organization" bundle="${msg}" /> </span><span class="fa arrow"></span> </a>
            <ul class="nav nav-second-level" ng-class="{in: $state.includes('organization')}">
                 <li data-ng-if="global.sessionValues.userStatus != 'SUSPENDED'" ng-class="{active: $state.includes('organization.department')}">
            <a ui-sref="organization.department" id="departments_navigation_button">
                <span class="pe-7s-id pe-lg nav-menu-icons"></span>
                <span class="nav-label"><fmt:message key="common.departments" bundle="${msg}" /></span>
            </a>
        </li>
          <li data-ng-if="global.sessionValues.userStatus != 'SUSPENDED'" ng-class="{active: $state.includes('organization.applications')}">
            <a ui-sref="organization.applications" id="applications_navigation_button">
                <span class="pe-7s-keypad pe-lg nav-menu-icons"></span>
                <span class="nav-label"><fmt:message key="common.applications" bundle="${msg}" /></span>
            </a>
        </li>
        <li data-ng-if="global.sessionValues.userStatus != 'SUSPENDED'" ng-class="{active: $state.includes('organization.projects')}">
            <a ui-sref="organization.projects" id="projects_navigation_button">
                <span class="pe-7s-folder pe-lg nav-menu-icons"></span>
                <span class="nav-label"><fmt:message key="common.projects" bundle="${msg}" /></span>
            </a>
        </li>
        <li data-ng-if="global.sessionValues.userStatus != 'SUSPENDED'" ng-class="{active: $state.includes('organization.accounts')}">
            <a ui-sref="organization.accounts" id="accounts_navigation_button">
                <span class="pe-7s-users pe-lg nav-menu-icons"></span>
                <span class="nav-label"><fmt:message key="common.accounts" bundle="${msg}" /></span>
            </a>
        </li>
         <li data-ng-if="global.sessionValues.userStatus != 'SUSPENDED'" ng-class="{active: $state.includes('organization.roles')}">
            <a ui-sref="organization.roles" id="roles_navigation_button">
                <span class="pe-7s-user pe-lg nav-menu-icons"></span>
                <span class="nav-label"><fmt:message key="common.roles" bundle="${msg}" /></span>
            </a>
         </li>
       </ul>
        </li>
        <li  ng-class="{active: $state.includes('cloud')}" >
            <a href="#" id="cloud_navigation_button"><span class="pe-7s-cloud pe-2x nav-menu-icons"></span> <span class="nav-label"><fmt:message key="common.cloud" bundle="${msg}" /> </span><span class="fa arrow"></span> </a>
            <ul class="nav nav-second-level" ng-class="{in: $state.includes('cloud')}">
                <li ui-sref-active="active"><a ui-sref="cloud.list-instance" id="instances_navigation_button"><span class="pe-7s-monitor pe-lg nav-menu-icons"></span><fmt:message key="common.instance" bundle="${msg}" /> </a></li>
                <li ui-sref-active="active"><a ui-sref="cloud.list-volume" id="volumes_navigation_button"><span class="pe-7s-server pe-lg nav-menu-icons"></span><fmt:message key="common.volume" bundle="${msg}" /> </a></li>
                <li ui-sref-active="active"><a ui-sref="cloud.list-snapshot" id="snapshots_navigation_button"><span class="pe-7s-camera pe-lg nav-menu-icons"></span><fmt:message key="common.snapshot" bundle="${msg}" /> </a></li>
                <li ui-sref-active="active"><a ui-sref="cloud.list-network" id="networks_navigation_button"><span class="pe-7s-science pe-lg nav-menu-icons"></span><fmt:message key="common.network" bundle="${msg}" /> </a></li>
                <li ui-sref-active="active"><a ui-sref="cloud.list-ssh" id="ssh_keys_navigation_button"><span class="pe-7s-key pe-lg nav-menu-icons"></span><fmt:message key="common.ssh.keys" bundle="${msg}" /> </a></li>
                <li ui-sref-active="active"><a ui-sref="cloud.list-affinity" id="affinity_keys_navigation_button"><span class="pe-7s-target pe-lg nav-menu-icons"></span><fmt:message key="common.affinity.group" bundle="${msg}" /> </a></li>
                <li ui-sref-active="active" ui-sref="cloud.quota-limit" id="quota_limits_navigation_button"><a href="#"><span class="pe-7s-graph pe-lg nav-menu-icons"></span><fmt:message key="common.quota.limit" bundle="${msg}" /> </a></li>
            </ul>
        </li>
        <li data-ng-if="global.sessionValues.userStatus != 'SUSPENDED'" ng-class="{active: $state.includes('vpc')}">
            <a ui-sref="vpc" id="vpc_navigation_button">
                <span class="fa fa-soundcloud fa-2x nav-menu-icons"></span>
                <span class="nav-label"><fmt:message key="common.vpc" bundle="${msg}" /></span>
            </a>
        </li>
        <li data-ng-if="global.sessionValues.userStatus != 'SUSPENDED'" ng-class="{active: $state.includes('vpn-customer-gateway')}">
            <a ui-sref="vpngateway" id="vpn_navigation_button">
                <span class="pe-7s-network  pe-2x nav-menu-icons pull-left"></span>
                <span class="nav-label"><fmt:message key="common.vpn.customer.gateway" bundle="${msg}" /></span>
            </a>
        </li>
        <li data-ng-if="global.sessionValues.userStatus != 'SUSPENDED'" ng-class="{active: $state.includes('template-store')}">
            <a ui-sref="template-store" id="templates_navigation_button">
                <!--<span class="pe-7s-display2 pe-2x nav-menu-icons"></span>-->
                <img src="images/icon-template.png" border="0" class="sidemenu-icons">
                <span class="nav-label"><fmt:message key="common.templates" bundle="${msg}" /></span>
            </a>
        </li>
        <li data-ng-if="global.sessionValues.userStatus != 'SUSPENDED'"  ng-class="{active: $state.includes('services')}">
            <a ui-sref="services" id="services_navigation_button">
                <img src="images/icon-services.png" border="0" class="sidemenu-icons">
                <span class="nav-label"><fmt:message key="common.services" bundle="${msg}" /></span>
            </a>
        </li>
    </ul>
</div>
