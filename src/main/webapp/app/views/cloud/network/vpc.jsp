<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
    <thead>
        <tr>
            <th><fmt:message key="common.name" bundle="${msg}" /></th>
            <th><fmt:message key="common.description" bundle="${msg}" /></th>
            <th><fmt:message key="common.zone" bundle="${msg}" /></th>
            <th><fmt:message key="common.cidr" bundle="${msg}" /></th>
            <th><fmt:message key="common.status" bundle="${msg}" /></th>
            <th><fmt:message key="common.action" bundle="${msg}" /></th>
        </tr>
    </thead>
    <tbody>
        <tr data-ng-repeat="network in networkList| filter: quickSearch">
            <td>
                <a class="text-info" ui-sref="cloud.list-network.view-network({id: {{ network.id}}})"  title="<fmt:message key="view.network" bundle="${msg}" />" >{{ network.name}}</a>
            </td>
            <td>{{ network.displayText}} </td>
            <td>{{ network.zone.name}} </td>
            <td>{{ network.cIDR}} </td>
            <td><label class="label label-success text-center text-white"> {{ network.status}} </label></td>

            <td>
                <a class="icon-button" title="<fmt:message key="common.edit" bundle="${msg}" />">
                    <span class="fa fa-edit m-r"> </span>
                </a>
                <a class="icon-button" title="<fmt:message key="common.delete" bundle="${msg}" />"  ><span class="fa fa-trash"></span></a>
            </td>
        </tr>
    </tbody>
</table>