<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div ui-view>
    <div class="hpanel">
        <div class="row m-l-sm m-r-sm panel-body" ng-controller="vpcCtrl">
            <ul class="nav nav-tabs">
                <li data-ng-class="{'active' : activitytab.category == 'vpngateway'}"><a
                        data-ng-click="getvpngateway('vpngateway')" data-toggle="tab"> <i
                            class="fa fa-list-ul"></i> <fmt:message key="common.vpn.gateway"
                            bundle="${msg}" /></a></li>
                <li data-ng-class="{'active' : activitytab.category == 'vpnconnection'}"><a
                        data-ng-click="getvpnconnection('vpnconnection')" data-toggle="tab">
                        <i class="fa fa-list-alt"></i> <fmt:message
                            key="common.vpn.connections" bundle="${msg}" />
                    </a></li>
            </ul>
            <div class="tab-content">
                <div  class="tab-pane"
                     data-ng-class="{'active' : activitytab.category == 'vpngateway'}" data-ng-include src="'app/views/vpc/vpn-gateway.jsp'"
                     id="events">
                </div>
                <div class="tab-pane "
                     data-ng-class="{'active' : activitytab.category == 'vpnconnection'}" data-ng-include src="'app/views/vpc/vpnconnection.jsp'"
                     id="alerts">
                </div>
            </div>
        </div>
    </div>
</div>

