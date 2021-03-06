<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div data-ng-if="showLoaderOffer" style="margin: 40%">
	<get-loader-image-offer ></get-loader-image-offer>
</div>
<form name="instanceForm" class="form-horizontal" >
<div data-ng-if="!showLoaderOffer">
	<div class="row border-content">
		<div class="col-offset-3 col-md-12 col-sm-12">
			<div class="row form-group required"
				data-ng-class="{ 'text-danger' : instanceForm.computeoffer.$invalid && OfferingSubmitted}">
				<div class="col-md-5 col-xs-5 col-sm-5">
					<div class="pull-left m-r-xs m-t-xxs"
						data-ng-show="computes && instance.computeOffering.customized">
						<a id="create_instance_compute" ng-click="computeSlide(); diskSlide();">
							<span data-ng-hide="compute" class="pe pe-lg pe-7s-plus"></span>
							<span data-ng-show="compute" class="pe pe-lg pe-7s-less"></span>
						</a>
					</div>
					<label class="pull-left section-title">
						<fmt:message key="common.compute.offering" bundle="${msg}" />
						<span title="<fmt:message key="common.required" bundle="${msg}" />"	class="text-danger font-bold">*</span>
					</label>
				</div>
				<div class="col-md-6 col-xs-6 col-sm-6">
					<select required="true" class="form-control form-group-lg"
						name="computeOffering" id="create_instance_compute_offering"
						ng-change='computeFunction(instance.computeOffering.customized)'
						data-ng-model="instance.computeOffering"
						data-ng-class="{'error': instanceForm.computeOffering.$invalid && OfferingSubmitted}"
						data-ng-options="computeOffering.name group by computeOffering.group for computeOffering in instanceElements.computeOfferingList">
						<option value="">
							<fmt:message key="common.select" bundle="${msg}" />
						</option>
					</select>
					<i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"
						tooltip="<fmt:message key="memory.and.cpu.for.the.instance" bundle="${msg}" />">
					</i>
					<div class="error-area"
						data-ng-show="instanceForm.computeoffer.$invalid && OfferingSubmitted">
						<i tooltip="<fmt:message key="compute.offering.is.required" bundle="${msg}" />"
							class="fa fa-warning error-icon">
						</i>
					</div>
					<input required="true" type="hidden" name="computeoffer" id="create_instance_compute_offering_custom"
						data-ng-model="instance.computeOffering.customized"
						class="form-control"
						data-ng-class="{'error': instanceForm.computeoffer.$invalid && OfferingSubmitted}">
				</div>
			</div>
		</div>
		<div data-ng-show="compute  && instance.computeOffering.customized">
			<div class="row m-b-xl form-group"
				data-ng-class="{ 'text-danger' : instanceForm.memory.$modelValue < 512 }">
				<label class="col-md-3 col-sm-3 control-label"><fmt:message key="memory" bundle="${msg}" /> :</label>
				<div class="col-md-5 col-sm-5">
					<rzslider  rz-slider-model="instance.computeOffer.memory.value"
						rz-slider-floor="instance.computeOffer.memory.floor"
						rz-slider-ceil="instance.computeOffer.memory.ceil"
						rz-slider-on-change="instance.computeOffer.memory.value"
						rz-slider-always-show-bar="true" rz-active></rzslider>
				</div>
				<div class="col-md-3 col-sm-3 digit-2-width" >
					<div class="input-group">
						<input class="form-control" required="true" name="memory"  id="create_instance_compute_offering_memory" data-ng-change="customMemory(instance.computeOffer.memory.value)"
							 type="number" min="{{instance.computeOffer.memory.floor}}" max="{{instance.computeOffer.memory.ceil}}"
							data-ng-model="instance.computeOffer.memory.value"> <span class="input-group-addon" id="basic-addon2">MB</span>
					</div>
				</div>
			</div>
			<div class="row m-b-xl"
				data-ng-class="{ 'text-danger' : instanceForm.cpuCore.$modelValue < 1 && OfferingSubmitted}">
				<label class="col-md-3 col-sm-3 control-label"><fmt:message
						key="cpu.cores" bundle="${msg}" /> :</label>
				<div class="col-md-5 col-sm-5">
					<rzslider rz-slider-model="instance.computeOffer.cpuCore.value"
						rz-slider-floor="instance.computeOffer.cpuCore.floor"
						rz-slider-ceil="instance.computeOffer.cpuCore.ceil"
						rz-slider-always-show-bar="true">
					</rzslider>
				</div>
				<div class="col-md-3 col-sm-3 digit-2-width">
					<div class="input-group">
						<input
							min="{{ instance.computeOffer.cpuCore.floor}}" id="create_instance_compute_offering_cpu_core" data-ng-change="customCpuCore(instance.computeOffer.cpuCore.value)"
							max="{{ instance.computeOffer.cpuCore.ceil}}" type="number"
							class="form-control" name="cpuCore"
							data-ng-model="instance.computeOffer.cpuCore.value">
							<span class="input-group-addon"><fmt:message key="core" bundle="${msg}" /></span>
					</div>
				</div>
			</div>
			<div class="row m-b-xl"
				data-ng-class="{ 'text-danger' : instanceForm.cpuSpeed.$modelValue < 500 && OfferingSubmitted}">
				<label class="col-md-3 col-sm-3 control-label"><fmt:message key="cpu.speed" bundle="${msg}" /> :</label>
				<div class="col-md-5 col-sm-5">
					<rzslider rz-slider-model="instance.computeOffer.cpuSpeed.value"
						rz-slider-floor="instance.computeOffer.cpuSpeed.floor"
						rz-slider-ceil="instance.computeOffer.cpuSpeed.ceil"
						rz-slider-always-show-bar="true">

					</rzslider>
				</div>
				<div class="col-md-3 col-sm-3 digit-2-width">
					<div class="input-group">
						<input id="create_instance_compute_offering_cpu_speed" required="true" data-ng-change="customCpuSpeed(instance.computeOffer.cpuSpeed.value)"
							min="{{ instance.computeOffer.cpuSpeed.floor}}"
							max="{{ instance.computeOffer.cpuSpeed.ceil}}"
							type="number" class="form-control" name="cpuSpeed"
							data-ng-model="instance.computeOffer.cpuSpeed.value"  >
													<span class="input-group-addon">MHz</span>
					</div>
				</div>
			</div>
			<div class="row m-b-xl"
				data-ng-show="instance.computeOffering.customizedIops">
				<div class="col-md-5 col-sm-6">
					<div class="form-group"
						data-ng-class="{ 'text-danger' : instanceForm.minIops.$modelValue < 0 && OfferingSubmitted}">
						<label class="col-md-7 col-sm-7 control-label"><fmt:message key="min.iops" bundle="${msg}" /> :</label>
						<div class="col-md-5 col-sm-5">
							<input class="form-control ng-pristine ng-valid ng-touched" id="create_instance_compute_offering_min_iops"
								type="text" data-ng-model="instance.computeOffer.minIops.value"
								valid-number="" name="minIops">
						</div>
					</div>
				</div>
				<div class="col-md-5 col-sm-6">
					<div class="form-group"
						data-ng-class="{ 'text-danger' : instanceForm.maxIops.$modelValue < 0 && OfferingSubmitted}">
						<label class="col-md-7 col-sm-7 control-label"><fmt:message key="max.iops" bundle="${msg}" /> :</label>
						<div class="col-md-5 col-sm-5">
							<input class="form-control ng-pristine ng-valid ng-touched" id="create_instance_compute_offering_max_iops"
								type="text" data-ng-model="instance.computeOffer.maxIops.value"
								valid-number="" name="maxIops">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row border-content">
		<div class="col-offset-3 col-md-12 col-sm-12">
			<div class="row  form-group">
				<div class="col-md-5 col-xs-5 col-sm-5">
					<label class="section-title"> <fmt:message key="common.disk.offering" bundle="${msg}" /></label>
				</div>
				<div class="col-md-6 col-xs-6 col-sm-6">
					<select class="form-control input-group" name="storageOffering" id="create_instance_disk_offering"
						data-ng-model="instance.storageOffering"
						ng-change='diskFunction(instance.storageOffering.name)'
						ng-options="storageOffering.name for storageOffering in instanceElements.diskOfferingList">
						<option value="">
							<fmt:message key="no.thanks" bundle="${msg}" />
						</option>
					</select>
					<i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"
						tooltip="<fmt:message key="secondary.disk.and.iops" bundle="${msg}" />">
					</i>
					<input type="hidden" name="storageOffering" id="create_instance_storage_offering_name"
						data-ng-model="instance.storageOffering.name" class="form-control">
				</div>
			</div>
		</div>
		<div data-ng-show="instance.storageOffering.isCustomDisk">
			<div class="form-group"
				data-ng-class="{ 'text-danger' : instanceForm.diskSize < 0}">
				<div class="row">
					<label class="col-md-3 col-xs-12 col-sm-2 control-label"><fmt:message key="common.size" bundle="${msg}" /> <fmt:message key="common.gb" bundle="${msg}" /> <span class="text-danger">*</span>
					</label>
					<div class="col-md-6 col-xs-12 col-sm-6">
						<rzslider rz-slider-model="instance.diskOffer.diskSize.value"
							rz-slider-floor="instance.diskOffer.diskSize.floor"
							rz-slider-ceil="instance.diskOffer.diskSize.ceil"
							rz-slider-always-show-bar="true">
						</rzslider>
					</div>
					<div class="col-md-2 col-xs-12 col-sm-3">
						<input type="number" required="true" id="create_instance_disk_size" required="true" data-ng-change="customdiskSize(instance.diskOffer.diskSize.value)"
							min="{{ instance.diskOffer.diskSize.floor }}"
							max="{{ instance.diskOffer.diskSize.ceil}}"
							class="form-control " name="diskSize"
							data-ng-model="instance.diskOffer.diskSize.value" >
					</div>
				</div>
			</div>
			<div class=""
				data-ng-class="{ 'text-danger' : instanceForm.diskMinIops.$invalid && formSubmitted}"
				data-ng-show="instance.storageOffering.isCustomizedIops">
				<div class=" m-b-xl">
					<div class="col-md-5 col-sm-6">
						<div class="form-group"
							data-ng-class="{ 'text-danger' : instanceForm.diskMinIops.$invalid && OfferingSubmitted}">
							<label class="col-md-6 col-xs-12 col-sm-6 control-label"><fmt:message key="min.iops" bundle="${msg}" /> <span class="text-danger">*</span>
							</label>
							<div class="col-md-6 col-sm-6">
								<input required="true" class="form-control ng-pristine ng-valid ng-touched" id="create_instance_disk_min_iops"
									type="text" data-ng-model="instance.diskMinIops"
									valid-number="" name="diskMinIops">
								<div class="error-area"
									data-ng-show="instanceForm.diskMinIops.$invalid && OfferingSubmitted">
									<i ng-attr-tooltip="{{ instanceForm.diskMinIops.errorMessage || '<fmt:message key="min.iops.required" bundle="${msg}" />' }}"
										class="fa fa-warning error-icon">
									</i>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-5 col-sm-6">
						<div class="form-group"
							data-ng-class="{ 'text-danger' : instanceForm.diskMinIops.$invalid && OfferingSubmitted}">
							<label class="col-md-6 col-xs-12 col-sm-6 control-label"><fmt:message key="max.iops" bundle="${msg}" /><span class="text-danger">*</span>
							</label>
							<div class="col-md-6 col-sm-6">
								<input required="true" class="form-control ng-pristine ng-valid ng-touched" id="create_instance_disk_max_iops"
									type="text" data-ng-model="instance.diskMaxIops"
									valid-number="" name="diskMaxIops">
								<div class="error-area"
									data-ng-show="instanceForm.diskMaxIops.$invalid && OfferingSubmitted">
									<i ng-attr-tooltip="{{ instanceForm.diskMaxIops.errorMessage || '<fmt:message key="max.iops.required" bundle="${msg}" />' }}"
										class="fa fa-warning error-icon">
									</i>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row border-content">
		<div class="col-offset-3 col-md-12 col-sm-12">
			<div class="row  form-group" data-ng-class="{ 'text-danger' : instanceForm.service.$invalid && OfferingSubmitted}">
				<div class="col-md-5 col-xs-5 col-sm-5">
					<label class="pull-left section-title">
						<fmt:message key="common.services" bundle="${msg}" />
						<span title="<fmt:message key="common.required" bundle="${msg}" />"	class="text-danger font-bold">*</span>
					</label>
				</div>
				<div class="col-md-6 col-xs-6 col-sm-6">
				    <select required="true" class="form-control form-group-lg"
						name="services" id="create_instance_services"
						data-ng-model="instance.services"
						data-ng-class="{'error': instanceForm.services.$invalid && OfferingSubmitted}"
						data-ng-options="services.serviceName for services in instanceElements.servicesList">
						<option value="">
							<fmt:message key="common.select" bundle="${msg}" />
						</option>
					</select>
					<i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"
						tooltip="<fmt:message key="choose.services" bundle="${msg}" />">
					</i>
					<div class="error-area"
						data-ng-show="instanceForm.service.$invalid && OfferingSubmitted">
						<i tooltip="<fmt:message key="services.is.required" bundle="${msg}" />"
							class="fa fa-warning error-icon">
						</i>
					</div>
					<input required="true" type="hidden" name="service" id="create_instance_service"
						data-ng-model="instance.services.serviceName"
						class="form-control"
						data-ng-class="{'error': instanceForm.service.$invalid && OfferingSubmitted}">
				</div>
			</div>
		</div>
	</div>
	<div class="row border-content">
		<div class="col-md-12 col-sm-12">
			<div class="row  form-group"
				data-ng-class="{ 'text-danger' : instanceForm.networkoffer.$invalid && OfferingSubmitted}">
				<div class="col-md-5 col-xs-5 col-sm-5">
					<div class="pull-left m-r-xs m-t-xxs"
						data-ng-show="instanceForm.networkOfferinglist.$valid">
						<a data-ng-hide="networkVM" id="create_instance_networks" ng-click="computeSlide(); diskSlide(); networkSlide();">
							<span data-ng-hide="networks " data-ng-hide="" class="pe pe-lg pe-7s-plus"></span>
							<span data-ng-show="networks" class="pe pe-lg pe-7s-less"></span>
						</a>
					</div>
					<label class="section-title"> <fmt:message key="common.network" bundle="${msg}" />
						<span title="<fmt:message key="common.required" bundle="${msg}" />" class="text-danger font-bold">*</span>
					</label>
				</div>
				<div class="col-md-6 col-xs-6 col-sm-6">
					<select data-ng-hide="networkVM" required="true" class="form-control input-group"
						name="networkOfferinglist" id="create_instance_network"
						data-ng-class="{'error': instanceForm.networkOfferinglist.$invalid && OfferingSubmitted}"
						data-ng-model="instance.networkOfferinglist"
						ng-change='networkFunction(instance.networkOfferinglist.value)'
						ng-options="networkOfferinglist.name for networkOfferinglist in instanceElements.networkOfferingList">
						<option value="">
							<fmt:message key="common.select" bundle="${msg}" />
						</option>
					</select>
					<label data-ng-show="networkVM" >
				      {{instance.network.name}}
				    </label>
					<i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"
						tooltip="<fmt:message key="networks.offerings" bundle="${msg}" />">
					</i>
					<div class="error-area"
						data-ng-show="instanceForm.networkoffer.$invalid && OfferingSubmitted">
						<i tooltip="<fmt:message key="network.offering.is.required" bundle="${msg}" />"
							class="fa fa-warning error-icon">
						</i>
					</div>
					<input required="true" type="hidden" name="networkoffer" id="create_instance_network_offering"
						data-ng-model="instance.networkOfferinglist.name"
						class="form-control"
						data-ng-class="{'error': instanceForm.networkoffer.$invalid && OfferingSubmitted}">
				</div>
				<div
					data-ng-show="instance.networkOfferinglist.value == 'new' && networks && !networkVM">
					<div class="col-md-12 col-sm-12">
						<div class="table-responsive m-t-md">
							<table cellspacing="1" cellpadding="1" id="create_instance_network_table"
								class="table table-bordered table-striped">
								<tbody>
									<tr>
										<td>
											<b><fmt:message key="network.name" bundle="${msg}" />
												<span title="<fmt:message key="common.required" bundle="${msg}" />" class="text-danger font-bold">*</span>
											</b>
										</td>
										<td>
											<input type="text" class="input-small " id="create_instance_network_name"
												data-ng-model="guestnetwork.name" />
										</td>
									</tr>
									<tr>
										<td width="35%">
											<b>
												<fmt:message key="common.networkoffering" bundle="${msg}" /> :
													<span title="<fmt:message key="common.required" bundle="${msg}" />" class="text-danger font-bold">*
													</span>
											</b>
										</td>
										<td width="65%">
											<select required="true"
											class="form-control" name="networkOffering" id="create_instance_guest_network"
											data-ng-model="guestnetwork.networkOffering"
											ng-options="networkOffering.displayText for networkOffering in instance.networks.networkOfferList">
												<option value="">
													<fmt:message key="common.select"
														bundle="${msg}" />
												</option>
										</select>
									</td>
									</tr>
								</tbody>
							</table>
							<button class="btn btn-info btn-sm pull-right" type="button" id="create_instance_add_network_button"
								data-ng-click=addnetwork()>
								<fmt:message key="common.add" bundle="${msg}" />
							</button>
						</div>
					</div>
				</div>
				<div
					data-ng-show=" instance.networkOfferinglist.value == 'all' && networks && !networkVM">
					<div class="col-md-12 col-sm-12">
						<div class="table-responsive m-t-md"
							style="height: 206px; overflow-y: auto; overflow-x: hidden;">
							<table cellspacing="1" cellpadding="1" id="create_instance_networks_table"
								class="table table-bordered table-striped">
								<thead>
									<tr>
										<th><fmt:message key="common.network" bundle="${msg}" /></th>
										<th><fmt:message key="common.description" bundle="${msg}" /></th>
										<th><fmt:message key="common.type" bundle="${msg}" /></th>
										<th><fmt:message key="common.action" bundle="${msg}" /></th>
									</tr>
								</thead>
								<tbody>
									<tr data-ng-repeat="networks in instance.networks.networkList">
										<td>
											<label>
												<input id="create_instance_network_checkbox_{{networks.id}}" data-unique-field="{{networks.name}}-{{networks.networkOffering.displayText}}" data-ng-model="instance.networkss[$index]" type="checkbox" data-ng-checked="false"
												class="test_create_instance_network_checkbox" required="true" name="network" value="{{networks.uuid}}" data-ng-change="stateChanged($index)" >
													{{ networks.name}}
											</label>
										</td>
										<td>
											<label>
													{{ networks.displayText}}
											</label>
										</td>
										<td>{{ networks.networkType}}</td>
										<td>
											<a title="<fmt:message key="ip.address" bundle="${msg}" />"></a>
											<span>
												<label>
													<input type="radio" id="create_instance_network_default_radio_button_{{networks.id}}" class="test_create_instance_network_default_radio_button" data-unique-field="{{networks.name}}-{{networks.networkOffering.displayText}}" name="networksDefault" data-ng-model="instance.networkc" value="{{networks.uuid}}">
														<fmt:message key="common.default" bundle="${msg}" />
												</label>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div
					data-ng-show=" instance.networkOfferinglist.value == 'vpc' && networks && !networkVM">
					<div class="col-md-12 col-sm-12">
						<div class="table-responsive m-t-md">
							<table cellspacing="1" cellpadding="1" id="create_instance_networks_table"
								class="table table-bordered table-striped">
								<thead>
									<tr>
										<th><fmt:message key="common.network" bundle="${msg}" /></th>
										<th><fmt:message key="common.vpc" bundle="${msg}" /></th>
										<th><fmt:message key="common.type" bundle="${msg}" /></th>
										<th><fmt:message key="common.action" bundle="${msg}" /></th>
									</tr>
								</thead>
								<tbody>
									<tr data-ng-repeat="networks in instance.networks.vpcList">
										<td>
											<label>
												<input id="create_instance_network_checkbox_{{networks.id}}" data-unique-field="{{networks.name}}-{{networks.networkOffering.displayText}}" data-ng-model="instance.networkss[$index]" type="checkbox" data-ng-checked="false"
												class="test_create_instance_network_checkbox" required="true" name="network" value="{{networks.uuid}}" data-ng-change="stateChangedvpc($index)">
													{{ networks.name}}
											</label>
										</td>
										<td>
											<label>
													{{ networks.vpc.name}}
											</label>
										</td>
										<td>{{ networks.networkType}}</td>
										<td>
											<a title="<fmt:message key="ip.address" bundle="${msg}" />"></a>
											<span>
												<label>
													<input type="radio" id="create_instance_network_default_radio_button_{{networks.id}}" class="test_create_instance_network_default_radio_button" data-unique-field="{{networks.name}}-{{networks.networkOffering.displayText}}" name="instance.networks.default" data-ng-model="instance.networkc" value="{{networks.uuid}}">
														<fmt:message key="common.default" bundle="${msg}" />
												</label>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</form>