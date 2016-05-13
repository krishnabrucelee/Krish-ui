<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div data-ng-controller="vpcCtrl">
<div class="white-content" >
<div data-ng-if="global.webSocketLoaders.ingressLoader" class="overlay-wrapper">
   <img data-ng-if="global.webSocketLoaders.ingressLoader" src="images/loading-bars.svg" class="inner-loading" />
</div>
	<form name = "vpcAclForm" novalidate  data-ng-controller="vpcCtrl" data-ng-submit="saveAclList(vpcAclForm, vpcAcl)" method="post">
<div class="table-responsive">
	<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped ">
		       <thead>
		           <tr>
		               <th class="col-md-1 col-xs-1">Rule Number</th>
		               <th class="col-md-1 col-xs-1">CIDR</th>
		               <th class="col-md-1 col-xs-1">Action</th>
		               <th class="col-md-1 col-xs-1">Protocol</th>
		               <th class="col-md-1 col-xs-1">Protocol Number</th>
		               <th class="col-md-1 col-xs-1">Start Port</th>
		               <th class="col-md-1 col-xs-1">End Port</th>
		               <th class="col-md-1 col-xs-1">ICMP Type</th>
		               <th class="col-md-1 col-xs-1">ICMP Code</th>
		               <th class="col-md-1 col-xs-1">Traffic Type</th>
		               <th class="col-md-1 col-xs-1">Add rule</th>
		               <th class="col-md-1 col-xs-1">Actions</th>
		           </tr>
		       </thead>
		       <tbody>
		           <tr>
		               <td><input required="true" type="text" name="ruleNumber"  valid-cidr data-ng-model="vpcAcl.ruleNumber" class="form-control input-group " ><span class="text-center text-danger" data-ng-show="vpcAclForm.rulenumber.$invalid && formSubmitted"> *Required</span></td>
		               <td><input required="true" type="text" name="sourceCIDR"  valid-cidr placeholder="0.0.0.0/24"  data-ng-model="vpcAcl.cidrList" class="form-control input-group " ><span class="text-center text-danger" data-ng-show="vpcAclForm.sourceCIDR.$invalid && formSubmitted" data-ng-class="cidrValidates && actionRules ? 'text-danger' : ''"> Invalid format</span></td>
		               <td><select required="true" class="form-control input-group" name="action" data-ng-model="vpcAcl.action"  data-ng-change="" ng-options="action for (id, action) in actionList"><option value=""><fmt:message key="common.select"
										bundle="${msg}" /></option></select></td>
						<td><select required="true" class="form-control input-group" name="protocol" data-ng-model="vpcAcl.protocol"  data-ng-change="selectProtocol(vpcAcl.protocol)" ng-options="protocol for (id, protocol) in protocolList"><option value=""><fmt:message key="common.select"
										bundle="${msg}" /></option></select> <span class="text-center text-danger" data-ng-show=""></span></td>
		               <td><input data-ng-if = " (vpcAcl.protocol== 'Protocol Number')" required="true" valid-number type="text" name="protocolNumber" data-ng-model="vpcAcl.protocolNumber" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.protocolNumber.$invalid && formSubmitted"> *Required</span> </td>
		               <td><input data-ng-if = " (vpcAcl.protocol == 'TCP' || vpcAcl.protocol=='UDP' || vpcAcl.protocol== 'Protocol Number')" required="true" valid-number  placeholder="1" data-ng-min="1" data-ng-max="65535"   type="text" name="startPort" data-ng-model="vpcAcl.startPort" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.startPort.$invalid && formSubmitted"> *Required</span> </td>
		               <td><input data-ng-if = " (vpcAcl.protocol == 'TCP' || vpcAcl.protocol=='UDP' || vpcAcl.protocol== 'Protocol Number')" required="true" valid-number  placeholder="65535" data-ng-min="1" data-ng-max="65535"   type="text" name="endPort" data-ng-model="vpcAcl.endPort" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.endPort.$invalid && formSubmitted"> *Required</span> </td>
		               <td><input data-ng-if = " (vpcAcl.protocol == 'ICMP' || vpcAcl.protocol== 'Protocol Number')" required="true" data-ng-init='-1'  type="text" name="icmpType" data-ng-model="vpcAcl.icmpType" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.icmpType.$invalid && formSubmitted"> </span></td>
		               <td><input data-ng-if = " (vpcAcl.protocol == 'ICMP' || vpcAcl.protocol== 'Protocol Number')" required="true" data-ng-init='-1'  type="text" name="icmpCode" data-ng-model="vpcAcl.icmpCode" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.icmpCode.$invalid && formSubmitted"></span></td>
		               <td><select required="true" class="form-control input-group" name="trafficType" data-ng-model="vpcAcl.trafficType"  data-ng-change="" ng-options="trafficType for (id, trafficType) in trafficTypeList"><option value=""><fmt:message key="common.select"
										bundle="${msg}" /></option></select></td>
		               <td>

		                 <get-loader-image data-ng-show="showLoader"></get-loader-image>
		                 <button class="btn btn-info"  data-ng-if="!showLoader" type="submit"><span class="pe-7s-plus pe-lg font-bold m-r-xs" ></span>Add Rule</button>

		                   <!-- <a data-ng-show="delete" class="btn btn-info" data-ng-click="openAddIsolatedNetwork('lg')"><span class="pe-7s-trash pe-lg font-bold m-r-xs"></span></a> -->
		               </td>
		               <td></td>
		           </tr>
		       </tbody>
		   </table>
