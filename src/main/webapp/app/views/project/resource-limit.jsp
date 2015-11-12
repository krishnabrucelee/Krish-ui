<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="hpanel" >
    <div class="panel-body">
        <form name="infraLimitForm" method="POST" data-ng-submit="validateInfraLimit(infraLimitForm)" novalidate >
            <div class="row">
                <div class="form-group" data-ng-class="{ 'text-danger' : infraLimitForm.instance.$invalid && formSubmitted}">

                    <label class="col-md-4 col-sm-4 control-label"><fmt:message key="instance.limits" bundle="${msg}" />:
                        <span class="text-danger">*</span>
                    </label>
                    <div class="col-md-2 col-sm-2">
                        <input type="text" required name="instance" valid-number data-ng-model="infraLimit.instance" class="form-control" >
                    </div>
                </div>
                <div class="form-group" data-ng-class="{ 'text-danger' : infraLimitForm.volume.$invalid && formSubmitted}">
                    <label class="col-md-4 col-sm-4 control-label"><fmt:message key="volume.limits" bundle="${msg}" />:
                        <span class="text-danger">*</span>
                    </label>
                    <div class="col-md-2 col-sm-2">
                        <input type="text" required name="volume" valid-number data-ng-model="infraLimit.volume" class="form-control" >
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group" data-ng-class="{ 'text-danger' : infraLimitForm.snapshot.$invalid && formSubmitted}">

                    <label class="col-md-4 col-sm-4 control-label"><fmt:message key="snapshot.limits" bundle="${msg}" />:
                        <span class="text-danger">*</span>
                    </label>
                    <div class="col-md-2 col-sm-2">
                        <input type="text" required name="snapshot" valid-number data-ng-model="infraLimit.snapshot" class="form-control" >
                    </div>
                </div>
                <div class="form-group" data-ng-class="{ 'text-danger' : infraLimitForm.network.$invalid && formSubmitted}">
                    <label class="col-md-4 col-sm-4 control-label"><fmt:message key="network.limits" bundle="${msg}" />:
                        <span class="text-danger">*</span>
                    </label>
                    <div class="col-md-2 col-sm-2">
                        <input type="text" required name="network" valid-number data-ng-model="infraLimit.network" class="form-control" >
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group" data-ng-class="{ 'text-danger' : infraLimitForm.publicIp.$invalid && formSubmitted}">

                    <label class="col-md-4 col-sm-4 control-label"><fmt:message key="public.ip.limits" bundle="${msg}" />:
                        <span class="text-danger">*</span>
                    </label>
                    <div class="col-md-2 col-sm-2">
                        <input type="text" required name="publicIp" valid-number data-ng-model="infraLimit.publicIp" class="form-control" >
                    </div>
                </div>
                <div class="form-group" data-ng-class="{ 'text-danger' : infraLimitForm.vpc.$invalid && formSubmitted}">
                    <label class="col-md-4 col-sm-4 control-label"><fmt:message key="vpu.limits" bundle="${msg}" />:
                        <span class="text-danger">*</span>
                    </label>
                    <div class="col-md-2 col-sm-2">
                        <input type="text" required name="vpc" valid-number data-ng-model="infraLimit.vpc" class="form-control" >
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="form-group" data-ng-class="{ 'text-danger' : infraLimitForm.cpu.$invalid && formSubmitted}">

                    <label class="col-md-4 col-sm-4 control-label"><fmt:message key="cpu.limits" bundle="${msg}" />:
                        <span class="text-danger">*</span>
                    </label>
                    <div class="col-md-2 col-sm-2">
                        <input type="text" required name="cpu" valid-number data-ng-model="infraLimit.cpu" class="form-control" >
                    </div>
                </div>
                <div class="form-group" data-ng-class="{ 'text-danger' : infraLimitForm.memory.$invalid && formSubmitted}">
                    <label class="col-md-4 col-sm-4 control-label"><fmt:message key="memory.limits(MB)" bundle="${msg}" />:
                        <span class="text-danger">*</span>
                    </label>
                    <div class="col-md-2 col-sm-2">
                        <input type="text" required name="memory" valid-number data-ng-model="infraLimit.memory" class="form-control" >
                    </div>
                </div>
            </div>


            <div class="row">
                <div class="form-group" data-ng-class="{ 'text-danger' : infraLimitForm.primaryStorage.$invalid && formSubmitted}">
                    <label class="col-md-4 col-sm-4 control-label"><fmt:message key="primary.storage.limits(GB)" bundle="${msg}" />:
                        <span class="text-danger">*</span>
                    </label>
                    <div class="col-md-2 col-sm-2">
                        <input type="text" required name="primaryStorage" valid-number data-ng-model="infraLimit.primaryStorage" class="form-control" >
                    </div>
                </div>
                <div class="form-group" data-ng-class="{ 'text-danger' : infraLimitForm.secondaryStorage.$invalid && formSubmitted}">
                    <label class="col-md-4 col-sm-4 control-label"><fmt:message key="secondary.storage.limits(GB)" bundle="${msg}" />:
                        <span class="text-danger">*</span>
                    </label>
                    <div class="col-md-2 col-sm-2">
                        <input type="text" required name="secondaryStorage" valid-number data-ng-model="infraLimit.secondaryStorage" class="form-control" >
                    </div>
                </div>
            </div>

            <hr>
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="pull-right">
                        <button type="submit" class="btn btn-info" > <fmt:message key="common.apply" bundle="${msg}" /> </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
