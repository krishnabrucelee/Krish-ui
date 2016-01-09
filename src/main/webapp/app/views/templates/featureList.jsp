<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <div class="row">

        <div class="col-md-12 col-sm-12" >
            <div class="hpanel">
                <div class="panel-heading">
            </div>

                <div class="white-content">
                    <div class="table-responsive">
                        <table cellspacing="1" cellpadding="1" class="table table-bordered dataTable table-striped table-hover table-mailbox">
                            <thead>
                                <tr>

                            <th class="col-md-2 col-sm-2"  data-ng-click="changeSorting('name')" data-ng-class="sort.descending && sort.column =='name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.name" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSorting('size')" data-ng-class="sort.descending && sort.column =='size'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.size" bundle="${msg}" />(<fmt:message key="common.gb" bundle="${msg}" />)</th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSorting('status')" data-ng-class="sort.descending && sort.column =='status'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="dynamically.scalable" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSorting('owner')" data-ng-class="sort.descending && sort.column =='owner'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.status" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSorting('createdDateTime')" data-ng-class="sort.descending && sort.column =='createdDateTime'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="template.owner" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSorting('format')" data-ng-class="sort.descending && sort.column =='format'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="register.date" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSorting('hvm')" data-ng-class="sort.descending && sort.column =='hvm'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.format" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSorting('passwordEnabled')" data-ng-class="sort.descending && sort.column =='passwordEnabled'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.hvm" bundle="${msg}" /></th>
                            <th class="col-md-1 col-sm-1"  data-ng-click="changeSorting('dynamicallyScalable')" data-ng-class="sort.descending && sort.column =='dynamicallyScalable'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="password.enabled" bundle="${msg}" /></th>
							<th class="col-md-1 col-sm-1"><fmt:message key="common.action" bundle="${msg}" /></th>
                            
                            </tr>
                            </thead>
                            <tbody>
                                <tr data-ng-if="template.share && template.featured" data-ng-repeat="template in filteredCount = (template.templateList| filter:quickSearch | orderBy:sort.column:sort.descending)">
                                    <td>
                                        <a data-ng-click="showDescription(template)">
                                           <img data-ng-show="template.osCategory.name.indexOf('windows') > -1" src="images/os/windows_logo.png" alt="" height="35" width="35" class="m-r-5" >
                       					   <img data-ng-show="template.osCategory.name.indexOf('CentOS') > -1" src="images/os/centos_logo.png" alt="" height="35" width="35" class="m-r-5" > {{ template.name }}
                                        </a>
                                    </td>
                                    <td>{{ template.size / global.Math.pow(2, 30)}}</td> 
                                    <td>{{ template.status }}</td>
                                    <td>{{ template.owner|| " - " }}</td>
                                    <td>{{ template.createdDateTime *1000 | date:'yyyy-MM-dd HH:mm:ss'}}</td>
                                    <td>{{ template.format }}</td>
                                    <td>{{ template.hvm || " - "}}</td>
                                    <td>{{ (template.passwordEnabled) ? "Yes" : "No"}}</td>
                                    <td>{{ (template.dynamicallyScalable) ? "Yes" : "No" }}</td>
                                    <td>
                                        <button title="Launch" class="btn btn-info btn-sm pull-right"><i class="fa fa-power-off"></i> <fmt:message key="common.launch" bundle="${msg}" /></button>
                                    </td>

                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
