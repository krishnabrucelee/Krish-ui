<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<form name="vmsnapshotForm" data-ng-submit="validateVMSnapshot(vmsnapshotForm)" method="post" novalidate="" >

    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-custom-icon="images/vm-snapshot.png" page-title="<fmt:message key="create.vm.snapshot" bundle="${msg}" />"><div class="row">
                    <div class="col-md-8 font-bold">
                        <span class="ver-align-mid"><i style="" class="pe-lg ng-hide" data-ng-hide="pageCustomIcon" title="<fmt:message key="create.vm.snapshot" bundle="${msg}" />"></i>
                            <img src="images/vm-snapshot.png" style="width:22px; height:22px;" data-ng-show="pageCustomIcon" alt="Create VM Snapshot">
                        </span>
                        <span class="ver-align-mid ng-binding"><fmt:message key="create.vm.snapshot" bundle="${msg}" /></span>
                    </div>

                    <div class="col-md-4">
                        <div class="pull-right font-extra-bold">
                            <span data-ng-hide="hideZone" class="ver-align-mid ng-binding" title="<fmt:message key="common.zone" bundle="${msg}" />"><i class="fa fa-map-marker m-r-xsm"></i> Beijing</span>
                            <a class="close-container" href="javascript:void(0);" data-ng-click="cancel()"><img src="images/close3.png" alt="Close"></a>
                        </div>
                    </div>
                </div></panda-modal-header>

        </div>

        <div class="modal-body">
            <div class="row"  >
                <div class="col-md-12">

                    <div class="form-group" ng-class="{'text-danger': vmsnapshotForm.name.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-3 col-sm-3 control-label" ><fmt:message key="common.name" bundle="${msg}" />
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-sm-5">
                                <input required="true" type="text" name="name" data-ng-model="vmsnapshot.name" class="form-control" data-ng-class="{'error':  vmsnapshotForm.name.$invalid && formSubmitted}"  >
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="name.of.the.instance" bundle="${msg}" />" ></i>
                                <div class="error-area" data-ng-show="vmsnapshotForm.name.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="name.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>

                        </div>
                    </div>
                    <div class="form-group" ng-class="{'text-danger': vmsnapshotForm.description.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-3 col-sm-3 control-label" ><fmt:message key="common.description" bundle="${msg}" />
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-sm-5">
                                <input required="true" type="text" name="description" data-ng-model="vmsnapshot.description" class="form-control" data-ng-class="{'error':  vmsnapshotForm.name.$invalid && formSubmitted}"  >
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="<fmt:message key="description.of.the.instance" bundle="${msg}" />" ></i>
                                <div class="error-area" data-ng-show="vmsnapshotForm.description.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="description.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" ng-class="{'text-danger': vmsnapshotForm.snapshotMemory.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-3 col-sm-3 control-label" ><fmt:message key="snapshot.memory" bundle="${msg}" /> <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-sm-5">
                                <label> <input icheck type="checkbox" name="snapshotMemory"  required value="true" data-ng-model="vmsnapshot.snapshotMemory" data-ng-class="{'error':  vmsnapshotForm.snapshotMemory.$invalid && formSubmitted}" > </label>



                            </div>

                        </div>
                    </div>
                    <div class="form-group" ng-class="{'text-danger': vmsnapshotForm.instance.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-3 col-sm-3 control-label" ><fmt:message key="common.instance" bundle="${msg}" />
                                <span class="text-danger">*</span>
                            </label>

                            <div class="col-md-5 col-sm-5 ">
                                <select required="true" class="form-control input-group" data-ng-class="{'error':  vmsnapshotForm.name.$invalid && formSubmitted}"  name="instance" data-ng-model="vmsnapshot.vm" ng-options="instance.name for instance in instanceList" >
                                    <option value=""><fmt:message key="common.select" bundle="${msg}" /></option>
                                </select>
                                <div class="error-area" data-ng-show="vmsnapshotForm.instance.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="instance.is.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                            </div>

                        </div>
                    </div>

                    <div class="form-group" >
                        <div class="row" >
                            <label class="col-md-3 col-sm-3 control-label" ><fmt:message key="note" bundle="${msg}" />
                            </label>
                            <div class="col-md-9 col-sm-9 ">
                                <span class="text-danger text-center"><fmt:message key="you.cannot.attach.or.detach.the.storage.volume" bundle="${msg}" />, <fmt:message key="when.the.particular.instance.have.vm.snapshots" bundle="${msg}" />.. </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="modal-footer">
            <get-loader-image data-ng-show="showLoader"></get-loader-image>
            <button type="button" data-ng-hide="showLoader" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
            <button class="btn btn-info" data-ng-hide="showLoader" type="submit"><fmt:message key="common.create" bundle="${msg}" /></button>

        </div></div>
</form>




