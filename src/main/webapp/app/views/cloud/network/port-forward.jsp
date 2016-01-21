<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="white-content">
    <form name="portform" method="POST" novalidate data-ng-submit="addVM(portform, portForward)">
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
                    <td><div class="col-xs-6"><input required="true" data-ng-show="udp || tcp" valid-number  placeholder="Start Port" data-ng-min="1" data-ng-max="65535"   type="text" name="privatestartPort" data-ng-model="portForward.privateStartPort" class="form-control" autofocus > <span class="text-center text-danger" data-ng-show="portform.privatestartPort.$invalid && portFormSubmitted"> *Required</span></div><div class="col-xs-6"><input data-ng-show="udp || tcp" required="true" valid-number  placeholder="End Port" data-ng-min="1" data-ng-max="65535"   type="text" name="privateendPort" data-ng-model="portForward.privateEndPort" class="form-control" autofocus > <span class="text-center text-danger" data-ng-show="portform.privateendPort.$invalid && portFormSubmitted"> *Required</span></div></td>
                    <td><div class="col-xs-6"><input required="true" data-ng-show="udp || tcp" valid-number  placeholder="Start Port" data-ng-min="1" data-ng-max="65535"   type="text" name="publicstartPort" data-ng-model="portForward.publicStartPort" class="form-control" autofocus ><span class="text-center text-danger" data-ng-show="portform.publicstartPort.$invalid && portFormSubmitted"> *Required</span> </div><div class="col-xs-6"><input data-ng-show="udp || tcp" required="true" valid-number  placeholder="End Port" data-ng-min="1" data-ng-max="65535"   type="text" name="publicendPort" data-ng-model="portForward.publicEndPort" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="portform.publicendPort.$invalid && portFormSubmitted"> *Required</span></div></td>
                    <td><select required="true" class="form-control input-group" name="protocolType" data-ng-model="portForward.protocolType" data-ng-init="portForward.protocolType = networkLists.portProtocols[0]" data-ng-change="selectProtocol(protocolType.name)" data-ng-options="protocolType.name for protocolType in dropnetworkLists.portProtocols">
                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>  </select> </td>
                    <td><input  class="btn btn-info" type="submit" value="Add VM" ></td>
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
               <tr ng-repeat="portForward in portList" class="font-bold text-center">
                   <td><div class="col-xs-6">{{portForward.privateStartPort}}</div><div class="col-xs-6">{{portForward.privateEndPort}}</div> </td>
                <td><div class="col-xs-6">{{portForward.publicStartPort}}</div><div class="col-xs-6">{{portForward.publicEndPort}}</div> </td>
				<td>{{portForward.protocolType}}</td>
                <td><span>VM: {{portForward.vmInstance.name}}</span></br>
                <span>IP: {{portForward.vmGuestIp}}</span></td>
                <td><span ng-if="portForward.isActive">Active</span><span ng-if="!portForward.isActive">InActive</span></td>
                <td>
                    <a data-ng-click="deletePortRules('sm',portForward)" title="Delete"><span class="fa fa-trash"></span></a>
                </td>
	        </tr>
            </tbody>
    </table>
 </form>
</div>
