<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="row" data-ng-controller="snapshotListCtrl">
	<div class="col-md-12 col-sm-12">
		<div class="hpanel">
			<div class="panel-body">
				<div class="tab-content">
					<div class="row m-t-n-md">
						<ul class="nav nav-tabs"
							data-ng-init="formElements.category = 'VM Snapshot'">
							<li class="active"><a href="javascript:void(0)"
								data-ng-click="vmSnapshot(1);formElements.category = 'VM Snapshot'"
								data-toggle="tab"><fmt:message key="vm.snapshot"
										bundle="${msg}" /></a></li>
							<li class=""><a href="javascript:void(0)"
								data-ng-click="formElements.category = 'snapshot'"
								data-toggle="tab"><fmt:message key="common.volume.backup"
										bundle="${msg}" /></a></li>
						</ul>
					</div>
					<div class="tab-pane"
						data-ng-class="{'active' : formElements.category == 'snapshot'}"
						id="snapshot">
						<div class="row" data-ng-include
							src="'app/views/cloud/snapshot/snapshot.jsp'"></div>
					</div>
					<div class="tab-pane"
						data-ng-class="{'active' : formElements.category == 'VM Snapshot'}"
						id="vmSnapshot">
						<div class="row" data-ng-include
							src="'app/views/cloud/snapshot/vmSnapshot.jsp'"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
