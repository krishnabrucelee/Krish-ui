<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<form name="departmentForm"
	data-ng-submit="save(departmentForm, department)" method="post"
	novalidate="">
	<div class="inmodal">
		<div class="modal-header">
			<panda-modal-header page-icon="fa fa-plus-circle"
				page-title="View Console"></panda-modal-header>
		</div>

		<div class="modal-body">
			<div class="row">
				<div class="col-md-9 col-sm-9">
					<iframe data-ng-src="{{ consoleUrl }}" width="600" height="500"></iframe>
				</div>
				<div class="col-md-3 col-sm-3">
					<div class="row">
						<h3>{{ instance.name }}</h3>
						<table cellspacing="1" cellpadding="1" width="300" height="200"
							class="table table-bordered table-striped">
							<tbody>
								<tr>
									<td>
									<label
										class="col-md-7 col-sm-7 col-xs-4 control-label "><fmt:message
												key="total.cpu" bundle="${msg}" /></label></td>
									<td>{{instance.cpuCore}}x{{instance.cpuSpeed}} MHz</td>
								</tr>
								<tr>
									<td><label
										class="col-md-7 col-sm-7 col-xs-4 control-label "><fmt:message
												key="network.read" bundle="${msg}" /></label></td>
									<td>{{instance.networkKbsRead}} KB</td>
								</tr>
								<tr>
									<td><label
										class="col-md-7 col-sm-7 col-xs-4 control-label "><fmt:message
												key="network.write" bundle="${msg}" /></label></td>
									<td>{{instance.networkKbsWrite}} KB</td>
								</tr>
								<tr>
									<td><label
										class="col-md-8 col-sm-7 col-xs-4 control-label "><fmt:message
												key="disk.read.bytes" bundle="${msg}" /></label></td>
									<td data-ng-if="instance.diskKbsRead>1024">{{(instance.diskKbsRead)/1024
										| number:2}} MB</td>
									<td data-ng-if="instance.diskKbsRead<1024">{{instance.diskKbsRead}}
										KB</td>
								</tr>
								<tr>
									<td><label
										class="col-md-8 col-sm-7 col-xs-7 control-label "><fmt:message
												key="disk.write.bytes" bundle="${msg}" /></label></td>
									<td data-ng-if="instance.diskKbsWrite>1024">{{(instance.diskKbsWrite)/1024
										| number:2}} MB</td>
									<td data-ng-if="instance.diskKbsWrite<1024">{{instance.diskKbsWrite}}
										KB</td>
								</tr>
								<tr>
									<td><label
										class="col-md-7 col-sm-7 col-xs-7 control-label "><fmt:message
												key="disk.read.io" bundle="${msg}" /></label></td>
									<td>{{instance.diskIoRead}}</td>

								</tr>
								<tr>
									<td><label
										class="col-md-7 col-sm-7 col-xs-7 control-label "><fmt:message
												key="disk.write.io" bundle="${msg}" /></label></td>
									<td>{{instance.diskIoWrite}}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

		<div class="modal-footer"></div>
	</div>
</form>



