<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<div ui-view >

    <div data-ng-hide="viewContent" ng-controller="instanceListCtrl">
        <div class="hpanel">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12 ">
                        <div class="pull-left">
                            <div class="dashboard-box pull-left">
                                <span class="pull-right"><fmt:message key="total.instance" bundle="${msg}" /></span>
                                <div class="clearfix"></div>
                                <span class="pull-left m-t-xs"><img src="images/instance-icon.png"></span>
                                <b class="pull-right">{{instanceList.length}}</b>
                                <div class="clearfix"></div>
                            </div>
                            <div class="dashboard-box pull-left">
                                <span class="pull-right"><fmt:message key="running.instance" bundle="${msg}" /></span>
                                <div class="clearfix"></div>
                                <span class="pull-left m-t-xs"><img src="images/instance-icon.png"></span>
                                <b class="pull-right">{{instancesList.Count}}</b>
                                <div class="clearfix"></div>
                            </div>
                            <div class="dashboard-box pull-left">
                                <span class="pull-right"><fmt:message key="stopped.instance" bundle="${msg}" /></span>
                                <div class="clearfix"></div>
                                <span class="pull-left m-t-xs"><img src="images/instance-icon.png"></span>
                                <b class="pull-right">{{instanceList.length - instancesList.Count}}</b>
                                <div class="clearfix"></div>
                            </div>
                        </div>

                        <div class="pull-right">
                            <panda-quick-search></panda-quick-search>
                            <div class="clearfix"></div>
                            <span class="pull-right m-l-sm m-t-sm">
                                <a class="btn btn-info" data-ng-click="openAddInstance('lg')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span><fmt:message key="create.vm" bundle="${msg}" /></a>
                                <a class="btn btn-info" ui-sref="cloud.list-instance" title="<fmt:message key="common.refresh" bundle="${msg}" />"  ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
                            </span>
                        </div>

                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12 ">
                 <pagination-content></pagination-content>
                    <div class="white-content">
                        <div class="table-responsive">
                            <table  cellspacing="1" cellpadding="1" class="table dataTable table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th  ng-click="changeSorting('name')" data-ng-class="sort.descending && sort.column =='name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="instance.name" bundle="${msg}" /></th>
                                        <th ng-click="changeSorting('owner')" data-ng-class="sort.descending && sort.column =='owner'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="owner" bundle="${msg}" /> </th>
                                        <th ng-click="changeSorting('application')" data-ng-class="sort.descending && sort.column =='application'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.application" bundle="${msg}" /> </th>
                                        <th ng-click="changeSorting('project')" data-ng-class="sort.descending && sort.column =='project'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.project" bundle="${msg}" /></th>
                                        <th ng-click="changeSorting('department')" class="w-10" data-ng-class="sort.descending && sort.column =='department'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.department" bundle="${msg}" /> </th>
                                        <th ng-click="changeSorting('ostype')" data-ng-class="sort.descending && sort.column =='ostype'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.osType" bundle="${msg}" /></th>
                                       <%--  <th ng-click="changeSorting('template.name')" data-ng-class="sort.descending && sort.column =='template.name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.template" bundle="${msg}" /> </th> --%>
                                        <th ng-click="changeSorting('ip')" data-ng-class="sort.descending && sort.column =='ip'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.ip" bundle="${msg}" /></th>
                                        <th ng-click="changeSorting('networkList[0].name')" data-ng-class="sort.descending && sort.column =='networkList[0].name'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.network" bundle="${msg}" /></th>
                                        <th ng-click="changeSorting('host')" data-ng-class="sort.descending && sort.column =='host'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.host" bundle="${msg}" /></th>
                                        <th ng-click="changeSorting('state')" class="col-md-1" data-ng-class="sort.descending && sort.column =='state'? 'sorting_desc' : 'sorting_asc' " ><fmt:message key="common.state" bundle="${msg}" /></th>
                                        <th class="w-sm"><fmt:message key="common.action" bundle="${msg}" /></th>
