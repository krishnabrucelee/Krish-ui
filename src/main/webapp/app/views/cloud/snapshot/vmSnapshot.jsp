<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="row" data-ng-controller="snapshotListCtrl">

    <div class="col-md-12 col-sm-12">
        <div class="hpanel">
            <div class="panel-heading">
                <div class="row" >

                    <div class="col-md-12 col-sm-12 pull-left m-b-sm"><fmt:message key="note" bundle="${msg}" />:
                        <span class="text-danger "><fmt:message key="you.cannot.attach.or.detach.the.storage.volume" bundle="${msg}" />, <fmt:message key="when.the.particular.instance.have.vm.snapshots" bundle="${msg}" />. </span>
                    </div>

                </div>

                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12 ">
                        <div class="pull-left">
                            <div class="pull-left">

                            </div>
                        </div>
                        <div class="pull-right">
                            <div class="quick-search">
										<div class="input-group">
											<input data-ng-model="quickSearch" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
											 <span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
										</div>
									</div>
                            <div class="clearfix"></div>

                            <span class="pull-right m-l-sm m-t-sm">
                                <a class="btn btn-info"  ng-click="openAddVMSnapshotContainer()"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="create.vm.snapshot" bundle="${msg}" /></a>
                                <a class="btn btn-info" title="<fmt:message key="common.refresh" bundle="${msg}" />"  ><span class="fa fa-refresh fa-lg"></span></a>
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
                                <th class="col-md-2 col-sm-2"><fmt:message key="common.description" bundle="${msg}" /></th>
                                <th class="col-md-2 col-sm-2"><fmt:message key="common.instance" bundle="${msg}" /></th>
                                <th class="col-md-1 col-sm-1"><fmt:message key="common.action" bundle="${msg}" /></th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr data-ng-repeat="snapshot in vmSnapshotList | filter:quickSearch">
                                <td>
                                    {{ snapshot.name}}
                                </td>
                                <td>
                                    {{ snapshot.description}}
                                </td>
                                <td>
                                    {{ snapshot.vm.name}}
                                </td>
                                 <td>
                                    <a class="icon-button" title="<fmt:message key="restore.vm.snapshot" bundle="${msg}" />"  data-ng-click="restoresnapshot('sm', vmsnapshot)()">
                                        <span class="fa fa-rotate-left "> </span>
                                    </a>
                                    <a class="icon-button" title="<fmt:message key="delete.vm.snapshot" bundle="${msg}" />" data-ng-click="delete('sm', vmsnapshot)()"><span class="fa fa-trash"></span></a>

                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>