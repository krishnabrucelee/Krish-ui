<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="hpanel" >
<div class="row m-l-sm m-r-sm panel-body" data-ng-controller="networksCtrl" >

    <ul class="nav nav-tabs" data-ng-init="templateCategory = tabview">
        <li data-ng-class="{'active' : tabview == 'details'}"><a href="javascript:void(0)" data-ng-click="templateCategory = 'details'" data-toggle="tab">  <i class="fa fa-list"></i> Details</a></li>
        <li data-ng-class="{'active' : tabview == 'firewall'}"><a  data-ng-click="firewallRule(1)" data-toggle="tab"><i class="custom-icon custom-firewall-ip"></i> Firewall</a></li>
        <li data-ng-class="{'active' : tabview == 'port-forward'}"><a  data-ng-click="portRulesLists(1)" data-toggle="tab"> <i class="fa fa-mail-forward"></i> Port Forwarding</a></li>
        <li data-ng-class="{'active' : tabview == 'load-balance'}"><a data-ng-click="templateCategory = 'load-balance'" data-toggle="tab"> <i class="custom-icon custom-load-ip"></i> Load Balancing</a></li>
        <li data-ng-show="ipDetails.vpnState == 'RUNNING'" data-ng-class="{'active' : tabview == 'vpn-details'}"><a data-ng-click="templateCategory = 'vpn-details'" data-toggle="tab"> <i class="custom-icon custom-icon-ip"></i> VPN</a></li>
    </ul>

    <div class="tab-content">
        <div class="tab-pane" data-ng-class="{'active' : templateCategory == 'details'}" id="step1-dashboard">
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

