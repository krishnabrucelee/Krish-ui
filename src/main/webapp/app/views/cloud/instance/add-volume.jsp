<form name="volumeForm" method="POST" data-ng-submit="save(volumeForm)" novalidate  data-ng-controller="storageCtrl">
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-database" page-title="Add Volume"></panda-modal-header>

        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group" ng-class="{ 'text-danger' : volumeForm.name.$invalid && formSubmitted}">
                        <div class="row">
                            <label  class="col-md-2 col-xs-12 col-sm-2 control-label">Name 
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <input required="true" type="text" name="name" data-ng-model="volume.name" class="form-control" data-ng-class="{'error': volumeForm.name.$invalid && formSubmitted}" >
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Name of the disk" ></i>
                                <div class="error-area" data-ng-show="volumeForm.name.$invalid && formSubmitted" ><i  tooltip="Name is Required" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group" ng-class="{ 'text-danger' : volumeForm.type.$invalid && formSubmitted}">
                        <div class="row">
                            <label class="col-md-2 col-xs-12 col-sm-2 control-label">Type <span class="m-l-xs"></span></label>
                            <div class="col-md-9 col-xs-12 col-sm-9">
                                <div class="btn-group" data-toggle="buttons">
                                    <label data-ng-init="volume.type = volumeElements.type[0]" data-ng-click="resetDiskValues(volumeType)"
                                           class="btn m-r-md w-sm" data-ng-class="volume.type.id == volumeType.id ? 'btn-info' : 'btn - default'" data-ng-repeat="volumeType in volumeElements.type">
                                        {{ volumeType.name}}
                                    </label> 
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Disk type" ></i>
                                </div>
                            </div>

                        </div>
                    </div>

                    <!--<div class="hr-line-dashed"></div>-->
                    <div class="form-group" ng-class="{ 'text-danger' : volumeForm.diskOfferings.$invalid && formSubmitted}">

                        <div class="row" > 
                            <label class="col-md-2 col-xs-12 col-sm-2 control-label">Plan 
                                <span class="text-danger">*</span>
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <select required="true" class="form-control input-group" name="diskOfferings" 
                                        data-ng-model="volume.diskOfferings" 
                                        data-ng-class="{'error': volumeForm.diskOfferings.$invalid && formSubmitted}"
                                        data-ng-options="diskOffering.name for diskOffering in volumeElements.diskOfferingList" >
                                    <option value="">Select</option>
                                </select> 
                                <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Select the plan" ></i>
                                <div class="error-area" data-ng-show="volumeForm.diskOfferings.$invalid && formSubmitted" ><i  tooltip="Plan is Required" class="fa fa-warning error-icon"></i></div>
                            </div>

                        </div>
                    </div>
                    <!--<div class="hr-line-dashed"></div>-->

                    <div data-ng-show="volume.diskOfferings.custom">
                        <div class="form-group" ng-class="{ 'text-danger' : volumeElements.diskOffer.diskSize.value <= 0 && formSubmitted}">

                            <div class="row" > 
                                <label class="col-md-2 col-xs-12 col-sm-2 control-label">Size (GB)  
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-6 col-xs-12 col-sm-6">
                                    <rzslider rz-slider-model="volumeElements.diskOffer.diskSize.value" rz-slider-floor="volumeElements.diskOffer.diskSize.floor" rz-slider-ceil="volumeElements.diskOffer.diskSize.ceil" rz-slider-always-show-bar="true"></rzslider>
                                </div>
                                <div class="col-md-2 col-xs-12 col-sm-3">
                                    <input type="text" valid-number  data-ng-min="{{ volumeElements.diskOffer.diskSize.floor}}" data-ng-max="{{ volumeElements.diskOffer.diskSize.ceil}}"
                                           class="form-control input-mini" data-ng-class="{'error': volumeForm.networkOffer.$invalid && formSubmitted}" name="volumeForm.diskOffer.diskSize.value" data-ng-model="volumeElements.diskOffer.diskSize.value">
                                </div>
                            </div>
                        </div>
                        <!--<div class="hr-line-dashed"></div>-->

                        <div class="form-group" ng-class="{ 'text-danger' : volumeElements.diskOffer.iops.value <= 0 && formSubmitted}">

                            <div class="row" > 
                                <label class="col-md-2 col-xs-12 col-sm-2 control-label">IOPS (Kbps)  
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="col-md-6 col-xs-12 col-sm-6">
                                    <rzslider  rz-slider-model="volumeElements.diskOffer.iops.value" rz-slider-floor="volumeElements.diskOffer.iops.floor" rz-slider-ceil="volumeElements.diskOffer.iops.ceil" rz-slider-always-show-bar="true"></rzslider>
                                </div>
                                <div class="col-md-2 col-xs-12 col-sm-3">
                                    <input type="text" valid-number  data-ng-min="{{ volumeElements.diskOffer.iops.floor}}" data-ng-max="{{ volumeElements.diskOffer.iops.ceil}}"
                                           class="form-control input-mini" data-ng-class="{'error': volumeForm.networkOffer.$invalid && formSubmitted}" name="volumeElements.diskOffer.iops.value" data-ng-model="volumeElements.diskOffer.iops.value" data-ng-change="volumeElements.diskOffer.iops.value = volumeElements.diskOffer.iops.value">
                                </div>
                            </div>
                        </div>
                        <!--<div class="hr-line-dashed"></div>-->
                    </div>

                </div>
            </div>
        </div>
        <div class="modal-footer">

            <span class="pull-left" data-ng-show="volume.diskOfferings.id == 4">
                <h4 class="text-danger price-text m-l-lg">
                    $0.10 <span>/ hour</span>   <small class="text-right text-muted m-l-sm">($7.2 / month)</small>
                </h4>
            </span>
            <a class="btn btn-default"  data-ng-click="cancel()">Cancel</a>
            <button class="btn btn-info" type="submit">Add</button>


        </div>
    </div>
</form>