<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class="" >
	<get-loader-image data-ng-show="showLoader"></get-loader-image>
	 <div data-ng-if="global.webSocketLoaders.volumeBackupLoader" class="overlay-wrapper">
          <img data-ng-if="global.webSocketLoaders.volumeBackupLoader" src="images/loading-bars.svg" class="inner-loading" />
     </div>
	<div class="col-md-12 col-sm-12" data-ng-hide="showLoader">
        <div class="hpanel">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12 ">
                    	<div class="pull-left dashboard-btn-area">
                            <div class="dashboard-box pull-left">
     							<div class="instance-border-content-normal">
                                <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="total.snapshot" bundle="${msg}" /></span>
                                <b class="pull-left">{{snapshotList.Count}}</b>
                                <div class="clearfix"></div>
                                </div>
                            </div>
                            <a class="btn btn-info font-bold"  has-permission= "DISK_SNAPSHOT" ng-click="openAddSnapshotContainer()"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>Create Snapshot</a>
                            <a class="btn btn-info" title="Refresh" data-ng-click="list(1)"><span class="fa fa-refresh fa-lg"></span></a>
                        </div>
                        <div class="pull-right dashboard-filters-area" id="snapshot_quick_search">
						<form data-ng-submit="snapshotSearchList(snapshotSearch)">
							<div class="quick-search pull-right">
								<div class="input-group">
									<input data-ng-model="snapshotSearch" id="snapshot_list_search" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
								   	<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
								</div>
							</div>
							<span class="pull-right m-r-sm" data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'" >
								<select
									class="form-control input-group col-xs-5" name="domainView"
									data-ng-model="domainView"
									data-ng-change="selectSnapshotDomainView(1, domainView.id)"
									data-ng-options="domainView.name for domainView in domainListView">
									<option value=""> <fmt:message key="common.domain.filter" bundle="${msg}" /></option>
								</select>
							</span>
							<div class="clearfix"></div>
							<span class="pull-right m-l-sm m-t-sm">
							</span>
						</form>
						</div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
            <div class="white-content">
                <div class="table-responsive">
                    <table cellspacing="1" cellpadding="1" class="table dataTable table-bordered table-striped">
                        <thead>
                            <tr>
                                <th class="col-md-2 col-sm-2" data-ng-click="changeSort('name',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='name'? 'sorting_desc' : 'sorting_asc'"><fmt:message key="common.name" bundle="${msg}" /></th>
                                <th class="col-md-2 col-sm-2" data-ng-click="changeSort('volume.name',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='volume.name'? 'sorting_desc' : 'sorting_asc'"><fmt:message key="common.volume" bundle="${msg}" /></th>
                                <th class="col-md-2 col-sm-2"><fmt:message key="common.instance" bundle="${msg}" /></th>
                                <th class="col-md-1 col-sm-1"><fmt:message key="common.type" bundle="${msg}" /></th>
                                <th class="col-md-2 col-sm-2" data-ng-click="changeSort('createdDateTime',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='volume.name'? 'sorting_desc' : 'sorting_asc'"><fmt:message key="common.created.date" bundle="${msg}" /></th>
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

