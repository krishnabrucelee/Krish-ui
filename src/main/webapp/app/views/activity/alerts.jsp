<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

                    <span class="pull-right m-l-sm m-t-sm">
                        <!-- <span data-ng-hide="activity.oneItemSelected.alerts">
                            <a class="btn btn-info" data-ng-click="archiveGlobal()"><span class="fa fa-file-archive-o"></span> Archive Alerts</a>
                            <a class="btn btn-info" data-ng-click="deleteGlobal()"><span class="fa fa-trash"></span> Delete Alerts</a>
                        </span>
                        <span data-ng-show="activity.oneItemSelected.alerts">
                            <a class="btn btn-info" data-ng-click="archive()"><span class="fa fa-file-archive-o"></span> Archive Alerts</a>
                            <a class="btn btn-info" data-ng-click="delete()"><span class="fa fa-trash"></span> Delete Alerts</a>
                        </span> -->
                        <a class="btn btn-info" data-ng-click="getActivityByCategory('alerts',1)" title="<fmt:message key="common.refresh" bundle="${msg}" />" ><span class="fa fa-refresh fa-lg "></span></a>
                    </span>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>

    </div>

    <div class="white-content">
        <div class="table-responsive">
            <table cellspacing="1" cellpadding="1" class="table  table-hover table-striped table-mailbox table-bordered ">
                 <thead>
                    <tr>
                        <th><div class="checkbox checkbox-single checkbox-info">
                              <input type="checkbox" data-ng-model="activity.selectedAll.alerts" data-ng-click="checkAll();">
                                <label></label>
                            </div>
                        </th>
                        <th><fmt:message key="common.description" bundle="${msg}" /></th>
                        <th><fmt:message key="common.type" bundle="${msg}" /></th>
                        <th><fmt:message key="common.date" bundle="${msg}" /></th>
                        <th><fmt:message key="action" bundle="${msg}" /></th>
                    </tr>
                    </thead>
                     <tbody data-ng-hide="activityList.length > 0">
                                    <tr>
                                        <td colspan="10"><fmt:message key="common.no.records.found" bundle="${msg}" />!!</td>
                                    </tr>
                </tbody>
                    <tbody data-ng-show="activityList.length > 0">

                    <tr data-ng-repeat="alert in activityList | filter: quickSearch">
                        <td class="">
                            <div class="checkbox checkbox-single checkbox-info">
                                  <input type="checkbox" data-ng-model="alert.isSelected" data-ng-click="checkOne(alert)">
                                <label></label>
                            </div>
                        </td>
                        <td><a data-ng-click="showDescription(alert)">{{ alert.message }}</a></td>
                        <td>{{ alert.event }}</td>
                        <td>{{ alert.eventDateTime * 1000  | date:'yyyy-MM-dd HH:mm:ss' }}</td>
                         <td>
                           <a class="icon-button" data-ng-click="archive()" title="<fmt:message key="archive" bundle="${msg}" />"><span class="fa fa-file-archive-o"></span></a>
                            <a class="icon-button"   data-ng-click="delete()"title="<fmt:message key="common.delete" bundle="${msg}" />"><span class="fa fa-trash"></span></a>
                        </td>
                    </tr>

                </tbody>
            </table>
            </div>
    </div>
     <pagination-content></pagination-content>
</div>
