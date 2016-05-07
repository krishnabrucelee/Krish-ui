<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

    <div class="content" ui-view>
	    <div ng-controller="vpcCtrl">
			<div class="hpanel">
				<div class="panel-heading">
						<div class="row">
							<div class="col-md-12 col-sm-12 col-xs-12 ">
								<div class="pull-left dashboard-btn-area">
									<div class="dashboard-box pull-left">
		     							<div class="instance-border-content-normal">
		                                <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="common.total" bundle="${msg}" /></span>
		                                <b class="pull-left">{{vpcList.Count}}</b>
		                                <div class="clearfix"></div>
		                                </div>
	                            	</div>
	                            	<a class="btn btn-info" data-ng-click="createVpc('md')"> <span class="pe-7s-plus pe-lg font-bold m-r-xs"></span> Add VPC</a>
	                            	<a class="btn btn-info" ui-sref="vpc.list" title="<fmt:message key="common.refresh" bundle="${msg}" />" ui-sref-opts="{reload: true}">
									<span class="fa fa-refresh fa-lg"></span></a>
								</div>
								<div class="pull-right dashboard-filters-area" id="application_quick_search">
									<form data-ng-submit="searchList(vpcSearch)">
										<div class="quick-search pull-right">
										<div class="input-group">
										<input data-ng-model="applicationSearch" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
								   		<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
										</div>
										</div>
										<span class="pull-right m-r-sm" data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'">
										<select	class="form-control input-group col-xs-5" name="domainView" data-ng-model="domainView" data-ng-change="selectDomainView(1)" data-ng-options="domainView.name for domainView in domainListView">
										<option value=""> <fmt:message key="common.domain.filter" bundle="${msg}" /></option>
										</select>
										</span>
								<div class="clearfix"></div>
								<span class="pull-right m-l-sm m-t-sm">	</span>
									</form>
								</div>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
				<div class="row">
					<div class="col-md-12 col-sm-12 col-xs-12 ">
						<div class="white-content">
							<div data-ng-show="showLoader" style="margin: 1%">
								<get-loader-image data-ng-show="showLoader"></get-loader-image>
							</div>
							<div class="table-responsive">
								<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
								    <thead>
								        <tr>
								            <th class="col-md-2 col-sm-2" data-ng-click="changeSort('name',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='name'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.name" bundle="${msg}" /></th>
								            <th class="col-md-3 col-sm-3" data-ng-click="changeSort('description',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='description'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.description" bundle="${msg}" /></th>
								            <th class="col-md-2 col-sm-2" data-ng-click="changeSort('zone.name',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='zone.name'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.zone" bundle="${msg}" /></th>
								            <th class="col-md-2 col-sm-2" data-ng-click="changeSort('cIDR',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='cIDR'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.cidr" bundle="${msg}" /></th>
								            <th class="col-md-2 col-sm-2" data-ng-click="changeSort('status',paginationObject.currentPage)" data-ng-class="sort.descending && sort.column =='status'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.state" bundle="${msg}" /></th>
								            <th class="col-md-1 col-sm-2">Actions</th>
								        </tr>
								    </thead>
								       <tbody data-ng-hide="vpcList.length > 0">
		                                    <tr>
		                                        <td class="col-md-5 col-sm-5" colspan="6"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
		                                    </tr>
		                                </tbody>
								     <tbody data-ng-show="vpcList.length > 0">
								        <tr data-ng-repeat=" vpc in filteredCount = (vpcList| filter: quickSearch | orderBy:sort.column:sort.descending)">
								            <td>
								                <a class="text-info" ui-sref="vpc.view-vpc({id: {{ 1}}})">{{ vpc.name}}</a>
								            </td>
								            <td>{{ vpc.description}}</td>
								            <td>{{ vpc.zone.name}}</td>
								            <td>{{ vpc.cIDR}}</td>
								            <td>{{ vpc.status}}</td>
								            <td>
								                <a class="icon-button" title="<fmt:message key="configure" bundle="${msg}" />" ui-sref="vpc.config-vpc({id: {{ 1}}})">
								                    <span class="fa fa-cog m-r"> </span>
								                </a>
								                 <a class="icon-button" title="<fmt:message key="restart.vpc" bundle="${msg}" />">
								                	<span class="fa fa-rotate-left m-r"></span>
								                </a>
								                <a class="icon-button" title="<fmt:message key="remove.vpc" bundle="${msg}" />"  ><span class="fa fa-trash"></span></a>
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
