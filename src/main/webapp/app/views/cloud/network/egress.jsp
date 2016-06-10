<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div data-ng-controller="networksCtrl">
<div data-ng-if="global.webSocketLoaders.egressLoader" class="overlay-wrapper">
   <img data-ng-if="global.webSocketLoaders.egressLoader" src="images/loading-bars.svg" class="inner-loading"/>
</div>
	<form name = "egressForm" novalidate data-ng-submit="egressSave(egressForm,firewallRules)" method="post">
        <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th class="col-md-3 col-xs-3"><fmt:message key="source.cidr" bundle="${msg}" /></th>
                    <th class="col-md-2 col-xs-2"><fmt:message key="common.protocol" bundle="${msg}" /></th>
                    <th class="col-md-2 col-xs-2" data-ng-if="(firewallRules.protocol == 'TCP') || (firewallRules.protocol == 'UDP')"><fmt:message key="common.start.port" bundle="${msg}" /></th>
                    <th class="col-md-2 col-xs-2"data-ng-if="(firewallRules.protocol == 'TCP') || (firewallRules.protocol == 'UDP')"><fmt:message key="common.end.port" bundle="${msg}" /></th>
                    <th class="col-md-2 col-xs-2" data-ng-if="firewallRules.protocol == 'ICMP'"><fmt:message key="icmp.type" bundle="${msg}" /></th>
                    <th class="col-md-2 col-xs-2" data-ng-if="firewallRules.protocol == 'ICMP'"><fmt:message key="icmp.code" bundle="${msg}" /></th>
                    <th class="col-md-3 col-xs-3"><fmt:message key="action" bundle="${msg}" /></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                       <td><input required="true" type="text" name="sourceCIDR"  valid-cidr placeholder="0.0.0.0/24"  data-ng-model="firewallRules.sourceCIDR" class="form-control input-group " >
                       <span class="text-center text-danger" data-ng-show="egressForm.sourceCIDR.$invalid && formSubmitted" data-ng-class="cidrValidate && actionRule ? 'text-danger' : ''"> <fmt:message key="invalid.format" bundle="${msg}" /></span></td>
                    <td><select required="true" class="form-control input-group" name="protocol" data-ng-model="firewallRules.protocol"  data-ng-change="selectProtocol(firewallRules.protocol)" ng-options="protocol for (id, protocol) in protocolList"><option value=""><fmt:message key="common.select"
													bundle="${msg}" /></option></select> <span class="text-center text-danger" data-ng-show="egressForm.protocol.$invalid && formSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span></td>
                    <td data-ng-if="(firewallRules.protocol == 'TCP') || (firewallRules.protocol == 'UDP')"><input required="true" valid-number  placeholder="1" data-ng-min="1" data-ng-max="65535"   type="text" name="startPort" data-ng-model="firewallRules.startPort" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="egressForm.startPort.$invalid && formSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span> </td>
                    <td data-ng-if="(firewallRules.protocol == 'TCP') || (firewallRules.protocol == 'UDP')"><input required="true" valid-number placeholder="65535" data-ng-min="1" data-ng-max="65535"   type="text" name="endPort" data-ng-model="firewallRules.endPort" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="egressForm.endPort.$invalid && formSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span> </td>
                    <td data-ng-if="firewallRules.protocol == 'ICMP'"><input valid-integer name="icmpMessage" required="true" data-ng-model="firewallRules.icmpMessage" class="form-control " autofocus type="text"><span class="text-center text-danger" data-ng-show="egressForm.icmpMessage.$invalid && formSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span></td>
                    <td data-ng-if="firewallRules.protocol == 'ICMP'"><input valid-integer name="icmpCode" required="true" data-ng-model="firewallRules.icmpCode" class="form-control " autofocus type="text"><span class="text-center text-danger" data-ng-show="egressForm.icmpCode.$invalid && formSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span></td>
                    <td>
                        <get-loader-image data-ng-show="showLoader"></get-loader-image>
                        <button class="btn btn-info"  data-ng-if="!showLoader" type="submit"><span class="pe-7s-plus pe-lg font-bold m-r-xs" ></span><fmt:message key="add.rule" bundle="${msg}" /></button>
                        <!-- <a data-ng-show="delete" class="btn btn-info" data-ng-click="openAddIsolatedNetwork('lg')"><span class="pe-7s-trash pe-lg font-bold m-r-xs"></span></a> -->
                    </td>
                </tr>
            </tbody>
        </table>
     </form>
    <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
          <thead>
                <tr>
                    <th class="col-md-3 col-xs-3"></th>
                    <th class="col-md-2 col-xs-2"></th>
                    <th class="col-md-2 col-xs-2"></th>
                    <th class="col-md-2 col-xs-2"></th>
                    <th class="col-md-3 col-xs-3"></th>
                </tr>
            </thead>
            <tbody>
               <tr ng-repeat="firewallRules in egressRuleList" class="font-bold text-center">
             	<td>{{firewallRules.sourceCIDR}}</td>
		        <td>{{firewallRules.protocol}}</td>
                <td><div  data-ng-if=" (firewallRules.startPort == '' || firewallRules.startPort!='') ">{{firewallRules.startPort}}</div> <div  data-ng-if=" (firewallRules.icmpMessage=='' || firewallRules.icmpMessage!='') ">{{firewallRules.icmpMessage}}</div><div  data-ng-if=" (firewallRules.protocol=='ALL') ">{{firewallRules.protocol}}</div></td>
                <td><div data-ng-if=" (firewallRules.endPort =='' || firewallRules.endPort!='')">{{firewallRules.endPort}} </div> <div data-ng-if="(firewallRules.icmpCode=='' || firewallRules.icmpCode!='')" >{{firewallRules.icmpCode}}</div><div  data-ng-if=" (firewallRules.protocol=='ALL') ">{{firewallRules.protocol}}</div></td>
                <td>
                <a data-ng-click="deleteEgress('sm', firewallRules)"><span class="fa fa-trash"></span></a>

                </td>
	        </tr>
            </tbody>
    </table>
</div>
