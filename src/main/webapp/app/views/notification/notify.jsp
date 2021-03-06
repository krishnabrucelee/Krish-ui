<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="cg-notify-message homer-notify" ng-class="$classes">
    <div class="p-md">
    <div ng-show="!$messageTemplate">
		<span ng-bind-html="$message"></span>
    	<!--<fmt:message key="" bundle="${msg}" /> -->
    	<!--
    	<div data-ng-if="$message === 'common.added.successfully'" >
        	<fmt:message key="common.added.successfully" bundle="${msg}" />
        </div>
        <div data-ng-if="message === 'common.updated.successfully'" >
        	<fmt:message key="common.updated.successfully" bundle="${msg}" />
        </div>
        <div data-ng-if="message === 'common.deleted.successfully'" >
        	<fmt:message key="common.deleted.successfully" bundle="${msg}" />
        </div> -->
    </div>

    <div ng-show="$messageTemplate" class="cg-notify-message-template test-success-notify" id="success_notify">

    </div>

    <button type="button" class="cg-notify-close" ng-click="$close()">
        <span aria-hidden="true">&times;</span>
        <span class="cg-notify-sr-only">Close</span>
    </button>
    </div>

</div>

