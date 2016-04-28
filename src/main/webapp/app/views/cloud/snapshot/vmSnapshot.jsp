<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="" >
    <div class="col-md-12 col-sm-12">
        <div class="hpanel">
            <div class="panel-heading">
                <div class="row" >
                <div data-ng-if="global.webSocketLoaders.snapshotLoader" class="overlay-wrapper">
                		            <img data-ng-if="global.webSocketLoaders.snapshotLoader" src="images/loading-bars.svg" class="inner-loading" />
            		            </div>
                    <div class="col-md-12 col-sm-12 pull-left m-b-sm"><fmt:message key="note" bundle="${msg}" />:
                        <span class="text-danger "><fmt:message key="you.cannot.attach.or.detach.the.storage.volume" bundle="${msg}" />, <fmt:message key="when.the.particular.instance.have.vm.snapshots" bundle="${msg}" />. </span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12 ">
                    	<div class="pull-left dashboard-btn-area">
                            <div class="dashboard-box pull-left">
     							<div class="instance-border-content-normal">
                                <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="total.vm.snapshot" bundle="${msg}" /></span>
                                <b class="pull-left">{{vmSnapshotList.Count}}</b>
                                <div class="clearfix"></div>
                                </div>
                            </div>
                            <a class="btn btn-info font-bold"  ng-click="openAddVMSnapshotContainer()"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="create.vm.snapshot" bundle="${msg}" /></a>
                            <a class="btn btn-info" ui-sref="cloud.list-snapshot" title="<fmt:message key="common.refresh" bundle="${msg}" />"  ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
                        </div>
                        <div class="pull-right dashboard-filters-area">
					        <panda-quick-search></panda-quick-search>
					        <span class="pull-right m-r-sm" data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'">
								<select
									class="form-control input-group col-xs-5" name="domainView"
									data-ng-model="domainView"
									data-ng-change="selectDomainView(1, domainView.id)"
									data-ng-options="domainView.name for domainView in domainListView">
									<option value=""> <fmt:message key="common.domain.filter" bundle="${msg}" /></option>
								</select>
							</span>
							<div class="clearfix"></div>
							<span class="pull-right m-l-sm m-t-sm"></span>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
              </div>
            <div class="white-content">
				<div data-ng-show = "showLoaderOffer" style="margin: 1%"><get-loader-image-offer data-ng-show="showLoaderOffer"></get-loader-image-offer></div>
      					<div  data-ng-hide="showLoaderOffer" class="table-responsive">
                        <table cellspacing="1" cellpadding="1" class="table dataTable table-bordered table-striped">
                            <thead>
                            <tr>
                                <th class="col-md-2 col-sm-2" data-ng-click="changeSort('name',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='name'? 'sorting_desc' : 'sorting_asc'"><fmt:message key="common.name" bundle="${msg}" /></th>
                                <th class="col-md-2 col-sm-2" data-ng-click="changeSort('description',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='description'? 'sorting_desc' : 'sorting_asc'"><fmt:message key="common.description" bundle="${msg}" /></th>
                                <th class="col-md-2 col-sm-2"><fmt:message key="common.instance" bundle="${msg}" /></th>
                                <th class="col-md-2 col-sm-2" data-ng-click="changeSort('snapshot.isCurrent',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='snapshot.isCurrent'? 'sorting_desc' : 'sorting_asc'"><fmt:message key="common.iscurrent" bundle="${msg}" /></th>
                                <th class="col-md-2 col-sm-2" data-ng-click="changeSort('createdDateTime',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='createdDateTime'? 'sorting_desc' : 'sorting_asc'"><fmt:message key="common.created.date" bundle="${msg}" /></th>
                                <th class="col-md-2 col-sm-2" data-ng-click="changeSort('status',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='status'? 'sorting_desc' : 'sorting_asc'"><fmt:message key="common.status" bundle="${msg}" /></th>
                                <th class="col-md-1 col-sm-1"><fmt:message key="common.action" bundle="${msg}" /></th>
                            </tr>
                        </thead>
                          <tbody data-ng-hide="vmSnapshotList.length > 0">
						<tr>
						<td class="col-md-11 col-sm-11" colspan="11"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
						</tr>
						</tbody>
                        <tbody data-ng-show="vmSnapshotList.length > 0">
                            <tr data-ng-repeat="snapshot in filteredCount = (vmSnapshotList| filter: quickSearch | orderBy:sort.column:sort.descending)">
                                <td>
                                    {{ snapshot.name}}
                                </td>
                                <td>
                                    {{ snapshot.description}}
                                </td>
                                <td>
                                    {{ snapshot.vm.name}}
                                </td>
                                <td data-ng-show = "snapshot.isCurrent">
                                    Yes
                                </td>
                                <td data-ng-show = "!snapshot.isCurrent">
                                    No
                                </td>
                                <td>
                                    {{ snapshot.createdDateTime*1000 | date:'yyyy-MM-dd HH:mm:ss'}}
                                </td>
                                <td>
                                <div class="text-center">
										<img src="images/vmsnapshot/ready.png" data-ng-if="snapshot.status == 'Ready'" title="{{ snapshot.status}}">
										<img src="images/vmsnapshot/expunging.png" data-ng-if="snapshot.status == 'Expunging'"
													title="{{ snapshot.status}}"
												>
										<img src="images/vmsnapshot/error.png" data-ng-if="snapshot.status == 'Error'"
													title="{{ snapshot.status}}"
												>
										<img src="images/vmsnapshot/creating.png" data-ng-if="snapshot.status == 'Creating'"
													title="{{ snapshot.status}}"
												>
										<img src="images/vmsnapshot/implemented.png" data-ng-if="instance.status == 'Implemented'"
													title="{{ snapshot.status}}"
												>
										</div>
                                </td>
                                 <td>
                                    <a data-ng-show = "snapshot.status != 'Error'" class="icon-button" title="<fmt:message key="restore.vm.snapshot" bundle="${msg}" />"  data-ng-click="restoresnapshot(snapshot)">
                                        <span class="fa fa-rotate-left "> </span>
                                    </a>
                                    <a class="icon-button" title="<fmt:message key="delete.vm.snapshot" bundle="${msg}" />" data-ng-click="deleteSnapshots('sm', snapshot)"><span class="fa fa-trash"></span></a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <pagination-contents></pagination-contents>
        </div>
    </div>
</div>