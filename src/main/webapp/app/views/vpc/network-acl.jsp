<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

    <div class="content" ui-view>
	    <div ng-controller="vpcCtrl">
			<div class="hpanel">
				<div class="panel-heading no-padding">
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12 ">
							<div class="pull-left dashboard-btn-area">
								<a id="vpc_network_acl_add_acl_list_button" class="btn btn-info" data-ng-click="addAcl('md')"> <span class="pe-7s-plus pe-lg font-bold m-r-xs"></span> <fmt:message key="add.acl.list" bundle="${msg}" /></a>
							</div>
							<div class="pull-right dashboard-filters-area">
							<form data-ng-submit="searchList(vmSearch)">
								<div class="quick-search pull-right">
									<div class="input-group">
										<input id="vpc_network_acl_quick_search" data-ng-model="vmSearch" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
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
					<div class="col-md-12 col-sm-12 col-xs-12" id="vpc_network_acl_pagination_container">
						<div class="white-content">
							<div data-ng-show="showLoader" style="margin: 1%">
								<get-loader-image data-ng-show="showLoader"></get-loader-image>
							</div>
							<div class="table-responsive">
								<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped" id="vpc_network_acl_table">
								    <thead>
								        <tr>
								            <th><fmt:message key="common.name" bundle="${msg}"/></th>
								            <th><fmt:message key="common.description" bundle="${msg}"/></th>
								            <th><fmt:message key="id" bundle="${msg}"/></th>
								        </tr>
								    </thead>
								    <tbody>
								        <tr data-ng-repeat="networkAcl in filteredCount = (aclList | filter: quickSearch | orderBy:sort.column:sort.descending)">
								            <td><a id="vpc_network_acl_name_button" class="text-info" ui-sref="vpc.view-vpc.config-vpc.network-acl.view-networkAcl({id3: {{ networkAcl.id }}, view: 'view'})" title="<fmt:message key="view.network" bundle="${msg}"/>">{{networkAcl.name}}</a></td>
											<td>{{networkAcl.description}}</td>
											<td>{{networkAcl.uuid}}</td>
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
