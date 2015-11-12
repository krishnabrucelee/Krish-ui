<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Header -->
<ng-include id="header" src="global.getViewPageUrl('common/header.jsp')"></ng-include>

<!-- Navigation -->
<ng-include id="menu" src="global.getViewPageUrl('common/navigation.jsp')"></ng-include>

<!-- Main Wrapper -->
<div id="wrapper">

    <div class="content" >

        <div class="row">
            <div class="col-md-12">
                <div class="alert alert-danger">The billing owner of this project is overdue, please contact billing ownerï¼»amalï¼½at your convenience.</div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3 col-sm-6">
                <div class="panel widget dashbox-maincolor3">
                    <div class="row row-table">
                        <div class="col-xs-4 h-115 text-center dashboxdark-maincolor3 left-radious"><app-currency class="fa-4x"></app-currency></div>
                        <div class="col-xs-8 p-xs">
                            <div class="h3">150.00 </div>
                            <div>Current Month Cost</div>
                        </div>       
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="panel widget dashbox-maincolor2">
                    <div class="row row-table">
                        <div class="col-xs-4 h-115 text-center dashboxdark-maincolor2 left-radious"><app-currency class="fa-4x"></app-currency></div>
                        <div class="col-xs-8 p-xs">
                            <div class="h3">250.00 </div>
                            <div>Estimated Month Cost</div>
                        </div>       
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <a href="#/usage/report">
                    <div class="panel widget dashbox-maincolor1">
                        <div class="row row-table">
                            <div class="col-xs-4 h-115 text-center dashboxdark-maincolor1 left-radious"><app-currency class="fa-4x"></app-currency></div>
                            <div class="col-xs-8 p-xs">
                                <div class="h3"> 4000.00 </div>
                                <div>Last 12 Months Cost</div>
                            </div>       
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="panel widget panel-primary">
                    <div class="panel-heading">
                        Budget - Monthly
                    </div>
                    <div class="row row-table">
                        <div class="col-xs-12 p-xs">
                            <div class="">
                                <progressbar value="55" type="success" class="m-t-xs  full progress" max="100" type="success"><i><span count-to="20" duration="1" count-from="1"></span> 40/ 100</i></progressbar>
                                <!--<progressbar class="progress-striped active" animate="true" max="100" value="40" type="success"><i><span count-to="20" duration="1" count-from="1"></span> 40/ 100</i></progressbar>-->
                            </div>
                            <a href="#" class="text-info">Set Budget</a> |
                            <a href="#" class="text-info">Manage Alert</a>
                        </div>       
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-4">
                <div class="panel panel-white">

                    <div class="panel-body p-sm">
                        <div class="row">
                        <span class="pull-right p-xs">
                                <select class="form-control" data-ng-init="filters = criteria[6]" data-ng-model="filters" data-ng-change="filterBy()" data-ng-options="filters.name for filters in criteria" >
                            
                                </select>
                        </span>
                        </div>
                        <h5 class="no-margins text-primary">
                            Top 5 Projects by Cost in {{filters.value | lowercase}}
                        </h5>  
                        <div class="m-t-md">
                            
                            <table cellspacing="1" cellpadding="1" class="top-projects no-margins table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th class="col-md-3"><small>Project</small></th>

                                        <th class="col-md-3"><small class="pull-right">Cost (<app-currency></app-currency>)</small></th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                        <div class="slimScroll-220">
                               <div class="text-center m-t-xxxl" data-ng-show="showLoader">
                            <img src="images/loading-bars.svg" />
                        </div>
                        <div data-ng-hide="showLoader">
                            <table cellspacing="1" cellpadding="3" class="top-projects table table-bordered table-striped">
                                <tbody >
                                    <tr data-ng-repeat="project in projectList">
                                        <td  class="col-md-3">{{ project.name}}</td>
                                        <td  class="col-md-3">
                                            <label class="badge badge-info p-xxs font-bold pull-right">{{  567.035 - (($index + 1) * 32 ) | number:2}}</label>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        </div>

                    </div>
                </div>
            </div>
             <div class="col-md-4">
                <div class="panel panel-white">

                    <div class="panel-body p-sm">
                        <div class="row">
                        <span class="pull-right p-xs">
                                <select class="form-control" data-ng-init="filterapp = criteria[6]" data-ng-model="filterapp" data-ng-change="filterByApplication()" data-ng-options="filters.name for filters in criteria" >
                            
                                </select>
                        </span>
                        </div>
                        <h5 class="no-margins text-primary">
                            Top 5 Applications by Cost in {{filterapp.value | lowercase}}
                        </h5>  
                        <div class="m-t-md">
                            
                            <table cellspacing="1" cellpadding="1" class="top-projects no-margins table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th class="col-md-3"><small>Application</small></th>

                                        <th class="col-md-3"><small class="pull-right">Cost (<app-currency></app-currency>)</small></th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                        <div class="slimScroll-220">
                               <div class="text-center m-t-xxxl" data-ng-show="showAppLoader">
                            <img src="images/loading-bars.svg" />
                        </div>
                        <div data-ng-hide="showAppLoader">
                            <table cellspacing="1" cellpadding="3" class="top-projects table table-bordered table-striped">
                                <tbody >
                                    <tr data-ng-repeat="application in applicationList">
                                        <td  class="col-md-3">{{ application.name}}</td>
                                        <td  class="col-md-3">
                                            <label class="badge badge-info p-xxs font-bold pull-right">{{ 330 - (($index + 1) * 35.035) | number:2}}</label>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="panel panel-white">

                    <div class="panel-body p-sm">
                        <div class="row">
                        <span class="pull-right p-xs">
                                <select class="form-control" data-ng-init="filterdept = criteria[6]" data-ng-model="filterdept" data-ng-change="filterByDepartment()" data-ng-options="filters.name for filters in criteria" >
                            
                                </select>
                        </span>
                        </div>
                        <h5 class="no-margins text-primary">
                            Top 5 Departments by Cost in {{filterdept.value | lowercase}}
                        </h5>  
                        <div class="m-t-md">
                            
                            <table cellspacing="1" cellpadding="1" class="top-projects no-margins table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th class="col-md-3"><small>Department</small></th>

                                        <th class="col-md-3"><small class="pull-right">Cost (<app-currency></app-currency>)</small></th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                        <div class="slimScroll-220">
                               <div class="text-center m-t-xxxl" data-ng-show="showDeptLoader">
                            <img src="images/loading-bars.svg" />
                        </div>
                        <div data-ng-hide="showDeptLoader">
                            <table cellspacing="1" cellpadding="3" class="top-projects table table-bordered table-striped">
                                <tbody >
                                    <tr data-ng-repeat="department in departmentList">
                                        <td  class="col-md-3">{{ department.name}}</td>
                                        <td  class="col-md-3">
                                            <label class="badge badge-info p-xxs font-bold pull-right">{{ 430 - (($index + 1) * 54.035) | number:2}}</label>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        </div>

                    </div>
                </div>
            </div>
