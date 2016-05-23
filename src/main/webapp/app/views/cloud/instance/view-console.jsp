<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<form name="departmentForm"
	data-ng-submit="save(departmentForm, department)" method="post"
	novalidate="">
	<div class="inmodal">
		<div class="modal-header">
			<panda-modal-header page-icon="fa fa-plus-circle" page-title="View Console"></panda-modal-header>
		</div>

		<div class="modal-body">
			<h3>{{ instance.name }}</h3>
			<hr>
			<div class="row">
				<div class="col-md-12 col-sm-12">
					<iframe data-ng-src="{{ consoleUrl }}" width="800" height="500" id="iframe-container"></iframe>
				</div>
				<%-- <div class="col-md-2 col-md-2">

					<ul class="list-group">
						<div
							data-ng-show="instance.status != 'Error' || instance.status != 'Expunging' || instance.status != 'Starting' || instance.status != 'Stopping' || instance.status != 'Destroying'  ">
							<li class="list-group-item"><a href="javascript:void(0);"
								title="<fmt:message key="stop" bundle="${msg}" />"
								data-ng-click="stopVm('sm',instance)"
								data-ng-show="instance.status == 'Running'"><span
									class="fa-ban fa font-bold m-xs"></span> <fmt:message
										key="stop" bundle="${msg}" /></a> <a href="javascript:void(0);"
								title="<fmt:message key="start" bundle="${msg}" />"
								data-ng-click="startVm('sm',instance)"
								data-ng-show="instance.status == 'Stopped'"><span
									class="fa-play fa font-bold m-xs"></span> <fmt:message
										key="start" bundle="${msg}" /></a></li>
							<li data-ng-if="instance.status == 'Running'"
								class="list-group-item"><a href="javascript:void(0);"
								data-ng-if="instance.status == 'Running'"
								title="<fmt:message key="restart" bundle="${msg}" />"
								data-ng-click="rebootVm('sm',instance)"><span
									class="fa-rotate-left fa font-bold m-xs"></span> <fmt:message
										key="reboot" bundle="${msg}" /></a></li>

							<li class="list-group-item"
								data-ng-if="instance.status == 'Running'"><a
								href="javascript:void(0);"
								title="<fmt:message key="reinstall.vm" bundle="${msg}" />"
								data-ng-click="reInstallVm('md',instance)"><span
									class="fa fa-history m-xs"></span> <fmt:message
										key="reinstall.vm" bundle="${msg}" /></a></li>

						</div>
						<li class="list-group-item">
							<!--<a href="#" title="Edit Note">  <span class="fa-edit fa font-bold m-xs"></span> Edit Note</a>-->
							<a title="<fmt:message key="edit.note" bundle="${msg}" />"
							data-ng-click="showDescription(instance)"><span
								class="fa-edit fa font-bold m-xs"></span>
							<fmt:message key="edit.note" bundle="${msg}" /></a>

						</li>

					</ul>
				</div> --%>
				<%-- <div class="col-md-3 col-sm-3">
					<div class="row">

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
				</div> --%>
			</div>
		</div>

		<div class="modal-footer"></div>
	</div>
</form>




