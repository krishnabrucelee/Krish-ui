<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class="row" data-ng-controller="snapshotListCtrl">

    <div class="col-md-12 col-sm-12">
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
                                <th class="col-md-2 col-sm-2">Snapshot Name</th>
                                <th class="col-md-2 col-sm-2">Volume Name</th>
                                <th class="col-md-2 col-sm-2">Instance Name</th>
                                <th class="col-md-1 col-sm-1">Type</th>
                                <th class="col-md-2 col-sm-2">Created Date</th>
                                <th class="col-md-1 col-sm-1">Status</th>
                                <th class="col-md-1 col-sm-1">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr data-ng-repeat="snapshot in snapshotList| filter:quickSearch">
                                <td>
                                    {{ snapshot.snapshotName}}
                                </td>
                                <td>
                                    {{ snapshot.volumeName}}
                                </td>
                                <td>
                                    {{ snapshot.instanceName}}
                                </td>
                                <td>
                                    {{ snapshot.type}}
                                </td>
                                <td>
                                    {{ snapshot.createdDate}}
                                </td>
                                <td>
                                    {{ snapshot.status}}
                                </td>
                                <td>
                                    <a class="icon-button" title="Create Volume" data-ng-click="createVolume()">
                                        <span class="fa fa-plus-square"> </span>
                                    </a>
                                    <a class="icon-button" title="Delete Snapshot" data-ng-click="deleteSnapshot()" ><span class="fa fa-trash"></span></a>

                                </td>

                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

