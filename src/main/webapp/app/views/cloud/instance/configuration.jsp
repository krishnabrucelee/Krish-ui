<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div ng-controller="configurationCtrl">
    <div class="row">
        <div class="col-md-12 col-sm-12">
            <h4 >
                <fmt:message key="compute.offer" bundle="${msg}" />
            </h4>
            <hr class="m-t-xs">
        </div>
    </div>
    <div class="row">
        <div class="col-md-7 col-sm-7 col-xs-12">
            <div class="row m-t-md">
                <div class="col-md-10 col-sm-10 col-xs-10">

                    <form name="instanceForm" method="POST" data-ng-submit="save(instanceForm, instance)" novalidate class="form-horizontal">
                         <div class="form-group" ng-class="{ 'text-danger' : instanceForm.computeoffer.$invalid && OfferingSubmitted}">
                            <label class="col-sm-4 control-label"><fmt:message key="select.the.plan" bundle="${msg}" />
                                <span class="text-danger">*</span>
                            </label>
                            	<div class="col-md-6 col-xs-6 col-sm-6">
									<select required="true" class="form-control form-group-lg" name="computeOffering" ng-change="computeFunction(instance.computeOffering.customized)" data-ng-model="instance.computeOffering"
					data-ng-class="{'error': instanceForm.computeOffering.$invalid && OfferingSubmitted}"  data-ng-options="computeOffering.name group by computeOffering.group for computeOffering in instanceElements.computeOfferingList">
									</select>
				<i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="compute.offering.plans" bundle="${msg}" />"></i>
				<div class="error-area" data-ng-show="instanceForm.computeoffer.$invalid && OfferingSubmitted">
					<i tooltip="<fmt:message key="compute.offering.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i>
				</div>
				<input required="true" type="hidden" name="computeoffer"
					data-ng-model="instance.computeOffering.customized" class="form-control"
					data-ng-class="{'error': instanceForm.computeoffer.$invalid && OfferingSubmitted}">
								</div>
                       	 </div>

        <div data-ng-show="compute  && instance.computeOffering.customized">
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
				data-ng-class="{ 'text-danger' : instanceForm.cpuSpeed.$modelValue < 500 && OfferingSubmitted}">
				<label class="col-md-3 col-sm-3 control-label"><fmt:message key="cpu.speed" bundle="${msg}" /> :</label>
				<div class="col-md-5 col-sm-5">
					<rzslider rz-slider-model="instance.computeOffer.cpuSpeed.value" data-ng-init="instance.computeOffer.cpuSpeed.value = 500"
						rz-slider-floor="instance.computeOffer.cpuSpeed.floor"
						rz-slider-ceil="instance.computeOffer.cpuSpeed.ceil"
						rz-slider-always-show-bar="true">

					</rzslider>
				</div>
				<div class="col-md-3 col-sm-3 digit-2-width">
					<div class="input-group">
						<input valid-number id="create_instance_compute_offering_cpu_speed"
							data-ng-min="{{ instance.computeOffer.cpuSpeed.floor}}"
							data-ng-max="{{ instance.computeOffer.cpuSpeed.ceil}}"
							type="text" class="form-control" name="cpuSpeed"
							data-ng-model="instance.computeOffer.cpuSpeed.value"  >
													<span class="input-group-addon">MHz</span>
					</div>

				</div>
			</div>
		<%-- <div class="row m-b-xl" data-ng-show="instance.computeOffering.customizedIops">
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
		</div> --%>
	</div>

                        <div class="form-group">
                            <label class="col-sm-4 control-label"><fmt:message key="note" bundle="${msg}" /></label>
                            <div class="col-sm-8">
                                <div class="well">

                              <fmt:message key="your.instance.must.be.stopped.before.attempting.to.resize.the.compute.offer" bundle="${msg}" />.

                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-8 col-sm-offset-4">
                                 <get-loader-image data-ng-show="showLoader"></get-loader-image>

                                <a class="btn btn-default" data-ng-hide="showLoader" ui-sref="cloud.list-instance"><fmt:message key="common.cancel" bundle="${msg}" /></a>
                                <button data-ng-class = "(instances.status == 'STOPPED') ? 'btn btn-info' : 'btn btn-disable'" data-ng-disabled="instances.status != 'STOPPED'" href="javascript:void(0);" data-ng-hide="showLoader" type="submit"  ><fmt:message key="common.resize" bundle="${msg}" /></button>


                            </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-4 col-sm-5 pull-right">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="fa fa-list m-r-sm"></i><fmt:message key="common.summary" bundle="${msg}" /></h3>
                </div>
                <div class="panel-body no-padding">
                    <table class="table table-condensed" cellspacing="1" cellpadding="1">
                        <tbody>
                        	<tr>
                                <td class="p-xs col-md-4 col-sm-4"><b><fmt:message key="instance.name" bundle="${msg}" /></b></td>
                                <td class="p-xs col-md-8 col-sm-8">{{instances.name}}</td>
                            </tr>
                            <tr>
                                <td class="p-xs col-md-4 col-sm-4"><b><fmt:message key="cpu" bundle="${msg}" /></b></td>
                                <td class="p-xs col-md-8 col-sm-8">{{instances.computeOffering.numberOfCores}} vCPU's</td>
                            </tr>
                            <tr>
                                <td class="p-xs col-md-4 col-sm-4"><b><fmt:message key="ram" bundle="${msg}" /></b></b></td>
                                <td class="p-xs col-md-8 col-sm-8">{{instances.computeOffering.memory}} MB of memory</td>
                            </tr>
                            <tr>
                                <td class="p-xs col-md-4 col-sm-4"><b><fmt:message key="disk.size" bundle="${msg}" /></b></td>
                                <td class="p-xs col-md-8 col-sm-8">{{volume[0].diskSize / global.Math.pow(2, 30) || "0"}} GB</td>
                            </tr>
                           <%-- <tr>
                                <td class="p-xs col-md-4 col-sm-4"><b><fmt:message key="common.network" bundle="${msg}" /></b></td>
                                <td class="p-xs col-md-8 col-sm-8">1000GB</td>
                            </tr>
                            <tr>
                                <td class="p-xs col-md-4 col-sm-4"><b><fmt:message key="bandwidth" bundle="${msg}" /></b></td>
                                <td class="p-xs col-md-8 col-sm-8">10 MB/s</td>
                            </tr>
                            <tr>
                                <td class="p-xs col-md-4 col-sm-4"><b><fmt:message key="disk.io" bundle="${msg}" /></b></td>
                                <td class="p-xs col-md-8 col-sm-8">{{instances.computeOffering.diskIo}}</td>
                            </tr> --%>
                        </tbody>
                    </table>
                </div>
             </div>
	         <div class="panel panel-info">
	         <div class="panel-heading">
	             <h3 class="panel-title"><i class="fa fa-list m-r-sm"></i><fmt:message key="common.plan" bundle="${msg}" /></h3>
	         </div>
	         <div class="panel-body no-padding">
	             <table class="table table-condensed" cellspacing="1" cellpadding="1">
	                 <tbody>
	                     <tr>
	                         <td colspan="2" class="p-xs">
	                             <b>{{instanceForm.computeOffering.$viewValue.name}}</b>
	                             <div>
	                                 <input type="hidden" readonly="readonly" data-ng-model= "computeOfferCostSum" data-ng-bind= "computeOfferCostSum = (instance.computeOffering.computeCost[0].instanceRunningCostIops + instance.computeOffering.computeCost[0].instanceRunningCostMemory
				    + instance.computeOffering.computeCost[0].instanceRunningCostVcpu
				    + (instance.computeOffering.computeCost[0].instanceRunningCostPerMB > 0 ? (instance.computeOffer.memory.value * instance.computeOffering.computeCost[0].instanceRunningCostPerMB) : 0)
				    + (instance.computeOffering.computeCost[0].instanceRunningCostPerVcpu > 0 ? (instance.computeOffer.cpuCore.value * instance.computeOffering.computeCost[0].instanceRunningCostPerVcpu) : 0)
				    + (instance.computeOffering.computeCost[0].instanceRunningCostPerMhz > 0 ? (instance.computeOffer.cpuSpeed.value * instance.computeOffering.computeCost[0].instanceRunningCostPerMhz) : 0))" />
				<span data-ng-show="computeOfferCostSum > 0" class="text-danger price-text">
	                                     <app-currency></app-currency>{{computeOfferCostSum/30 | number:4 }}<span> / <fmt:message key="common.day" bundle="${msg}" /></span>
	                                 </span>
	                                 <span data-ng-hide="computeOfferCostSum > 0" class="font-bold text-success pricing-text">
	                                     <fmt:message key="free" bundle="${msg}" />
	                                 </span>
	                             </div>
	                             <div>
	                                 <small data-ng-show="computeOfferCostSum > 0" class="text-muted">
	                                     (<app-currency></app-currency>{{computeOfferCostSum | number:4 }} / <fmt:message key="common.month" bundle="${msg}" />)
	                                 </small>
	                             </div>
	                         </td>
	                     </tr>
	                 </tbody>
	             </table>
	         </div>
	       </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 col-sm-12">
            <h4>
               <fmt:message key="add.ssh.key.pair" bundle="${msg}" />
            </h4>
            <hr class="m-t-xs">
        </div>
    </div>

      <div class="row">
        <div class="col-md-7 col-sm-7 col-xs-12">

            <div class="row m-t-md">
                <div class="col-md-10 col-sm-10 col-xs-10">

                    <form name="resetForm" data-ng-submit="resetKey(resetForm, resetSSH)" method="post" novalidate class="form-horizontal">
                        <div class="form-group" ng-class="{ 'text-danger' : resetForm.keypairName.$invalid && formSubmitted}">
                            <label class="col-sm-4 control-label"><fmt:message key="select.the.key.pair" bundle="${msg}" />
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-sm-5">
                                <select required="true" class="form-control input-group" name="keypairName"
                                        data-ng-model="resetSSH.keypairName" data-ng-class="{'error': resetForm.keypairName.$invalid && formSubmitted}"
                                        data-ng-options="keypairName.name for keypairName in formElements.sshKeyList" >
                                    <option value="">Select</option>
                                </select>
                                <div class="error-area" data-ng-show="resetForm.keypairName.$invalid && formSubmitted" ><i  tooltip="keypair.is.required" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-4 control-label"><fmt:message key="note" bundle="${msg}" /></label>
                            <div class="col-sm-8">
                                <div class="well">
                                   1.<fmt:message key="note.reset.ssh.key" bundle="${msg}" /><br>
                                   2.<fmt:message key="add.ssh.key.vm.note" bundle="${msg}" /><br>
                                   3.<fmt:message key="add.ssh.key.vm.note.for.instance" bundle="${msg}" />
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-8 col-sm-offset-4">
                                <get-loader-image data-ng-if="showLoader"></get-loader-image>
                                <button type="button" data-ng-if="!showLoader" class="btn btn-default " ui-sref="cloud.list-instance"><fmt:message key="common.cancel" bundle="${msg}" /></button>
			                    <button data-ng-class = "(instances.status == 'STOPPED' && instances.template.osCategory.name != 'Windows') ? 'btn btn-info' : 'btn btn-disable'" data-ng-disabled="instances.status != 'STOPPED' || instances.template.osCategory.name == 'Windows'" href="javascript:void(0);" data-ng-hide="showLoader" type="submit"  ><fmt:message key="common.ok" bundle="${msg}" /></button>
                            </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
        <div class="col-md-5">

        </div>
    </div>

