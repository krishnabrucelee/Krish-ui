<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div data-ng-if = "showLoaderOffer" style="margin: 40%">
      <get-loader-image-offer data-ng-show="showLoaderOffer"></get-loader-image-offer>
      </div>
	<div data-ng-if = "!showLoaderOffer" >
<div class="row border-content">
	<div class="col-offset-3 col-md-12 col-sm-12">
		<div class="row form-group required"
			ng-class="{ 'text-danger' : instanceForm.computeoffer.$invalid && OfferingSubmitted}">
			<div class="col-md-5 col-xs-5 col-sm-5">
				<div class="pull-left m-r-xs m-t-xxs"
					data-ng-show="computes && instance.computeOffering.customized">
					<a ng-click="computeSlide(); diskSlide();"> <span
						data-ng-hide="compute" class="pe pe-lg pe-7s-plus"></span> <span
						data-ng-show="compute" class="pe pe-lg pe-7s-less"></span>
					</a>
				</div>
				<label class="pull-left section-title"><fmt:message key="common.compute.offering" bundle="${msg}" /><span
					title="<fmt:message key="common.required" bundle="${msg}" />" class="text-danger font-bold">*</span></label>
			</div>
			<div class="col-md-6 col-xs-6 col-sm-6">
				<select required="true" class="form-control form-group-lg"
					name="computeOffering"
					ng-change='computeFunction(instance.computeOffering.customized)'
					data-ng-model="instance.computeOffering"
					data-ng-class="{'error': instanceForm.computeOffering.$invalid && OfferingSubmitted}"
					data-ng-options="computeOffering.name group by computeOffering.group for computeOffering in instanceElements.computeOfferingList">
					<option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
				</select> <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"
					tooltip="<fmt:message key="memory.and.cpu.for.the.instance" bundle="${msg}" />"></i>
				<div class="error-area"
					data-ng-show="instanceForm.computeoffer.$invalid && OfferingSubmitted">
					<i tooltip="<fmt:message key="compute.offering.is.required" bundle="${msg}" />"
						class="fa fa-warning error-icon"></i>
				</div>
				<input required="true" type="hidden" name="computeoffer"
					data-ng-model="instance.computeOffering.customized" class="form-control"
					data-ng-class="{'error': instanceForm.computeoffer.$invalid && OfferingSubmitted}">
			</div>
		</div>
	</div>
	<div
		data-ng-show="compute  && instance.computeOffering.customized">
		<div class="row m-b-xl"
			ng-class="{ 'text-danger' : instanceForm.memory.$modelValue <= 0 && OfferingSubmitted}">
			<label class="col-md-3 col-sm-3 control-label"><fmt:message key="memory" bundle="${msg}" /> :</label>
			<div class="col-md-5 col-sm-5">
				<rzslider rz-slider-model="instance.computeOffer.memory.value"
					rz-slider-floor="instance.computeOffer.memory.floor"
					rz-slider-ceil="instance.computeOffer.memory.ceil"
					rz-slider-always-show-bar="true"></rzslider>
			</div>
			<div class="col-md-3 col-sm-3 digit-2-width">
				<div class="input-group">
					<input class="form-control" name="memory" valid-number
						data-ng-min="{{ instance.computeOffer.memory.floor}}"
						data-ng-max="{{ instance.computeOffer.memory.ceil}}" type="text"
						data-ng-model="instance.computeOffer.memory.value"> <span
						class="input-group-addon" id="basic-addon2">MB</span>
				</div>
			</div>
		</div>
		<div class="row m-b-xl"
			ng-class="{ 'text-danger' : instanceForm.cpuCore.$modelValue <= 0 && OfferingSubmitted}">
			<label class="col-md-3 col-sm-3 control-label"><fmt:message key="cpu.cores" bundle="${msg}" /> :</label>
			<div class="col-md-5 col-sm-5">
				<rzslider rz-slider-model="instance.computeOffer.cpuCore.value"
					rz-slider-floor="instance.computeOffer.cpuCore.floor"
					rz-slider-ceil="instance.computeOffer.cpuCore.ceil"
					rz-slider-always-show-bar="true"></rzslider>
			</div>
			<div class="col-md-3 col-sm-3 digit-2-width">
				<div class="input-group">
					<input valid-number
						data-ng-min="{{ instance.computeOffer.cpuCore.floor}}"
						data-ng-max="{{ instance.computeOffer.cpuCore.ceil}}" type="text"
						class="form-control" name="cpuCore"
						data-ng-model="instance.computeOffer.cpuCore.value"> <span
						class="input-group-addon"><fmt:message key="core" bundle="${msg}" /></span>
				</div>
			</div>
		</div>
		<div class="row m-b-xl"
			ng-class="{ 'text-danger' : instanceForm.cpuSpeed.$modelValue <= 1000 && OfferingSubmitted}">
			<label class="col-md-3 col-sm-3 control-label"><fmt:message key="cpu.speed" bundle="${msg}" /> :</label>
			<div class="col-md-5 col-sm-5">
				<rzslider rz-slider-model="instance.computeOffer.cpuSpeed.value"
					rz-slider-floor="instance.computeOffer.cpuSpeed.floor"
					rz-slider-ceil="instance.computeOffer.cpuSpeed.ceil"
					rz-slider-always-show-bar="true"></rzslider>
			</div>
			<div class="col-md-3 col-sm-3 digit-2-width">
				<div class="input-group">
					<input valid-number
						data-ng-min="{{ instance.computeOffer.cpuSpeed.floor}}"
						data-ng-max="{{ instance.computeOffer.cpuSpeed.ceil}}" type="text"
						class="form-control" name="cpuSpeed"
						data-ng-model="instance.computeOffer.cpuSpeed.value"> <span
						class="input-group-addon">MHz</span>
				</div>
			</div>
		</div>
		<div class="row m-b-xl" data-ng-show="instance.computeOffering.customizedIops">
			<div class="col-md-5 col-sm-6">
				<div class="form-group"
					ng-class="{ 'text-danger' : instanceForm.minIops.$modelValue <= 0 && OfferingSubmitted}">
					<label class="col-md-7 col-sm-7 control-label"><fmt:message key="min.iops" bundle="${msg}" /> :</label>
					<div class="col-md-5 col-sm-5">
						<input class="form-control ng-pristine ng-valid ng-touched"
							type="text" data-ng-model="instance.computeOffer.minIops.value"
							valid-number="" name="minIops">
					</div>
				</div>
			</div>
			<div class="col-md-5 col-sm-6">
				<div class="form-group"
					ng-class="{ 'text-danger' : instanceForm.maxIops.$modelValue <= 0 && OfferingSubmitted}">
					<label class="col-md-7 col-sm-7 control-label"><fmt:message key="max.iops" bundle="${msg}" /> :</label>
					<div class="col-md-5 col-sm-5">
						<input class="form-control ng-pristine ng-valid ng-touched"
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
				<div class="pull-left m-r-xs m-t-xxs"
					data-ng-show="disks && instance.diskOffering.name == 'Custom'">
					<a ng-click="diskSlide(); computeSlide();"> <span
						data-ng-hide="disk" class="pe pe-lg pe-7s-plus"></span> <span
						data-ng-show="disk" class="pe pe-lg pe-7s-less"></span>
					</a>
				</div>
				<label class="section-title"> <fmt:message key="common.disk.offering" bundle="${msg}" /></label>
			</div>
			<div class="col-md-6 col-xs-6 col-sm-6">
				<select class="form-control input-group" name="storageOffering"
					data-ng-model="instance.storageOffering"
					ng-change='diskFunction(instance.storageOffering.name)'
					ng-options="storageOffering.name for storageOffering in instanceElements.diskOfferingList">
					<option value=""><fmt:message key="no.thanks" bundle="${msg}" /></option>
				</select> <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"
					tooltip="<fmt:message key="secondary.disk.and.iops" bundle="${msg}" />"></i> <input type="hidden"
					name="storageOffering" data-ng-model="instance.storageOffering.name"
					class="form-control">
			</div>
		</div>
	</div>
	<div data-ng-show="disk && instance.diskOffering.isCustom == 'somes'">
		<div class="row m-b-xl"
			ng-class="{ 'text-danger' : instanceForm.diskSize.$modelValue <= 0 && OfferingSubmitted}">
			<label class="col-md-3 col-sm-3 control-label"><fmt:message key="disk.size" bundle="${msg}" /> :</label>
			<div class="col-md-5 col-sm-5">
				<rzslider rz-slider-model="instance.diskOffer.diskSize.value"
					rz-slider-floor="instance.diskOffer.diskSize.floor"
					rz-slider-ceil="instance.diskOffer.diskSize.ceil"
					rz-slider-always-show-bar="true"></rzslider>
			</div>
			<div class="col-md-4 col-sm-3 digit-4-width">
				<div class="input-group">
					<input valid-number
						data-ng-min="{{ instance.diskOffer.diskSize.floor}}"
						data-ng-max="{{ instance.diskOffer.diskSize.ceil}}" type="text"
						class="form-control input-mini" name="diskSize"
						data-ng-model="instance.diskOffer.diskSize.value"> <span
						class="input-group-addon">GB</span>
				</div>
			</div>
		</div>
		<div class="row m-b-xl">
			<div class="col-md-5 col-sm-6">
				<div class="form-group"
					ng-class="{ 'text-danger' : instanceForm.minIops.$modelValue <= 0 && OfferingSubmitted}">
					<label class="col-md-7 col-sm-7 control-label"><fmt:message key="min.iops" bundle="${msg}" /> :</label>
					<div class="col-md-5 col-sm-5">
						<input class="form-control ng-pristine ng-valid ng-touched"
							type="text" data-ng-model="instance.diskOffer.minIops.value"
							valid-number="" name="minIops">
					</div>
				</div>
			</div>
			<div class="col-md-5 col-sm-6">
				<div class="form-group"
					ng-class="{ 'text-danger' : instanceForm.maxIops.$modelValue <= 0 && OfferingSubmitted}">
					<label class="col-md-7 col-sm-7 control-label"><fmt:message key="max.iops" bundle="${msg}" /> :</label>
					<div class="col-md-5 col-sm-5">
						<input class="form-control ng-pristine ng-valid ng-touched"
							type="text" data-ng-model="instance.diskOffer.maxIops.value"
							valid-number="" name="maxIops">
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="row border-content">
    <div class="col-md-12 col-sm-12">
        <div class="row  form-group" ng-class="{ 'text-danger' : instanceForm.networkoffer.$invalid && OfferingSubmitted}">
            <div class="col-md-5 col-xs-5 col-sm-5">
                <div class="pull-left m-r-xs m-t-xxs" data-ng-show="instanceForm.networkOfferinglist.$valid">
                    <a ng-click="computeSlide(); diskSlide(); networkSlide();">
                        <span data-ng-hide="networks" class="pe pe-lg pe-7s-plus"></span>
                        <span data-ng-show="networks" class="pe pe-lg pe-7s-less"></span>
                    </a>
                </div>
                <label  class="section-title" > <fmt:message key="common.network" bundle="${msg}" /><span title="<fmt:message key="common.required" bundle="${msg}" />" class="text-danger font-bold">*</span></label>
            </div>
            <div class="col-md-6 col-xs-6 col-sm-6">
                <select required="true" class="form-control input-group" name="networkOfferinglist"  data-ng-class="{'error': instanceForm.networkOfferinglist.$invalid && OfferingSubmitted}" data-ng-model="instance.networkOfferinglist" ng-change='networkFunction(instance.networkOfferinglist.value)' ng-options="networkOfferinglist.name for networkOfferinglist in instanceElements.networkOfferingList" >
                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                </select>
                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="networks.offerings" bundle="${msg}" />" ></i>
                <div class="error-area" data-ng-show="instanceForm.networkoffer.$invalid && OfferingSubmitted" ><i  tooltip="<fmt:message key="network.offering.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                <input required="true" type="hidden" name="networkoffer" data-ng-model="instance.networkOfferinglist.name" class="form-control" data-ng-class="{'error': instanceForm.networkoffer.$invalid && OfferingSubmitted}"  >
            </div>
            <div data-ng-show="instance.networkOfferinglist.value == 'new' && networks" >
                <div class="col-md-12 col-sm-12">
                    <div class="table-responsive m-t-md">

                        <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
                            <tbody>
                                <tr>
                                    <td><b><fmt:message key="network.name" bundle="${msg}" /><span title="<fmt:message key="common.required" bundle="${msg}" />" class="text-danger font-bold">*</span></b></td>
                                    <td><input type="text" class="input-small " data-ng-model="guestnetwork.name" /></td>
                                </tr>
                                <tr>
                                    <td width="35%">
                                        <b><fmt:message key="common.networkoffering" bundle="${msg}" />  :<span title="<fmt:message key="common.required" bundle="${msg}" />" class="text-danger font-bold">*</span></b>
                                    </td>
                                    <td width="65%">
                                        <select required="true" class="form-control" name="networkOffering" data-ng-model="guestnetwork.networkOffering" ng-options="networkOffering.displayText for networkOffering in instance.networks.networkOfferList" >
                                            <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                        </select>
                                    </td>
                                </tr>
                             </tbody>
                        </table>
                       <button  class="btn btn-info btn-sm pull-right" type="button" data-ng-click=addnetwork()> <fmt:message key="common.add" bundle="${msg}" /></button>
                    </div>
                </div>
            </div>
            <div data-ng-show=" instance.networkOfferinglist.value == 'all' && networks"  >
                <div class="col-md-12 col-sm-12">
                    <div class="table-responsive m-t-md" style="height: 206px; overflow-y: auto; overflow-x: hidden;" >
                        <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th><fmt:message key="common.network" bundle="${msg}" /></th>
                                    <th><fmt:message key="common.type" bundle="${msg}" /></th>
                                    <th><fmt:message key="common.action" bundle="${msg}" /></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr data-ng-repeat="networks in instance.networks.networkList">
                                    <td>
                                        <label><input  data-ng-model="instance.networks[$index]" type="checkbox" required="true"  name="network" value="{{networks}}" > {{ networks.name}}</label>
                                    </td>
                                    <td>{{ networks.networkType}}</td>
                                    <td>
                                        <a title="<fmt:message key="ip.address" bundle="${msg}" />"  ></a>
                                        <input type="text" valid-cidr required="true" placeholder="<fmt:message key="ip.address" bundle="${msg}" />"  class="input-small" data-ng-model="networks.ipaddress" />
                                        <span ><label><input type="radio" name="instance.networks.default"  data-ng-model="instance.networkc" value="{{networks}}" > <fmt:message key="common.default" bundle="${msg}" /></label></span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div data-ng-show=" instance.networkOfferinglist.value == 'vpc' && networks" >
                <div class="col-md-12 col-sm-12">
                    <div class="table-responsive m-t-md">
                        <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th><fmt:message key="common.network" bundle="${msg}" /></th>
                                    <th><fmt:message key="common.type" bundle="${msg}" /></th>
                                    <th><fmt:message key="common.action" bundle="${msg}" /></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr data-ng-repeat="networks in instance.networks.networkList| filter:{ vpc : true }">
                                    <td>
                                        <label><input data-ng-model="networks.selected" type="checkbox" required="true" name="instance.networks" value="networks" > {{ networks.name}}</label>
                                    </td>
                                    <td>{{ networks.type}}</td>
                                    <td>
                                        <a title="<fmt:message key="ip.address" bundle="${msg}" />"></a>
                                        <input type="text" required="true" valid-cidr placeholder="<fmt:message key="ip.address" bundle="${msg}" />"  class="input-small" data-ng-model="networks.ipaddress" />
                                        <span ><label><input type="radio" name="instance.networks.default" data-ng-model="instance.networks[$index]" value="{{networks}}" > <fmt:message key="common.default" bundle="${msg}" /></label></span>
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
