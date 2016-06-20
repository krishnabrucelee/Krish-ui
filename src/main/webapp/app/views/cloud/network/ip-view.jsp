<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="hpanel" >
<div class="row m-l-sm m-r-sm panel-body" data-ng-controller="networksCtrl" >

    <ul class="nav nav-tabs" data-ng-init="templateCategory = 'ipdetails'">
        <li data-ng-class="{'active' : templateCategory == 'ipdetails'}"><a href="javascript:void(0)" data-ng-click="templateCategory = 'ipdetails'" data-toggle="tab">  <i class="fa fa-list"></i> <fmt:message key="common.details" bundle="${msg}" /></a></li>
        <li data-ng-class="{'active' : templateCategory == 'firewall'}"><a  data-ng-click="firewallRule(1)" data-toggle="tab"><i class="custom-icon custom-firewall-ip"></i> <fmt:message key="firewall" bundle="${msg}" /></a></li>
        <li data-ng-if = "!ipDetails.isStaticnat" data-ng-class="{'active' : templateCategory == 'port-forward'}"><a  data-ng-click="portRulesLists(1)" data-toggle="tab"> <i class="fa fa-mail-forward"></i> <fmt:message key="port.forwarding" bundle="${msg}" /></a></li>
        <li data-ng-if = "!ipDetails.isStaticnat" data-ng-class="{'active' : templateCategory == 'load-balance'}"><a data-ng-click="LBlist(1)" data-toggle="tab"> <i class="custom-icon custom-load-ip"></i> <fmt:message key="load.balancing" bundle="${msg}" /></a></li>
        <li data-ng-show="ipDetails.vpnState == 'RUNNING'" data-ng-class="{'active' : templateCategory == 'vpn-details'}"><a data-ng-click="templateCategory = 'vpn-details'" data-toggle="tab"> <i class="custom-icon custom-icon-ip"></i> <fmt:message key="vpn" bundle="${msg}" /></a></li>
    </ul>

    <div class="tab-content">
        <div class="tab-pane" data-ng-class="{'active' : templateCategory == 'ipdetails'}" id="step1-dashboard">
            <div data-ng-include src="'app/views/cloud/network/ip-details.jsp'"></div>
        </div>
        <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'firewall'}" id="step1-config">
            <div data-ng-include src="'app/views/cloud/network/firewall.jsp'"></div>
        </div>
        <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'port-forward'}" id="step1-storage">
            <div data-ng-include src="'app/views/cloud/network/port-forward.jsp'"></div>
        </div>
        <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'load-balance'}" id="step1-network">
            <div data-ng-include src="'app/views/cloud/network/load-balance.jsp'"></div>
        </div>
        <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'vpn-details'}" id="step1-vpn">
            <div data-ng-include src="'app/views/cloud/network/vpn-details.jsp'"></div>
        </div>
    </div>

</div>
</div>

