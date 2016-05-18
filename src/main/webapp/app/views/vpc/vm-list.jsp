<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<form name="vmlistform">
<div class="inmodal">
<div class="modal-header">
	<panda-modal-header id="vpc_loadbalance_add_vm_page_title" page-icon="fa fa-cloud" page-title="Add VMs"></panda-modal-header>

</div>
<div class="modal-body">
	<div class="row">
		<div class="hpanel">
			<div class="panel-heading">
				<div class="row">
					<div class="col-md-3 col-sm-3 col-xs-3 ">
						<div class="quick-search">
							<div class="input-group">
								<input data-ng-model="instanceSearch" type="text" id="vpc_loadbalance_add_vm_quick_search"
									class="form-control input-medium" placeholder="Quick Search"
									aria-describedby="quicksearch-go"> <span
									class="input-group-addon" id="quicksearch-go"><span
									class="pe-7s-search pe-lg font-bold"></span></span>
							</div>
						</div>
					</div>
				</div>
				<div class="clearfix"></div>
			</div>
			<div class="white-content">
				<div class="table-responsive">
					<table cellspacing="1" cellpadding="1"
						class="table table-bordered table-striped" id="vpc_loadbalance_add_vm_table">
						<thead>
							<tr>
								<th>Name</th>
								<th>Internal Name</th>
								<th>Display Name</th>
								<th>Zone</th>
								<th>State</th>
								<th>Select</th>
							</tr>
						</thead>
						<tbody>
							<tr data-ng-repeat="instance in lbvmList | filter: instanceSearch">
							<td><a id="vpc_loadbalance_add_vm_name" class="text-info">{{ instance.vmInstance.name }}</a>

									<div data-ng-show="instance.lbvm">
									<select id="vpc_loadbalance_add_vm_ip_address" required="true" data-ng-show="instance.lbvm"  multiple class="form-control input-group" name="ipAddress" data-ng-model="instance.ipAddress"  data-ng-options="ipAddress.guestIpAddress for ipAddress in instance.vmIpAddress"  >
									</select>
									</div>

										</td>
								<td>{{instance.vmInstance.instanceInternalName}}</td>
								<td>{{instance.vmInstance.displayName}}</td>
								<td>{{instance.vmInstance.zone.name}}</td>
								<td><label class="label label-success"
									data-ng-if="instance.vmInstance.status == 'RUNNING'">{{
										instance.vmInstance.status }}</label> <label class="label label-danger"
									data-ng-if="instance.vmInstance.status == 'STOPPED'">{{
										instance.vmInstance.status }}</label> <input type="hidden"
									data-ng-model="instance.vmInstance.status" value="{{ instance.vmInstance.status }}" />
								</td>
								<td>

										<div class="form-group"  >
											<input id="vpc_loadbalance_add_vm_lb_vm" required type="checkbox"  class="form-control" icheck
												data-ng-model="instance.lbvm"
												data-ng-value="{{instance.vmInstance.id}}" name="selectVM"
												data-ng-change="nicIPList(instance.vmInstance.id)" >
										</div>
					</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal-footer">
			<get-loader-image data-ng-if="showLoader"></get-loader-image>
			<button type="button" id="vpc_loadbalance_add_vm_cancel_button" data-ng-if="!showLoader" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
			<button class="btn btn-info" id="vpc_loadbalance_add_vm_apply_button"  data-ng-if="!showLoader" data-ng-click="loadbalancerSave(lbvmList)"><fmt:message key="common.apply" bundle="${msg}" /></button>
  			</div>

		</div>


</div>
</form>








