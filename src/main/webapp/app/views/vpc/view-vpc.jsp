<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- Header -->

    <div class="content" ui-view>
    	<div data-ng-controller="vpcCtrl">
            <div class="row" >
                <div class="col-md-8">
                    <div class="panel panel-default">
                    	<div class="panel-heading">
							<h3 class="panel-title"><fmt:message key="vpc.details" bundle="${msg}" /></h3>
						</div>
						<div class="panel-body p-md">
							<table cellspacing="1" cellpadding="1" class="table table-condensed table-striped">
								<tbody>
									<tr>
										<td><b> <fmt:message key="common.name" bundle="${msg}" /></b></td>
										<td><label data-ng-if="type != 'edit'" class="ng-binding ng-scope">myfirstVPC1</label></td>
									</tr>
									<tr>
										<td><b> <fmt:message key="common.description" bundle="${msg}" /></b></td>
										<td><label data-ng-if="type != 'edit'" class="ng-binding ng-scope">Test description VPC1</label></td>
									</tr>
									<tr>
										<td><b> <fmt:message key="account" bundle="${msg}" /></b></td>
										<td>admin</td>
									</tr>
									<tr>
										<td><b><fmt:message key="common.company" bundle="${msg}" /></b></td>
										<td>stackwatch.io</td>
									</tr>
									<tr>
										<td><b><fmt:message key="common.zone" bundle="${msg}" /></b></td>
										<td>pandatest</td>
									</tr>
									<tr>
										<td><b><fmt:message key="common.cidr" bundle="${msg}" /></b></td>
										<td>10.0.0.0/22</td>
									</tr>
									<tr>
										<td><b><fmt:message key="networkdomain" bundle="${msg}" /></b></td>
										<td>0.0.0.0</td>
									</tr>
									<tr>
										<td><b><fmt:message key="common.state" bundle="${msg}" /></b></td>
										<td><b class="text-success text-uppercase">IMPLEMENTED</b></td>
									</tr>
									<tr>
										<td><b><fmt:message key="common.persistent" bundle="${msg}" /></b></td>
										<td>NO</td>
									</tr>
									<tr>
										<td><b><fmt:message key="redundant.vpc" bundle="${msg}" /></b></td>
										<td>YES</td>
									</tr>
									<tr>
										<td><b><fmt:message key="restart.required" bundle="${msg}" /></b></td>
										<td>NO</td>
									</tr>
									<tr>
										<td><b><fmt:message key="id" bundle="${msg}" /></b></td>
										<td>1943c385-1aae-4d66-8a4e-295268ff2db3</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-4">
					<div class="panel panel-info">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bolt"></i>&nbsp;&nbsp;
								<fmt:message key="quick.actions" bundle="${msg}" />
							</h3>
						</div>
						<div class="panel-body no-padding">
							<ul class="list-group">
								<li class="list-group-item ng-scope" data-ng-if="type != 'edit'">
									<a href="#/network/list/edit/2" title="<fmt:message key="edit.vpc" bundle="${msg}" />" has-permission="EDIT_NETWORK"> <span class="fa fa-edit m-xs"></span> <fmt:message key="edit.vpc" bundle="${msg}" /></a>
								</li>
					 			<li class="list-group-item">
		                            <a data-ng-click="restart('sm', network)" title="<fmt:message key="restart.vpc" bundle="${msg}" />" href="javascript:void(0);"><span class="fa-repeat fa m-xs"></span><fmt:message key="restart.vpc" bundle="${msg}" /></a>
		                        </li>
								<li class="list-group-item">
									<a data-ng-click="delete('sm', network)" title="<fmt:message key="delete.vpc" bundle="${msg}" />" href="javascript:void(0);" has-permission="DELETE_NETWORK"><span class="fa-trash fa m-xs"></span><fmt:message key="delete.vpc" bundle="${msg}" /></a>
								</li>
								<li class="list-group-item">
									<a class="btn btn-info" ui-sref="vpc.config-vpc({id: {{ 1}}})" ><span class="fa fa-cog"> </span> Configure</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title"><fmt:message key="common.tags" bundle="${msg}" /></h3>
						</div>
						<div class="panel-body">
							<div class="row form-group">
								<div class="col-lg-6 col-md-6 col-sm-6"><div class="m-t-xs"><fmt:message key="common.key" bundle="${msg}" /></div></div>
								<div class="col-lg-6 col-md-6 col-sm-6"><input class="form-control" type="text"></div>
							</div>
							<div class="row form-group">
								<div class="col-lg-6 col-md-6 col-sm-6"><div class="m-t-xs"><fmt:message key="common.value" bundle="${msg}" /></div></div>
								<div class="col-lg-6 col-md-6 col-sm-6"><input class="form-control" type="text"></div>
							</div>
							<div class="row form-group">
								<div class="col-lg-6 col-md-6 col-sm-6"></div>
								<div class="col-lg-6 col-md-6 col-sm-6"><a class="btn btn-success" ui-sref="config-vpc({id: {{ 1}}})" ><span class="fa fa-plus"> </span> <fmt:message key="common.add" bundle="${msg}" /></a></div>
							</div>
						</div>
					</div>
				</div>
        	</div>
    	</div>
    </div>
    <div id="footer" ng-include="'app/views/common/footer.jsp'"></div>




