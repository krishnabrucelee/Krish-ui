<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

    <div class="content" ui-view>
	    <div ng-controller="vpcCtrl">
			<div class="hpanel">
				<div class="panel-heading no-padding">
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12 ">
							<div class="pull-left dashboard-btn-area">
								<a class="btn btn-info" data-ng-click="createVpc('md')"> <span class="pe-7s-plus pe-lg font-bold m-r-xs"></span> Add VPC</a>
							</div>
							<div class="pull-right dashboard-filters-area">
							<form data-ng-submit="searchList(vmSearch)">
								<div class="quick-search pull-right">
									<div class="input-group">
										<input data-ng-model="vmSearch" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
									   	<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
									</div>
								</div>
								<div class="clearfix"></div>
								<span class="pull-right m-l-sm m-t-sm">
								</span>
							</form>
							</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="row">
					<div class="col-md-12 col-sm-12 col-xs-12 ">
						<div class="white-content">
							<div data-ng-show="showLoader" style="margin: 1%">
								<get-loader-image data-ng-show="showLoader"></get-loader-image>
							</div>
							<div data-ng-hide="showLoader"class="table-responsive">
								<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
								    <thead>
								        <tr>
								            <th data-ng-click="changeSort('name',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='name'? 'sorting_desc' : 'sorting_asc' ">Name</th>
								            <th data-ng-click="changeSort('description',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='description'? 'sorting_desc' : 'sorting_asc' ">Description</th>
								            <th data-ng-click="changeSort('domain.name',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='domain.name'? 'sorting_desc' : 'sorting_asc' "><fmt:message
														key="common.company" bundle="${msg}" /></th>
											<th data-ng-click="changeSort('department.userName',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='Account'? 'sorting_desc' : 'sorting_asc' "><fmt:message
														key="common.department" bundle="${msg}"/></th>
											<th><fmt:message key="common.project" bundle="${msg}"/></th>
								            <th data-ng-click="changeSort('zone.name',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='zone.name'? 'sorting_desc' : 'sorting_asc' ">Zone</th>
								            <th data-ng-click="changeSort('cIDR',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='cIDR'? 'sorting_desc' : 'sorting_asc' ">CIDR</th>
								            <th data-ng-click="changeSort('status',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='status'? 'sorting_desc' : 'sorting_asc' ">State</th>
								            <th>Actions</th>
								        </tr>
								    </thead>
								    <tbody data-ng-hide="vpcList.length > 0">
			                                <tr>
			                                    <td class="col-md-9 col-sm-9" colspan="9"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
			                                </tr>
			                            </tbody>
								    <tbody data-ng-show="vpcList.length > 0">
								        <tr data-ng-repeat="vpc in filteredCount = (vpcList | filter: quickSearch | orderBy:sort.column:sort.descending)">
								            <td>
								                <a class="text-info" ui-sref="vpc.view-vpc({id: {{ 1}}})">{{vpc.name}}</a>
								            </td>
								            <td>{{vpc.description}}</td>
								            <td>{{vpc.domain.name }}</td>
											<td>{{vpc.department.userName || '-'}}</td>
											<td>{{vpc.project.name || '-'}}</td>
								            <td>{{vpc.zone.name}}</td>
								            <td>{{vpc.cIDR}}</td>
								            <td><label class="label label-success text-center text-white">{{vpc.status}}</label></td>
								            <td>
								                <a class="icon-button" title="Configure" ui-sref="vpc.config-vpc({id: {{ 1}}})">
								                    <span class="fa fa-cog m-r"> </span>
								                </a>
								                 <a class="icon-button" data-ng-click="restart('md', vpc)" title="Restart VPC">
								                	<span class="fa fa-rotate-left m-r"></span>
								                </a>
								                <a class="icon-button" data-ng-click="delete('sm', vpc)" title="Remove VPC"  ><span class="fa fa-trash"></span></a>
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
		</div>
	</div>