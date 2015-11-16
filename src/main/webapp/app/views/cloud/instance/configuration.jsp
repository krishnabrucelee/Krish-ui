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



            <div class="row">
                <div class="col-md-12">
                    <div class="btn-group" data-toggle="buttons">
                        <label data-ng-init="computeOffer.type = computeOfferElements.type[0]" data-ng-click="changePlan(offerType)"
                               class="btn m-r-xs w-sm" data-ng-class="computeOffer.type.id == offerType.id ? 'btn-info' : 'btn - default'" data-ng-repeat="offerType in computeOfferElements.type">
                            {{ offerType.name}}
                        </label>
                    </div>
                </div>
            </div>

            <div class="row m-t-md">
                <div class="col-md-10 col-sm-10 col-xs-10">

                    <form name="computeOfferForm" method="POST" data-ng-submit="save(computeOfferForm)" novalidate class="form-horizontal">
                        <div class="form-group" ng-class="{ 'text-danger' : computeOfferForm.plan.$invalid && formSubmitted}">
                            <label class="col-sm-4 control-label"><fmt:message key="select.the.plan" bundle="${msg}" />
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-sm-6">
                                <select required="true" class="form-control input-group" name="plan"
                                        data-ng-model="computeOffer.plan" data-ng-class="{'error': computeOfferForm.plan.$invalid && formSubmitted}"
                                        data-ng-options="plan.name for plan in computeOffer.type.planList" >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                </select>
                                <div class="error-area" data-ng-show="computeOfferForm.plan.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="plan.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>

                        </div>


                        <div data-ng-show="computeOffer.plan.name == 'Custom'" >
                            <div class="row m-b-xl" ng-class="{ 'text-danger' : computeOfferForm.ram.$modelValue <= 0 && formSubmitted}">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="ram" bundle="${msg}" /> :</label>
                                <div class="col-md-5 col-sm-5">
                                    <rzslider rz-slider-model="instance.computeOffer.ram.value" rz-slider-floor="instance.computeOffer.ram.floor" rz-slider-ceil="instance.computeOffer.ram.ceil" rz-slider-always-show-bar="true"></rzslider>
                                </div>

                                <div class="col-md-3 col-sm-3 digit-2-width">
                                    <div class="input-group">
                                        <input class="form-control" name="ram"
                                               valid-number
                                               data-ng-min="{{ instance.computeOffer.ram.floor}}"
                                               data-ng-max="{{ instance.computeOffer.ram.ceil}}" type="text"
                                               data-ng-model="instance.computeOffer.ram.value">
                                        <span class="input-group-addon" id="basic-addon2">GB</span>
                                    </div>
                                </div>
                            </div>
                            <div class="row m-b-xl" ng-class="{ 'text-danger' : computeOfferForm.cpuCore.$modelValue <= 0 && formSubmitted}">
                                <label class="col-md-3 col-sm-3 control-label"><fmt:message key="cpu.cores" bundle="${msg}" /> :</label>
                                <div class="col-md-5 col-sm-5">
                                    <rzslider rz-slider-model="instance.computeOffer.cpuCore.value" rz-slider-floor="instance.computeOffer.cpuCore.floor" rz-slider-ceil="instance.computeOffer.cpuCore.ceil" rz-slider-always-show-bar="true"></rzslider>
                                </div>
                                <div class="col-md-3 col-sm-3 digit-2-width">
                                    <div class="input-group">
                                        <input valid-number
                                               data-ng-min="{{ instance.computeOffer.cpuCore.floor}}"
                                               data-ng-max="{{ instance.computeOffer.cpuCore.ceil}}" type="text"
                                               class="form-control" name="cpuCore"
                                               data-ng-model="instance.computeOffer.cpuCore.value">
                                        <span class="input-group-addon"><fmt:message key="core" bundle="${msg}" /></span>
                                    </div>
                                </div>
                            </div>

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
                                <a class="btn btn-default"  ui-sref="cloud.list-instance"><fmt:message key="common.cancel" bundle="${msg}" /></a>
                                <button class="btn btn-info" type="submit"  ><fmt:message key="common.resize" bundle="${msg}" /></button>
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
                                <td class="p-xs col-md-4 col-sm-4"><b><fmt:message key="cpu" bundle="${msg}" /></b></td>
                                <td class="p-xs col-md-8 col-sm-8">2 vCPU's</td>
                            </tr>
                            <tr>
                                <td class="p-xs col-md-4 col-sm-4"><b><fmt:message key="ram" bundle="${msg}" /></b></b></td>
                                <td class="p-xs col-md-8 col-sm-8">4096MB of memory</td>
                            </tr>
                            <tr>
                                <td class="p-xs col-md-4 col-sm-4"><b>System Disk</b></td>
                                <td class="p-xs col-md-8 col-sm-8">20.0GB</td>
                            </tr>
                            <tr>
                                <td class="p-xs col-md-4 col-sm-4"><b>Network</b></td>
                                <td class="p-xs col-md-8 col-sm-8">1000GB</td>
                            </tr>
                            <tr>
                                <td class="p-xs col-md-4 col-sm-4"><b>Bandwidth</b></td>
                                <td class="p-xs col-md-8 col-sm-8">10 MB/s</td>
                            </tr>
                            <tr>
                                <td class="p-xs col-md-4 col-sm-4"><b>Disk IO</b></td>
                                <td class="p-xs col-md-8 col-sm-8">Good</td>
                            </tr>
                            <tr>
                                <td colspan="2" class="p-xs">
                                    <h4 class="text-danger price-text">
                                        <app-currency></app-currency>0.10 <span>/ <fmt:message key="common.hour" bundle="${msg}" /></span>   <small class="text-right text-muted m-l-sm">(<app-currency></app-currency>7.2 / <fmt:message key="common.month" bundle="${msg}" />)</small>
                                    </h4>
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
                <fmt:message key="affinity.group" bundle="${msg}" /> (<fmt:message key="optional" bundle="${msg}" />)
            </h4>
            <hr class="m-t-xs">
        </div>
    </div>

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
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                </select>
                                <div class="error-area" data-ng-show="affinityForm.group.$invalid && affinitySubmitted" ><i  tooltip="<fmt:message key="group.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
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
                                <button class="btn btn-info" type="submit"  ><fmt:message key="common.ok" bundle="${msg}" /></button>
                            </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
        <div class="col-md-5">

        </div>
    </div>
</div>
