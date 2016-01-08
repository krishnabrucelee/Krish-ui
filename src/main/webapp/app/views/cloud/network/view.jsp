<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="hpanel" ui-view>
<div class="row m-l-sm m-r-sm panel-body" data-ng-controller="networksCtrl">
     <ul class="nav nav-tabs" data-ng-init="templateCategory = tabview">
        <li data-ng-class="{'active' : tabview != 'egress'}"><a href="javascript:void(0)" data-ng-click="templateCategory = 'details'" data-toggle="tab">  <i class="fa fa-list"></i> <fmt:message key="common.details" bundle="${msg}" /></a></li>
        <li data-ng-class="{'active' : tabview == 'egress'}"><a  data-ng-click="templateCategory = 'egress'" data-toggle="tab"><!--<i class="fa fa-sign-in"></i>--> <i class="custom-icon custom-icon-egress"></i><fmt:message key="common.egressrule" bundle="${msg}" /></a></li>
        <li ><a  data-ng-click="templateCategory = 'ip'" data-toggle="tab"> <!--<i class="fa fa-sitemap"></i>--> <i class="custom-icon custom-icon-ip"></i><fmt:message key="ip.address" bundle="${msg}" /></a></li>
        <li ><a data-ng-click="templateCategory = 'instance'" data-toggle="tab"> <i class="fa fa-cloud"></i> <fmt:message key="common.instance" bundle="${msg}" /></a></li>
    </ul>
     <div class="tab-content">
        <div class="tab-pane" data-ng-class="{'active' : templateCategory == 'details'}" id="step1-dashboard">
            <div data-ng-include src="'app/views/cloud/network/details.jsp'"></div>
         </div>
          <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'egress'}" id="step1-config">
            <div data-ng-include src="'app/views/cloud/network/egress.jsp'"></div>
        </div>
        <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'ip'}" id="step1-storage">
            <div data-ng-include src="'app/views/cloud/network/ip-address.jsp'"></div>
        </div>
        <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'instance'}" id="step1-network">
        <div data-ng-include src="'app/views/cloud/network/instance.jsp'"></div>
        </div>
     </div>
 </div>
</div>

