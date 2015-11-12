<div class="hpanel"> 
    <div class="panel-body">
        <div class="form-group" >
            <div class="row">
                <label class="col-md-2 col-sm-2 control-label pull-left">Zone</label>
                <div class="col-md-5 col-sm-5">
                    <input disabled="" type="text" name="zone" data-ng-model="global.zone.name"  class="form-control" >
                </div>
                <div class="col-md-5 tooltip-container">
                    <a class="pe-7s-help1" tooltip-placement="right" tooltip="Name of the zone"></a>
                </div>
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group" ng-class="{ 'has-error' : volumeStaticForm.name.$invalid && formSubmitted.static}">
            <div class="row">
                <label class="col-md-2 col-sm-2 control-label pull-left">Name<span class="text-danger">*</span></label>
                <div class="col-md-5">
                    <input required="true" type="text" name="name" data-ng-model="volume.name" class="form-control" >
                    <span class="help-block m-b-none" ng-show="volumeStaticForm.name.$invalid && formSubmitted.static" >Name is required.</span>
                </div>
                <div class="col-md-5 col-sm-5 tooltip-container">
                    <a class="pe-7s-help1" tooltip-placement="right" tooltip="Name of the disk"></a>
                </div>
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group" ng-class="{ 'has-error' : volumeStaticForm.diskOfferings.$invalid && formSubmitted.static}">

            <div class="row" > 
                <label class="col-md-2 control-label pull-left">Disk Offering<span class="text-danger">*</span></label>
                <div class="col-md-5">
                    <select required="true" class="form-control input-group" name="diskOfferings" data-ng-model="volume.diskOfferings" ng-options="diskOffering.name for diskOffering in volumeElements.diskOfferingList" >
                        <option value="">Select</option>
                    </select>    
                    <span class="help-block m-b-none" ng-show="volumeStaticForm.diskOfferings.$invalid && formSubmitted.static" >Disk offering is required.</span>
                </div>
                <div class="col-md-4 col-sm-4 tooltip-container">    
                    <a class="pe-7s-help1" tooltip-placement="right" tooltip="Secondary disk and IOPS" ></a>
                </div>

            </div>{{ volumeStaticForm.diskOffering }}
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group">
            <div class="col-sm-8 col-sm-offset-4 col-md-8 col-md-offset-4">
                <span class="pull-right">
                    <a class="btn btn-info btn-outline" ui-sref="cloud.list-volume">Cancel</a>
                    <button class="btn btn-info" type="submit">Save</button>
                </span>
            </div>
        </div>
    </div>
</div>
