<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="white-content">
    <form name="portform" method="POST" novalidate data-ng-submit="addVM(portform)">

        <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th class="col-md-2 col-xs-3">Private Port</th>
                    <th class="col-md-2 col-xs-3">Public Port</th>
                    <th class="col-md-2 col-xs-2">Protocol</th>
                    <th class="col-md-2 col-xs-2">Add VM</th>
                    <th class="col-md-1 col-xs-1">State</th>
                    <th class="col-md-1 col-xs-1">Actions</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><div class="col-xs-6"><input required="true" data-ng-show="udp || tcp" valid-number  placeholder="Start Port" data-ng-min="1" data-ng-max="65535"   type="text" name="privatestartPort" data-ng-model="privateStartPort" class="form-control" autofocus > <span class="text-center text-danger" data-ng-show="portform.privatestartPort.$invalid && portFormSubmitted"> *Required</span></div><div class="col-xs-6"><input data-ng-show="udp || tcp" required="true" valid-number  placeholder="End Port" data-ng-min="1" data-ng-max="65535"   type="text" name="privateendPort" data-ng-model="privateEndPort" class="form-control" autofocus > <span class="text-center text-danger" data-ng-show="portform.privateendPort.$invalid && portFormSubmitted"> *Required</span></div></td>
                    <td><div class="col-xs-6"><input required="true" data-ng-show="udp || tcp" valid-number  placeholder="Start Port" data-ng-min="1" data-ng-max="65535"   type="text" name="publicstartPort" data-ng-model="publicStartPort" class="form-control" autofocus ><span class="text-center text-danger" data-ng-show="portform.publicstartPort.$invalid && portFormSubmitted"> *Required</span> </div><div class="col-xs-6"><input data-ng-show="udp || tcp" required="true" valid-number  placeholder="End Port" data-ng-min="1" data-ng-max="65535"   type="text" name="publicendPort" data-ng-model="publicEndPort" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="portform.publicendPort.$invalid && portFormSubmitted"> *Required</span></div></td>
                    <td><select required="true" class="form-control input-group" name="protocol" data-ng-model="protocolName" data-ng-init="protocolName = networkLists.portProtocols[0]" data-ng-change="selectProtocol(protocolName.name)" data-ng-options="protocolName.name for protocolName in dropnetworkLists.portProtocols">
                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>  </select> </td>
                    <td><!-- <input  class="btn btn-info" type="submit" value="Add VM" > --></td>
                    <td></td>
                    <td> </td>
                </tr>
            </tbody>
        </table>
    <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
          <thead>
                <tr>
                    <th class="col-md-2 col-xs-3"></th>
                    <th class="col-md-2 col-xs-3"></th>
                    <th class="col-md-2 col-xs-2"></th>
                    <th class="col-md-2 col-xs-2"></th>
                    <th class="col-md-1 col-xs-1"></th>
                    <th class="col-md-1 col-xs-1"></th>

                </tr>
            </thead>
            <tbody>
               <tr ng-repeat="rule in portList" class="font-bold text-center">
                   <td><div class="col-xs-6">{{rule.privateStartPort}}</div><div class="col-xs-6">{{rule.privateEndPort}}</div> </td>
                <td><div class="col-xs-6">{{rule.publicStartPort}}</div><div class="col-xs-6">{{rule.publicEndPort}}</div> </td>
				<td>{{rule.protocolType}}</td>
                <td><span>VM: {{rule.vmInstance.name}}</span></br>
                <span>IP: {{rule.vmGuestIp}}</span></td>
                <td><span ng-if="rule.isActive">Active</span><span ng-if="!rule.isActive">InActive</span></td>
                <td>
                   <!--  <a data-ng-click="deleteRules(rule.id,'Port')" title="Delete"><span class="fa fa-trash"></span></a> -->
                </td>
	        </tr>

            </tbody>
    </table>


 </form>
</div>
