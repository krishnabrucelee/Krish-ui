<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
								<td><a class="text-info">{{ instance.name }}</a>
									<div data-ng-show="instance.selected">{{
										instance.ipAddress}}</div> <%--  <div data-ng-show="instance.selected" class="m-t-sm">
				<select  multiple="multiple" class="form-control input-group" name="ipaddress" data-ng-model="instance.ipAddress" ng-options="instance.ipAddress for ipaddress in vmList"  >
                <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                </select>
				</div> --%> <!--   <input type="hidden" data-ng-model="instance.ipAddress" value="{{ instance.ipAddress }}"/>
                           <input type="hidden" data-ng-model="instances.name" value="{{ instance.name }}"/>
                        </td> -->
								<td>{{instance.instanceInternalName}}</td>
								<td>{{instance.displayName}}</td>
								<td>{{instance.zone.name}}</td>
								<input type="hidden" data-ng-model="instances.zoneName"
									value="{{ instance.zone.name }}" />
								</td>
								<td><label class="label label-success"
									data-ng-if="instance.status == 'Running'">{{
										instance.status }}</label> <label class="label label-danger"
									data-ng-if="instance.status == 'Stopped'">{{
										instance.status }}</label> <input type="hidden"
									data-ng-model="instances.status" value="{{ instance.status }}" />
								</td>
								<td><label class="">
										<div class="icheckbox_square-green"
											style="position: relative;">
											<input type="checkbox" icheck
												data-ng-model="instance.selected"
												value="{{ instance.name }}" name="selectVM"
												data-ng-change="nicIPList(instance)"> <label></label>
										</div>
								</label></td>
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
			<button class="btn btn-info"  data-ng-if="!showLoader" data-ng-click="loadbalancerSave(instance)"><fmt:message key="common.apply" bundle="${msg}" /></button>
		</div>

</div>








