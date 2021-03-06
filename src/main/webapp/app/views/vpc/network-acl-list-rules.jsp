<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div data-ng-controller="vpcCtrl">
<div class="white-content" >
<div data-ng-if="global.webSocketLoaders.egressLoader" class="overlay-wrapper">
    <get-show-loader-image data-ng-show="global.webSocketLoaders.egressLoader"></get-show-loader-image>
</div>

<div class="table-responsive acl-table">
	<form name = "vpcAclForm" novalidate  data-ng-controller="vpcCtrl" data-ng-submit="saveAclList(vpcAclForm, vpcAcl)" method="post">

	<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped" id="vpc_acl_list_rules_table">
		       <thead>
		           <tr>
		               <th class="acl-table-cell"><fmt:message key="vpc.ruleNumber" bundle="${msg}" /></th>
		               <th class="acl-table-cell"><fmt:message key="common.cidr" bundle="${msg}" /></th>
		               <th class="acl-table-cell"><fmt:message key="action" bundle="${msg}" /></th>
		               <th class="acl-table-cell"><fmt:message key="common.protocol" bundle="${msg}" /></th>
		               <th class="acl-table-cell"><fmt:message key="protocol.number" bundle="${msg}" /></th>
		               <th class="acl-table-cell"><fmt:message key="common.start.port" bundle="${msg}" /></th>
		               <th class="acl-table-cell"><fmt:message key="common.end.port" bundle="${msg}" /></th>
		               <th class="acl-table-cell"><fmt:message key="icmp.type" bundle="${msg}" /></th>
		               <th class="acl-table-cell"><fmt:message key="icmp.code" bundle="${msg}" /></th>
		               <th class="acl-table-cell"><fmt:message key="traffic.type" bundle="${msg}" /></th>
		               <th class="acl-table-cell"><fmt:message key="add.rule" bundle="${msg}" /></th>
		               <th class="acl-table-cell"><fmt:message key="common.action" bundle="${msg}" /></th>
		           </tr>
		       </thead>
		       <tbody>
		           <tr>
		               <td><input id="vpc_acl_list_rules_rule_number" required="true" type="text" name="ruleNumber"  valid-cidr data-ng-model="vpcAcl.ruleNumber" class="form-control input-group " ><span class="text-center text-danger" data-ng-show="vpcAclForm.ruleNumber.$invalid && formSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span></td>
		               <td><input id="vpc_acl_list_rules_source_cidr" required="true" type="text" name="sourceCIDR"  valid-cidr placeholder="0.0.0.0/24"  data-ng-model="vpcAcl.cidrList" class="form-control input-group " ><span class="text-center text-danger" data-ng-show="vpcAclForm.sourceCIDR.$invalid && formSubmitted" data-ng-class="cidrValidates && actionRules ? 'text-danger' : ''"> <fmt:message key="invalid.format" bundle="${msg}" /></span></td>
		               <td><select id="vpc_acl_list_rules_action" required="true" class="form-control input-group" name="action" data-ng-model="vpcAcl.action"  data-ng-change="" ng-options="action for (id, action) in actionList"><option value=""><fmt:message key="common.select"
										bundle="${msg}" /></option></select><span class="text-center text-danger" data-ng-show="vpcAclForm.action.$invalid && formSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span></td>
						<td><select id="vpc_acl_list_rules_protocol" required="true" class="form-control input-group" name="protocol" data-ng-model="vpcAcl.protocol"  data-ng-change="selectProtocol(vpcAcl.protocol)" ng-options="protocol for (id, protocol) in protocolList"><option value=""><fmt:message key="common.select"
										bundle="${msg}" /></option></select> <span class="text-center text-danger" data-ng-show="vpcAclForm.protocol.$invalid && formSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span></span></td>
		               <td><input id="vpc_acl_list_rules_protocol_number" data-ng-if = " (vpcAcl.protocol== 'Protocol Number')" required="true" valid-number type="text" name="protocolNumber" data-ng-model="vpcAcl.protocolNumber" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.protocolNumber.$invalid && formSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span> </td>
		               <td><input id="vpc_acl_list_rules_start_port" data-ng-if = " (vpcAcl.protocol == 'TCP' || vpcAcl.protocol=='UDP' || vpcAcl.protocol== 'Protocol Number')" required="true" valid-number  placeholder="1" data-ng-min="1" data-ng-max="65535"   type="text" name="startPort" data-ng-model="vpcAcl.startPort" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.startPort.$invalid && formSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span> </td>
		               <td><input id="vpc_acl_list_rules_end_port" data-ng-if = " (vpcAcl.protocol == 'TCP' || vpcAcl.protocol=='UDP' || vpcAcl.protocol== 'Protocol Number')" required="true" valid-number  placeholder="65535" data-ng-min="1" data-ng-max="65535"   type="text" name="endPort" data-ng-model="vpcAcl.endPort" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.endPort.$invalid && formSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span> </td>
		               <td><input id="vpc_acl_list_rules_icmp_type" data-ng-if = " (vpcAcl.protocol == 'ICMP')" required="true" data-ng-value='vpcAcl.icmpType = -1'  type="text" name="icmpType" data-ng-model="vpcAcl.icmpType" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.icmpType.$invalid && formSubmitted"> </span></td>
		               <td><input id="vpc_acl_list_rules_icmp_code" data-ng-if = " (vpcAcl.protocol == 'ICMP')" required="true" data-ng-value='vpcAcl.icmpCode = -1'  type="text" name="icmpCode" data-ng-model="vpcAcl.icmpCode" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.icmpCode.$invalid && formSubmitted"></span></td>
		               <td><select id="vpc_acl_list_rules_traffic_type" required="true" class="form-control input-group" name="trafficType" data-ng-model="vpcAcl.trafficType"  data-ng-change="" ng-options="trafficType for (id, trafficType) in trafficTypeList"><option value=""><fmt:message key="common.select"
										bundle="${msg}" /></option></select><span class="text-center text-danger" data-ng-show="vpcAclForm.trafficType.$invalid && formSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span></td>
		               <td>

		                 <get-loader-image data-ng-show="showLoader"></get-loader-image>
		                 <button id="vpc_acl_list_rules_add_rule_button" class="btn btn-info"  data-ng-if="!showLoader" type="submit"><span class="pe-7s-plus pe-lg font-bold m-r-xs" ></span><fmt:message key="add.rule" bundle="${msg}" /></button>

		                   <!-- <a data-ng-show="delete" class="btn btn-info" data-ng-click="openAddIsolatedNetwork('lg')"><span class="pe-7s-trash pe-lg font-bold m-r-xs"></span></a> -->
		               </td>
		               <td></td>
		           </tr>
		       </tbody>
		   </table>


