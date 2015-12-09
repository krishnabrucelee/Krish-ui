<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div id="navigation">
    <ul side-navigation class="nav" id="side-menu">
        <li class="" ng-class="{active: $state.includes('home')}">
            <a ui-sref="dashboard">
                <span class="pe-7s-home pe-2x nav-menu-icons"></span>
                <span class="nav-label"><fmt:message key="common.home" bundle="${msg}" /> </span>
            </a>
        </li>
        <li ng-class="{active: $state.includes('cloud')}" >
            <a href="#"><span class="pe-7s-cloud pe-2x nav-menu-icons"></span> <span class="nav-label"><fmt:message key="common.cloud" bundle="${msg}" /> </span><span class="fa arrow"></span> </a>
            <ul class="nav nav-second-level" ng-class="{in: $state.includes('cloud')}">
                <li ui-sref-active="active"><a ui-sref="cloud.list-instance"><fmt:message key="common.instance" bundle="${msg}" /> </a></li>
                <li ui-sref-active="active"><a ui-sref="cloud.list-volume"><fmt:message key="common.volume" bundle="${msg}" /> </a></li>
                <li ui-sref-active="active"><a ui-sref="cloud.list-snapshot"><fmt:message key="common.snapshot" bundle="${msg}" /> </a></li>
                <li ui-sref-active="active"><a ui-sref="cloud.list-network"><fmt:message key="common.network" bundle="${msg}" /> </a></li>
                <li ui-sref-active="active"><a ui-sref="cloud.list-ssh"><fmt:message key="common.ssh.keys" bundle="${msg}" /> </a></li>
                <li ui-sref-active="active" ui-sref="cloud.quota-limit"><a href="#"><fmt:message key="common.quota.limit" bundle="${msg}" /> </a></li>
            </ul>
        </li>
        <li ng-class="{active: $state.includes('vpc')}">
            <a ui-sref="vpc">
                <span class="fa fa-soundcloud fa-2x nav-menu-icons"></span>
                <span class="nav-label"><fmt:message key="common.vpc" bundle="${msg}" /></span>
            </a>
        </li>
        <li ng-class="{active: $state.includes('template-store')}">
            <a ui-sref="template-store">
                <!--<span class="pe-7s-display2 pe-2x nav-menu-icons"></span>-->
                <img src="images/icon-template.png" border="0" class="sidemenu-icons">
                <span class="nav-label"><fmt:message key="common.templates" bundle="${msg}" /></span>
            </a>
        </li>
        <li  ng-class="{active: $state.includes('services')}">
            <a ui-sref="services">
                <img src="images/icon-services.png" border="0" class="sidemenu-icons">
                <span class="nav-label"><fmt:message key="common.services" bundle="${msg}" /></span>
            </a>
        </li>
        <li ng-class="{active: $state.includes('projects')}">
            <a ui-sref="projects">
                <span class="pe-7s-folder pe-2x nav-menu-icons"></span>
                <span class="nav-label"><fmt:message key="common.projects" bundle="${msg}" /></span>
            </a>
        </li>
        <li ng-class="{active: $state.includes('applications')}">
            <a ui-sref="applications">
                <span class="pe-7s-keypad pe-2x nav-menu-icons"></span>
                <span class="nav-label"><fmt:message key="common.applications" bundle="${msg}" /></span>
            </a>
        </li>
        <li ng-class="{active: $state.includes('accounts')}">
            <a ui-sref="accounts">
                <span class="pe-7s-users pe-2x nav-menu-icons"></span>
                <span class="nav-label"><fmt:message key="common.accounts" bundle="${msg}" /></span>
            </a>
        </li>
         <li ng-class="{active: $state.includes('roles')}">
            <a ui-sref="roles">
                <span class="pe-7s-user pe-2x nav-menu-icons"></span>
                <span class="nav-label"><fmt:message key="common.roles" bundle="${msg}" /></span>
            </a>
         </li>
         <li ng-class="{active: $state.includes('department')}">
            <a ui-sref="department">
                <span class="pe-7s-network pe-2x nav-menu-icons"></span>
                <span class="nav-label"><fmt:message key="common.departments" bundle="${msg}" /></span>
            </a>
        </li>

           <li ng-class="{active: $state.includes('domain')}">
            <a ui-sref="domain">
                <span class="pe-7s-network pe-2x nav-menu-icons"></span>
                <span class="nav-label"><fmt:message key="common.domain" bundle="${msg}" /></span>
            </a>
        </li>
    </ul>
</div>

