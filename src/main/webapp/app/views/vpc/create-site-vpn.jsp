<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="inmodal" data-ng-contoller="vpcCtrl">
    <div class="modal-header">
        <panda-modal-header id="delete_vpc_page_title" hide-zone="false" page-icon="fa fa-check-square" page-title="common.confirmation"></panda-modal-header>
    </div>

    <div class="modal-body">
        <div class=" row">
        <div class="form-group has-error col-md-2 col-sm-2  col-xs-2">

            </div>
            <div class="form-group col-md-10 col-sm-10  col-xs-10">
                <p >Please confirm that you would like to create a site-to-site VPN gateway for this VPC. </p>
            </div>


        </div>

    </div>
    <div class="modal-footer">
        <get-loader-image data-ng-show="showLoader"></get-loader-image>

        <button type="button" id="delete_vpc_cancel_button" data-ng-hide="showLoader" class="btn btn-default "  ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
        <button type="button" id="delete_vpc_ok_button" data-ng-hide="showLoader" class="btn btn-info"   ng-click="ok()" data-dismiss="modal"><fmt:message key="common.ok" bundle="${msg}" /></button>

    </div>
</div>




