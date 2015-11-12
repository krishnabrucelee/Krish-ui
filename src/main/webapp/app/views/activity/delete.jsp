<form name="deleteForm" method="POST" data-ng-submit="remove(deleteForm)" novalidate  data-ng-controller="deleteCtrl">
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-trash"  page-title="{{ modalTitle}}"></panda-modal-header>
        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group" ng-class="{'text-danger': deleteForm.type.$invalid && formSubmitted}">
                        <div class="row">
                            <label  class="col-md-3 col-xs-12 col-sm-2 control-label">By type 
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <input required="true" type="text" name="type" data-ng-class="{'error': deleteForm.type.$invalid && formSubmitted}" data-ng-model="activity.type" class="form-control" >
                                <div class="error-area" data-ng-show="deleteForm.type.$invalid && formSubmitted" ><i  tooltip="Type is Required" class="fa fa-warning error-icon"></i></div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" ng-class="{'text-danger': deleteForm.startDate.$invalid && formSubmitted}">
                        <div class="row">
                            <label  class="col-md-3 col-xs-12 col-sm-2 control-label">By date (Start) 
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5">
                                <p class="input-group">
                                    <input type="text" name="startDate" data-ng-class="{'error': deleteForm.startDate.$invalid && formSubmitted}" readonly class="form-control" datepicker-popup="{{global.date.format}}" data-ng-model="activity.startDate" is-open="activity.startDateOpened" datepicker-options="global.date.dateOptions" ng-required="true" close-text="Close" />
                                    <span class="input-group-btn">
                                        <button type="button" data-ng-class="{'error': deleteForm.startDate.$invalid && formSubmitted}" class="btn btn-default" ng-click="open($event, 'startDateOpened')"><i class="glyphicon glyphicon-calendar"></i></button>
                                    </span>
                                <div class="error-area" data-ng-show="deleteForm.startDate.$invalid && formSubmitted" ><i  tooltip="Date is Required" class="fa fa-warning error-icon"></i></div>

                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" ng-class="{'text-danger': deleteForm.endDate.$invalid && formSubmitted}">
                        <div class="row">
                            <label  class="col-md-3 col-xs-12 col-sm-2 control-label">By date (End) 
                            </label>
                            <div class="col-md-5 col-xs-12 col-sm-5"> {{ $scope.dt}}
                                <p class="input-group">
                                    <input type="text" readonly class="form-control" data-ng-class="{'error': deleteForm.endDate.$invalid && formSubmitted}" datepicker-popup="{{global.date.format}}" data-ng-model="activity.endDate" name="endDate" is-open="activity.endDateOpened"  datepicker-options="global.date.dateOptions"  ng-required="true" close-text="Close" />
                                    <span class="input-group-btn">
                                        <button type="button" data-ng-class="{'error': deleteForm.endDate.$invalid && formSubmitted}" class="btn btn-default" ng-click="open($event, 'endDateOpened')"><i class="glyphicon glyphicon-calendar"></i></button>
                                    </span>
                                <div class="error-area" data-ng-show="deleteForm.endDate.$invalid && formSubmitted" ><i  tooltip="Date is Required" class="fa fa-warning error-icon"></i></div>

                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <a class="btn btn-default"  data-ng-click="cancel()">Cancel</a>
            <button class="btn btn-info" type="submit">Delete</button>
        </div>
    </div>
</form>