<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="vmlistform">
<div class="inmodal">
<div class="modal-header">
	<panda-modal-header page-icon="fa fa-cloud" page-title="Add VMs"></panda-modal-header>

</div>
<div class="modal-body">
	<div class="row">
		<div class="hpanel">
			<div class="panel-heading">
				<div class="row">
					<div class="col-md-3 col-sm-3 col-xs-3 ">
						<div class="quick-search">
							<div class="input-group">
								<input data-ng-model="instanceSearch" type="text"
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
						class="table table-bordered table-striped">
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
							<td><a class="text-info">{{ instance.vmInstance.name }}</a>

									<div data-ng-show="instance.lbvm">
									<select required="true" data-ng-show="instance.lbvm"  multiple class="form-control input-group" name="ipAddress" data-ng-model="instance.ipAddress"  data-ng-options="ipAddress.guestIpAddress for ipAddress in instance.vmIpAddress"  >
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
											<input required type="checkbox"  class="form-control" icheck
												data-ng-model="instance.lbvm"
												data-ng-value="{{instance.vmInstance.id}}" name="selectVM"
												data-ng-change="instanceIPList(instance.vmInstance.id)" >
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
			<button type="button" data-ng-if="!showLoader" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
			<button class="btn btn-info"  data-ng-if="!showLoader" data-ng-click="loadbalancerSave(lbvmList)"><fmt:message key="common.apply" bundle="${msg}" /></button>
  			</div>

		</div>
</div>
</form>

