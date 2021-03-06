<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="hpanel" >
    <div class="panel-heading">

        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12 ">
                <div class="pull-left">
                    <div class="pull-left">

                    </div>
                </div>
                <div class="pull-right">
                    <!-- <panda-quick-search></panda-quick-search>
                    <div class="clearfix"></div> -->
<!--
                    <span class="pull-right m-l-sm m-t-sm">
                        <span data-ng-hide="activity.oneItemSelected.notifications">
                            <a class="btn btn-info" data-ng-click="archiveGlobal()"><span class="fa fa-file-archive-o"></span> Archive Notifications</a>
                            <a class="btn btn-info" data-ng-click="deleteGlobal()"><span class="fa fa-trash"></span> Delete Notifications</a>
                        </span>
                        <span data-ng-show="activity.oneItemSelected.notifications">
                            <a class="btn btn-info" data-ng-click="archive()"><span class="fa fa-file-archive-o"></span> Archive Notifications</a>
                            <a class="btn btn-info" data-ng-click="delete()"><span class="fa fa-trash"></span> Delete Notifications</a>
                        </span>
                        <a class="btn btn-info" title="Refresh" ><span class="fa fa-refresh fa-lg "></span></a>
                    </span> -->
                </div>
            </div>
            <div class="clearfix"></div>
        </div>


    </div>

    <div class="white-content">
        <div class="table-responsive">
            <table cellspacing="1" cellpadding="1" class="table   table-striped table-mailbox table-bordered ">
                <thead>
                    <tr>
                        <th><div class="checkbox checkbox-single checkbox-info">
                    <input type="checkbox" data-ng-model="activity.selectedAll.notifications" data-ng-click="checkAll();">
                    <label></label>
                </div>
                </th>
                <th><fmt:message key="common.description" bundle="${msg}" /></th>
                <th><fmt:message key="common.type" bundle="${msg}" /></th>
                <th><fmt:message key="common.date" bundle="${msg}" /></th>
                <th><fmt:message key="action" bundle="${msg}" /></th>
                </tr>
                </thead>
                <tbody data-ng-hide="activityListt.length > 0">
                                    <tr>
                                        <td colspan="10"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
                                    </tr>
                </tbody>
                <tbody data-ng-show="activityListt.length > 0">

                    <tr data-ng-repeat="notification in activityListt| filter: quickSearch">
                        <td class="">
                            <div class="checkbox checkbox-single checkbox-info">
                                <input type="checkbox" data-ng-model="notification.isSelected" data-ng-click="checkOne(notification)">
                                <label></label>
                            </div>
                        </td>
                        <td><a data-ng-click="showDescription(notification)">{{ notification.description}}</a></td>
                        <td>{{ notification.type}}</td>
                        <td>{{ notification.date}}</td>
                        <td>
                            <a class="icon-button" data-ng-click="archive()" title="<fmt:message key="archive" bundle="${msg}" />"><span class="fa fa-file-archive-o"></span></a>
                            <a class="icon-button"   data-ng-click="delete()"title="<fmt:message key="common.delete" bundle="${msg}" />"><span class="fa fa-trash"></span></a>
                        </td>
                    </tr>

                </tbody>
            </table>
        </div>
    </div>
</div>
