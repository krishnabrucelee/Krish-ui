<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<form name="networkForm" method="POST" data-ng-submit="addNicToVirtualMachine(networkForm, network)"  novalidate >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-custom-icon="images/network-icon-2.png"  page-title="<fmt:message key="add.network.to.vm" bundle="${msg}" />"></panda-modal-header>

        </div>
        <div class="modal-body">

            <div class="row">
                <div class="col-md-12">
                    <h6 class="text-left m-l-md ">
                        <fmt:message key="please.specify.the.network.that.you.would.like.to.add.this.VM.to" bundle="${msg}" />.<fmt:message key="a.new.nic.will.be.added.for.this.network" bundle="${msg}" />.
                    </h6>
                    <br/>
                    <!--<div class="hr-line-dashed"></div>-->
                    <div class="form-group" ng-class="{ 'text-danger' : networkForm.networkOffers.$invalid && formSubmitted}">

                        <div class="row" >
                            <label class="col-md-offset-1 col-sm-offset-1  col-md-2 col-xs-3 col-sm-1 control-label "><fmt:message key="common.network" bundle="${msg}" /><span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-xs-5 col-sm-5">
                                <select required="true" class="form-control input-group" name="networkOffers"
                                        data-ng-model="network" data-ng-class="{'error': networkForm.networkOffers.$invalid && formSubmitted}"
                                        data-ng-options="network.name for network in networkList" >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                </select>
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="select.the.network" bundle="${msg}" />" ></i>
                                <div class="error-area" data-ng-show="networkForm.networkOffers.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="network.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
			<get-loader-image data-ng-show="showLoader"></get-loader-image>
            <a class="btn btn-default"   data-ng-if="!showLoader"  data-ng-click="cancel()"><fmt:message key="common.cancel" bundle="${msg}" /></a>
            <button class="btn btn-info"   data-ng-if="!showLoader"   type="submit"><fmt:message key="common.add" bundle="${msg}" /></button>
        </div>
    </div>
</form>