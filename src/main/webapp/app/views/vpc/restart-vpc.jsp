<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="inmodal" data-ng-contoller="vpcCtrl">
    <div class="modal-header">
        <panda-modal-header id="restart_vpc_page_title" hide-zone="false" page-icon="fa fa-warning" page-title="<fmt:message key="restart.vpc" bundle="${msg}" />"></panda-modal-header>
    </div>
    <div class="modal-body">
        <div class=" row">
            <div class="form-group has-error col-md-12 col-sm-12   m-t-md">
            <fmt:message key="confirmation.to.restart.vpc" bundle="${msg}" />.<br/>
            <fmt:message key="remark" bundle="${msg}" />: <fmt:message key="note.message.vpc" bundle="${msg}" />.
            </div>
        </div>
          <div class=" row">
            <div class="form-group  col-md-4 col-sm-4  col-xs-3">
                                 <fmt:message key="common.cleanup" bundle="${msg}" />
            </div>
            <div class="icheckbox_square-green form-group col-md-8 col-sm-8  col-xs-8 m-t-md">
						<input id="restart_vpc_clean_up" icheck type="checkbox" data-ng-model="cleanup">
             </div>
        </div>
        <div class=" row">
            <div class="form-group  col-md-4 col-sm-4  col-xs-3">
                                 <fmt:message key="make.redundant" bundle="${msg}" />
            </div>
            <div class="icheckbox_square-green form-group col-md-8 col-sm-8  col-xs-8 m-t-md">
						<input id="restart_vpc_make_redunt" icheck type="checkbox" data-ng-model="makeredunt">
             </div>
        </div>
    </div>
    <div class="modal-footer">
        <get-loader-image data-ng-show="showLoader"></get-loader-image>
        <button type="button" data-ng-hide="showLoader" class="btn btn-default" id="restart_vpc_cancel_button"  data-ng-click="cancel()" data-dismiss="modal"><fmt:message key="common.cancel" bundle="${msg}" /></button>
        <button type="button" data-ng-hide="showLoader" class="btn btn-info" id="restart_vpc_restart_button"   data-ng-click="ok(cleanup,makeredunt)" data-dismiss="modal"><fmt:message key="common.restart" bundle="${msg}" /></button>
    </div>
</div>




