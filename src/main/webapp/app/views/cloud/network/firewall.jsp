<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div data-ng-controller="networksCtrl">
<div class="white-content" >
	<form name = "ingressForm"  data-ng-submit="ingressSave(ingressForm,firewallRuleIngress)" method="post">

<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th class="col-md-2 col-xs-2">Source CIDR</th>
                    <th class="col-md-2 col-xs-2">Protocol</th>
                    <th class="col-md-1 col-xs-1">Start Port</th>
                    <th class="col-md-1 col-xs-1">End Port</th>
                    <th class="col-md-1 col-xs-1">ICMP Type</th>
                    <th class="col-md-1 col-xs-1">ICMP Code</th>
                    <th class="col-md-1 col-xs-1">Add Rule</th>
                    <th class="col-md-2 col-xs-2">State</th>
                    <th class="col-md-1 col-xs-1">Action</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><input required="true" type="text" name="sourceCIDR"  valid-cidr placeholder="0.0.0.0/24"  data-ng-model="firewallRuleIngress.sourceCIDR" class="form-control input-group " ><span class="text-center" data-ng-show="cidrValidates && actionRules" data-ng-class="cidrValidates && actionRules ? 'text-danger' : ''"> Invalid format</span></td>
                    <td><select required="true" class="form-control input-group" name="protocol" data-ng-model="firewallRuleIngress.protocol"  data-ng-change="selectProtocol(protocol)" ng-options="protocol for (id, protocol) in protocolLists"><option value=""><fmt:message key="common.select"
													bundle="${msg}" /></option></select> <span class="text-center text-danger" data-ng-show="firewallRuleIngress.protocol == null && formSubmitted"> *Required</span></td>
                    <td data-ng-show="udp || tcp"><input required="true" valid-number  placeholder="1-65535" data-ng-min="1" data-ng-max="65535"   type="text" name="startPort" data-ng-model="firewallRuleIngress.startPort" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="firewallRuleIngress.startPort == null && formSubmitted"> *Required</span> </td>
                    <td data-ng-show="udp || tcp"><input required="true" valid-number placeholder="1-65535" data-ng-min="1" data-ng-max="65535"   type="text" name="endPort" data-ng-model="firewallRuleIngress.endPort" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="firewallRuleIngress.endPort == null && formSubmitted"> *Required</span> </td>
                    <td ><input valid-number   name="icmpType" data-ng-model="firewallRuleIngress.icmpType" class="form-control " autofocus type="text"></td>
                    <td ><input valid-number  name="icmpCode" data-ng-model="firewallRuleIngress.icmpCode" class="form-control " autofocus type="text"></td>
                    <td>
                        <a  class="btn btn-info" data-ng-click="ingressSave(firewallRules)"><span class="pe-7s-plus pe-lg font-bold m-r-xs" ></span>Add Rule</a>
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
                <td><div  data-ng-show = " (firewallRules.startPort == '' || firewallRules.startPort!='') ">{{firewallRules.startPort}}</div> <div  data-ng-show=" (firewallRules.icmpType=='' || firewallRules.icmpType!='') ">{{firewallRules.icmpType}}</div></td>
                <td><div data-ng-show= " (firewallRules.endPort =='' || firewallRules.endPort!='')">{{firewallRules.endPort}} </div> <div data-ng-show="(firewallRules.icmpCode=='' || firewallRules.icmpCode!='')" >{{firewallRules.icmpCode}}</div></td>
                <td> <div  data-ng-show=" (firewallRules.icmpType=='' || firewallRules.icmpType!='') ">{{firewallRules.icmpType}}</div></td>
                <td> <div data-ng-show="(firewallRules.icmpCode=='' || firewallRules.icmpCode!='')" >{{firewallRules.icmpCode}}</div></td>
       			<td>
                </td>
                <td><span ng-if = "firewallRules.isActive">Active</span></td>
                <td><a data-ng-click="deleteIngress('sm', firewallRules)"><span class="fa fa-trash"></span></a>
                </td>
	        </tr>
            </tbody>
    </table>


</div></div>
