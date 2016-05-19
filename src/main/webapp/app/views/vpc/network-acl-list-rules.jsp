<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div data-ng-controller="vpcCtrl">
<div class="white-content" >
<div data-ng-if="global.webSocketLoaders.egressLoader" class="overlay-wrapper">
   <img data-ng-if="global.webSocketLoaders.egressLoader" src="images/loading-bars.svg" class="inner-loading" />
</div>
<!-- <div class="table-responsive acl-table">
                <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
                    <thead>
                    <tr>
                        <th class="acl-table-cell">Name</th>
                        <th class="acl-table-cell">Phone</th>
                        <th class="acl-table-cell">Street Address</th>
                        <th class="acl-table-cell">City</th>
                        <th class="acl-table-cell">Country</th>
                        <th class="acl-table-cell">Name</th>
                        <th class="acl-table-cell">Phone</th>
                        <th class="acl-table-cell">Street Address</th>
                        <th class="acl-table-cell">City</th>
                        <th class="acl-table-cell">Country</th>
                        <th class="acl-table-cell">Street Address</th>
                        <th class="acl-table-cell">City</th>
                        <th class="acl-table-cell">Country</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="acl-table-cell">Abraham</td>
                        <td class="acl-table-cell">076 9477 4896</td>
                        <td class="acl-table-cell">294-318 Duis Ave</td>
                        <td class="acl-table-cell">Vosselaar</td>
                        <td class="acl-table-cell">Belgium</td>
                        <td class="acl-table-cell">Abraham</td>
                        <td class="acl-table-cell">076 9477 4896</td>
                        <td class="acl-table-cell">294-318 Duis Ave</td>
                        <td class="acl-table-cell">Vosselaar</td>
                        <td class="acl-table-cell">Belgium</td>
                        <td class="acl-table-cell">294-318 Duis Ave</td>
                        <td class="acl-table-cell">Vosselaar</td>
                        <td class="acl-table-cell">Belgium</td>
                    </tr>
                    <tr>
                        <td class="acl-table-cell">Abraham</td>
                        <td class="acl-table-cell">076 9477 4896</td>
                        <td class="acl-table-cell">294-318 Duis Ave</td>
                        <td class="acl-table-cell">Vosselaar</td>
                        <td class="acl-table-cell">Belgium</td>
                        <td class="acl-table-cell">Abraham</td>
                        <td class="acl-table-cell">076 9477 4896</td>
                        <td class="acl-table-cell">294-318 Duis Ave</td>
                        <td class="acl-table-cell">Vosselaar</td>
                        <td class="acl-table-cell">Belgium</td>
                        <td class="acl-table-cell">294-318 Duis Ave</td>
                        <td class="acl-table-cell">Vosselaar</td>
                        <td class="acl-table-cell">Belgium</td>
                    </tr>
                    </tbody>
                </table>
                </div> -->
