<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<form name="resourceAllocationForm" data-ng-submit="save(resourceAllocationForm)" method="post" novalidate="" data-ng-controller="resourceAllocationCtrl">

    <div class="row">
        <div class="col-md-12 col-sm-12">
            <div class="hpanel">
                <div class="panel-heading">

                    <div class="clearfix"></div>
                </div>
                <div class="panel-body">
                    <div class="col-md-12 col-sm-12 m-b-md border-bottom">
						<input type="hidden" data-ng-model="resourceQuota.domain" />
<!-- 						<input type="hidden" data-ng-model="type" /> -->

                        <div class="col-md-4 col-sm-4" data-ng-if="type == 'department-quota'" >
                            <div class="form-group">

                                <div class="row">
                                    <label class="col-md-4 col-sm-4 control-label"><fmt:message key="common.department" bundle="${msg}" />:
                                    </label>
                                    <div class="col-md-8 col-sm-8">
                                        <!-- <select   class="form-control input-group" name="department" data-ng-disabled="true" data-ng-model="resourceQuota.department" ng-options="department.userName for department in departmentList" >
                                            <option value="">Select</option>
                                        </select> -->
                                       <label> {{resourceQuota.department.userName}}</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                          <div class="col-md-4 col-sm-4" data-ng-if="type == 'project-quota'">
                            <div class="form-group">
                                <div class="row" >
                                    <label class="col-md-4 col-sm-4 control-label"><fmt:message key="common.project" bundle="${msg}" />:
                                    </label>
                                    <div class="col-md-8 col-sm-8">

                                        <!-- <select  class="form-control input-group"  data-ng-disabled="true"  name="project"   data-ng-model="resourceQuota.project" ng-options="project.name for project in projectList" >
                                            <option value="">Select</option>
                                        </select> -->
                                          <label> {{resourceQuota.project.name}}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
				<get-loader-image data-ng-show="showLoader"></get-loader-image>
					<div class="col-md-12 col-sm-12" data-ng-hide="showLoader">
						<div class="form-group"
							ng-class="{
                                            'text-danger'
                                            : resourceAllocationForm.Volume.$invalid && formSubmitted}">
							<div class="row">
								<label class="col-md-2 col-sm-2 control-label"><fmt:message
										key="max.volumes" bundle="${msg}" />: <span
									class="text-danger">*</span> </label>

								<div class="col-md-2 col-sm-2">
									<input required="true" type="text" valid-integer name="Volume"
										data-ng-model="resourceQuota.Volume" class="form-control"
										data-ng-class="{'error': resourceAllocationForm.Volume.$invalid && formSubmitted}">
									<i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"
										tooltip="<fmt:message key="maximum.volumes.to.be.allocated" bundle="${msg}" />"></i>
									<div class="error-area"
										data-ng-show="resourceAllocationForm.Volume.$invalid && formSubmitted">
										<i
											ng-attr-tooltip="{{ resourceAllocationForm.Volume.errorMessage || '<fmt:message key="max.volumes.are.required" bundle="${msg}" />' }}"
											class="fa fa-warning error-icon"></i>
									</div>
								</div>
                                 <div data-ng-if="resource=='department'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Volume: <b class="text-danger">
									<span>{{resourceDomainCount.Volume  || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.project" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Volume : <b class="text-danger">
									<span>{{resourceProjectCount.Volume  || '-'}}</span></b></label>
                                </div>
                                <div data-ng-if="resource=='project'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Volume: <b class="text-danger">
									<span>{{resourceDomainCount.Volume || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.department" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Volume : <b class="text-danger">
									<span>{{resourceDepartmentCount.Volume || '-' }}</span></b></label>
                                </div>
							</div>
						</div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : resourceAllocationForm.Instance.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-2 col-sm-2 control-label"><fmt:message key="max.user.vms" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-2 col-sm-2">
                                    <input required="true" type="text" valid-integer is-number name="Instance" data-ng-model="resourceQuota.Instance"  class="form-control" data-ng-class="{'error': resourceAllocationForm.Instance.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.user.vms.to.be.allocated" bundle="${msg}" />"></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.Instance.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.Instance.errorMessage || '<fmt:message key="max.user.vms.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
                                 <div data-ng-if="resource=='department'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Instance: <b class="text-danger">
									<span>{{resourceDomainCount.Instance  || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.project" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Instance : <b class="text-danger">
									<span>{{resourceProjectCount.Instance || '-'}}</span></b></label>
                                </div>
                                  <div data-ng-if="resource=='project'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Instance: <b class="text-danger">
									<span>{{resourceDomainCount.Instance || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.department" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Instance : <b class="text-danger">
									<span>{{resourceDepartmentCount.Instance || '-'}}</span></b></label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : resourceAllocationForm.Template.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-2 col-sm-2 control-label"><fmt:message key="max.templates" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-2 col-sm-2">
                                    <input required="true" type="text" valid-integer name="Template" data-ng-model="resourceQuota.Template"  class="form-control" data-ng-class="{'error': resourceAllocationForm.Template.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.templates.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.Template.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.Template.errorMessage || '<fmt:message key="max.templates.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
                                <div data-ng-if="resource=='department'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Template: <b class="text-danger">
									<span>{{resourceDomainCount.Template || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.project" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Template : <b class="text-danger">
									<span>{{resourceProjectCount.Template || '-'}}</span></b></label>
                                </div>
                                  <div data-ng-if="resource=='project'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Template: <b class="text-danger">
									<span>{{resourceDomainCount.Template || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.department" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Template : <b class="text-danger">
									<span>{{resourceDepartmentCount.Template || '-'}}</span></b></label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : resourceAllocationForm.Network.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-2 col-sm-2 control-label"><fmt:message key="max.networks" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-2 col-sm-2">
                                    <input required="true" type="text" valid-integer name="Network" data-ng-model="resourceQuota.Network"  class="form-control" data-ng-class="{'error': resourceAllocationForm.Network.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.networks.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.Network.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.Network.errorMessage || '<fmt:message key="max.networks.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
                                 <div data-ng-if="resource=='department'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Network: <b class="text-danger">
									<span>{{resourceDomainCount.Network || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.project" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Network : <b class="text-danger">
									<span>{{resourceProjectCount.Network || '-'}}</span></b></label>
                                </div>
                                  <div data-ng-if="resource=='project'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Network: <b class="text-danger">
									<span>{{resourceDomainCount.Network || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.department" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Network : <b class="text-danger">
									<span>{{resourceDepartmentCount.Network || '-'}}</span></b></label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : resourceAllocationForm.Snapshot.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-2 col-sm-2 control-label"><fmt:message key="max.snapshots" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-2 col-sm-2">
                                    <input required="true" type="text" valid-integer name="Snapshot" data-ng-model="resourceQuota.Snapshot"  class="form-control" data-ng-class="{'error': resourceAllocationForm.Snapshot.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.snapshots.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.Snapshot.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.Snapshot.errorMessage || '<fmt:message key="max.snapshots.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
                                <div data-ng-if="resource=='department'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Snapshot: <b class="text-danger">
									<span>{{resourceDomainCount.Snapshot || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.project" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Snapshot : <b class="text-danger">
									<span>{{resourceProjectCount.Snapshot || '-'}}</span></b></label>
                                </div>
                                <div data-ng-if="resource=='project'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Snapshot: <b class="text-danger">
									<span>{{resourceDomainCount.Snapshot || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.department" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Snapshot : <b class="text-danger">
									<span>{{resourceDepartmentCount.Snapshot || '-'}}</span></b></label>
                                </div>

                            </div>
                        </div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : resourceAllocationForm.IP.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-2 col-sm-2 control-label"><fmt:message key="max.public.ips" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-2 col-sm-2">
                                    <input required="true" type="text" valid-integer name="IP" data-ng-model="resourceQuota.IP"  class="form-control" data-ng-class="{'error': resourceAllocationForm.IP.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.public.ips.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.IP.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.IP.errorMessage || '<fmt:message key="max.public.ips.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
                                  <div data-ng-if="resource=='department'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Public IP: <b class="text-danger">
									<span>{{resourceDomainCount.IP || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.project" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Public IP : <b class="text-danger">
									<span>{{resourceProjectCount.IP || '-'}}</span></b></label>
                                </div>
                                 <div data-ng-if="resource=='project'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Public IP: <b class="text-danger">
									<span>{{resourceDomainCount.IP || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.department" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Public IP : <b class="text-danger">
									<span>{{resourceDepartmentCount.IP || '-'}}</span></b></label>
                                </div>

                            </div>
                        </div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : resourceAllocationForm.VPC.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-2 col-sm-2 control-label"><fmt:message key="max.vpcs" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-2 col-sm-2">
                                    <input required="true" type="text" valid-integer name="VPC" data-ng-model="resourceQuota.VPC"  class="form-control" data-ng-class="{'error': resourceAllocationForm.VPC.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.vpcs.to.be.allocated" bundle="${msg}" />"></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.VPC.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.VPC.errorMessage || '<fmt:message key="max.vpcs.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
                                <div data-ng-if="resource=='department'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> VPC: <b class="text-danger">
									<span>{{resourceDomainCount.VPC || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.project" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> VPC : <b class="text-danger">
									<span>{{resourceProjectCount.VPC || '-'}}</span></b></label>
                                </div>
                                <div data-ng-if="resource=='project'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> VPC: <b class="text-danger">
									<span>{{resourceDomainCount.VPC || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.department" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> VPC : <b class="text-danger">
									<span>{{resourceDepartmentCount.VPC || '-'}}</span></b></label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : resourceAllocationForm.CPU.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-2 col-sm-2 control-label"><fmt:message key="max.cpu.cores" bundle="${msg}" />:
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-2 col-sm-2">
                                    <input required="true" type="text" valid-integer name="CPU" data-ng-model="resourceQuota.CPU"  class="form-control" data-ng-class="{'error': resourceAllocationForm.CPU.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.cpu.cores.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.CPU.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.CPU.errorMessage || '<fmt:message key="max.cpu.cores.are.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i></div>
                                </div>
                                  <div data-ng-if="resource=='department'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> CPU Cores: <b class="text-danger">
									<span>{{resourceDomainCount.CPU || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.project" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> CPU Cores: <b class="text-danger">
									<span>{{resourceProjectCount.CPU || '-'}}</span></b></label>
                                </div>
                                 <div data-ng-if="resource=='project'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> CPU Cores: <b class="text-danger">
									<span>{{resourceDomainCount.CPU || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.department" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> CPU Cores: <b class="text-danger">
									<span>{{resourceDepartmentCount.CPU || '-'}}</span></b></label>
                                </div>

                            </div>
                        </div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : resourceAllocationForm.Memory.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-2 col-sm-2 control-label"><fmt:message key="max.memory" bundle="${msg}" /> (MiB):
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-2 col-sm-2">
                                    <input required="true" type="text" valid-integer name="Memory" data-ng-model="resourceQuota.Memory"  class="form-control" data-ng-class="{'error': resourceAllocationForm.Memory.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.memory.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.Memory.$invalid && formSubmitted" >
                                    <i  ng-attr-tooltip="{{ resourceAllocationForm.Memory.errorMessage || '<fmt:message key="max.memory.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i></div>
                                </div>
                                  <div data-ng-if="resource=='department'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Memory: <b class="text-danger">
									<span>{{resourceDomainCount.Memory || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.project" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Memory : <b class="text-danger">
									<span>{{resourceProjectCount.Memory || '-'}}</span></b></label>
                                </div>
                                <div data-ng-if="resource=='project'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Memory: <b class="text-danger">
									<span>{{resourceDomainCount.Memory || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.department" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> Memory : <b class="text-danger">
									<span>{{resourceDepartmentCount.Memory || '-'}}</span></b></label>
                                </div>
                             </div>
                        </div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : resourceAllocationForm.PrimaryStorage.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-2 col-sm-2 control-label"><fmt:message key="max.primary" bundle="${msg}" /> (GiB):
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-2 col-sm-2">
                                    <input required="true" type="text" valid-integer name="PrimaryStorage" data-ng-model="resourceQuota.PrimaryStorage"  class="form-control" data-ng-class="{'error': resourceAllocationForm.PrimaryStorage.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.primary.storage.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.PrimaryStorage.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.PrimaryStorage.errorMessage || '<fmt:message key="max.primary.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                    </div>
                                </div>
                                <div data-ng-if="resource=='department'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> PrimaryStorage: <b class="text-danger">
									<span>{{resourceDomainCount.PrimaryStorage || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.project" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> PrimaryStorage : <b class="text-danger">
									<span>{{resourceProjectCount.PrimaryStorage || '-'}}</span></b></label>
                                </div>
                                   <div data-ng-if="resource=='project'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> PrimaryStorage: <b class="text-danger">
									<span>{{resourceDomainCount.PrimaryStorage || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.department" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> PrimaryStorage : <b class="text-danger">
									<span>{{resourceDepartmentCount.PrimaryStorage || '-'}}</span></b></label>
                                </div>
                               </div>

                        </div>
                        <div class="form-group" ng-class="{
                                            'text-danger'
                                            : resourceAllocationForm.SecondaryStorage.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-2 col-sm-2 control-label"><fmt:message key="max.secondary" bundle="${msg}" /> (GiB):
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-2 col-sm-2">
                                    <input required="true" type="text" valid-integer name="SecondaryStorage" data-ng-model="resourceQuota.SecondaryStorage"  class="form-control" data-ng-class="{'error': resourceAllocationForm.SecondaryStorage.$invalid && formSubmitted}">
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="maximum.secondary.storage.to.be.allocated" bundle="${msg}" />" ></i>
                                    <div class="error-area" data-ng-show="resourceAllocationForm.SecondaryStorage.$invalid && formSubmitted" >
                                    	<i  ng-attr-tooltip="{{ resourceAllocationForm.SecondaryStorage.errorMessage || '<fmt:message key="max.secondary.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i></div>
                                </div>
                                <div data-ng-if="resource=='department'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> SecondaryStorage: <b class="text-danger">
									<span>{{resourceDomainCount.SecondaryStorage || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.project" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" />  SecondaryStorage : <b class="text-danger">
									<span>{{resourceProjectCount.SecondaryStorage || '-'}}</span></b></label>
                                </div>
                                 <div data-ng-if="resource=='project'" class="col-md-8 col-sm-8 m-l-xxl ">
                                	<label class="col-md-6 font-normal col-sm-7 "> <fmt:message key="common.domain" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> SecondaryStorage: <b class="text-danger">
									<span>{{resourceDomainCount.SecondaryStorage || '-'}}</span>
									</b></label>
                                	<label class="col-md-6 font-normal col-sm-6 "> <fmt:message key="common.department" bundle="${msg}" /> <fmt:message key="common.available" bundle="${msg}" /> SecondaryStorage : <b class="text-danger">
									<span>{{resourceDepartmentCount.SecondaryStorage || '-'}}</span></b></label>
                                </div>

                            </div>
                        </div>
						<div class="form-group">
							<div class="row">
						  <label class="col-sm-1 col-md-1 control-label"><fmt:message key="note" bundle="${msg}" /> :</label>
                            <div class="col-sm-4 col-md-3">
                                <div class="well ">
                              <fmt:message key="common.quota.note.display" bundle="${msg}" />
                                </div>
                            </div>
								<get-loader-image data-ng-show="showLoader"></get-loader-image>
								<div class="col-md-4 col-sm-5" data-ng-hide="showLoader">
									<a class="btn btn-default btn-outline"
										data-ng-if="type == 'department-quota'" ui-sref="department""><fmt:message
											key="common.cancel" bundle="${msg}" /></a> <a
										class="btn btn-default btn-outline"
										data-ng-if="type == 'project-quota'" ui-sref="projects""><fmt:message
											key="common.cancel" bundle="${msg}" /> </a>

									<button data-ng-if="type == 'department-quota'"
										class="btn btn-info" has-permission="DEPARTMENT_QUOTA_EDIT"
										data-ng-hide="showLoader" type="submit">
										<fmt:message key="common.update" bundle="${msg}" />
									</button>
									<button data-ng-if="type == 'project-quota'"
										class="btn btn-info" has-permission="PROJECT_QUOTA_EDIT"
										type="submit">
										<fmt:message key="common.update" bundle="${msg}" />
									</button>
								</div>
							</div>
						</div>
					</div>

				</div>
            </div>


        </div>
    </div>
    </form>