</div>

</form>
    <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
          <thead>
                <tr>
                    <th class="col-md-1 col-xs-1"></th>
                    <th class="col-md-1 col-xs-1"></th>
                    <th class="col-md-1 col-xs-1"></th>
                    <th class="col-md-1 col-xs-1"></th>
                    <th class="col-md-1 col-xs-1"></th>
                    <th class="col-md-1 col-xs-1"></th>
                    <th class="col-md-1 col-xs-1"></th>
                    <th class="col-md-1 col-xs-1"></th>
                    <th class="col-md-1 col-xs-1"></th>
                    <th class="col-md-1 col-xs-1"></th>
                    <th class="col-md-1 col-xs-1"></th>
                    <th class="col-md-1 col-xs-1"></th>
                </tr>
            </thead>
            <tbody>
               <tr ng-repeat="vpcAcl in vpcAclRulesList" class="font-bold text-center">
               <td class="col-md-1 col-xs-1">{{vpcAcl.ruleNumber}}</td>
             	<td class="col-md-1 col-xs-1">{{vpcAcl.cidrList}}</td>
             	<td class="col-md-1 col-xs-1">{{vpcAcl.action}}</td>
		        <td class="col-md-1 col-xs-1">{{vpcAcl.protocol}}</td>
		        <td class="col-md-1 col-xs-1">{{vpcAcl.protocolNumber}}</td>
                <td class="col-md-1 col-xs-1"><div>{{vpcAcl.startPort}}</div></td>
                <td class="col-md-1 col-xs-1"><div>{{vpcAcl.endPort}} </div></td>
                <td class="col-md-1 col-xs-1"> <div>{{vpcAcl.icmpType}}</div></td>
                <td class="col-md-1 col-xs-1"> <div>{{vpcAcl.icmpCode}}</div></td>
              	<td class="col-md-1 col-xs-1"> <div>{{vpcAcl.trafficType}}</div></td>
                <td class="col-md-1 col-xs-1"> </td>
                <td class="col-md-1 col-xs-1">
                <a id="network_edit_button_{{network.id}}"
												    data-unique-field="{{network.domain.name}}-{{network.department.userName}}-{{network.name}}"
													title="<fmt:message key="common.edit" bundle="${msg}" />"
													ui-sref="cloud.list-network.view-network({id: {{ network.id }}, view: 'edit'})">
														<span class="fa fa-edit m-r"> </span></a>
                <a data-ng-click="deleteNetworkAcl('sm', vpcAcl)"><span class="fa fa-trash"></span></a>
                </td>
	        </tr>
            </tbody>
    </table>


</div></div>
