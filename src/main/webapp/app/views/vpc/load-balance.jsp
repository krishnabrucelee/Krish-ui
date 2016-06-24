<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div ui-view data-ng-controller="vpcCtrl">
    <div class="white-content">
    <div data-ng-if="global.webSocketLoaders.loadBalancerLoader" class="overlay-wrapper">
  <get-show-loader-image data-ng-show="global.webSocketLoaders.loadBalancerLoader"></get-show-loader-image>
      		            </div>
        <form name="loadform" method="POST" novalidate
              data-ng-submit="openAddVM(loadform,loadBalancer)">
				<div class="form-group" ng-class="{'text-danger': loadform.vpcnetworks.$invalid && loadFormSubmitted">
					<div class="row">
                	<div class="col-md-4  col-sm-4 col-xs-14">
                		<h5 class="pull-left"><fmt:message key="tier" bundle="${msg}" /> :</h5>
                    	<select id="vpc_ip_address_loadbalance_tier" required="true"  class="form-control m-l-md port-forwarding-select input-group pull-left"
									name="vpcnetworks" data-ng-model="loadBalancer.vpcnetwork"
									ng-options="vpcnetwork.name for vpcnetwork in vpcNetworkListForLB" data-ng-class="{'error': loadform.vpcnetworks.$invalid && loadFormSubmitted"
									>
									<option value=""><fmt:message key="common.select"
											bundle="${msg}" /></option>
								</select>
								<span class="text-center text-danger"
                                          data-ng-show="loadform.vpcnetworks.$invalid && loadFormSubmitted">
                                <fmt:message key="common.required" bundle="${msg}" /></span></td>
                         </div>
                        </div>
                        </div>


            <table cellspacing="1" cellpadding="1"
                   class="table table-bordered table-striped" id="vpc_ip_address_loadbalance_table">
                <thead>
                    <tr>
                        <th class="col-md-2 col-xs-2"><fmt:message key="common.name" bundle="${msg}" /></th>
                        <th class="col-md-1 col-xs-1"><fmt:message key="common.public.port" bundle="${msg}" /></th>
                        <th class="col-md-1 col-xs-1"><fmt:message key="common.private.port" bundle="${msg}" /></th>
                        <th class="col-md-2 col-xs-2"><fmt:message key="common.algorithm" bundle="${msg}" /></th>
                        <th class="col-md-1 col-xs-2"><fmt:message key="stickiness" bundle="${msg}" /></th>
                        <th class="col-md-1 col-xs-2"><fmt:message key="health.check" bundle="${msg}" /></th>
                        <th class="col-md-1 col-xs-2"><fmt:message key="add.vms" bundle="${msg}" /></th>
                        <th class="col-md-1 col-xs-2"><fmt:message key="common.status" bundle="${msg}" /></th>
                        <th class="col-md-2 col-xs-2"><fmt:message key="action" bundle="${msg}" /></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><input required="true" type="text" name="name" id="vpc_ip_address_loadbalance_name"
                                   data-ng-model="loadBalancer.name" class="form-control"><span
                                   class="text-center text-danger"
                                   data-ng-show="loadform.name.$invalid && loadFormSubmitted">
                                <fmt:message key="common.required" bundle="${msg}" /></span></td>
                        <td><input required="true" valid-number id="vpc_ip_address_loadbalance_public_port"
                                   data-ng-model="loadBalancer.publicPort" data-ng-min="1" data-ng-max="65535"
                                   type="text" name="publicPort" class="form-control " autofocus>
                            <span class="text-center text-danger"
                                  data-ng-show="loadform.publicPort.$invalid && loadFormSubmitted">
                                <fmt:message key="common.required" bundle="${msg}" /></span></td>
                        <td><input required="true" valid-number id="vpc_ip_address_loadbalance_private_port"
                                   data-ng-model="loadBalancer.privatePort" data-ng-min="1" data-ng-max="65535"
                                   type="text" name="privatePort" class="form-control " autofocus>
                            <span class="text-center text-danger"
                                  data-ng-show="loadform.privatePort.$invalid && loadFormSubmitted">
                                <fmt:message key="common.required" bundle="${msg}" /></span></td>
                        <td><select required="true" class="form-control" id="vpc_ip_address_loadbalance_algorithm"
                                    name="algorithm" data-ng-model="loadBalancer.algorithms"
                                    data-ng-init="loadBalancer.algorithms = networkLists.algorithms[0]"
                                    data-ng-change="selectAlgorithm(algorithms.name)"
                                    data-ng-options="algorithms.name for algorithms in dropnetworkLists.algorithms"><option
                                    value=""><fmt:message key="common.select"
                                    bundle="${msg}" /></option></select> <span class="text-center text-danger"
                                                                       data-ng-show="loadform.algorithm.$invalid && loadFormSubmitted">
                                <fmt:message key="common.required" bundle="${msg}" /></span></td>
                        <td><a id="vpc_ip_address_loadbalance_stickiness_button" class="btn btn-info" ng-click="createStickiness('md')"><fmt:message key="configure" bundle="${msg}" /></a></td>
                        <td><a id="vpc_ip_address_loadbalance_configure_button" class="btn btn-info"><fmt:message key="configure" bundle="${msg}" /></a></td>
                        <td><input id="vpc_ip_address_loadbalance_add_vm_button" class="btn btn-info" type="submit" value="<fmt:message key="add.vm" bundle="${msg}" />"></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
            <table cellspacing="1" cellpadding="1"
                   class="table table-bordered table-striped" id="vpc_ip_address_loadbalance_table_list">
                <thead>
                    <tr>
                        <th class="col-md-2 col-xs-2"></th>
                        <th class="col-md-1 col-xs-1"></th>
                        <th class="col-md-1 col-xs-1"></th>
                        <th class="col-md-2 col-xs-2"></th>
                        <th class="col-md-1 col-xs-2"></th>
                        <th class="col-md-1 col-xs-2"></th>
                        <th class="col-md-1 col-xs-2"></th>
                        <th class="col-md-1 col-xs-2"></th>
                        <th class="col-md-2 col-xs-2"></th>

                    </tr>
                </thead>
                <tbody  ng-repeat="loadBalancer in rulesList">
                    <tr
                        class="font-bold">
                        <td>
                        	{{loadBalancer.name}}
	                        <a id="vpc_ip_address_loadbalance_list_name" data-ng-if="loadBalancer.expanded && loadBalancer.vmIpAddress.length > 0"  data-ng-click="loadBalancer.expanded = false" class="pull-right pe-lg font-bold m-r-xs pe-7s-angle-up-circle"></a>
	                        <a id="vpc_ip_address_loadbalance_list_name" data-ng-if="!loadBalancer.expanded && loadBalancer.vmIpAddress.length > 0"  data-ng-click="loadBalancer.expanded = true" class="pull-right pe-7s-angle-down-circle pe-lg font-bold m-r-xs"></a>
                        </td>
                        <td>{{loadBalancer.publicPort}}</td>
                        <td>{{loadBalancer.privatePort}}</td>
                        <td>{{loadBalancer.algorithm}}</td>
                        <td><a id="vpc_ip_address_loadbalance_list_edit_stickiness_button" class= "btn btn-info" data-ng-if = "loadBalancer.lbPolicy.stickinessMethod!=null"  data-ng-click="editStickiness('md',loadBalancer.lbPolicy)"> {{loadBalancer.lbPolicy.stickinessMethod}}</a>
                        <a id="vpc_ip_address_loadbalance_list_configure_stickiness_button" class="btn btn-info" data-ng-if = "loadBalancer.lbPolicy.stickinessMethod ==null"
                               data-ng-click="configureStickiness('md',loadBalancer)">{{'Configure'}}</a></td>
                        <td><a id="vpc_ip_address_loadbalance_list_configure_button" class="btn btn-info">Configure</a></td>
                        <td><a id="vpc_ip_address_loadbalance_list_add_vm_button" class="btn btn-info" data-ng-if = "loadBalancer.id!=null"  data-ng-click="applyNewRule('lg',loadBalancer)"><fmt:message key="add.vm" bundle="${msg}" /></a></td>
                        <td>{{loadBalancer.state}}</td>
                        <td><a id="vpc_ip_address_loadbalance_list_edit_button" class="icon-button"
                               data-ng-click="editrule('md', loadBalancer)"
                               title="<fmt:message key="common.edit" bundle="${msg}" />">
                               <span class="fa fa-edit m-r"> </span>
                            </a> <a class="icon-button" id="vpc_ip_address_loadbalance_list_delete_button"
                                    title="<fmt:message key="common.delete" bundle="${msg}" />"
                                    data-ng-click="deleteRules('sm', loadBalancer)"><span
                                    class="fa fa-trash"></span></a></td>

                    </tr>
                    <tr ng-if="loadBalancer.expanded"  ng-repeat="vmIpAddress in loadBalancer.vmIpAddress"  class="text-center">
                        <td colspan="2" >{{vmIpAddress.guestIpAddress}}</td>
                        <td colspan="2"  >{{vmIpAddress.vmInstance.name}}</td>
                        <td colspan="3"  >{{vmIpAddress.vmInstance.status}}</td>
                        <td colspan="3"><a class="icon-button m-l-lg" id="vpc_ip_address_loadbalance_list_remove_button"
                                    title="<fmt:message key="common.delete" bundle="${msg}" /> "
                                    data-ng-click="removeRule('sm',vmIpAddress, loadBalancer)"><span
                                    class="fa fa-trash"></span></a></td>
                                    </tr>

                </tbody>
            </table>
        </form>
    </div>
</div>
