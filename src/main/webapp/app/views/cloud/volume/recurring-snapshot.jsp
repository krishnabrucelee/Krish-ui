<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="recurringSnapshotForm" method="POST" data-ng-submit="recurringsave(recurringSnapshotForm,recurringSnapshot)" novalidate >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-repeat"  page-title="<fmt:message key="recurring.snapshot" bundle="${msg}" />"></panda-modal-header>
        </div>
        <div class="modal-body">
            <div class="row">

                <div class="col-md-12">
                    <ul class="nav nav-tabs" data-ng-init="recurringSnapshot.intervalType = 'hourly'">
                        <li data-ng-if="!snapshotTab.HOURLY" class="active"><a href="javascript:void(0)" data-ng-click="recurringSnapshot.intervalType = 'hourly'" data-toggle="tab"> <fmt:message key="common.hourly" bundle="${msg}" /> </a></li>
                        <li data-ng-if="!snapshotTab.DAILY"><a href="javascript:void(0)" data-ng-click="recurringSnapshot.intervalType = 'daily'" data-toggle="tab"><fmt:message key="common.daily" bundle="${msg}" /></a></li>
                        <li data-ng-if="!snapshotTab.WEEKLY" ><a href="javascript:void(0)" data-ng-click="recurringSnapshot.intervalType = 'weekly'" data-toggle="tab"><fmt:message key="common.weekly" bundle="${msg}" /></a></li>
                        <li  data-ng-if="!snapshotTab.MONTHLY"><a href="javascript:void(0)" data-ng-click="recurringSnapshot.intervalType = 'monthly'" data-toggle="tab"><fmt:message key="common.monthly" bundle="${msg}" /></a></li>
                    </ul>

                    <div class="tab-content">
                        <div class="tab-pane active" >
							<input type="hidden" data-ng-model="recurringSnapshot.intervalType"  />
                            <div class="row">
                                <div class="col-md-12">

                                    <div class="form-group" data-ng-show="recurringSnapshot.intervalType == 'hourly' && !snapshotTab.HOURLY" >
                                        <div class="row">
                                            <label class="col-md-3 col-sm-4  col-xs-12 control-label pull-left"><fmt:message key="common.time" bundle="${msg}" /></label>
                                            <div class="col-md-2 col-sm-2 col-xs-12" >
                                                <select required="true" class="form-control input-group" name="minutes" data-ng-model="recurringSnapshot.minutes" data-ng-init="recurringSnapshot.minutes = 1" >
                                                    <option ng-repeat="i in formElements.minuteCount track by $index" value="{{$index + 1}}">{{$index + 1}}</option>
                                                </select>
                                                <span class="help-block m-b-none" ng-show="recurringSnapshotForm.name.$invalid && formSubmitted" ><fmt:message key="name.is.required" bundle="${msg}" />.</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group" data-ng-show="recurringSnapshot.intervalType != 'hourly'" >
                                        <div class="row">
                                            <label class="col-md-3 col-sm-4  col-xs-12 control-label pull-left"><fmt:message key="common.time" bundle="${msg}" /></label>
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
                                                <select required="true" class="form-control input-group" name="meridian" data-ng-model="recurringSnapshot.meridian" data-ng-init="recurringSnapshot.meridian = 'AM'" >
                                                    <option value="AM"><fmt:message key="common.am" bundle="${msg}" /></option>
                                                    <option value="PM"><fmt:message key="common.pm" bundle="${msg}" /></option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="form-group" ng-class="{ 'text-danger' : recurringSnapshotForm.timeZone.$invalid && formSubmitted}">
                                        <div class="row">


                                            <label class="col-md-3 col-sm-4 col-xs-12 control-label pull-left"><fmt:message key="common.time.zone" bundle="${msg}" /></label>
                                            <div class="col-md-6 col-sm-4 col-xs-12">
                                                <select required="true" class="form-control input-group" data-ng-init="recurringSnapshot.timeZone = formElements.timeZoneList[0]" name="timeZone" data-ng-model="recurringSnapshot.timeZone"
                                                        ng-options="timeZone.name for timeZone in formElements.timeZoneList">
                                                </select>
                                                <span class="help-block m-b-none" ng-show="recurringSnapshotForm.timeZone.$invalid && formSubmitted" ><fmt:message key="name.is.required" bundle="${msg}" />.</span>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="form-group" >
                                        <div class="row">
                                            <div ng-class="{ 'text-danger' : recurringSnapshotForm.noOfSnapshot.$invalid && formSubmitted}">
                                                <label class="col-md-3 col-sm-3 col-xs-12 control-label pull-left"><fmt:message key="no.of.snapshot" bundle="${msg}" /><span class="text-danger">*</span></label>
                                                <div class="col-md-2 col-sm-2 col-xs-12">
                                                    <input required="true" data-ng-min="1" valid-number type="text" name="noOfSnapshot" data-ng-model="recurringSnapshot.maximumSnapshots" class="form-control" data-ng-class="{'error': recurringSnapshotForm.maximumSnapshots.$invalid && formSubmitted}"  >
                                                    <div class="error-area" data-ng-show="recurringSnapshotForm.maximumSnapshots.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="common.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                                </div>
                                            </div>
                                            <div data-ng-show="recurringSnapshot.intervalType == 'monthly'"  ng-class="{ 'text-danger' : recurringSnapshotForm.dayOfMonth.$invalid && formSubmitted}">
                                                <label class="col-md-2 col-sm-2 col-xs-12  control-label pull-left"><fmt:message key="no.of.snapshot" bundle="${msg}" /><fmt:message key="common.day.of.month" bundle="${msg}" /><span class="text-danger">*</span></label>
                                                <div class="col-md-2 col-sm-2 col-xs-12">
                                                    <select required="true" class="form-control input-group" name="dayOfMonth" data-ng-model="recurringSnapshot.dayOfMonth" data-ng-class="{'error':  recurringSnapshotForm.dayOfMonth.$invalid && formSubmitted}" data-ng-init="recurringSnapshot.dayOfMonth = 1">
                                                        <option ng-repeat="i in formElements.dayOfMonth track by $index" value="{{$index + 1}}">{{$index + 1}}</option>
                                                    </select>
                                                   <div class="error-area" data-ng-show="recurringSnapshotForm.dayOfMonth.$invalid && formSubmitted" ><i  tooltip="<fmt:message key="common.required" bundle="${msg}" />" class="fa fa-warning error-icon"></i></div>
                                                </div>

                                            </div>
                                            <div data-ng-show="recurringSnapshot.intervalType == 'weekly'"  ng-class="{ 'text-danger' : recurringSnapshotForm.dayOfWeek.$invalid && formSubmitted}">
                                                <label class="col-md-2 col-sm-2 col-xs-12  control-label pull-left"><fmt:message key="common.day.of.week" bundle="${msg}" /><span class="text-danger">*</span></label>
                                               <!--  <div class="col-md-3 col-sm-3 col-xs-12">
                                                    <select required="true" class="form-control input-group" name="dayOfWeek" data-ng-model="recurringSnapshot.dayOfWeek" data-ng-class="{'error':  recurringSnapshotForm.dayOfWeek.$invalid && formSubmitted}" data-ng-init="recurringSnapshot.dayOfWeek ='Sunday'">
                                                        <option value="Sunday">Sunday</option>
                                                        <option value="Monday">Monday</option>
                                                        <option value="Tuesday">Tuesday</option>
                                                        <option value="Wednesday">Wednesday</option>
                                                        <option value="Thursday">Thursday</option>
                                                        <option value="Friday">Friday</option>
                                                        <option value="Saturday">Saturday</option>
                                                    </select>
                                                    <div class="error-area" data-ng-show="recurringSnapshotForm.days.$invalid && formSubmitted" ><i  tooltip="Required" class="fa fa-warning error-icon"></i></div>
                                                </div> -->
												 <div class="col-md-6 col-sm-4 col-xs-12">
                                                <select required="true" class="form-control input-group" data-ng-init="recurringSnapshot.dayOfWeek = formElements.dayOfWeekList[0]" name="dayOfWeek" data-ng-model="recurringSnapshot.dayOfWeek"
                                                        ng-options="dayOfWeek.name for dayOfWeek in formElements.dayOfWeekList">
                                                </select>
                                                <span class="help-block m-b-none" ng-show="recurringSnapshotForm.dayOfWeek.$invalid && formSubmitted" ><fmt:message key="day.of.week.is.required" bundle="${msg}" />.</span>
                                            </div>
                                            </div>

                                            <div class="col-md-2 col-sm-2 col-xs-12 pull-right ">
                                                <button class="btn btn-info" type="submit"  ><fmt:message key="common.add" bundle="${msg}" /></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <hr>

                        <div class=" col-md-12 col-sm-12 col-lg-12">

                            <div class=" form-group row font-extra-bold"><fmt:message key="scheduled.snapshots" bundle="${msg}" /></div>


                            <div class="white-content">
                                <div class="table-responsive scroll-100">
                                    <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">

                                        <thead>
                                            <tr>
                                                <th><fmt:message key="common.time" bundle="${msg}" /></th>
                                                <th><fmt:message key="common.period" bundle="${msg}" /></th>
                                                <th><fmt:message key="common.time.zone" bundle="${msg}" /></th>
                                                <th><fmt:message key="no.of.snapshot" bundle="${msg}" /></th>
                                                <th><fmt:message key="action" bundle="${msg}" /></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr  data-ng-repeat="snapshot in recurringSnapshotList">
                                                <td>
                                                     <div data-ng-if = "snapshot.intervalType == 'HOURLY'" >{{snapshot.scheduleTime}}</div>
                                                      <div data-ng-if = "snapshot.intervalType == 'DAILY'" >{{snapshot.scheduleTime}}</div>
													 <div data-ng-if = "snapshot.intervalType == 'WEEKLY'" >{{snapshot.scheduleTest}}</div>
													 <div data-ng-if = "snapshot.intervalType == 'MONTHLY'" >{{snapshot.scheduleTest}}</div>
                                                </td>
                                                <td>
                                                  <div data-ng-if = "snapshot.intervalType == 'WEEKLY'" ><fmt:message key="common.every" bundle="${msg}" /> {{snapshot.day}}</div>
                                                   <div data-ng-if = "snapshot.intervalType == 'MONTHLY'"><fmt:message key="common.day" bundle="${msg}" />{{snapshot.scheduleType}} <fmt:message key="of.month" bundle="${msg}" /></div>
                                                </td>
                                                <td>

                                                    {{ snapshot.timeZone}}
                                                </td>
                                                <td>
                                                    {{ snapshot.maximumSnapshots}}
                                                </td>

                                                <td>
                                                    <a class="icon-button" title="<fmt:message key="common.delete" bundle="${msg}" />" data-ng-click="deleteSnapshotPolicy('sm',snapshot.id)"><span class="fa fa-trash"></span></a>
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
            <a class="btn btn-default pull-right" data-ng-click="cancel()"><fmt:message key="common.cancel" bundle="${msg}" /></a>

        </div>
    </div>
</form>