<div class="table-responsive acl-table">
	<form name = "vpcAclForm" novalidate  data-ng-controller="vpcCtrl" data-ng-submit="saveAclList(vpcAclForm, vpcAcl)" method="post">

	<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped" id="vpc_acl_list_rules_table">
		       <thead>
		           <tr>
		               <th class="acl-table-cell">Rule Number</th>
		               <th class="acl-table-cell">CIDR</th>
		               <th class="acl-table-cell">Action</th>
		               <th class="acl-table-cell">Protocol</th>
		               <th class="acl-table-cell">Protocol Number</th>
		               <th class="acl-table-cell">Start Port</th>
		               <th class="acl-table-cell">End Port</th>
		               <th class="acl-table-cell">ICMP Type</th>
		               <th class="acl-table-cell">ICMP Code</th>
		               <th class="acl-table-cell">Traffic Type</th>
		               <th class="acl-table-cell">Add rule</th>
		               <th class="acl-table-cell">Actions</th>
		           </tr>
		       </thead>
		       <tbody>
		           <tr>
		               <td><input id="vpc_acl_list_rules_rule_number" required="true" type="text" name="ruleNumber"  valid-cidr data-ng-model="vpcAcl.ruleNumber" class="form-control input-group " ><span class="text-center text-danger" data-ng-show="vpcAclForm.ruleNumber.$invalid && formSubmitted"> *Required</span></td>
		               <td><input id="vpc_acl_list_rules_source_cidr" required="true" type="text" name="sourceCIDR"  valid-cidr placeholder="0.0.0.0/24"  data-ng-model="vpcAcl.cidrList" class="form-control input-group " ><span class="text-center text-danger" data-ng-show="vpcAclForm.sourceCIDR.$invalid && formSubmitted" data-ng-class="cidrValidates && actionRules ? 'text-danger' : ''"> Invalid format</span></td>
		               <td><select id="vpc_acl_list_rules_action" required="true" class="form-control input-group" name="action" data-ng-model="vpcAcl.action"  data-ng-change="" ng-options="action for (id, action) in actionList"><option value=""><fmt:message key="common.select"
										bundle="${msg}" /></option></select><span class="text-center text-danger" data-ng-show="vpcAclForm.action.$invalid && formSubmitted"> *Required</span></td>
						<td><select id="vpc_acl_list_rules_protocol" required="true" class="form-control input-group" name="protocol" data-ng-model="vpcAcl.protocol"  data-ng-change="selectProtocol(vpcAcl.protocol)" ng-options="protocol for (id, protocol) in protocolList"><option value=""><fmt:message key="common.select"
										bundle="${msg}" /></option></select> <span class="text-center text-danger" data-ng-show="vpcAclForm.protocol.$invalid && formSubmitted"> *Required</span></span></td>
		               <td><input id="vpc_acl_list_rules_protocol_number" data-ng-if = " (vpcAcl.protocol== 'Protocol Number')" required="true" valid-number type="text" name="protocolNumber" data-ng-model="vpcAcl.protocolNumber" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.protocolNumber.$invalid && formSubmitted"> *Required</span> </td>
		               <td><input id="vpc_acl_list_rules_start_port" data-ng-if = " (vpcAcl.protocol == 'TCP' || vpcAcl.protocol=='UDP' || vpcAcl.protocol== 'Protocol Number')" required="true" valid-number  placeholder="1" data-ng-min="1" data-ng-max="65535"   type="text" name="startPort" data-ng-model="vpcAcl.startPort" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.startPort.$invalid && formSubmitted"> *Required</span> </td>
		               <td><input id="vpc_acl_list_rules_end_port" data-ng-if = " (vpcAcl.protocol == 'TCP' || vpcAcl.protocol=='UDP' || vpcAcl.protocol== 'Protocol Number')" required="true" valid-number  placeholder="65535" data-ng-min="1" data-ng-max="65535"   type="text" name="endPort" data-ng-model="vpcAcl.endPort" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.endPort.$invalid && formSubmitted"> *Required</span> </td>
		               <td><input id="vpc_acl_list_rules_icmp_type" data-ng-if = " (vpcAcl.protocol == 'ICMP')" required="true" data-ng-value='vpcAcl.icmpType = -1'  type="text" name="icmpType" data-ng-model="vpcAcl.icmpType" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.icmpType.$invalid && formSubmitted"> </span></td>
		               <td><input id="vpc_acl_list_rules_icmp_code" data-ng-if = " (vpcAcl.protocol == 'ICMP')" required="true" data-ng-value='vpcAcl.icmpCode = -1'  type="text" name="icmpCode" data-ng-model="vpcAcl.icmpCode" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.icmpCode.$invalid && formSubmitted"></span></td>
		               <td><select id="vpc_acl_list_rules_traffic_type" required="true" class="form-control input-group" name="trafficType" data-ng-model="vpcAcl.trafficType"  data-ng-change="" ng-options="trafficType for (id, trafficType) in trafficTypeList"><option value=""><fmt:message key="common.select"
										bundle="${msg}" /></option></select><span class="text-center text-danger" data-ng-show="vpcAclForm.trafficType.$invalid && formSubmitted"> *Required</span></td>
		               <td>

		                 <get-loader-image data-ng-show="showLoader"></get-loader-image>
		                 <button id="vpc_acl_list_rules_add_rule_button" class="btn btn-info"  data-ng-if="!showLoader" type="submit"><span class="pe-7s-plus pe-lg font-bold m-r-xs" ></span>Add Rule</button>

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