<%--        <div class="row">
        <div class="col-md-12 col-sm-12">
            <h4>
               <fmt:message key="affinity.group" bundle="${msg}" /> (<fmt:message key="optional" bundle="${msg}" />)
            </h4>
            <hr class="m-t-xs">
        </div>
    </div> --%>
<%--
    <div class="row">
        <div class="col-md-7 col-sm-7 col-xs-12">

            <div class="row m-t-md">
                <div class="col-md-10 col-sm-10 col-xs-10">

                    <form name="affinityForm" method="POST" data-ng-submit="saveAffinity(affinityForm)" novalidate class="form-horizontal">
                        <div class="form-group" ng-class="{ 'text-danger' : affinityForm.group.$invalid && affinitySubmitted}">
                            <label class="col-sm-4 control-label"><fmt:message key="select.group" bundle="${msg}" />
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-sm-5">
                                <select required="true" class="form-control input-group" name="group"
                                        data-ng-model="affinity.group" data-ng-class="{'error': affinityForm.group.$invalid && affinitySubmitted}"
                                        data-ng-options="group.name for group in affinityElements.groupList" >
                                    <option value="">Select</option>
                                </select>
                                <div class="error-area" data-ng-show="affinityForm.group.$invalid && affinitySubmitted" ><i  tooltip="Group is required" class="fa fa-warning error-icon"></i></div>
                            </div>
                            <div class="col-sm-3">
                                <a class="btn btn-info" data-ng-click="addAffinityGroup('md')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="add.new.affinity" bundle="${msg}" /></a>
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-sm-4 control-label"><fmt:message key="note" bundle="${msg}" /></label>
                            <div class="col-sm-8">
                                <div class="well">
                                   <fmt:message key="your.instance.must.be.stopped.before.attempting.to.change.the.affinity.group" bundle="${msg}" />

                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-8 col-sm-offset-4">
                                <a class="btn btn-default"  ui-sref="cloud.list-instance"><fmt:message key="common.cancel" bundle="${msg}" /></a>
                                <button data-ng-class = "(instances.status == 'STOPPED') ? 'btn btn-info' : 'btn btn-disable'" data-ng-disabled="instances.status != 'STOPPED'" href="javascript:void(0);" data-ng-hide="showLoader" type="submit"  ><fmt:message key="common.ok" bundle="${msg}" /></button>
                            </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
        <div class="col-md-5">

        </div>
    </div> --%>
</div>