<!--            <div class="col-md-8">
                <div class="panel panel-white">
                    <div class="panel-body p-sm">
                        <div class="text-center m-t-xxxl" data-ng-show="showProjectLoader">
                            <img src="images/loading-bars.svg" />
                        </div>
                        <div data-ng-hide="showProjectLoader">
                            <div data-ng-hide="currentProject">
                                <h4 class="no-margins text-primary">Projects Cost (Current month)</h4>
                                <div class="row">
                                    <div class="col-md-1">
                                        <app-currency class="m-t-xxxl text-big pull-left"></app-currency>
                                    </div>
                                    <div class="col-md-10 m-t-md">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <span class="pull-right">
                                                    <select class="form-control" data-ng-model="currentProject" data-ng-change="getProjectDetails()" data-ng-options="project.name for project in projectList" >
                                                        <option value="">All Project</option>
                                                    </select>
                                                </span>
                                            </div>
                                        </div>
                                        <canvas barchart options="singleBarChartOptions" data="projectSummaryData" height="120"  responsive="true" ></canvas>
                                    </div>
                                </div>
                            </div>
                            <div data-ng-show="currentProject">
                                <h4 class="no-margins text-primary">Project daily consumption ({{ currentProject.name}}) </h4>
                                <div class="row">
                                    <div class="col-md-1">
                                        <app-currency class="m-t-xxxl text-big pull-left"></app-currency>
                                    </div>
                                    <div class="col-md-10 m-t-md">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <span class="pull-right">
                                                    <select class="form-control" data-ng-model="currentProject" data-ng-change="getProjectDetails()" data-ng-options="project.name for project in projectList" >
                                                        <option value="">All Project</option>
                                                    </select>
                                                </span>
                                            </div>
                                        </div>
                                        <canvas barchart options="singleBarChartOptions" data="dahboardSummaryData" height="120"  responsive="true" ></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>-->

        </div>

        <div class="row">

            <div class="col-md-4  col-sm-12">
                <div class="panel panel-white">

                    <div class="panel-body p-sm">
                        <h4 class="no-margins text-primary">
                            Projected cost by project
                        </h4>  
                        <div class="m-t-md">
                            <table cellspacing="1" cellpadding="1" class="projects-by-cost no-margins table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th class="col-md-3"><small>Project</small></th>
                                        <th class="col-md-3 text-center"><small >Current<br>(<app-currency></app-currency>)</small></th>
                                        <th class="col-md-3 text-center"  ><small>Last<br>(<app-currency></app-currency>)</small></th>
                                        <th class="col-md-3 text-center"><small>Projected<br>(<app-currency></app-currency>)</small></th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                        <div class="slimScroll-175">
                            <table cellspacing="1" cellpadding="1" class="projects-by-cost table table-bordered table-striped">
                                <tbody >
                                    <tr data-ng-repeat="project in projectList">
                                        <td  class="col-md-3">{{ project.name}}</td>
                                        <td  class="col-md-3">
                                            {{ ($index + 1) * 115 | number:2}}
                                        </td>
                                        <td class="col-md-3">
                                            {{ ($index + 1) * 115 | number:2}}
                                        </td>
                                        <td  class="col-md-3">
                                            <span class="text-danger font-extra-bold">{{ ($index + 2.5) * 115 | number:2}}</span>
                                        </td>
                                    </tr>
                                    <tr data-ng-repeat="project in projectList">
                                        <td>{{ project.name}}</td>
                                        <td>
                                            {{ ($index + 1) * 115 | number:2}}
                                        </td>
                                        <td>
                                            {{ ($index + 1) * 115 | number:2}}
                                        </td>
                                        <td>
                                            <span class="text-danger font-extra-bold">{{ ($index + 2.5) * 115 | number:2}}</span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-5 col-sm-12">
                <div class="panel panel-white">
                    <div class="panel-body p-sm">
                        <h4  class="no-margins text-primary">Support Tickets</h4>
                        <div class="m-t-md slimScroll">
                            <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
                                <tbody>
                                    <tr data-ng-repeat="ticket in ticketList">
                                        <td>
                                            <a href="#">
                                                <div class="col-md-3 col-sm-3">
                                                    Priority<br>
                                                    <span class="badge badge-danger p-xs m-t-sm" data-ng-show="ticket.priority == 'High'">{{ ticket.priority}}</span>
                                                    <span class="badge badge-warning p-xs m-t-sm" data-ng-show="ticket.priority == 'Medium'">{{ ticket.priority}}</span>
                                                    <span class="badge badge-success p-xs m-t-sm" data-ng-show="ticket.priority == 'Low'">{{ ticket.priority}}</span>
                                                </div>
                                                <div class="col-md-6  col-sm-6">
                                                    <h5 class="no-margins">{{ ticket.subject}}</h5>
                                                    <small>{{ ticket.description | limitTo:70}}..</small>
                                                </div>
                                                <div class="col-md-3  col-sm-3">
                                                    <span class="text-info font-bold">4h 20min before</span>
                                                </div>
                                            </a>
                                        </td>
                                    </tr>


                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>


            </div>

            <div class="col-md-3  col-sm-12">
                <div class="panel hblue panel-white">
                    <div class="panel-body list p-sm">
                        <h4 class="no-margins  text-primary">Latest Events - Projects</h4>

                        <!--<div class="list-item-container scroll-div h-100" ng-slimscroll>-->
                        <div class="table slimScroll m-t-sm">
                            <div class="list-item" data-ng-repeat="event in recentActivityList">
                                <!--<h5 class="no-margins font-bold text-color3">{{ event.description }}</h5>-->
                                <div class="row">
                                    <div class="col-md-3">
                                        <span class="badge badge-info event-date">
                                            <b>{{ $index + 26}}</b>Aug
                                        </span>
                                    </div>
                                    <div class="event-des text-primary col-md-9">
                                        <a href="#">{{ event.description}}</a>
                                    </div>
                                </div>
                                <!--<span class="badge badge-info"><small >{{ event.date}}</small></span>-->
                            </div>
                            <div class="list-item" data-ng-repeat="event in recentActivityList">
                                <!--<h5 class="no-margins font-bold text-color3">{{ event.description }}</h5>-->
                                <div class="row">
                                <div class="col-md-3">
                                    <span class="badge badge-info event-date">
                                        <b>{{ $index + 26}}</b>Aug
                                    </span>
                                </div>
                                <div class="event-des text-primary col-md-9">
                                    <a href="#">{{ event.description}}</a>
                                </div>
                                </div>
                                <!--<span class="badge badge-info"><small >{{ event.date}}</small></span>-->
                            </div>
                        </div>
                        <!--</div>-->
                    </div>
                </div>
            </div>
        </div>

    </div>
    
    <script type="text/javascript">
        $(document).ready(function() {
        $('.slimScroll').slimScroll();
                $('.slimScroll-175').slimScroll({
        height:'176px'
        });
                $('.slimScroll-220').slimScroll({
        height:'234px'
        });
        });
    </script>
    
