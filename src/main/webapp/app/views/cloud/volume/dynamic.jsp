<div class="hpanel"> 
    <div class="panel-body">
        <div class="form-group" >
            <div class="row">
                <label class="col-md-2 control-label pull-left">Zone</label>
                <div class="col-md-5">
                    <input disabled="" type="text" name="name" data-ng-model="global.zone.name"  class="form-control" >
                </div>
                <div class="col-md-5 tooltip-container">
                    <a class="pe-7s-help1" tooltip-placement="right" tooltip="Name of the zone"></a>
                </div>
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group" ng-class="{ 'has-error' : volumeDynamicForm.name.$invalid && formSubmitted.dynamic}">
            <div class="row">
                <label class="col-md-2 control-label pull-left">Name<span class="text-danger">*</span></label>
                <div class="col-md-5">
                    <input required="true" type="text" name="name" data-ng-model="volume.name" class="form-control" >
                    <span class="help-block m-b-none" ng-show="volumeDynamicForm.name.$invalid && formSubmitted.dynamic" >Name is required.</span>
                </div>
                <div class="col-md-5 tooltip-container">
                    <a class="pe-7s-help1" tooltip-placement="right" tooltip="Name of the disk"></a>
                </div>
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group" ng-class="{ 'has-error' : volumeDynamicForm.diskOffering.$invalid && formSubmitted.dynamic}">

            <div class="row" > 
                <label class="col-md-3 col-sm-3 control-label">Disk Size :</label>
                <div class="col-md-6 col-sm-6">
                    <rzslider rz-slider-model="volumeElements.diskOffer.diskSize.value" rz-slider-floor="volumeElements.diskOffer.diskSize.floor" rz-slider-ceil="volumeElements.diskOffer.diskSize.ceil" rz-slider-always-show-bar="true"></rzslider>
                </div>
                <div class="col-md-3 col-sm-3">
                    <div class="input-group">
                        <input type="text" class="form-control input-mini" name="volumeDynamicForm.diskOffer.diskSize.value" data-ng-model="volumeElements.diskOffer.diskSize.value">
                        <span class="input-group-addon">GB</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group" ng-class="{ 'has-error' : volumeDynamicForm.diskOffering.$invalid && formSubmitted.dynamic}">

            <div class="row" > 
                <label class="col-md-3 col-sm-3 control-label">IOPS :</label>
                <div class="col-md-6 col-sm-6">
                    <rzslider  rz-slider-model="volumeElements.diskOffer.iops.value" rz-slider-floor="volumeElements.diskOffer.iops.floor" rz-slider-ceil="volumeElements.diskOffer.iops.ceil" rz-slider-always-show-bar="true"></rzslider>
                </div>
                <div class="col-md-3 col-sm-3">
                    <div class="input-group">
                        <input type="text" class="form-control input-small" name="volumeElements.diskOffer.iops.value" data-ng-model="volumeElements.diskOffer.iops.value">
                        <span class="input-group-addon">Kbps</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group">
            <div class="col-sm-8 col-sm-offset-4">
                <span class="pull-right">
                    <a class="btn btn-info btn-outline" ui-sref="cloud.list-volume">Cancel</a>
                    <button class="btn btn-info" type="submit">Save</button>
                </span>
            </div>
        </div>
    </div>
</div>