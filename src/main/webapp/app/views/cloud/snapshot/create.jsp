<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div data-ng-hide="createSnapshot">

<form name="snapshotForm" data-ng-submit="validateSnapshot(snapshotForm)" method="post" novalidate="" data-ng-controller="addSnapshotCtrl" >
		<div class="inmodal">
			<div class="modal-header">
				<panda-modal-header page-icon="fa fa-database"
					page-title="List of Available Disk"></panda-modal-header>
			</div>
			<div class="modal-body">
				<div class="row" data-ng-show="showLoader">
					<div class="col-md-12">
						<img src="images/loading-bars.svg" width="64" height="64" />
					</div>
				</div>
				<div class="row" data-ng-hide="showLoader">
					<div class="col-md-12">
						<div class="text-center">
							<p><fmt:message key="volume.snapshot.info.msg" bundle="${msg}" /></p>
						</div>
						<div class="scroll-area">
							<div class="table-responsive">
								<table cellspacing="1" cellpadding="1"
									class="table table-bordered table-striped">
									<thead>
										<tr>
											<th class="col-md-2 col-sm-2"><fmt:message key="common.volume" bundle="${msg}" /></th>
											<th class="col-md-2 col-sm-2"><fmt:message key="common.instance" bundle="${msg}" /></th>
											<th class="col-md-2 col-sm-2"><fmt:message key="common.type" bundle="${msg}" /></th>
										</tr>
									</thead>
									<tbody>
										<tr data-ng-repeat="volume in volumesList">
											<td>
											<a ng-click="updatePageStatus('md', volume)">
											{{ volume.name }}</a>
											</td>
											<td>{{ volume.vmInstance.name }}</td>

											<td>{{ volume.volumeType }}</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="modal-footer">
				<div>
					<span class="pull-right">
						<h4 class="text-danger price-text m-l-lg">
							<app-currency></app-currency>
							0.10 <span>/ hour</span> <span>/GB</span>
						</h4>
					</span>
				</div>
			</div>
		</div>
	</form>
</div>
<div data-ng-include src="'app/views/cloud/snapshot/download-snapshot.jsp'" data-ng-show="createSnapshot"></div>




