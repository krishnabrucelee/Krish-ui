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
                <div class="alert alert-danger no-border-radious">This system will go for maintenance on May 1st</div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-5">
                <div class="panel panel-white no-border-radious">
                    <div class="panel-body p-sm">
                        <h5 class="no-margins text-primary">
                            Infrastructure
                        </h5>
                        <div class="row">
            				<div class="col-md-4 col-sm-4 col-xs-6">
            					<div class="quick-view-details running-vm">
            						<div class="quick-view-icon pull-right"></div>
            						<div class="quick-view-count pull-right">09</div>
            					</div>
            					<div class="quick-view-title text-center">Running VM</div>
            				</div>
            				<div class="col-md-4 col-sm-4 col-xs-6">
            					<div class="quick-view-details stopped-vm">
            						<div class="quick-view-icon pull-right"></div>
            						<div class="quick-view-count pull-right">06</div>
            					</div>
            					<div class="quick-view-title text-center">Stopped VM</div>
            				</div>
            				<div class="col-md-4 col-sm-4 col-xs-6">
            					<div class="quick-view-details total-vm">
            						<div class="quick-view-icon pull-right"></div>
            						<div class="quick-view-count pull-right">15</div>
            					</div>
            					<div class="quick-view-title text-center">Total VM</div>
            				</div>
            				<div class="col-md-4 col-sm-4 col-xs-6">
            					<div class="quick-view-details vcpu">
            						<div class="quick-view-icon pull-right"></div>
            						<div class="quick-view-count pull-right">03</div>
            					</div>
            					<div class="quick-view-title text-center">vCpu</div>
            				</div>
            				<div class="col-md-4 col-sm-4 col-xs-6">
            					<div class="quick-view-details vcpu">
            						<div class="quick-view-icon pull-right"></div>
            						<div class="quick-view-count pull-right">15<small>(GB)</small></div>
            					</div>
            					<div class="quick-view-title text-center">RAM</div>
            				</div>
            				<div class="col-md-4 col-sm-4 col-xs-6">
            					<div class="quick-view-details vcpu">
            						<div class="quick-view-icon pull-right"></div>
            						<div class="quick-view-count pull-right">18<small>(GB)</small></div>
            					</div>
            					<div class="quick-view-title text-center">Storage Allocation</div>
            				</div>
            				<div class="col-md-4 col-sm-4 col-xs-6">
            					<div class="quick-view-details networks">
            						<div class="quick-view-icon pull-right"></div>
            						<div class="quick-view-count pull-right">12</div>
            					</div>
            					<div class="quick-view-title text-center">Public IP</div>
            				</div>
            				<div class="col-md-4 col-sm-4 col-xs-6">
            					<div class="quick-view-details networks">
            						<div class="quick-view-icon pull-right"></div>
            						<div class="quick-view-count pull-right">04</div>
            					</div>
            					<div class="quick-view-title text-center">Networks</div>
            				</div>
            				<div class="col-md-4 col-sm-4 col-xs-6">
            					<div class="quick-view-details private-template">
            						<div class="quick-view-icon pull-right"></div>
            						<div class="quick-view-count pull-right">07</div>
            					</div>
            					<div class="quick-view-title text-center">Private Template</div>
            				</div>
           				</div>
                    </div>
                </div>
            </div>
            <div class="col-md-7">
                <div class="panel panel-white no-border-radious">
                    <div class="panel-body p-sm">
                        <h5 class="no-margins text-primary">
                            Quota
                        </h5>
                        <div class="row dashboard-quota-area" ng-controller="appCtrl">
            				<div class="col-md-3 col-sm-4 col-xs-6 dashboard-quota">
            					<div class="doughnutchart-value">42%</div>
            					<canvas doughnutchart options="doughnutOptions" data="doughnutData1" height="140" responsive=true></canvas>
            					vCpu<span>Using 4 of 10</span>
            				</div>
            				<div class="col-md-3 col-sm-4 col-xs-6 dashboard-quota">
            					<div class="doughnutchart-value">73%</div>
            					<canvas doughnutchart options="doughnutOptions" data="doughnutData2" height="140" responsive=true></canvas>
            					Memory<span>Using 730 of 1000</span>
            				</div>
            				<div class="col-md-3 col-sm-4 col-xs-6 dashboard-quota">
            					<div class="doughnutchart-value">22%</div>
            					<canvas doughnutchart options="doughnutOptions" data="doughnutData3" height="140" responsive=true></canvas>
            					Volume<span>Using 2 of 10</span>
            				</div>
            				<div class="col-md-3 col-sm-4 col-xs-6 dashboard-quota">
            					<div class="doughnutchart-value">88%</div>
            					<canvas doughnutchart options="doughnutOptions" data="doughnutData4" height="140" responsive=true></canvas>
            					Network<span>Using 8 of 10</span>
            				</div>
            				<div class="col-md-3 col-sm-4 col-xs-6 dashboard-quota">
            					<div class="doughnutchart-value">88%</div>
            					<canvas doughnutchart options="doughnutOptions" data="doughnutData4" height="140" responsive=true></canvas>
            					IP Address<span>Using 8 of 10</span>
            				</div>
            				<div class="col-md-3 col-sm-4 col-xs-6 dashboard-quota">
            					<div class="doughnutchart-value">73%</div>
            					<canvas doughnutchart options="doughnutOptions" data="doughnutData2" height="140" responsive=true></canvas>
            					Primary Storage<span>Using 73 of 100</span>
            				</div>
            				<div class="col-md-3 col-sm-4 col-xs-6 dashboard-quota">
            					<div class="doughnutchart-value">22%</div>
            					<canvas doughnutchart options="doughnutOptions" data="doughnutData3" height="140" responsive=true></canvas>
            					Secondary Storage<span>Using 22 of 100</span>
            				</div>
            				<div class="col-md-3 col-sm-4 col-xs-6 dashboard-quota">
            					<div class="doughnutchart-value">42%</div>
            					<canvas doughnutchart options="doughnutOptions" data="doughnutData1" height="140" responsive=true></canvas>
            					Snapshots<span>Using 4 of 10</span>
            				</div>
           				</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <div class="panel panel-white no-border-radious dashboard-tab">
                    <div class="panel-body p-sm">
						<tabset>
			                <tab>
			                    <tab-heading>
			                        Department
			                    </tab-heading>
			                    <div class="panel-body">
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
			                        <div class="slimScroll-175">
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
			                </tab>
			                <tab>
			                    <tab-heading>
			                        Project
			                    </tab-heading>
			                    <div class="panel-body">
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
			                        <div class="slimScroll-175">
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
			                </tab>
			                <tab>
			                    <tab-heading>
			                        Application
			                    </tab-heading>
			                    <div class="panel-body">
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
			                        <div class="slimScroll-175">
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
			                </tab>
			            </tabset>
                    </div>
                </div>
            </div>
            <div class="col-md-8">
                <div class="panel panel-white no-border-radious">
                    <div class="panel-body p-sm">
                        <h5 class="no-margins text-primary">
                            Cost ny Month
                        </h5>
                        <p>
                        	<img src="images/sample-graph.jpg" />
                        </p>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
        	<div class="col-md-12">
        		<div class="panel panel-white no-border-radious dashboard-accordian">
                    <div class="panel-body">
                    	<div class="col-md-3 no-padding">
                    		<div class="user-service-first-level slimScroll-220">
                    			<ul>
                    				<li><a href="javascript:void(0)">Department <span class="fa  fa-chevron-right pull-right"></span></a></li>
                    				<li><a href="javascript:void(0)">Application <span class="fa  fa-chevron-right pull-right"></span></a></li>
                    				<li><a href="javascript:void(0)">Users <span class="fa  fa-chevron-right pull-right"></span></a></li>
                    			</ul>
                    		</div>
                    	</div>
                    	<div class="col-md-3 no-padding">
                    		<div class="select-any">
                   				<span class="fa fa-hand-o-left fa-3x"></span>
                    			<br> Select any <br> service or user
                    		</div>
                    		<div class="user-service-second-level slimScroll-220">
                    			<div>
                    				<ul>
	                    				<li><a >Department 1 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a >Department 2 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">Department 3 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">Department 4 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">Department 5 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">Department 6 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">Department 7 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">Department 8 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">Department 9 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    			</ul>
                    			</div>
                    			<div class="user-service-list">
                    				<ul>
	                    				<li><a  href="javascript:void(0)">Application 1 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">Application 2 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">Application 3 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">Application 4 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">Application 5 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">Application 6 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">Application 7 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">Application 8 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">Application 9 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    			</ul>
                    			</div>
                    			<div class="user-service-list">
                    				<ul>
	                    				<li><a  href="javascript:void(0)">User 1 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">User 2 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">User 3 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">User 4 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">User 5 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">User 6 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">User 7 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">User 8 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    				<li><a  href="javascript:void(0)">User 9 <span class="fa  fa-chevron-right pull-right"></span></a></li>
	                    			</ul>
                    			</div>
                    		</div>
                    	</div>
                    	<div class="col-md-6">
                    		<div class="user-service-detail">
                    			<!-- <div class="select-any">
                    				<span class="fa fa-hand-o-left fa-3x"></span>
	                    			<br> Select any <br> service or user
	                    		</div> -->
                    			<div class="user-service-single-detail">
                    				<div class="table-responsive">
						                <table cellspacing="1" cellpadding="1" class="table table-condensed table-striped">
						                    <thead>
						                    <tr>
						                        <th>Department</th>
						                        <th>Owner</th>
						                    </tr>
						                    </thead>
						                    <tbody>
						                    <tr>
						                        <td>Department Name 1 </td>
						                        <td>Owner of the Department</td>
						                    </tr>
						                    <tr>
						                        <td>Department Name 2</td>
						                        <td>Owner of the Department</td>
						                    </tr>
						                    <tr>
						                        <td>Department Name 3</td>
						                        <td>Owner of the Department</td>
						                    </tr>
						                    </tbody>
						                </table>
									</div>
                    			</div>
                    			<div class="user-service-single-detail">
                    				<div class="table-responsive">
						                <table cellspacing="1" cellpadding="1" class="table table-condensed table-striped">
						                    <thead>
						                    <tr>
						                        <th>Application</th>
						                        <th>Owner</th>
						                    </tr>
						                    </thead>
						                    <tbody>
						                    <tr>
						                        <td>Application Name 1 </td>
						                        <td>Owner of the Department</td>
						                    </tr>
						                    <tr>
						                        <td>Application Name 2</td>
						                        <td>Owner of the Department</td>
						                    </tr>
						                    <tr>
						                        <td>Application Name 3</td>
						                        <td>Owner of the Department</td>
						                    </tr>
						                    </tbody>
						                </table>
									</div>
                    			</div>
                    			<div class="user-service-single-detail">
                    				<div class="table-responsive">
						                <table cellspacing="1" cellpadding="1" class="table table-condensed table-striped">
						                    <thead>
						                    <tr>
						                        <th>Users</th>
						                        <th>Owner</th>
						                    </tr>
						                    </thead>
						                    <tbody>
						                    <tr>
						                        <td>User Name 1 </td>
						                        <td>Owner of the Department</td>
						                    </tr>
						                    <tr>
						                        <td>User Name 2</td>
						                        <td>Owner of the Department</td>
						                    </tr>
						                    <tr>
						                        <td>User Name 3</td>
						                        <td>Owner of the Department</td>
						                    </tr>
						                    </tbody>
						                </table>
									</div>
                    			</div>
                    		</div>
                    	</div>
                    </div>
               	</div>
        	</div>
        </div>

        <div class="row">
            
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
    </div>
    <div id="footer" ng-include="'app/views/common/footer.jsp'"></div>

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

