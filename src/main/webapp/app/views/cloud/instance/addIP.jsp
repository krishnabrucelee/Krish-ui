<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<form name="nicForm" data-ng-submit="saveIP(nicForm, nic)" method="post" novalidate="">

	<div class="inmodal">
		<div class="modal-header">
			<panda-modal-header page-icon="fa fa-plus-circle"
				page-title="<fmt:message key="acquire.new.secondary.ip" bundle="${msg}" />"></panda-modal-header>
		</div>

		<div class="modal-body">
			<div class="row" >
            	<div class="col-md-12 col-sm-12 pull-left m-b-sm">
                    <label><fmt:message key="note" bundle="${msg}" />:</label>
                     <div><fmt:message key="common.nicIP.note" bundle="${msg}" />.</div>
                </div>
            </div>
			<div class="row">
				<div class="col-md-12">
					<div class="form-group">
						<div class="row">
							<label class="col-md-3 col-xs-12 col-sm-3 control-label"><fmt:message key="ip.address" bundle="${msg}" /></label>
							<div class="col-md-6 col-xs-12 col-sm-6">
								<input  type="text" name="vmIpAddress" data-ng-model="nic.vmIpAddress" class="form-control">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="modal-footer">
			<get-loader-image data-ng-if="showLoader"></get-loader-image>
			<button type="button" data-ng-if="!showLoader" class="btn btn-default " ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
			<button class="btn btn-info"  data-ng-if="!showLoader" type="submit"><fmt:message key="common.add" bundle="${msg}" /></button>
		</div>
	</div>
</form>

