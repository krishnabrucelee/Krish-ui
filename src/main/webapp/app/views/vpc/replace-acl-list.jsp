<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="inmodal" data-ng-contoller="vpcCtrl">
    <div class="modal-header">
        <panda-modal-header id="replace_vpc_acl_list_page_title" hide-zone="false" page-icon="fa fa-exchange" page-title="<fmt:message key="replace.acl.list" bundle="${msg}" />"></panda-modal-header>
    </div>

    <div class="modal-body">

        <div class="row">
							<label
								class="col-md-4 col-xs-12 col-sm-4 control-label control-normal"><fmt:message key="acl" bundle="${msg}" /></label>
							<div class="col-md-6  col-sm-6 col-xs-12">
								<select class="form-control input-group" id="replace_vpc_acl_list_acl" name="acl"
									data-ng-model="aclID"
									ng-options="acl.name for acl in aclList">
									<option value=""><fmt:message key="common.select"
											bundle="${msg}" /></option>
								</select> <i
									tooltip="<fmt:message key="choose.acl" bundle="${msg}" />"
									class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon"></i>

							</div>
		</div>

    </div>
    <div class="modal-footer">
        <get-loader-image data-ng-show="showLoader"></get-loader-image>

        <button type="button" id="replace_acl_cancel_button" data-ng-hide="showLoader" class="btn btn-default "  ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
        <button type="button" id="replace_acl_ok_button" data-ng-hide="showLoader" class="btn btn-info"   ng-click="ok(aclID)" data-dismiss="modal"><fmt:message key="common.replace" bundle="${msg}" /></button>

    </div>
</div>