<!--                                        <th  ng-click="changeSorting('name')" >Name <span class="pull-right" data-ng-class="sort.descending && sort.column =='name'? 'pe-7s-angle-up-circle' : 'pe-7s-angle-down-circle' "></span></th>
                                        <th ng-click="changeSorting('owner')">Owner <span class="pull-right" data-ng-class="sort.descending && sort.column =='owner'? 'pe-7s-angle-up-circle' : 'pe-7s-angle-down-circle' "></span></th>
                                        <th ng-click="changeSorting('application')">Application <span class="pull-right" data-ng-class="sort.descending&& sort.column =='application' ? 'pe-7s-angle-up-circle' : 'pe-7s-angle-down-circle' "></span></th>
                                        <th ng-click="changeSorting('project')">Project <span class="pull-right" data-ng-class="sort.descending && sort.column =='project' ? 'pe-7s-angle-up-circle' : 'pe-7s-angle-down-circle' "></span></th>
                                        <th ng-click="changeSorting('department')" class="w-10">Department <span class="pull-right" data-ng-class="sort.descending && sort.column =='department' ? 'pe-7s-angle-up-circle' : 'pe-7s-angle-down-circle' "></span></th>
                                        <th ng-click="changeSorting('ostype')">OS Type <span class="pull-right" data-ng-class="sort.descending && sort.column =='ostype' ? 'pe-7s-angle-up-circle' : 'pe-7s-angle-down-circle' "></span></th>
                                        <th ng-click="changeSorting('template.name')">Template <span class="pull-right" data-ng-class="sort.descending && sort.column =='template.name' ? 'pe-7s-angle-up-circle' : 'pe-7s-angle-down-circle' "></span></th>
                                        <th ng-click="changeSorting('ip')">IP <span class="pull-right" data-ng-class="sort.descending && sort.column =='ip' ? 'pe-7s-angle-up-circle' : 'pe-7s-angle-down-circle' "></span></th>
                                        <th ng-click="changeSorting('networkList[0].name')">Network <span class="pull-right" data-ng-class="sort.descending && sort.column =='networkList[0].name'? 'pe-7s-angle-up-circle' : 'pe-7s-angle-down-circle' "></span></th>
                                        <th ng-click="changeSorting('state')" class="col-md-1">State<span class="pull-right" data-ng-class="sort.descending && sort.column =='state' ? 'pe-7s-angle-up-circle' : 'pe-7s-angle-down-circle' "></span></th>
                                        <th class="w-sm">Action</th>-->
                                    </tr>
                                </thead>
                                <tbody>
                                   <tr data-ng-repeat="instance in instanceList | filter: quickSearch  |orderBy:sort.column:sort.descending"   >
                                        <td>
                                            <a class="text-info" ui-sref="cloud.list-instance.view-instance({id: {{ instance.id}}})"  title="View Instance" >{{ instance.name}}</a>
                                        </td>
                                        <td>{{ instance.instanceOwner.userName}}</td>
                                        <td>{{ instance.application}}</td>
                                        <td>{{ instance.project.name}}</td>
                                        <td>{{ instance.department.userName}}</td>
<!--                                         <td>{{ instance.template.displayText}}</td> -->
 										<td>{{ instance.template.osType.description}}</td>
                                        <td>{{ instance.ipAddress}}</td>
                                        <td>{{ instance.network.name}}</td>
                                        <td>{{ instance.host.name}}</td>
                                        <td>
                                            <label class="label label-success" data-ng-if="instance.status == 'Running'">{{ instance.status}}</label>
                                            <label class="label label-danger" data-ng-if="instance.status == 'Stopped'">{{ instance.status}}</label>
                                            <label class="label label-primary" data-ng-if="instance.status == 'Starting'">{{ instance.status}}</label>
                                            <label class="label label-danger" data-ng-if="instance.status == 'Error'">{{ instance.status}}</label>
					    					<label class="label label-danger" data-ng-if="instance.status == 'Stopping'">{{ instance.status}}</label>
                                            <label class="label label-danger" data-ng-if="instance.status == 'Expunging'">{{ instance.status}}</label>
                                            <label class="label label-danger" data-ng-if="instance.status == 'Destroyed'">{{ instance.status}}</label>

                                        </td>
                                        <td>

						<div data-ng-show="instance.status != 'Error' && instance.status != 'Expunging'">
                                            <a class="icon-button text-center" title="<fmt:message key="start" bundle="${msg}" />"  data-ng-click="startVm('sm',instance)" data-ng-hide="instance.status == 'Running'">
                                                <span class="fa fa-play" ></span>
                                            </a>
                                            <a class="icon-button text-center"  data-ng-click="stopVm('sm',instance)" title="<fmt:message key="stop" bundle="${msg}" />" data-ng-show="instance.status  == 'Running'">
                                                <span class="fa fa-ban" ></span>
                                            </a>
                                            <a class="icon-button text-center" data-ng-if="instance.status == 'Running'" title="<fmt:message key="restart" bundle="${msg}" />" data-ng-click="rebootVm('sm',instance)"  ><span class="fa fa-rotate-left"></span></a>
                                            <a data-ng-click="showConsole(instance)" class="icon-button text-center" title="<fmt:message key="view.console" bundle="${msg}" />"><span class="fa-desktop fa m-xs"></span></a>
                                            <a class="icon-button text-center" title="<fmt:message key="display.note" bundle="${msg}" />" data-ng-click="showDescription(instance)"><span class="fa-file-text fa"></span></a>
						</div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>

                            </div>
                    </div>
                     <pagination-content></pagination-content>
                </div>
            </div>
        </div>
    </div>
</div>
