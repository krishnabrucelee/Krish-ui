<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<form name="EditNetworkAclForm" data-ng-submit="update(EditNetworkAclForm)" method="post" novalidate="" >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header id="editrule" hide-zone="false" page-icon="fa fa-edit" page-title="<fmt:message key="edit.rule" bundle="${msg}" />"></panda-modal-header>

        </div>
        <div class="modal-body">
            <div class="row"  >
                <div class="col-md-12">
					<div class="form-group"ng-class="{'text-danger': EditNetworkAclForm.ruleNumber.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message key="vpc.ruleNumber" bundle="${msg}" /><span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
                                <input type="text" id="edit_vpcAcl_ruleNumber" name="ruleNumber"  data-ng-model="vpcAcl.ruleNumber"  class="form-control" data-ng-class="{'error': EditNetworkAclForm.ruleNumber.$invalid && formSubmitted}"/>
                                <i  tooltip="<fmt:message key="vpc.ruleNumber" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area" data-ng-show="EditNetworkAclForm.ruleNumber.$invalid && formSubmitted" >
                                    <i ng-attr-tooltip="{{ EditNetworkAclForm.ruleNumber.errorMessage || '<fmt:message key="networkAcl.ruleNumber.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group"ng-class="{'text-danger': EditNetworkAclForm.cidrList.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label control-normal">CIDR:<span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
                                <input required="true" type="text" name="sourceCIDR"  valid-cidr placeholder="0.0.0.0/24"  data-ng-model="vpcAcl.cidrList" class="form-control input-group " ><span class="text-center text-danger" data-ng-show="vpcAclForm.sourceCIDR.$invalid && formSubmitted" data-ng-class="cidrValidates && actionRules ? 'text-danger' : ''"> Invalid format</span>
                                <i  tooltip="<fmt:message key="vpcAcl.cidrList" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area" data-ng-show="EditNetworkAclForm.cidrList.$invalid && formSubmitted" >
                                    <i ng-attr-tooltip="{{ EditNetworkAclForm.cidrList.errorMessage || '<fmt:message key="vpcAcl.cidrList.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group"ng-class="{'text-danger': EditNetworkAclForm.action.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label control-normal">Action:<span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
                               <select required="true" class="form-control input-group" name="action" data-ng-model="vpcAcl.action"  data-ng-change="" ng-options="action for (id, action) in actionList"><option value=""><fmt:message key="common.select"
										bundle="${msg}" /></option></select>
                                <i  tooltip="<fmt:message key="vpcAcl.action" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area" data-ng-show="EditNetworkAclForm.action.$invalid && formSubmitted" >
                                    <i ng-attr-tooltip="{{ EditNetworkAclForm.action.errorMessage || '<fmt:message key="vpcAcl.action.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group"ng-class="{'text-danger': EditNetworkAclForm.protocol.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label control-normal">Protocol:<span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
                             <select required="true" class="form-control input-group" name="protocol" data-ng-model="vpcAcl.protocol"  data-ng-change="selectProtocol(vpcAcl.protocol)" ng-options="protocol for (id, protocol) in protocolList"><option value=""><fmt:message key="common.select"
										bundle="${msg}" /></option></select> <span class="text-center text-danger" data-ng-show=""></span>
                                <i  tooltip="<fmt:message key="vpcAcl.protocol" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area" data-ng-show="EditNetworkAclForm.protocol.$invalid && formSubmitted" >
                                    <i ng-attr-tooltip="{{ EditNetworkAclForm.protocol.errorMessage || '<fmt:message key="vpcAcl.protocol.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                     <div class="form-group"ng-class="{'text-danger': EditNetworkAclForm.protocolNumber.$invalid && formSubmitted}">
                        <div class="row" data-ng-show = " (vpcAcl.protocol== 'Protocol Number')" >
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label control-normal">Protocol Number:<span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
                             <input data-ng-if = " (vpcAcl.protocol== 'Protocol Number')" required="true" valid-number type="text" name="protocolNumber" data-ng-model="vpcAcl.protocolNumber" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.protocolNumber.$invalid && formSubmitted"> *Required</span> <span class="text-center text-danger" data-ng-show=""></span>
                                <i  tooltip="<fmt:message key="vpcAcl.protocolNumber" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area" data-ng-show="EditNetworkAclForm.protocolNumber.$invalid && formSubmitted" >
                                    <i ng-attr-tooltip="{{ EditNetworkAclForm.protocolNumber.errorMessage || '<fmt:message key="vpcAcl.protocolNumber.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                     <div class="form-group"ng-class="{'text-danger': EditNetworkAclForm.startPort.$invalid && formSubmitted}">
                        <div class="row" data-ng-show = " (vpcAcl.protocol == 'TCP' || vpcAcl.protocol=='UDP' || vpcAcl.protocol== 'Protocol Number')">
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label control-normal">Start Port:<span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
							<input data-ng-if = " (vpcAcl.protocol == 'TCP' || vpcAcl.protocol=='UDP' || vpcAcl.protocol== 'Protocol Number')" required="true" valid-number  placeholder="1" data-ng-min="1" data-ng-max="65535"   type="text" name="startPort" data-ng-model="vpcAcl.startPort" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.startPort.$invalid && formSubmitted"> *Required</span>
							<i  tooltip="<fmt:message key="vpcAcl.startPort" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area" data-ng-show="EditNetworkAclForm.startPort.$invalid && formSubmitted" >
                                    <i ng-attr-tooltip="{{ EditNetworkAclForm.startPort.errorMessage || '<fmt:message key="vpcAcl.startPort.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group"ng-class="{'text-danger': EditNetworkAclForm.endPort.$invalid && formSubmitted}">
                        <div class="row" data-ng-show = "(vpcAcl.protocol == 'TCP' || vpcAcl.protocol=='UDP' || vpcAcl.protocol== 'Protocol Number')">
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label control-normal">End Port:<span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
							<input data-ng-if = " (vpcAcl.protocol == 'TCP' || vpcAcl.protocol=='UDP' || vpcAcl.protocol== 'Protocol Number')" required="true" valid-number  placeholder="65535" data-ng-min="1" data-ng-max="65535"   type="text" name="endPort" data-ng-model="vpcAcl.endPort" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.endPort.$invalid && formSubmitted"> *Required</span>
							<i  tooltip="<fmt:message key="vpcAcl.endPort" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
							<div class="error-area" data-ng-show="EditNetworkAclForm.endPort.$invalid && formSubmitted" >
                                    <i ng-attr-tooltip="{{ EditNetworkAclForm.endPort.errorMessage || '<fmt:message key="vpcAcl.endPort.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group"ng-class="{'text-danger': EditNetworkAclForm.icmpType.$invalid && formSubmitted}">
                        <div class="row" data-ng-show = " (vpcAcl.protocol == 'ICMP')">
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label control-normal">ICMP Type:<span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
						<input data-ng-if = " (vpcAcl.protocol == 'ICMP')" required="true"  type="text" name="icmpType" data-ng-model="vpcAcl.icmpType" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.icmpType.$invalid && formSubmitted"> </span>                                <div class="error-area" data-ng-show="EditNetworkAclForm.ruleNumber.$invalid && formSubmitted" >
                                    <i  tooltip="<fmt:message key="vpcAcl.icmpType" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                    <i ng-attr-tooltip="{{ EditNetworkAclForm.icmpType.errorMessage || '<fmt:message key="vpcAcl.icmpType.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                     <div class="form-group"ng-class="{'text-danger': EditNetworkAclForm.icmpCode.$invalid && formSubmitted}">
                        <div class="row" data-ng-show = " (vpcAcl.protocol == 'ICMP')">
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label control-normal">ICMP Code:<span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
						<input data-ng-if = " (vpcAcl.protocol == 'ICMP')" required="true"  type="text" name="icmpCode" data-ng-model="vpcAcl.icmpCode" class="form-control " autofocus ><span class="text-center text-danger" data-ng-show="vpcAclForm.icmpCode.$invalid && formSubmitted"></span>   <div class="error-area" data-ng-show="EditNetworkAclForm.ruleNumber.$invalid && formSubmitted" >
						 <i  tooltip="<fmt:message key="vpcAcl.icmpCode" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
						 <i ng-attr-tooltip="{{ EditNetworkAclForm.icmpCode.errorMessage || '<fmt:message key="vpcAcl.icmpCode.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                     <div class="form-group"ng-class="{'text-danger': EditNetworkAclForm.trafficType.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label control-normal">Traffic Type:<span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
                               <select required="true" class="form-control input-group" name="trafficType" data-ng-model="vpcAcl.trafficType"  data-ng-change="" ng-options="trafficType for (id, trafficType) in trafficTypeList"><option value=""><fmt:message key="common.select"
										bundle="${msg}" /></option></select>
                                <i  tooltip="<fmt:message key="vpcAcl.trafficType" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area" data-ng-show="EditNetworkAclForm.trafficType.$invalid && formSubmitted" >
                                    <i ng-attr-tooltip="{{ EditNetworkAclForm.trafficType.errorMessage || '<fmt:message key="vpcAcl.trafficType.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                     </div>

            </div>
        </div>

        <div class="modal-footer">
            <get-loader-image data-ng-show="showLoader"></get-loader-image>

            <button type="button" id="edit_department_cancel_button" data-ng-hide="showLoader" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
            <button class="btn btn-info" data-ng-hide="showLoader" id="edit_department_update_button" type="submit"><fmt:message key="common.update" bundle="${msg}" /></button>

        </div>
        </div>
</form>