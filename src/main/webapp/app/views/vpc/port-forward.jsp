<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="white-content">
<div data-ng-if="global.webSocketLoaders.portForwardLoader" class="overlay-wrapper">
    <img data-ng-if="global.webSocketLoaders.portForwardLoader" src="images/loading-bars.svg" class="inner-loading" />
</div>
    <form name="portform" method="POST" novalidate data-ng-submit="addVM(portform, portForward)">
		<div class="form-group">
        	<div class="row">

                	<div class="col-md-4  col-sm-4 col-xs-14">
                		<h5 class="pull-left">Tier :</h5>
                    	<select required="true" class="form-control m-l-md port-forwarding-select input-group pull-left" name="vpcnetwork" data-ng-model="portForward.vpcnetwork" ng-options="vpcnetwork.name for vpcnetwork in vpcNetworkListByPortforwarding" >
                        	<option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                        </select>
                    </div>
                        </div>
        </div>


        <table   cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th class="col-md-2 col-xs-3"><fmt:message key="common.private.port" bundle="${msg}" /></th>
                    <th class="col-md-2 col-xs-3"><fmt:message key="common.public.port" bundle="${msg}" /></th>
                    <th class="col-md-2 col-xs-2"><fmt:message key="common.protocol" bundle="${msg}" /></th>
                    <th class="col-md-2 col-xs-2"><fmt:message key="add.vm" bundle="${msg}" /></th>
                    <th class="col-md-1 col-xs-1"><fmt:message key="common.state" bundle="${msg}" /></th>
                    <th class="col-md-1 col-xs-1"><fmt:message key="common.action" bundle="${msg}" /></th>
                </tr>
            </thead>
           <tbody>
                <tr>
                    <td><div class="col-xs-6"><input clear-input  required="true"  data-ng-show="udp || tcp" valid-number  placeholder="<fmt:message key="common.start.port" bundle="${msg}" />" data-ng-min="1" data-ng-max="65535"   type="text" name="privatestartPort" data-ng-model="portForward.privateStartPort" class="form-control" autofocus > <span class="text-center text-danger" data-ng-show="portform.privatestartPort.$invalid && portFormSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span></div><div class="col-xs-6"><input data-ng-show="udp || tcp" required="true" valid-number  placeholder="<fmt:message key="common.end.port" bundle="${msg}" />" data-ng-min="1" data-ng-max="65535"   type="text" name="privateendPort" data-ng-model="portForward.privateEndPort" class="form-control" autofocus > <span class="text-center text-danger" data-ng-show="portform.privateendPort.$invalid && portFormSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span></div></td>
                    <td><div class="col-xs-6"><input clear-input  required="true" data-ng-show="udp || tcp" valid-number  placeholder="<fmt:message key="common.start.port" bundle="${msg}" />" data-ng-min="1" data-ng-max="65535"   type="text" name="publicstartPort" data-ng-model="portForward.publicStartPort" class="form-control" autofocus ><span class="text-center text-danger" data-ng-show="portform.publicstartPort.$invalid && portFormSubmitted"><fmt:message key="common.required" bundle="${msg}" /></span> </div><div class="col-xs-6"><input data-ng-show="udp || tcp" required="true" valid-number  placeholder="<fmt:message key="common.end.port" bundle="${msg}" />" data-ng-min="1" data-ng-max="65535"   type="text" name="publicendPort" data-ng-model="portForward.publicEndPort" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="portform.publicendPort.$invalid && portFormSubmitted"> <fmt:message key="common.required" bundle="${msg}" /></span></div></td>
                    <td><select clear-input  required="true" class="form-control input-group" name="protocolType" data-ng-model="portForward.protocolType" data-ng-init="portForward.protocolType = networkLists.portProtocols[0]" data-ng-change="selectProtocol(protocolType.name)" data-ng-options="protocolType.name for protocolType in dropnetworkLists.portProtocols">
                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>  </select> </td>
                    <td><center><input  class="btn btn-info" type="submit" value="<fmt:message key="add.vm" bundle="${msg}" />" ></center></td>
                    <td></td>
                    <td> </td>
                </tr>
            </tbody>
        </table>
        <div data-ng-show="showLoader" style="margin: 1%">
			<get-loader-image data-ng-show="showLoader"></get-loader-image>
		</div>
        <table data-ng-hide="showLoader" cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
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
                <td><span ng-if="portForward.isActive"><fmt:message key="common.active" bundle="${msg}" /></span><span ng-if="!portForward.isActive"><fmt:message key="common.inactive" bundle="${msg}" /></span></td>
                <td>
                    <a data-ng-click="deletePortRules('sm',portForward)" title="<fmt:message key="common.delete" bundle="${msg}" />"><span class="fa fa-trash"></span></a>
                </td>
	        </tr>
            </tbody>
    </table>
 </form>
</div>
