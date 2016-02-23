<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class="" data-ng-controller="snapshotListCtrl">
	<get-loader-image data-ng-show="showLoader"></get-loader-image>
	<div class="col-md-12 col-sm-12" data-ng-hide="showLoader">
        <div class="hpanel">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12 ">
                        <div class="pull-left">
                            <div class="pull-left">
                            </div>
                        </div>
                        <div class="pull-right">
                            <panda-quick-search></panda-quick-search>
                            <div class="clearfix"></div>
                            <span class="pull-right m-l-sm m-t-sm">
                                <a class="btn btn-info"  ng-click="openAddSnapshotContainer()"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>Create Snapshot</a>
                                <a class="btn btn-info" title="Refresh" ><span class="fa fa-refresh fa-lg"></span></a>
                            </span>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
            <div class="white-content">
                <div class="table-responsive">
                    <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th class="col-md-2 col-sm-2"><fmt:message key="common.name" bundle="${msg}" /></th>
                                <th class="col-md-2 col-sm-2"><fmt:message key="common.volume" bundle="${msg}" /></th>
                                <th class="col-md-2 col-sm-2"><fmt:message key="common.instance" bundle="${msg}" /></th>
                                <th class="col-md-1 col-sm-1"><fmt:message key="common.type" bundle="${msg}" /></th>
                                <th class="col-md-2 col-sm-2"><fmt:message key="common.created.date" bundle="${msg}" /></th>
                                <th class="col-md-1 col-sm-1"><fmt:message key="common.status" bundle="${msg}" /></th>
                                <th class="col-md-1 col-sm-1"><fmt:message key="common.action" bundle="${msg}" /></th>
                            </tr>
                        </thead>
                        <tbody data-ng-hide="snapshotList.length > 0">
						<tr>
						<td class="col-md-11 col-sm-11" colspan="11"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
						</tr>
						</tbody>
                        <tbody data-ng-show="snapshotList.length > 0">
                            <tr data-ng-repeat="snapshot in snapshotList| filter:quickSearch">
                                <td>
                                    {{ snapshot.name}}
                                </td>
                                <td>
                                    {{ snapshot.volume.name}}
                                </td>
                                <td>
                                    {{ snapshot.volume.vmInstance.name}}
                                </td>
                                <td>
                                    {{snapshot.volume.volumeType}}
                                </td>
                                <td>
                                    {{ snapshot.createdDateTime*1000 | date:'yyyy-MM-dd HH:mm:ss'}}
                                </td>
                                <td>
                                    {{ snapshot.status}}
                                </td>
                                <td>
                                   <a class="icon-button" title="Create Volume" data-ng-click="createVolume('md', snapshot)">
                                        <span class="fa fa-plus-square"> </span>
                                    </a>
                                     <a class="icon-button" title="Revert Snapshot" data-ng-click="revertSnapshot('md', snapshot)">
                                        <span class="fa fa-rotate-left"> </span>
                                    </a>
                                    <a class="icon-button" title="Delete Snapshot" data-ng-click="deleteVolumeSnapshot('sm', snapshot)" ><span class="fa fa-trash"></span></a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
           <pagination-content></pagination-content>
        </div>
    </div>
</div>

