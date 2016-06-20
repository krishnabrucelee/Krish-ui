<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div data-ng-hide="createSnapshot">

<form name="snapshotForm" data-ng-submit="validateSnapshot(snapshotForm)" method="post" novalidate="" data-ng-controller="addSnapshotCtrl" >
		<div class="inmodal">
			<div class="modal-header">
				<panda-modal-header page-icon="fa fa-database"
					page-title="<fmt:message key="list.of.available.disk" bundle="${msg}" />"></panda-modal-header>
			</div>
			<div class="modal-body">
				<div class="row" data-ng-show="showLoader">
					<div class="col-md-12">
					<get-loader-image></get-loader-image>	</div>
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
					<div class="col-md-12 col-sm-12">
                             <span class="pull-left">
                        <h4 class="text-danger price-text m-l-lg">
                            <app-currency></app-currency>{{miscellaneousVolumeSnapshotList[0].costperGB }} <span>/GB/<fmt:message key="common.day" bundle="${msg}" /></span>
                        </h4>
                    </span>
				</div>
			</div>
		</div>
	</form>
</div>
<div data-ng-include src="'app/views/cloud/snapshot/download-snapshot.jsp'" data-ng-show="createSnapshot"></div>




