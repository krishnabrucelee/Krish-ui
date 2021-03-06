<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="hpanel" >
<div class="row m-l-sm m-r-sm panel-body" data-ng-controller="vpcCtrl" >

    <ul class="nav nav-tabs" data-ng-init="tabview = 'ipdetails'">
        <li data-ng-class="{'active' : tabview == 'ipdetails'}"><a href="javascript:void(0)" data-ng-click="tabview = 'ipdetails'" data-toggle="tab">  <i class="fa fa-list"></i> <fmt:message key="common.details" bundle="${msg}" /></a></li>
        <li data-ng-if = "!ipDetails.isStaticnat && !ipDetails.isSourcenat"  data-ng-class="{'active' : tabview == 'port-forward'}"><a  data-ng-click="portRulesLists(1)" data-toggle="tab"> <i class="fa fa-mail-forward"></i> <fmt:message key="port.forwarding" bundle="${msg}" /></a></li>
        <li data-ng-if = "!ipDetails.isStaticnat && !ipDetails.isSourcenat" data-ng-class="{'active' : tabview == 'load-balance'}"><a data-ng-click="LBlist(1)" data-toggle="tab"> <i class="custom-icon custom-load-ip"></i> <fmt:message key="load.balancing" bundle="${msg}" /></a></li>
        <li data-ng-show="ipDetails.vpnState == 'RUNNING'" data-ng-class="{'active' : tabview == 'vpn-details'}"><a data-ng-click="tabview = 'vpn-details'" data-toggle="tab"> <i class="custom-icon custom-icon-ip"></i> <fmt:message key="vpn" bundle="${msg}" /></a></li>
    </ul>

    <div class="tab-content">
        <div class="tab-pane" data-ng-class="{'active' : tabview == 'ipdetails'}" id="step1-dashboard">
            <div data-ng-include src="'app/views/vpc/ip-details.jsp'"></div>
        </div>
        <div class="tab-pane"  data-ng-class="{'active' : tabview == 'port-forward'}" id="step1-storage">
            <div data-ng-include src="'app/views/vpc/port-forward.jsp'"></div>
        </div>
        <div class="tab-pane"  data-ng-class="{'active' : tabview == 'load-balance'}" id="step1-network">
            <div data-ng-include src="'app/views/vpc/load-balance.jsp'"></div>
        </div>
        <div class="tab-pane"  data-ng-class="{'active' : tabview == 'vpn-details'}" id="step1-vpn">
            <div data-ng-include src="'app/views/vpc/vpn-details.jsp'"></div>
        </div>
    </div>

</div>
</div>

