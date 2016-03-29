<form name="archiveForm" method="POST" data-ng-submit="save(archiveForm)" novalidate  data-ng-controller="archiveCtrl">
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-file-archive-o"  page-title="{{ modalTitle}}"></panda-modal-header>

        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group" ng-class="{'text-danger': archiveForm.type.$invalid && formSubmitted}">
                        <div class="row">
                            <label  class="col-md-3 col-xs-12 col-sm-2 control-label">By Type
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <input required="true" type="text" name="type" data-ng-class="{'error': archiveForm.type.$invalid && formSubmitted}" data-ng-model="activity.type" class="form-control" >
                                <div class="error-area" data-ng-show="archiveForm.type.$invalid && formSubmitted" ><i  tooltip="Type is Required" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" ng-class="{'text-danger': archiveForm.startDate.$invalid && formSubmitted}">
                        <div class="row">
                            <label  class="col-md-3 col-xs-12 col-sm-2 control-label">By date (Start)
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5 ">

                                <div class="input-group">
                                    <input type="text" readonly name="startDate" data-ng-class="{'error': archiveForm.startDate.$invalid && formSubmitted}" class="form-control" datepicker-popup="{{global.date.format}}" data-ng-model="activity.startDate" is-open="activity.startDateOpened" datepicker-options="global.date.dateOptions" ng-required="true" close-text="Close" />
                                    <span class="input-group-btn">
                                        <button data-ng-class="{'error': archiveForm.startDate.$invalid && formSubmitted}"  type="button" class="btn btn-default" ng-click="open($event, 'startDateOpened')"><i class="glyphicon glyphicon-calendar"></i></button>
                                    </span>

                                </div>
                                <div class="error-area" data-ng-show="archiveForm.startDate.$invalid && formSubmitted" ><i  tooltip="Date is Required" class="fa fa-warning error-icon"></i></div>

                            </div>
                        </div>
                    </div>
                    <div class="form-group" ng-class="{'text-danger': archiveForm.endDate.$invalid && formSubmitted}">
                        <div class="row">
                            <label  class="col-md-3 col-xs-12 col-sm-2 control-label">By date (End)
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <div class="input-group">
                                    <input type="text" name="endDate" readonly class="form-control" data-ng-class="{'error': archiveForm.endDate.$invalid && formSubmitted}" datepicker-popup="{{global.date.format}}" data-ng-model="activity.endDate" is-open="activity.endDateOpened"  datepicker-options="global.date.dateOptions"  ng-required="true" close-text="Close" />
                                    <span class="input-group-btn">
                                        <button type="button" data-ng-class="{'error': archiveForm.endDate.$invalid && formSubmitted}" class="btn btn-default" ng-click="open($event, 'endDateOpened')"><i class="glyphicon glyphicon-calendar"></i></button>
                                    </span>
                                </div>
                                <div class="error-area" data-ng-show="archiveForm.endDate.$invalid && formSubmitted" ><i  tooltip="Date is Required" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <a class="btn btn-default"  data-ng-click="cancel()">Cancel</a>
            <button class="btn btn-info"   type="submit">Archive</button>
        </div>
    </div>
</form>