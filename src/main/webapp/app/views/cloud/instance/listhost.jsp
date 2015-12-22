<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div  ng-controller=instanceViewCtrl>

                        <div class="white-content">
     

	<div data-ng-show="showLoader" style="margin: 1%">
		<get-loader-image data-ng-show="showLoader"></get-loader-image>
	</div>
	<div data-ng-hide="showLoader" class="table-responsive col-12-table">
		<table cellspacing="1" cellpadding="1"
			class="table table-bordered table-striped">
			<thead>
				<tr>
					<th><fmt:message key="common.name" bundle="${msg}" /></th>
					<th><fmt:message key="common.id" bundle="${msg}" /></th>
					<th><fmt:message key="common.state" bundle="${msg}" /></th>
				    <th><fmt:message key="host.ip.address" bundle="${msg}" /></th>
					<th><fmt:message key="common.hypervisor" bundle="${msg}" /></th>
					<th><fmt:message key="common.zone" bundle="${msg}" /></th>
					<th><fmt:message key="common.pod" bundle="${msg}" /></th>
					<th><fmt:message key="common.cluster" bundle="${msg}" /></th>
					<th><fmt:message key="common.dedicated.host" bundle="${msg}" /></th>
				</tr>
			</thead>
			<tbody>
	
					<td>{{ instance.host.name}}</td>
					<td>{{ instance.host.id}}</td>
					<td>{{ instance.host.status}}</td>
					<td>{{ instance.host.hostIpaddress}}</td>
					<td>{{ instance.template.hypervisor.name}}</td>
					<td>{{ instance.zone.name }}</td>
					<td>{{ instance.host.pod.name }}</td>
					<td>{{ instance.host.cluster.name }}</td>
					<td>{{ instance.host.hostHighAvailability}}</td>
				
				</tr>
			</tbody>
		</table>
	</div>
</div>
</div>
