<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
    <thead>
        <tr>
            <th class="col-md-3 col-xs-3"><fmt:message key="account" bundle="${msg}" /></th>
            <th class="col-md-2 col-xs-2"><fmt:message key="role" bundle="${msg}" /></th>
            <th class="col-md-3 col-xs-3"><fmt:message key="common.action" bundle="${msg}" /></th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><input  type="text" data-ng-model="account.name" class="form-control input-group " ></td>
            <td></td>
            <td>
                <img src="images/loading-bars.svg" data-ng-show="showLoader" width="30" height="30" />
                <a  data-ng-hide="showLoader" class="btn btn-info" data-ng-click="addAccount(account)" ><span class="pe-7s-plus pe-lg font-bold m-r-xs" ></span><fmt:message key="common.add" bundle="${msg}" /></a>
            </td>
        </tr>
    </tbody>
</table>
<table cellspacing="1" cellpadding="1" class="table table-bordered table-striped m-t-n-md" data-ng-show="projectAccountList.length > 0">

            <tbody>
               <tr ng-repeat="project in projectAccountList.slice().reverse()" class="font-bold text-center p-sm">
             	<td class="col-md-3 col-xs-3">{{ project.name }}</td>
		<td class="col-md-2 col-xs-2">{{ project.role.name }}</td>
                <td class="col-md-3 col-xs-3">
                    <span data-ng-show="projectAccountList.length-1 != $index">
                        <a class="icon-button" title="Remove account from the project" data-ng-click="deleteAccount($index)">
                            <span data-ng-show="removeLoader['index_'+$index]" class="m-r-xl" ><img src="images/loading-bars.svg"  width="30" height="30" /></span>
                            <span data-ng-hide="removeLoader['index_'+$index]" class="fa fa-trash"></span>
                        </a>
                        <a class="icon-button" title="Make account project owner"  data-ng-click="makeOwner($index)">
                            <span data-ng-show="ownerLoader['index_'+$index]"><img src="images/loading-bars.svg" width="30" height="30" /></span>
                            <span data-ng-hide="ownerLoader['index_'+$index]" class="fa fa-user-md"></span>
                        </a>
                    </span>
                </td>
	        </tr>
<!--            deleteRules(rule.id,'Egress')-->
            </tbody>
    </table>