</form>
    <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped" id="vpc_acl_list_rules_table_list">
          <thead>
                <tr>
                    <th class="acl-table-cell"></th>
                    <th class="acl-table-cell"></th>
                    <th class="acl-table-cell"></th>
                    <th class="acl-table-cell"></th>
                    <th class="acl-table-cell"></th>
                    <th class="acl-table-cell"></th>
                    <th class="acl-table-cell"></th>
                    <th class="acl-table-cell"></th>
                    <th class="acl-table-cell"></th>
                    <th class="acl-table-cell"></th>
                    <th class="acl-table-cell"></th>
                    <th class="acl-table-cell"></th>
                </tr>
            </thead>
            <tbody>
               <tr ng-repeat="vpcAcl in vpcAclRulesList" class="font-bold text-center">
               <td class="acl-table-cell">{{vpcAcl.ruleNumber}}</td>
             	<td class="acl-table-cell">{{vpcAcl.cidrList}}</td>
             	<td class="acl-table-cell">{{vpcAcl.action}}</td>
		        <td class="acl-table-cell">{{vpcAcl.protocol}}</td>
		        <td class="acl-table-cell">{{vpcAcl.protocolNumber}}</td>
                <td class="acl-table-cell"><div>{{vpcAcl.startPort}}</div></td>
                <td class="acl-table-cell"><div>{{vpcAcl.endPort}} </div></td>
                <td class="acl-table-cell"> <div>{{vpcAcl.icmpType}}</div></td>
                <td class="acl-table-cell"> <div>{{vpcAcl.icmpCode}}</div></td>
              	<td class="acl-table-cell"> <div>{{vpcAcl.trafficType}}</div></td>
                <td class="acl-table-cell"> </td>
                <td class="acl-table-cell">
				<a id="vpc_acl_list_rules_edit_button" data-ng-click="editNetworkAcl('md', vpcAcl)" title="<fmt:message key="common.edit" bundle="${msg}" />"><span class="fa fa-edit m-r"></span></a>
                <a id="vpc_acl_list_rules_delete_button" data-ng-click="deleteNetworkAcl('sm', vpcAcl)" title="<fmt:message key="common.delete" bundle="${msg}" />"><span class="fa fa-trash"></span></a>
                </td>
	        </tr>
            </tbody>
    </table>

</div>
</div></div>
