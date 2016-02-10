<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div >
	<div class="white-content">


		<table has-permission="ASSIGN_USERS_TO_PROJECTS" cellspacing="1" cellpadding="1"
			class="table table-bordered table-striped">
			<thead>
				<tr>
					<th class="col-md-3 col-xs-3"><fmt:message key="account" bundle="${msg}" /></th>
					<th class="col-md-3 col-xs-3"><fmt:message key="common.department" bundle="${msg}" /></th>
					<th class="col-md-3 col-xs-3"><fmt:message key="common.action" bundle="${msg}" /></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="department-selectbox"><div custom-select="t as t.userName for t in projectElements.projectuserList | filter: { userName: $searchTerm }" ng-model="project.user">
						<div class="pull-left">
						<strong>{{ t.userName }}</strong><br />
						</div>
						<div class="clearfix"></div>
						</div></td>
					<td>{{projectInfo.department.userName}}</td>
					<td><a class="btn btn-info" data-ng-click="addUser(project.user)"><span
							class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="common.add" bundle="${msg}" /></a> <!--<a data-ng-show="delete" class="btn btn-info" data-ng-click="openAddIsolatedNetwork('lg')"><span class="pe-7s-trash pe-lg font-bold m-r-xs"></span></a>-->
					</td>
				</tr>
			</tbody>
		</table>
		<table cellspacing="1" cellpadding="1"
			class="table table-bordered table-striped h-300">
			<thead>
				<tr>
					<th class="col-md-3 col-xs-3"></th>
					<th class="col-md-3 col-xs-3"></th>
					<th class="col-md-3 col-xs-3"></th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="user in projectInfo.userList" class="font-bold text-center">
					<td>{{user.userName}}</td>
					<td>{{user.department.userName}}</td>
					<td><a  data-ng-if="projectInfo.projectOwner.id !== user.id " has-permission="RELEASE_USERS_TO_PROJECTS" data-ng-click="removeUser(user)"><span
							class="fa fa-trash"></span></a></td>
				</tr>
				<!--            deleteRules(rule.id,'Egress')-->
			</tbody>
		</table>



	</div>
</div>
