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
							<h3 class="panel-title">VPC Details</h3>
						</div>
						<div class="panel-body p-md">
							<table cellspacing="1" cellpadding="1" class="table table-condensed table-striped">
								<tbody>
									<tr>
										<td><b> Name</b></td>
										<td><label data-ng-if="type != 'edit'" class="ng-binding ng-scope">myfirstVPC1</label></td>
									</tr>
									<tr>
										<td><b> Description</b></td>
										<td><label data-ng-if="type != 'edit'" class="ng-binding ng-scope">Test description VPC1</label></td>
									</tr>
									<tr>
										<td><b> Account</b></td>
										<td>admin</td>
									</tr>
									<tr>
										<td><b>Domain</b></td>
										<td>stackwatch.io</td>
									</tr>
									<tr>
										<td><b>Zone</b></td>
										<td>pandatest</td>
									</tr>
									<tr>
										<td><b>CIDR</b></td>
										<td>10.0.0.0/22</td>
									</tr>
									<tr>
										<td><b>Network Domain</b></td>
										<td>0.0.0.0</td>
									</tr>
									<tr>
										<td><b>State</b></td>
										<td><b class="text-success text-uppercase">IMPLEMENTED</b></td>
									</tr>
									<tr>
										<td><b>Persistent </b></td>
										<td>NO</td>
									</tr>
									<tr>
										<td><b>Redundant VPC</b></td>
										<td>YES</td>
									</tr>
									<tr>
										<td><b>Restart required</b></td>
										<td>NO</td>
									</tr>
									<tr>
										<td><b>ID</b></td>
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
								Quick Actions
							</h3>
						</div>
						<div class="panel-body no-padding">
							<ul class="list-group">
								<li class="list-group-item ng-scope" data-ng-if="type != 'edit'">
									<a href="#/network/list/edit/2" title=" Edit Network" has-permission="EDIT_NETWORK"> <span class="fa fa-edit m-xs"></span> Edit Network</a>
								</li>
					 			<li class="list-group-item">
		                            <a data-ng-click="restart('sm', network)" title=" Restart Network " href="javascript:void(0);"><span class="fa-repeat fa m-xs"></span>Restart Network</a>
		                        </li>
								<li class="list-group-item">
									<a data-ng-click="delete('sm', network)" title=" Delete Network" href="javascript:void(0);" has-permission="DELETE_NETWORK"><span class="fa-trash fa m-xs"></span> Delete Network</a>
								</li>
								<li class="list-group-item">
									<a class="btn btn-info" ui-sref="vpc.config-vpc({id: {{ 1}}})" ><span class="fa fa-cog"> </span> Configure</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">Tags</h3>
						</div>
						<div class="panel-body">
							<div class="row form-group">
								<div class="col-lg-6 col-md-6 col-sm-6"><div class="m-t-xs">key</div></div>
								<div class="col-lg-6 col-md-6 col-sm-6"><input class="form-control" type="text"></div>
							</div>
							<div class="row form-group">
								<div class="col-lg-6 col-md-6 col-sm-6"><div class="m-t-xs">Value</div></div>
								<div class="col-lg-6 col-md-6 col-sm-6"><input class="form-control" type="text"></div>
							</div>
							<div class="row form-group">
								<div class="col-lg-6 col-md-6 col-sm-6"></div>
								<div class="col-lg-6 col-md-6 col-sm-6"><a class="btn btn-success" ui-sref="config-vpc({id: {{ 1}}})" ><span class="fa fa-plus"> </span> Add</a></div>
							</div>
						</div>
					</div>
				</div>
        	</div>
    	</div>
    </div>
    <div id="footer" ng-include="'app/views/common/footer.jsp'"></div>




