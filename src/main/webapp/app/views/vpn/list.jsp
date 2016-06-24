<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<!-- Header -->
<ng-include id="header" src="global.getViewPageUrl('common/header.jsp')"></ng-include>

<!-- Navigation -->
<ng-include id="menu" src="global.getViewPageUrl('common/navigation.jsp')"></ng-include>
<div id="wrapper">
 <div small-header class="normalheader transition ng-scope small-header">
        <div class="hpanel" tour-step order="1" content="Place your page title and breadcrumb. Select small or large header or give the user choice to change the size." placement="bottom">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-left">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a ui-sref="dashboard"><fmt:message key="common.home" bundle="${msg}" /></a></li>
                        <li ng-repeat="state in $state.$current.path" ng-switch="$last || !!state.abstract" ng-class="{active: $last}">
                            <span data-ng-if="state.data.pageTitle === 'VPN Customer Gateway'">
	                            <a ng-switch-when="false" ng-href="{{'#' + state.url.format($stateParams)}}"><fmt:message key="common.vpn.customer.gateway" bundle="${msg}" /></a>
	                            <span ng-switch-when="true"><fmt:message key="common.vpn.customer.gateway" bundle="${msg}" /></span>
                            </span>
                        </li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <div class="content" ui-view>
	    <div ng-controller="vpnGatewayCtrl">
	     <div data-ng-if="global.webSocketLoaders.vpcLoader" class="overlay-wrapper">
                   <img data-ng-if="global.webSocketLoaders.vpcLoader" src="images/loading-bars.svg" class="inner-loading" />
             </div>
			<div class="hpanel">
				<div class="panel-heading">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="pull-left dashboard-btn-area">
                    	<div class="dashboard-box pull-left">
  							<div class="instance-border-content-normal">
                             <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="common.total" bundle="${msg}" /></span>
                             <b class="pull-left">{{vpngatewayList.Count}}</b>
                             <div class="clearfix"></div>
                             </div>
                         </div>
						 <a has-permission="CREATE_VPC" class="btn btn-info" id="vpc_add_button" data-ng-click="createVpc('md')"> <span class="pe-7s-plus pe-lg font-bold m-r-xs"></span> <fmt:message key="add.vpn.customer.gateway" bundle="${msg}"/></a>
                         <a class="btn btn-info" id="vpc_refresh_button" data-ng-click="list(1)"  title="<fmt:message key="common.refresh" bundle="${msg}"/>"><span class="fa fa-refresh fa-lg "></span></a>
                    </div>
                    <div class="pull-right dashboard-filters-area">
						<form data-ng-submit="searchList(vpngatewaySearch)">
							<div class="quick-search pull-right">
							<div class="input-group">
							<input data-ng-model="vpngatewaySearch" id="vpc_quick_search" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
							<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
							</div>
							</div>
							<span class="pull-right m-r-sm" data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'">
								<select	class="form-control input-group col-xs-5" id="vpc_domain_filter" name="domainView" data-ng-model="domainView" data-ng-change="selectDomainView(1)" data-ng-options="domainView.name for domainView in domainList">
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
					<div class="col-md-12 col-sm-12 col-xs-12 " id="vpc_pagination_container">
						<div class="white-content">
							<div data-ng-show="showLoader" style="margin: 1%">
								<get-loader-image data-ng-show="showLoader"></get-loader-image>
							</div>
							<div data-ng-hide="showLoader"class="table-responsive">
							<div class="white-content">
								<table cellspacing="1" cellpadding="1" class="table dataTable table-bordered table-striped" id="vpc_table">
								    <thead>
								        <tr>
								            <th data-ng-click="changeSort('name',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='name'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.name" bundle="${msg}" /></th>
								            <th data-ng-click="changeSort('gateway',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='gateway'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="gateway" bundle="${msg}" /></th>
								            <th data-ng-click="changeSort('ipsecPresharedKey',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='ipsecPresharedKey'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.ipsec.preshared.key" bundle="${msg}" /></th>
								            <th data-ng-click="changeSort('cIDR',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='cIDR'? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.cidr" bundle="${msg}" /></th>
								            <th data-ng-click="changeSort('domainName',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='domainName'? 'sorting_desc' : 'sorting_asc' "><fmt:message
														key="common.company" bundle="${msg}" /></th>
											<th data-ng-click="changeSort('departmentUserName',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='departmentUserName'? 'sorting_desc' : 'sorting_asc' "><fmt:message
														key="common.department" bundle="${msg}"/></th>
											<th data-ng-click="changeSort('projectName ',paginationObject.currentPage)"
													data-ng-class="sort.descending && sort.column =='projectName '? 'sorting_desc' : 'sorting_asc' "><fmt:message key="common.project" bundle="${msg}"/></th>
								             <th><fmt:message key="common.action" bundle="${msg}"/></th>
								        </tr>
								    </thead>
								    <tbody data-ng-hide="vpngatewayList.length > 0">
			                                <tr>
			                                    <td class="col-md-9 col-sm-9" colspan="9"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
			                                </tr>
			                            </tbody>
								    <tbody data-ng-show="vpngatewayList.length > 0">
								         <tr data-ng-repeat="vpngateway in filteredCount = vpngatewayList">
								            <td>
								                <a class="text-info" id="vpc_name_button" ">{{vpngateway.name}}</a>
								            </td>
								            <td>{{vpngateway.gateway}}</td>
								            <td>{{vpngateway.ipsecPresharedKey}}</td>
								            <td>{{vpngateway.cIDR}}</td>
								            <td>{{vpngateway.domainName }}</td>
											<td>{{vpngateway.departmentUserName || '-'}}</td>
											<td>{{vpngateway.projectName || '-'}}</td>
								            <td>
								                <input type="hidden" id="vpngateway_unique_{{vpngateway.id}}"  data-unique-field="{{ vpngateway.domainName }}-{{vpngateway.departmentUserName}}-{{ vpngateway.name}}" class="test_vpngateway_unique">
								                <a class="icon-button test_vpc_configure_button" id="vpngateway_edit_button_{{vpngateway.id}}" title="<fmt:message key="common.edit" bundle="${msg}" />" >
								                    <span class="fa fa-edit m-r-xs"> </span>
								                </a>
								                <a  class="icon-button test_vpc_delete_button" id="vpc_delete_button_{{vpc.id}}" data-ng-click="delete('sm', vpc.id)" title="<fmt:message key="remove.vpc" bundle="${msg}" />"  ><span class="fa fa-trash"></span></a>
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
