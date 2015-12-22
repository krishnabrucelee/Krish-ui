<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div>
  <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header page-icon="fa fa-plus-circle" page-title="<fmt:message key="host.information" bundle="${msg}" />"></panda-modal-header>
        </div>
        <div class="modal-body">
                        <div class="white-content">
     

	<div data-ng-show="showLoader" style="margin: 1%">
		<get-loader-image data-ng-show="showLoader"></get-loader-image>
	</div>
	<div data-ng-hide="showLoader" class="table-responsive col-12-table no-margins">
		<table cellspacing="1" cellpadding="1"
			class="table table-bordered table-striped">
			<thead>
				<tr>
				
					<th class = "col-sm-3"><fmt:message key="common.name" bundle="${msg}" /></th>
					<th class = "col-sm-1"><fmt:message key="common.id" bundle="${msg}" /></th>
					<th class = "col-sm-1"><fmt:message key="common.state" bundle="${msg}" /></th>
				    <th class = "col-sm-2"><fmt:message key="host.ip.address" bundle="${msg}" /></th>
					<th class = "col-sm-1"><fmt:message key="common.hypervisor" bundle="${msg}" /></th>
					<th class = "col-sm-2"><fmt:message key="common.zone" bundle="${msg}" /></th>
					<th class = "col-sm-2"><fmt:message key="common.pod" bundle="${msg}" /></th>
					<th class = "col-sm-2"><fmt:message key="common.cluster" bundle="${msg}" /></th>
					<th class = "col-sm-2"><fmt:message key="common.dedicated" bundle="${msg}" /></th>
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
					<td>{{ (instance.host.hostHighAvailablility) ? "yes" : "no" }}</td>
				
				</tr>
			</tbody>
		</table>
	</div>
</div>
</div>
 <div class="modal-footer">
            <get-loader-image data-ng-show="showLoader"></get-loader-image>
             <button type="button" data-ng-hide="showLoader" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
          
        </div>
</div>
</div>

