<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<form name="addnetworkForm" data-ng-submit="save(addnetworkForm, network)" method="post" novalidate=""  >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-plus-circle" page-title="<fmt:message key="add.isolated.network" bundle="${msg}" />"></panda-modal-header>
        </div>
        <div class="modal-body">
            <div class="row"  >
                <div class="col-md-12">

                    <div class="form-group" ng-class="{'text-danger': addnetworkForm.name.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label" ><fmt:message key="common.name" bundle="${msg}" /> <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-6 col-xs-12 col-sm-6">
                                <input required="true" type="text"  name="name" data-ng-model="network.name"  class="form-control" data-ng-class="{'error': addnetworkForm.name.$invalid && formSubmitted}">
                                <i  tooltip="<fmt:message key="network.name" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area" data-ng-show="addnetworkForm.name.$invalid && formSubmitted" >
                                    <i ng-attr-tooltip="{{ addnetworkForm.name.errorMessage || '<fmt:message key="network.name.is.required" bundle="${msg}" />' }}" class="fa fa-warning error-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" ng-class="{'text-danger': addnetworkForm.description.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label" ><fmt:message key="common.description" bundle="${msg}" /> <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-6 col-xs-12 col-sm-6">
                                <textarea rows="4" required="true" type="text"  name="description" data-ng-model="network.displayText"  class="form-control" data-ng-class="{'error': addnetworkForm.description.$invalid && formSubmitted}"></textarea>
                                <i  tooltip="<fmt:message key="description.of.the.network" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area" data-ng-show="addnetworkForm.description.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="network.description.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group"ng-class="{'text-danger':addnetworkForm.zone.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message key="common.zone" bundle="${msg}" /><span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
                                <select required="true" class="form-control input-group" name="zone" data-ng-model="network.zone" ng-options="zone.name for zone in zoneList" data-ng-class="{'error': addnetworkForm.zone.$invalid && formSubmitted}" >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                </select>
                                <i  tooltip="<fmt:message key="choose.zone" bundle="${msg}" /> " class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area" data-ng-show="addnetworkForm.zone.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="zone.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group"ng-class="{'text-danger':addnetworkForm.networkoffering.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message key="common.networkoffering" bundle="${msg}" /><span class="text-danger">*</span></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
                                <select required="true" class="form-control input-group" name="networkoffering" data-ng-model="network.networkOffering" ng-options="networkoffering.displayText for networkoffering in networkOfferList" data-ng-class="{'error': addnetworkForm.networkoffering.$invalid && formSubmitted}" >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                </select>
                                <i  tooltip="<fmt:message key="choose.networkoffering" bundle="${msg}" /> " class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area" data-ng-show="addnetworkForm.networkoffering.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="networkoffering.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label class="col-md-4 col-sm-4 control-label"><fmt:message key="guestgateway" bundle="${msg}" />
                            </label>
                            <div class="col-md-6 col-sm-6">
                                <input type="text" name="guestgateway" data-ng-model="network.gateway" class="form-control" >
                                <i  tooltip="<fmt:message key="guestgateway" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" >
                        <div class="row">
                            <label class="col-md-4 col-sm-4 control-label"><fmt:message key="guestnetmask" bundle="${msg}" />
                            </label>
                            <div class="col-md-6 col-sm-6">
                                <input  type='text'   name="guestnetmask" data-ng-model="network.netMask" class="form-control"  >
                                <i  tooltip="<fmt:message key="guestnetmask" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" >
                        <div class="row">
                            <label class="col-md-4 col-sm-4 control-label"><fmt:message key="networkdomain" bundle="${msg}" />
                            </label>
                            <div class="col-md-6 col-sm-6">
                                <input type="text" name="networkdomain" data-ng-model="network.networkDomain" class="form-control" >
                                <i  tooltip="<fmt:message key="networkdomain" bundle="${msg}" />" class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message key="common.domain" bundle="${msg}" /></label>
                            <div class="col-md-6  col-sm-6 col-xs-12">
                                <select  class="form-control input-group" name="domain" data-ng-model="network.domain" ng-options="domain.name for domain in domainList"  >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                </select>
                                <i  tooltip="<fmt:message key="choose.domain" bundle="${msg}" /> " class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" ng-class="{'text-danger': !network.department && formSubmitted}" data-ng-if="network.domain">
                        <div class="row">
                            <label class="col-md-4 col-xs-12 col-sm-4 control-label"><fmt:message
                                    key="common.department" bundle="${msg}" /> <span
                                    class="text-danger">*</span> </label>
                            <div class="col-md-6 col-xs-12 col-sm-6 department-selectbox">
                                <div
                                    data-ng-class="{'error': !network.department && formSubmitted}"
                                    custom-select="t as t.userName for t in formElements.departmenttypeList | filter: { name: $searchTerm }"
                                    ng-model="network.department">
                                    <div class="pull-left">
                                        <strong>{{ t.userName}}</strong><br />
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <i tooltip="<fmt:message key="common.department" bundle="${msg}" />"
                                   class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>
                                <div class="error-area"
                                     data-ng-show="addnetworkForm.account.$invalid && formSubmitted">
                                    <i
                                        ng-attr-tooltip="{{ addnetworkForm.account.errorMessage || '<fmt:message key="account.is.required" bundle="${msg}" />' }}"
                                        class="fa fa-warning error-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <get-loader-image data-ng-show="showLoader"></get-loader-image>
             <button type="button" data-ng-hide="showLoader" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
            <button class="btn btn-info" data-ng-hide="showLoader" type="submit"><fmt:message key="common.add" bundle="${msg}" /></button>
        </div></div>
</form>




