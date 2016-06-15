<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="cg-notify-message event-notify-message homer-notify" ng-class="$classes">
    <div class="p-xs">
    <div ng-show="!$messageTemplate">
		<a data-ng-click="showDescriptions()" ng-bind-html="$message"></a>
    </div>
    <div ng-show="$messageTemplate" class="cg-notify-message-template test-success-notify" id="success_notify">

    </div>

    <button type="button" class="cg-notify-close" ng-click="$close();listEvent()">
        <span aria-hidden="true">&times;</span>
        <span class="cg-notify-sr-only">Close</span>
    </button>
     <button type="button" class="cg-notify-close m-r-md" ng-click="deleteEvent();$close()">
        <span aria-hidden="true"><span class="fa fa-trash"></span></span>
        <span class="cg-notify-sr-only">Delete</span>
    </button>
    </div>

</div>