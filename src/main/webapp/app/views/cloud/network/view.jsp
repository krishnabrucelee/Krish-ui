<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="hpanel" ui-view>
<div data-ng-if="global.webSocketLoaders.networkLoader" class="overlay-wrapper">
                		            <img data-ng-if="global.webSocketLoaders.networkLoader" src="images/loading-bars.svg" class="inner-loading" />
 </div>
<div class="row m-l-sm m-r-sm panel-body" data-ng-controller="networksCtrl">
     <ul class="nav nav-tabs" data-ng-init="templateCategorys = tabviews">
        <li data-ng-class="{'active' : tabviews == 'details'}"><a href="javascript:void(0)" data-ng-click="edit($state.params.id)" data-toggle="tab">  <i class="fa fa-list"></i> <fmt:message key="common.details" bundle="${msg}" /></a></li>
        <li data-ng-if = "persistNetwork.networkCreationType != 'VPC'" data-ng-class="{'active' : tabviews == 'egress'}"><a  data-ng-click="firewallRulesLists(1)" data-toggle="tab"><!--<i class="fa fa-sign-in"></i>--> <i class="custom-icon custom-icon-egress"></i><fmt:message key="common.egressrule" bundle="${msg}" /></a></li>
        <li data-ng-if = "persistNetwork.networkCreationType != 'VPC'" data-ng-class="{'active' : tabviews == 'ip'}"><a  data-ng-click="ipLists(1)" data-toggle="tab"> <!--<i class="fa fa-sitemap"></i>--> <i class="custom-icon custom-icon-ip"></i><fmt:message key="ip.address" bundle="${msg}" /></a></li>
        <li data-ng-class="{'active' : tabviews == 'instance'}"><a data-ng-click="vmLists(1)" data-toggle="tab"> <i class="fa fa-cloud"></i> <fmt:message key="common.instance" bundle="${msg}" /></a></li>
    </ul>
     <div class="tab-content">
     <div data-ng-if = "showLoaderOffer" style="margin: 20%">
                <get-loader-image data-ng-if="showLoaderOffer"></get-loader-image>
            </div>
        <div class="tab-pane" data-ng-class="{'active' : templateCategorys == 'details'}" id="step1-dashboard">
            <div data-ng-include src="'app/views/cloud/network/details.jsp'"></div>
        </div>
        <div class="tab-pane"  data-ng-class="{'active' : templateCategorys == 'egress'}" id="step1-config">
            <div data-ng-include src="'app/views/cloud/network/egress.jsp'"></div>
        </div>
        <div class="tab-pane"  data-ng-class="{'active' : templateCategorys == 'ip'}" id="step1-storage">
            <div data-ng-include src="'app/views/cloud/network/ip-address.jsp'"></div>
        </div>
        <div class="tab-pane"  data-ng-class="{'active' : templateCategorys == 'instance'}" id="step1-network">
       		 <div data-ng-include src="'app/views/cloud/network/instance.jsp'"></div>
        </div>
     </div>
 </div>
</div>

