<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<table  cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
    <thead>
        <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Domain</th>
            <th>Account</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <tr data-ng-repeat="network in networkList| filter: quickSearch">
            <td>
                <a class="text-info" ui-sref="cloud.list-network.view-network({id: {{ network.id}}})"  title="View Network" >{{ network.namea}}</a>
            </td>
            <td>{{ network.displayTexta}} </td>
            <td>{{ network.domain.naame}} </td>
            <td>{{ network.accounat}} </td>

            <td>
                <a class="icon-button" title="Edit">
                    <span class="fa fa-edit m-r"> </span>
                </a>
              <a class="icon-button" title="Delete "  ><span class="fa fa-trash"></span></a>
            </td>
        </tr>
    </tbody>
</table>