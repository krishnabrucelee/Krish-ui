<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- Header -->
<ng-include id="header" src="global.getViewPageUrl('common/header.jsp')"></ng-include>

<!-- Navigation -->
<ng-include id="menu" src="global.getViewPageUrl('common/navigation.jsp')"></ng-include>
<div id="wrapper">
 <div small-header class="normalheader transition ng-scope small-header">
        <div class="hpanel" tour-step order="1" content="Place your page title and breadcrumb. Select small or large header or give the user choice to change the size." placement="bottom">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a ui-sref="dashboard"><fmt:message key="common.home" bundle="${msg}" /></a></li>
                        <li ng-repeat="state in $state.$current.path" ng-switch="$last || !!state.abstract" ng-class="{active: $last}">
                            <span data-ng-if="state.data.pageTitle === 'VPC'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.vpc" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.vpc" bundle="${msg}" /></span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'view VPC'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}">{{ state.data.pageName }}</a>
	                            <span ng-switch-when="true">{{ state.data.pageName }}</span>
                            </span>
                            <span data-ng-if="state.data.pageTitle === 'config VPC'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="vpc.configuration" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="vpc.configuration" bundle="${msg}" /></span>
                            </span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    <span id="vpc_page_title" data-ng-if="$state.current.data.pageTitle === 'VPC'"><fmt:message key="common.vpc" bundle="${msg}" /></span>
                </h2>
                <h2 class="font-light m-b-xs">
                    <span id="vpc_page_title" data-ng-if="$state.current.data.pageTitle === 'view VPC'">{{ $state.current.data.pageName }}</span>
                </h2>
                <h2 class="font-light m-b-xs">
                    <span id="vpc_page_title" data-ng-if="$state.current.data.pageTitle === 'config VPC'"><fmt:message key="vpc.configuration" bundle="${msg}" /></span>
                </h2>
                <small>{{ $state.current.data.pageDesc}}</small>
            </div>
        </div>
    </div>

    <div class="content" ui-view>
	    <div ng-controller="vpcCtrl">
			<div class="hpanel">
				<div class="panel-heading">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="pull-left dashboard-btn-area">
                    	<div class="dashboard-box pull-left">
  							<div class="instance-border-content-normal">
                             <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="common.total" bundle="${msg}" /></span>
                             <b class="pull-left">{{vpcList.Count}}</b>
                             <div class="clearfix"></div>
                             </div>
                         </div>
						 <a class="btn btn-info" data-ng-click="createVpc('md')"> <span class="pe-7s-plus pe-lg font-bold m-r-xs"></span> Add VPC</a>
                         <a class="btn btn-info" data-ng-click="list(1)"  title="<fmt:message key="common.refresh" bundle="${msg}"/>"><span class="fa fa-refresh fa-lg "></span></a>
                    </div>
                    <div class="pull-right dashboard-filters-area" id="vpc_quick_search">
						<form data-ng-submit="searchList(vpcSearch)">
							<div class="quick-search pull-right">
							<div class="input-group">
							<input data-ng-model="vpcSearch" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
							<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
							</div>
							</div>
							<span class="pull-right m-r-sm" data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'">
								<select	class="form-control input-group col-xs-5" name="domainView" data-ng-model="domainView" data-ng-change="selectDomainView(1)" data-ng-options="domainView.name for domainView in domainList">
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
							<div data-ng-hide="showLoader"class="table-responsive">
							<div class="white-content">
								<table cellspacing="1" cellpadding="1" class="table dataTable table-bordered table-striped">
								    <thead>
								        <tr>
								            <th data-ng-click="changeSort('name',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='name'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.name" bundle="${msg}" /></th>
								            <th data-ng-click="changeSort('description',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='description'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.description" bundle="${msg}" /></th>
								            <th data-ng-click="changeSort('domain.name',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='domain.name'? 'sorting_desc' : 'sorting_asc' "><fmt:message
														key="common.company" bundle="${msg}" /></th>
											<th data-ng-click="changeSort('department.userName',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='Account'? 'sorting_desc' : 'sorting_asc' "><fmt:message
														key="common.department" bundle="${msg}"/></th>
											<th><fmt:message key="common.project" bundle="${msg}"/></th>
								            <th data-ng-click="changeSort('zone.name',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='zone.name'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.zone" bundle="${msg}" /></th>
								            <th data-ng-click="changeSort('cIDR',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='cIDR'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.cidr" bundle="${msg}" /></th>
								            <th data-ng-click="changeSort('status',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='status'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.state" bundle="${msg}" /></th>
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
								                <a class="text-info" ui-sref="vpc.view-vpc({id: {{ vpc.id}}})">{{vpc.name}}</a>
								            </td>
								            <td>{{vpc.description}}</td>
								            <td>{{vpc.domain.name }}</td>
											<td>{{vpc.department.userName || '-'}}</td>
											<td>{{vpc.project.name || '-'}}</td>
								            <td>{{vpc.zone.name}}</td>
								            <td>{{vpc.cIDR}}</td>
								            <td><label data-ng-if="vpc.status == 'ENABLED'" class="label label-success text-center text-white">ACTIVE</label><label data-ng-if="vpc.status != 'ENABLED'" class="label label-danger text-center text-white">INACTIVE</label></td>
								            <td>
								                <a class="icon-button" title="<fmt:message key="configure" bundle="${msg}" />"href="#/vpc/view/{{vpc.id}}/config-vpc">
								                    <span class="fa fa-cog m-r"> </span>
								                </a>
								                 <a class="icon-button" data-ng-click="restart('md', vpc)" title="<fmt:message key="restart.vpc" bundle="${msg}" />">
								                	<span class="fa fa-rotate-left m-r"></span>
								                </a>
								                <a class="icon-button" data-ng-click="delete('sm', vpc)" title="<fmt:message key="remove.vpc" bundle="${msg}" />"  ><span class="fa fa-trash"></span></a>
								            </td>
								        </tr>
								    </tbody>
								</table>
								</div>
							</div>
						</div>
						<pagination-content></pagination-content>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="footer" ng-include="'app/views/common/footer.jsp'"></div>
	</div>
