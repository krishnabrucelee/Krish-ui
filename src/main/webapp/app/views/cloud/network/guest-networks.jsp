<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div ui-view ng-controller="networksCtrl">

                        <div class="white-content">
	<div data-ng-show="showLoader" style="margin: 1%">
		<get-loader-image data-ng-show="showLoader"></get-loader-image>
	</div>

	<div data-ng-hide="showLoader" class="table-responsive">
		<table cellspacing="1" cellpadding="1"
			class="table dataTable table-bordered table-striped">
			<thead>

				<tr>
					<th  data-ng-click="changeSorting('name')" data-ng-class="sort.descending && sort.column =='name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.name" bundle="${msg}" /></th>
					<th  data-ng-click="changeSorting('Account')" data-ng-class="sort.descending && sort.column =='Account'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.account" bundle="${msg}" /></th>
					<th  data-ng-click="changeSorting('networkType')" data-ng-class="sort.descending && sort.column =='networkType'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.type" bundle="${msg}" /></th>
					<th  data-ng-click="changeSorting('cIDR')" data-ng-class="sort.descending && sort.column =='cIDR'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.cidr" bundle="${msg}" /></th>
					<th  data-ng-click="changeSorting('gateway')" data-ng-class="sort.descending && sort.column =='gateway'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="gateway" bundle="${msg}" /></th>
					<th><fmt:message key="common.action" bundle="${msg}" /></th>
				</tr>
			</thead>
			<tbody>
				<tr data-ng-repeat="network in filteredCount = (networkList | filter: quickSearch | orderBy:sort.column:sort.descending)">
					<td><a class="text-info"
						ui-sref="cloud.list-network.view-network({id: {{ network.id }}, view: 'view'})"
						title="View Network">{{ network.name }}</a></td>
					<td>{{ network.department.userName}}</td>
					<td>{{ network.networkType }}</td>
					<td>{{ network.cIDR }}</td>
					<td>{{ network.gateway}}</td>
					<td><a class="icon-button" has-permission="EDIT_NETWORK"
						title="<fmt:message key="common.edit" bundle="${msg}" />"
						ui-sref="cloud.list-network.view-network({id: {{ network.id }}, view: 'edit'})">
							<span class="fa fa-edit m-r"> </span>
					</a> <%-- <a class="icon-button"
						title="<fmt:message key="common.restart" bundle="${msg}" /> "><span
							class="fa fa-rotate-left m-r"></span></a> --%>
							 <a class="icon-button"
						has-permission="DELETE_NETWORK"
						title="<fmt:message key="common.delete" bundle="${msg}" /> "
						data-ng-click="delete('sm', network)"><span
							class="fa fa-trash"></span></a></td>
				</tr>
			</tbody>
		</table>

	</div>
	</div>
</div>