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
								<a class="btn btn-info" data-ng-click="addAcl('md')"> <span class="pe-7s-plus pe-lg font-bold m-r-xs"></span> <fmt:message key="add.acl.list" bundle="${msg}" /></a>
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
							<div class="table-responsive">
								<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
								    <thead>
								        <tr>
								            <th><fmt:message key="common.name" bundle="${msg}"/></th>
								            <th><fmt:message key="common.description" bundle="${msg}"/></th>
								            <th><fmt:message key="id" bundle="${msg}"/></th>
								        </tr>
								    </thead>
								    <tbody>
								        <tr>
								            <td>default_allow</td>
								            <td>Default Network ACL Allow All</td>
								            <td>376020c2-c407-11e5-a31f-364817483cf1</td>
								        </tr>
								        <tr>
								            <td>default_allow</td>
								            <td>Default Network ACL Allow All</td>
								            <td>376020c2-c407-11e5-a31f-364817483cf1</td>
								        </tr>
								        <tr>
								            <td>default_allow</td>
								            <td>Default Network ACL Allow All</td>
								            <td>376020c2-c407-11e5-a31f-364817483cf1</td>
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