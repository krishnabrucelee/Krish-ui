<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="inmodal" >
    <div class="modal-header">
        <panda-modal-header page-title="{{activity.pageTitle}} <fmt:message key="common.description" bundle="${msg}" />" hide-zone="true"></panda-modal-header>

    </div>
    <div class="modal-body">
        <div data-ng-show="activity.category == 'events'">
            <div data-ng-include src="'app/views/activity/event-description.jsp'" ></div>
        </div>
        <div data-ng-hide="activity.category == 'events'">
            <div data-ng-include src="'app/views/activity/other-description.jsp'" ></div>
        </div>
    </div>
    <div class="modal-footer">

        <a class="btn btn-info"  data-ng-click="cancel()"><fmt:message key="common.close" bundle="${msg}" /></a>

    </div>
</div>

