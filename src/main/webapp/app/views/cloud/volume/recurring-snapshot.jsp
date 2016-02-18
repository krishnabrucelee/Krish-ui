<form name="recurringSnapshotForm" method="POST" data-ng-submit="recurringsave(recurringSnapshotForm)" novalidate data-ng-controller="recurringSnapshotCtrl">
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-repeat"  page-title="Recurring Snapshot"></panda-modal-header>
        </div>
        <div class="modal-body">
            <div class="row">

                <div class="col-md-12">

                    <ul class="nav nav-tabs" data-ng-init="formElements.category = 'hourly'">
                        <li class="active"><a href="javascript:void(0)" data-ng-click="formElements.category = 'hourly'" data-toggle="tab"> Hourly</a></li>
                        <li class=""><a href="javascript:void(0)" data-ng-click="formElements.category = 'daily'" data-toggle="tab">Daily</a></li>
                        <li class=""><a href="javascript:void(0)" data-ng-click="formElements.category = 'weekly'" data-toggle="tab">Weekly</a></li>
                        <li class=""><a href="javascript:void(0)" data-ng-click="formElements.category = 'monthly'" data-toggle="tab">Monthly</a></li>
                    </ul>

                    <div class="tab-content">
                        <div class="tab-pane active" >

                            <div class="row">
                                <div class="col-md-12">

                                    <div class="form-group" data-ng-show="formElements.category == 'hourly'" >
                                        <div class="row">
                                            <label class="col-md-3 col-sm-4  col-xs-12 control-label pull-left">Time</label>
                                            <div class="col-md-2 col-sm-2 col-xs-12" >
                                                <select required="true" class="form-control input-group" name="minutes" data-ng-model="recurringSnapshot.minutes" data-ng-init="recurringSnapshot.minutes = 1" >
                                                    <option ng-repeat="i in formElements.minuteCount track by $index" value="{{$index + 1}}">{{$index + 1}}</option>
                                                </select>
                                                <span class="help-block m-b-none" ng-show="recurringSnapshotForm.name.$invalid && formSubmitted" >Name is required.</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group" data-ng-show="formElements.category != 'hourly'" >
                                        <div class="row">
                                            <label class="col-md-3 col-sm-4  col-xs-12 control-label pull-left">Time</label>
                                            <div class="col-md-2 col-sm-2  col-xs-4" >
                                                <select required="true" class="form-control input-group" name="hours" data-ng-model="recurringSnapshot.hours" data-ng-init="recurringSnapshot.hours = 1" >
                                                    <option ng-repeat="i in formElements.hourCount track by $index" value="{{$index + 1}}">{{$index + 1}}</option>
                                                </select>
                                            </div>

                                            <div class="col-md-2 m-l-n-sm col-sm-2  col-xs-4" >
                                                <select required="true" class="form-control input-group" name="minutes" data-ng-model="recurringSnapshot.minutes" data-ng-init="recurringSnapshot.minutes = 1" >
                                                    <option ng-repeat="i in formElements.minuteCount track by $index" value="{{$index + 1}}">{{$index + 1}}</option>
                                                </select>
                                            </div>

                                            <div class="col-md-3 m-l-n-sm col-sm-3 col-xs-4" >
                                                <select required="true" class="form-control input-group" name="meridiam" data-ng-model="recurringSnapshot.meridiam" data-ng-init="recurringSnapshot.meridiam = 'AM'" >
                                                    <option value="AM">AM</option>
                                                    <option value="PM">PM</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="form-group" ng-class="{ 'text-danger' : recurringSnapshotForm.timeZone.$invalid && formSubmitted}">
                                        <div class="row">


                                            <label class="col-md-3 col-sm-4 col-xs-12 control-label pull-left">Time Zone</label>
                                            <div class="col-md-6 col-sm-4 col-xs-12">
                                                <select required="true" class="form-control input-group" data-ng-init="recurringSnapshot.timeZone = formElements.timeZoneList[0]" name="timeZone" data-ng-model="recurringSnapshot.timeZone"
                                                        ng-options="timeZone.name for timeZone in formElements.timeZoneList">
                                                </select>
                                                <span class="help-block m-b-none" ng-show="recurringSnapshotForm.timeZone.$invalid && formSubmitted" >Name is required.</span>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="form-group" >
                                        <div class="row">
                                            <div ng-class="{ 'text-danger' : recurringSnapshotForm.noOfSnapshot.$invalid && formSubmitted}">
                                                <label class="col-md-3 col-sm-3 col-xs-12 control-label pull-left">No.of.snapshot<span class="text-danger">*</span></label>
                                                <div class="col-md-2 col-sm-2 col-xs-12">
                                                    <input required="true" data-ng-min="1" valid-number type="text" name="noOfSnapshot" data-ng-model="recurringSnapshot.noOfSnapshot" class="form-control" data-ng-class="{'error': recurringSnapshotForm.noOfSnapshot.$invalid && formSubmitted}"  >
                                                    <div class="error-area" data-ng-show="recurringSnapshotForm.noOfSnapshot.$invalid && formSubmitted" ><i  tooltip="Required" class="fa fa-warning error-icon"></i></div>
                                                </div>
                                            </div>
                                            <div data-ng-show="formElements.category == 'monthly'"  ng-class="{ 'text-danger' : recurringSnapshotForm.dayOfMonth.$invalid && formSubmitted}">
                                                <label class="col-md-2 col-sm-2 col-xs-12  control-label pull-left">Day of month<span class="text-danger">*</span></label>
                                                <div class="col-md-2 col-sm-2 col-xs-12">
                                                    <select required="true" class="form-control input-group" name="dayOfMonth" data-ng-model="recurringSnapshot.dayOfMonth" data-ng-class="{'error':  recurringSnapshotForm.dayOfMonth.$invalid && formSubmitted}" data-ng-init="recurringSnapshot.dayOfMonth = 1">
                                                        <option ng-repeat="i in formElements.dayOfMonth track by $index" value="{{$index + 1}}">{{$index + 1}}</option>
                                                    </select>
                                                   <div class="error-area" data-ng-show="recurringSnapshotForm.dayOfMonth.$invalid && formSubmitted" ><i  tooltip="Required" class="fa fa-warning error-icon"></i></div>
                                                </div>

                                            </div>
                                            <div data-ng-show="formElements.category == 'weekly'"  ng-class="{ 'text-danger' : recurringSnapshotForm.dayOfWeek.$invalid && formSubmitted}">
                                                <label class="col-md-2 col-sm-2 col-xs-12  control-label pull-left">Day of week<span class="text-danger">*</span></label>
                                                <div class="col-md-3 col-sm-3 col-xs-12">
                                                    <select required="true" class="form-control input-group" name="dayOfWeek" data-ng-model="recurringSnapshot.dayOfWeek" data-ng-class="{'error':  recurringSnapshotForm.dayOfWeek.$invalid && formSubmitted}" data-ng-init="recurringSnapshot.dayOfWeek ='Sunday'">
                                                        <option value="Sunday">Sunday</option>
                                                        <option value="Monday">Monday</option>
                                                        <option value="Tuesday">Tuesday</option>
                                                        <option value="Wednesday">Wednesday</option>
                                                        <option value="Thursday">Thursday</option>
                                                        <option value="Friday">Friday</option>
                                                        <option value="Saturday">Saturday</option>
                                                    </select>
                                                    <div class="error-area" data-ng-show="recurringSnapshotForm.dayOfWeek.$invalid && formSubmitted" ><i  tooltip="Required" class="fa fa-warning error-icon"></i></div>
                                                </div>

                                            </div>

                                            <div class="col-md-2 col-sm-2 col-xs-12 pull-right ">
                                                <button class="btn btn-info" type="submit"  >Add</button>
                                            </div>
                                        </div>
                                    </div>




                                </div>

                            </div>
                        </div>

                        <hr>

                        <div class=" col-md-12 col-sm-12 col-lg-12">

                            <div class=" form-group row font-extra-bold">Scheduled Snapshots</div>


                            <div class="white-content">
                                <div class="table-responsive scroll-100">
                                    <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">

                                        <thead>
                                            <tr>
                                                <th>Time</th>
                                                <th>Period</th>
                                                <th>Time Zone</th>
                                                <th>No. of Snapshots</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr data-ng-repeat="snapshot in snapshotList">
                                                <td>
                                                    {{ snapshot.time}}
                                                </td>
                                                <td>
                                                    {{ snapshot.dayOfWeek}}
                                                </td>
                                                <td>

                                                    {{ snapshot.timeZone.name}}
                                                </td>
                                                <td>
                                                    {{ snapshot.noOfSnapshots}}
                                                </td>

                                                <td>
                                                    <a class="icon-button" title="Delete" data-ng-click="snapshotList.splice($index, 1)"><span class="fa fa-trash"></span></a>
                                                </td>
                                            </tr>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal-footer">
            <a class="btn btn-default pull-right" data-ng-click="cancel()">Cancel</a>

        </div>
    </div>
</form>
