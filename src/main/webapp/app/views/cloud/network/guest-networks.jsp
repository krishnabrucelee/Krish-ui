<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div data-ng-contoller="networksCtrl">
<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
                    <thead>
                    <tr>
                        <th><fmt:message key="common.name" bundle="${msg}" /></th>
                        <th><fmt:message key="common.account" bundle="${msg}" /></th>
                        <th><fmt:message key="common.type" bundle="${msg}" /></th>
                        <th><fmt:message key="common.cidr" bundle="${msg}" /></th>
                        <th><fmt:message key="gateway" bundle="${msg}" /></th>
                        <th><fmt:message key="common.action" bundle="${msg}" /></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr data-ng-repeat="network in networkList | filter: quickSearch">
                        <td>
                            <a class="text-info" ui-sref="cloud.list-network.view-network({id: {{ network.id }}, view: 'view'})"  title="View Network" >{{ network.name }}</a>
                        </td>
                        <td>{{ network.department.userName}} </td>
                        <td>{{ network.networkType }} </td>
                        <td>{{ network.cIDR }} </td>
                        <td>{{ network.gateway}} </td>
                        <td>
                            <a class="icon-button" title="<fmt:message key="common.edit" bundle="${msg}" />" ui-sref="cloud.list-network.view-network({id: {{ network.id }}, view: 'edit'})" >
                             <span class="fa fa-edit m-r"> </span>
                             </a>
                            <a class="icon-button" title="<fmt:message key="common.restart" bundle="${msg}" /> "  ><span class="fa fa-rotate-left m-r"></span></a>
                            <a class="icon-button" title="<fmt:message key="common.delete" bundle="${msg}" /> " data-ng-click="delete('sm', network)" ><span class="fa fa-trash"></span></a>
                        </td>
                    </tr>
                    </tbody>
</table>
</div>