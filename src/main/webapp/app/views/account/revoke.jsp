<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="inmodal" data-ng-contoller="accountListCtrl">
    <div class="modal-header">
        <panda-modal-header hide-zone="false" id="disable_user_page_title" page-icon="fa fa-user-secret" page-title="<fmt:message key="disable.user" bundle="${msg}" />"></panda-modal-header>
    </div>

    <div class="modal-body">
        <div class=" row">
            <div class="form-group has-error col-md-3 col-sm-3  col-xs-3">

                <img src="images/warning.png" alt="">
            </div>
            <div class="form-group has-error col-md-9 col-sm-9  col-xs-9 m-t-md">
                <p ><fmt:message key="disable.message" bundle="${msg}" /> </p>
            </div>


        </div>

    </div>
    <div class="modal-footer">
        <get-loader-image data-ng-show="showLoader"></get-loader-image>

        <button type="button" id="disable_user_cancel_button" data-ng-hide="showLoader" class="btn btn-default "  ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
        <button type="button" id="disable_user_ok_button" data-ng-hide="showLoader" class="btn btn-info"   ng-click="ok(user)" data-dismiss="modal"><fmt:message key="common.disable" bundle="${msg}" /></button>

    </div>
</div>



























