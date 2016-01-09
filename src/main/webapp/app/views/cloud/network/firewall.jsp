<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div data-ng-controller="networksCtrl">
<div class="white-content" >
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
                    <td><input  type="text" name="cidr"  valid-cidr placeholder="0.0.0.0/24"  data-ng-model="cidr" class="form-control col-md-2 col-xs-2" ><span class="text-center" data-ng-show="cidrValidate && actionRule" data-ng-class="cidrValidate && actionRule ? 'text-danger' : ''"> Invalid format</span></td>
                    <td><select  class="form-control col-md-2 col-xs-2" name="protocol" data-ng-model="protocolName" data-ng-init="protocolName = networkLists.fireProtocols[0]" data-ng-change="selectProtocol(protocolName.name)" data-ng-options="protocolName.name for protocolName in dropnetworkLists.fireProtocols"><option value=""><fmt:message key="common.select"
													bundle="${msg}" /></option></select>   </td>
                    <td ><input data-ng-show="udp || tcp" valid-number  placeholder="" data-ng-min="1" data-ng-max="65535"   type="text" name="startPort" data-ng-model="startPort" class="form-control col-md-1 col-xs-1" autofocus > </td>
                    <td ><input data-ng-show="udp || tcp" valid-number placeholder="" data-ng-min="1" data-ng-max="65535"   type="text" name="endPort" data-ng-model="endPort" class="form-control  col-md-1 col-xs-1" autofocus > </td>
                    <td ><input data-ng-show="icmp" valid-number   name="icmpType" data-ng-model="icmpType" class="form-control  col-md-1 col-xs-1 " autofocus type="text"></td>
                    <td ><input data-ng-show="icmp" valid-number  name="icmpCode" data-ng-model="icmpCode" class="form-control  col-md-1 col-xs-1" autofocus type="text"></td>
                    <td><a  class="btn btn-info" data-ng-click="addRule('firewall')" >Add</a></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
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
               <tr ng-repeat="rule in rules" class="font-bold text-center">
             	<td>{{rule.cidr}}</td>
		<td>{{rule.protocol}}</td>
                <td><div>{{rule.startPort}}</div> </td>
                <td><div>{{rule.endPort}} </div> </td>
                <td><div>{{rule.icmpType}}</div></td>
                <td><div>{{rule.icmpCode}}</div></td>
                <td></td>
                <td>Active</td>
                <td>
                    <a data-ng-click="deleteRules(rule.id,'Firewall')" title="Delete"><span class="fa fa-trash"></span></a>
                </td>
	        </tr>

            </tbody>
    </table>



</div></div>
