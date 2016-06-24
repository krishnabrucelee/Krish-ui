<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div data-ng-controller="networksCtrl">
<div class="white-content" >
<div data-ng-if="global.webSocketLoaders.ingressLoader" class="overlay-wrapper">
   <get-show-loader-image data-ng-show="global.webSocketLoaders.ingressLoader"></get-show-loader-image>

</div>
	<form name = "ingressForm" novalidate data-ng-submit="ingressSave(ingressForm,firewallRuleIngress)" method="post">

<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th class="col-md-2 col-xs-2"><fmt:message key="source.cidr" bundle="${msg}" /></th>
                    <th class="col-md-2 col-xs-2"><fmt:message key="common.protocol" bundle="${msg}" /></th>
                    <th class="col-md-1 col-xs-1"><fmt:message key="common.start.port" bundle="${msg}" /></th>
                    <th class="col-md-1 col-xs-1"><fmt:message key="common.end.port" bundle="${msg}" /></th>
                    <th class="col-md-1 col-xs-1"><fmt:message key="icmp.type" bundle="${msg}" /></th>
                    <th class="col-md-1 col-xs-1"><fmt:message key="icmp.code" bundle="${msg}" /></th>
                    <th class="col-md-1 col-xs-1"><fmt:message key="common.add.rule" bundle="${msg}" /></th>
                    <th class="col-md-2 col-xs-2"><fmt:message key="common.status" bundle="${msg}" /></th>
                    <th class="col-md-1 col-xs-1"><fmt:message key="action" bundle="${msg}" /></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><input required="true" type="text" name="sourceCIDR"  valid-cidr placeholder="0.0.0.0/24"  data-ng-model="firewallRuleIngress.sourceCIDR" class="form-control input-group " ><span class="text-center text-danger" data-ng-show="ingressForm.sourceCIDR.$invalid && formSubmitted" data-ng-class="cidrValidates && actionRules ? 'text-danger' : ''"> <fmt:message key="invalid.format" bundle="${msg}" /></span></td>
                    <td><select required="true" class="form-control input-group" name="protocol" data-ng-model="firewallRuleIngress.protocol"  data-ng-change="selectProtocol(protocol)" ng-options="protocol for (id, protocol) in protocolLists"><option value=""><fmt:message key="common.select"
													bundle="${msg}" /></option></select> <span class="text-center text-danger" data-ng-show="ingressForm.protocol.$invalid && formSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span></td>
                    <td><input required="true" valid-number  data-ng-if="(firewallRuleIngress.protocol == 'TCP') || (firewallRuleIngress.protocol == 'UDP')"  placeholder="1" data-ng-min="1" data-ng-max="65535"   type="text" name="startPort" data-ng-model="firewallRuleIngress.startPort" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="ingressForm.startPort.$invalid && formSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span> </td>
                    <td><input required="true" valid-number  data-ng-if="(firewallRuleIngress.protocol == 'TCP') || (firewallRuleIngress.protocol == 'UDP')" placeholder="65535" data-ng-min="1" data-ng-max="65535"   type="text" name="endPort" data-ng-model="firewallRuleIngress.endPort" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="ingressForm.endPort.$invalid && formSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span> </td>
                    <td><input required="true"   data-ng-if="(firewallRuleIngress.protocol == 'ICMP') " valid-integer name="icmpType" data-ng-model="firewallRuleIngress.icmpType" class="form-control " autofocus type="text"><span class="text-center text-danger" data-ng-show="ingressForm.icmpType.$invalid && formSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span> </td>
                    <td ><input required="true" valid-integer data-ng-if= "firewallRuleIngress.protocol == 'ICMP'"  name="icmpCode" data-ng-model="firewallRuleIngress.icmpCode" class="form-control " autofocus type="text"><span class="text-center text-danger" data-ng-show="ingressForm.icmpCode.$invalid && formSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span> </td>
                    <td>

                      <get-loader-image data-ng-show="showLoader"></get-loader-image>
                      <button class="btn btn-info"  data-ng-if="!showLoader" type="submit"><span class="pe-7s-plus pe-lg font-bold m-r-xs" ></span><fmt:message key="common.add.rule" bundle="${msg}" /></button>

                        <!-- <a data-ng-show="delete" class="btn btn-info" data-ng-click="openAddIsolatedNetwork('lg')"><span class="pe-7s-trash pe-lg font-bold m-r-xs"></span></a> -->
                    </td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
</form>
    <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
          <thead>
                <tr>
                    <th class="col-md-2 col-xs-2"></th>
                    <th class="col-md-2 col-xs-2"></th>
                    <th class="col-md-1 col-xs-1"></th>
                    <th class="col-md-1 col-xs-1"></th>
                    <th class="col-md-1 col-xs-1"></th>
                    <th class="col-md-1 col-xs-1"></th>
                    <th class="col-md-1 col-xs-1"></th>
                    <th class="col-md-2 col-xs-2"></th>
                    <th class="col-md-1 col-xs-1"></th>
                </tr>
            </thead>
            <tbody>
               <tr ng-repeat="firewallRules in firewallRulesList" class="font-bold text-center">
             	<td>{{firewallRules.sourceCIDR}}</td>
		        <td>{{firewallRules.protocol}}</td>
                <td><div  data-ng-show = " (firewallRules.startPort == '' || firewallRules.startPort!='') ">{{firewallRules.startPort}}</div></td>
                <td><div data-ng-show= " (firewallRules.endPort =='' || firewallRules.endPort!='')">{{firewallRules.endPort}} </div></td>
                <td> <div  data-ng-show=" (firewallRules.icmpMessage=='' || firewallRules.icmpMessage!='') ">{{firewallRules.icmpMessage}}</div></td>
                <td> <div data-ng-show="(firewallRules.icmpCode=='' || firewallRules.icmpCode!='')" >{{firewallRules.icmpCode}}</div></td>
       			<td><div style="width:107px;"></div></td>
                <td><span ng-if = "firewallRules.isActive">Active</span></td>
                <td><a data-ng-click="deleteIngress('sm', firewallRules)"><span class="fa fa-trash"></span></a>
                </td>
	        </tr>
            </tbody>
    </table>


</div></div>
