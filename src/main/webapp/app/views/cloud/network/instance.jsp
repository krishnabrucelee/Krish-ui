<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="panel-heading">
	<div class="row">
		<div class="pull-right">
			<div class="quick-search">
				<div class="input-group">
					<input data-ng-model="networkSearch" type="text" class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />"
						aria-describedby="quicksearch-go"
					> <span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
				</div>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
</div>
<div class="white-content">
	<form>
		<div class="table-responsive col-12-table">
			<table cellspacing="1" cellpadding="1" class="table dataTable table-bordered table-striped ">
				<thead>
					<tr>
						<th><fmt:message key="common.name" bundle="${msg}" /></th>
						<th><fmt:message key="common.internal.name" bundle="${msg}" /></th>
						<th><fmt:message key="common.display.name" bundle="${msg}" /></th>
						<th><fmt:message key="common.zone" bundle="${msg}" /></th>
						<th><fmt:message key="common.state" bundle="${msg}" /></th>
					</tr>
				</thead>
				<tbody>
					<tr data-ng-repeat="instance in vmList | filter: networkSearch ">
						<td><a class="text-info" ui-sref="cloud.list-instance.view-instance({id: {{ instance.vmInstance.id}}})"
							title="<fmt:message key="view.instance" bundle="${msg}" />"
						>{{ instance.vmInstance.name}}</a></td>
						<td>{{instance.vmInstance.instanceInternalName}}</td>
						<td>{{instance.vmInstance.displayName}}</td>
						<td>{{instance.vmInstance.zone.name}}</td>
						<td>
							<div class="text-center">
								<img src="images/status/running.png" data-ng-if="instance.vmInstance.status == 'RUNNING'"
									title="{{ instance.vmInstance.status}}"
								>
								<!-- <button class="btn btn-xs btn-success btn-circle" data-ng-if="instance.status == 'RUNNING'"
													title="{{ instance.status}}"
												></button> -->
								<img src="images/status/stopped.png" data-ng-if="instance.vmInstance.status == 'STOPPED'"
									title="{{ instance.vmInstance.status}}"
								> <img src="images/status/warning.png" data-ng-if="instance.vmInstance.status == 'STARTING'"
									title="{{ instance.vmInstance.status}}"
								> <img src="images/status/stopped.png" data-ng-if="instance.vmInstance.status == 'ERROR'"
									title="{{ instance.vmInstance.status}}"
								> <img src="images/status/warning.png" data-ng-if="instance.vmInstance.status == 'STOPPING'"
									title="{{ instance.vmInstance.status}}"
								> <img src="images/status/warning.png" data-ng-if="instance.vmInstance.status == 'EXPUNGING'"
									title="{{ instance.vmInstance.status}}"
								> <img src="images/status/stopped.png" data-ng-if="instance.vmInstance.status == 'DESTROYED'"
									title="{{ instance.vmInstance.status}}"
								> <img src="images/status/warning.png" data-ng-if="instance.vmInstance.status == 'MIGRATING'"
									title="{{ instance.vmInstance.status}}"
								>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</form>
</div>