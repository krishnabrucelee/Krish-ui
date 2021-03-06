<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12 ">
        <div class="pull-left">
            <div class="pull-left">
                <a title="<fmt:message key="grid.view" bundle="${msg}" />" class="btn btn-info" data-ng-click="listView = !listView"  data-ng-class="!listView ? 'disabled' : ''" > <i class="fa fa-th-large" /></a>
                <a title="<fmt:message key="list.view" bundle="${msg}" />"  class="btn btn-info" data-ng-click="listView = !listView" data-ng-class="listView ? 'disabled' : ''" > <i class="fa fa-list" /></a>
            </div>
        </div>
        <div class="pull-right">
            <panda-quick-search></panda-quick-search>
            <div class="clearfix"></div>

            <span class="pull-right m-l-sm m-t-sm">
                <a  class="btn btn-info" data-ng-click="uploadTemplateContainer()"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span> <fmt:message key="register.template" bundle="${msg}" /></a>

                <a  class="btn btn-info" title="<fmt:message key="common.refresh" bundle="${msg}" />"><span class="fa fa-refresh fa-lg "></span></a>
            </span>
        </div>
    </div>
    <div class="clearfix"></div>
</div>