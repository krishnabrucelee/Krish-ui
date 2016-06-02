<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<!-- Header -->
<ng-include id="header" src="global.getViewPageUrl('common/header.jsp')"></ng-include>

<!-- Navigation -->
<ng-include id="menu" src="global.getViewPageUrl('common/navigation.jsp')"></ng-include>

<!-- Main Wrapper -->
<div id="wrapper">
	<div class="content"  data-ng-if="global.sessionValues.type === 'ROOT_ADMIN'">
		<div class="row">
            <div class="col-md-12">
                <div class="alert alert-danger no-border-radious">
                	<fmt:message key="dashboard.content" bundle="${msg}" />
                </div>
            </div>
        </div>
	</div>
    <div class="content"  data-ng-if="global.sessionValues.type !== 'ROOT_ADMIN'">

<!--         <div class="row">
            <div class="col-md-12">
                <div class="alert alert-danger no-border-radious">This system will go for maintenance on May 1st</div>
            </div>
        </div> -->
        <div class="row">
            <div class="col-md-5 dashboard-infra-wrapper">
                <div class="panel panel-white no-border-radious dashboard-infrastructure-section">
                    <div class="panel-body p-sm">
                        <h5 class="no-margins text-primary">
                            <fmt:message key="common.infrastructure" bundle="${msg}" />
                        </h5>
                        <div class="text-center m-t-xxxl" data-ng-show="showInfrastructureLoader">
                             <img src="images/loading-bars.svg" />
                         </div>
                        <div class="row" data-ng-hide="showInfrastructureLoader">
                            <div class="col-md-4 col-sm-4 col-xs-6">
                                <div class="quick-view-details running-vm">
                                    <div class="quick-view-icon text-right pull-right"></div>
                                    <div class="clearfix"></div>
                                    <div class="quick-view-count text-right">{{ infrastructure.runningVmCount }}</div>
                                </div>
                                <div class="quick-view-title text-center"><fmt:message key="running.vm" bundle="${msg}" /></div>
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-6">
                                <div class="quick-view-details stopped-vm">
                                    <div class="quick-view-icon text-right pull-right"></div>
                                    <div class="clearfix"></div>
                                    <div class="quick-view-count text-right">{{ infrastructure.stoppedVmCount }}</div>
                                </div>
                                <div class="quick-view-title text-center"><fmt:message key="stopped.vm" bundle="${msg}" /></div>
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-6">
                                <div class="quick-view-details total-vm">
                                    <div class="quick-view-icon text-right pull-right"></div>
                                    <div class="clearfix"></div>
                                    <div class="quick-view-count text-right">{{ infrastructure.totalCount }}</div>
                                </div>
                                <div class="quick-view-title text-center"><fmt:message key="total.vm" bundle="${msg}" /></div>
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-6">
                                <div class="quick-view-details vcpu">
                                    <div class="quick-view-icon text-right pull-right"></div>
                                    <div class="clearfix"></div>
                                    <div class="quick-view-count text-right">{{ infrastructure.vcpu }}</div>
                                </div>
                                <div class="quick-view-title text-center"><fmt:message key="vcpu" bundle="${msg}" /></div>
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-6">
                                <div class="quick-view-details vcpu">
                                    <div class="quick-view-icon text-right pull-right"></div>
                                    <div class="clearfix"></div>
                                    <div class="quick-view-count text-right">{{ infrastructure.ram }}<small>(GB)</small></div>
                                </div>
                                <div class="quick-view-title text-center"><fmt:message key="ram" bundle="${msg}" /></div>
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-6">
                                <div class="quick-view-details vcpu">
                                	<div class="quick-view-icon text-right pull-right"></div>
                                	<div class="clearfix"></div>
                                    <div class="quick-view-count text-right">{{ infrastructure.storage }}<small>(GB)</small></div>

                                </div>
                                <div class="quick-view-title text-center"><fmt:message key="storage.allocation" bundle="${msg}" /></div>
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-6">
                                <div class="quick-view-details networks">
                                    <div class="quick-view-icon text-right pull-right"></div>
                                    <div class="clearfix"></div>
                                    <div class="quick-view-count text-right">{{ infrastructure.publicIp }}</div>
                                </div>
                                <div class="quick-view-title text-center"><fmt:message key="public.ip" bundle="${msg}" /></div>
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-6">
                                <div class="quick-view-details networks">
                                    <div class="quick-view-icon text-right pull-right"></div>
                                    <div class="clearfix"></div>
                                    <div class="quick-view-count text-right">{{ infrastructure.networks }}</div>
                                </div>
                                <div class="quick-view-title text-center"><fmt:message key="common.networks" bundle="${msg}" /></div>
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-6">
                                <div class="quick-view-details private-template">
                                    <div class="quick-view-icon text-right pull-right"></div>
                                    <div class="clearfix"></div>
                                    <div class="quick-view-count text-right">{{ infrastructure.template }}</div>
                                </div>
                                <div class="quick-view-title text-center"><fmt:message key="private.template" bundle="${msg}" /></div>
                            </div>
                           </div>
                    </div>
                </div>
            </div>
            <div class="col-md-7 dashboard-quota-wrapper">
                <div class="panel panel-white no-border-radious dashboard-quota-section">
                    <div class="panel-body p-sm">
                        <h5 class="no-margins text-primary">
                            <fmt:message key="quota" bundle="${msg}" />
                        </h5>
                        <div class="text-center m-t-xxxl" data-ng-show="showQuotaLoader">
                             <img src="images/loading-bars.svg" />
                         </div>
                        <div class="row dashboard-quota-area" data-ng-hide="showQuotaLoader">
                            <div data-ng-if="quotaLimit.max != '-1'"class="col-md-3 col-sm-3 col-xs-6 dashboard-quota" data-ng-repeat="quotaLimit in quotaLimits">
                                <div class="doughnut-fixed-area">
                                    <div data-ng-if="quotaLimit.percentage == undefined" class="m-b-sm"><img src="images/unlimited-quota.png" ></div>
	                                <div data-ng-if="quotaLimit.percentage != undefined" class="doughnutchart-value">{{ quotaLimit.percentage }}%</div>
	                                <canvas data-ng-if="quotaLimit.percentage != undefined" doughnutchart options="doughnutOptions" data="quotaLimit.doughnutData" width="120" height="85"></canvas>
	                                <div>{{ quotaLimit.label }}</div>
	                                <span data-ng-if="quotaLimit.usedLimit != undefined && quotaLimit.usedLimit != NaN && quotaLimit.max != undefined"><fmt:message key="using" bundle="${msg}" /> {{quotaLimit.usedLimit}} <fmt:message key="of" bundle="${msg}" /> {{quotaLimit.max}}</span>
	                                <span data-ng-if="(quotaLimit.usedLimit == undefined || quotaLimit.usedLimit == NaN) && quotaLimit.max != undefined"><fmt:message key="using" bundle="${msg}" /> 0 <fmt:message key="of" bundle="${msg}" /> {{quotaLimit.max}}</span>
	                                <span data-ng-if="quotaLimit.usedLimit != undefined && quotaLimit.usedLimit != NaN && quotaLimit.max == undefined"><fmt:message key="using" bundle="${msg}" /> {{quotaLimit.usedLimit}} <fmt:message key="of" bundle="${msg}" /> <fmt:message key="unlimited" bundle="${msg}" /></span>
	                                <span data-ng-if="(quotaLimit.usedLimit == undefined || quotaLimit.usedLimit == NaN) && quotaLimit.max == undefined"><fmt:message key="using" bundle="${msg}" /> 0 <fmt:message key="of" bundle="${msg}" /> <fmt:message key="unlimited" bundle="${msg}" /></span>
                                </div>
                            </div>
                            <div data-ng-if="quotaLimit.max == '-1'" class="col-md-3 col-sm-3 col-xs-6 dashboard-quota" data-ng-repeat="quotaLimit in quotaLimits">
                               <div class="doughnut-fixed-area">
	                               <div class="m-b-sm">
	                               <img src="images/unlimited-quota.png" ></div>
	                                <div>{{ quotaLimit.label }}</div>
	                                <span data-ng-if="quotaLimit.usedLimit != undefined && quotaLimit.usedLimit != NaN"><fmt:message key="using" bundle="${msg}" /> {{quotaLimit.usedLimit}} <fmt:message key="of" bundle="${msg}" /> <fmt:message key="unlimited" bundle="${msg}" /></span>
	                                <span data-ng-if="quotaLimit.usedLimit == undefined || quotaLimit.usedLimit == NaN"><fmt:message key="using" bundle="${msg}" /> 0 <fmt:message key="of" bundle="${msg}" /> <fmt:message key="unlimited" bundle="${msg}" /></span>
                                </div>
                            </div>

                           </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-5 col-sm-5">
                <div class="panel panel-white no-border-radious dashboard-tab">
                    <div class="panel-body">
                    <ul class="row">
                        <li class="col-md-6 no-padding text-center"><a href="javascript:void(0)" data-ng-init="toggleCostList('department');" data-ng-class="{'active' : dashboard.costList.department}" data-ng-click="toggleCostList('department')" ><fmt:message key="common.department" bundle="${msg}" /></a></li>
                        <li class="col-md-6 no-padding text-center"><a href="javascript:void(0)" data-ng-class="{'active' : dashboard.costList.project}" data-ng-click="toggleCostList('project')"><fmt:message key="common.project" bundle="${msg}" /></a></li>
                        <!-- <li><a href="javascript:void(0)" data-ng-class="{'active' : dashboard.costList.application}" data-ng-click="toggleCostList('application')">Application</a></li> -->
                    </ul>
                    <div class="dashboard-department-cost" data-ng-show="dashboard.costList.department">
                        <div class="panel-body">
                            <h5 class="no-margins text-primary">
                                <fmt:message key="top.5.departments.by.cost" bundle="${msg}" /> <br>(Current Month) {{filterdept.value | lowercase}}
                            </h5>

                            <div class="m-t-md">

                                <table cellspacing="1" cellpadding="1" class="top-projects no-margins table table-condensed table-striped">
                                    <thead>
                                        <tr>
                                            <th class="col-md-3"><small><fmt:message key="common.department" bundle="${msg}" /></small></th>
                                            <th class="col-md-3"><small class="pull-right"><fmt:message key="cost" bundle="${msg}" /> (<app-currency></app-currency>)</small></th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                             <div class="text-center m-t-xxxl" data-ng-show="showTopDeptLoader">
                                 <img src="images/loading-bars.svg" />
                             </div>
                             <div data-ng-hide="showDeptLoader">
								<table cellspacing="1" cellpadding="3" class="top-projects table table-condensed table-striped">
                                     <tbody >
                                         <tr data-ng-repeat="department in top5DepartmentList | limitTo:5">
                                             <td  class="col-md-3">{{ department.account }}</td>
                                             <td  class="col-md-3">
                                                 <label class="badge badge-info p-xxs font-bold pull-right">{{  department.grandTotalCost | number:2}}</label>
                                             </td>
                                         </tr>
                                     </tbody>
                                 </table>
                             </div>
                        </div>
                    </div>
                    <div class="dashboard-project-cost" data-ng-show="dashboard.costList.project">
                        <div class="panel-body">
                            <h5 class="no-margins text-primary">
                                <fmt:message key="top.5.projects.by.cost" bundle="${msg}" /> <br>(Current Month) {{filters.value | lowercase}}
                            </h5>

                            <div class="m-t-md">
                                <table cellspacing="1" cellpadding="1" class="top-projects no-margins table table-condensed table-striped">
                                    <thead>
                                        <tr>
                                            <th class="col-md-3"><small><fmt:message key="common.project" bundle="${msg}" /></small></th>

                                            <th class="col-md-3"><small class="pull-right"><fmt:message key="cost" bundle="${msg}" /> (<app-currency></app-currency>)</small></th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>

                             <div class="text-center m-t-xxxl" data-ng-show="showTopProjectLoader">
                                 <img src="images/loading-bars.svg" />
                             </div>
                             <div data-ng-hide="showTopProjectLoader">
                                 <table cellspacing="1" cellpadding="3" class="top-projects table table-condensed table-striped">
                                     <tbody >
                                         <tr data-ng-repeat="project in top5ProjectList | limitTo:5">
                                             <td  class="col-md-3">{{ project.project }}</td>
                                             <td  class="col-md-3">
                                                 <label class="badge badge-info p-xxs font-bold pull-right">{{  project.grandTotalCost | number:2 }}</label>
                                             </td>
                                         </tr>
                                     </tbody>
                                 </table>
                             </div>
                        </div>
                    </div>
                    <div class="dashboard-application-cost" data-ng-show="dashboard.costList.application">
                        <div class="panel-body">
                            <h5 class="no-margins text-primary">
                                <fmt:message key="top.5.applications.by.cost" bundle="${msg}" /> (Current Month) {{filterapp.value | lowercase}}
                            </h5>
                            <div class="m-t-md">

                                <table cellspacing="1" cellpadding="1" class="top-projects no-margins table table-condensed table-striped">
                                    <thead>
                                        <tr>
                                            <th class="col-md-3"><small><fmt:message key="application" bundle="${msg}" /></small></th>

                                            <th class="col-md-3"><small class="pull-right"><fmt:message key="cost" bundle="${msg}" /> (<app-currency></app-currency>)</small></th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                            <div class="slimScroll-175">
                                   <div class="text-center m-t-xxxl" data-ng-show="showAppLoader">
                                        <img src="images/loading-bars.svg" />
                                    </div>
                                <div data-ng-hide="showAppLoader">
                                    <table cellspacing="1" cellpadding="3" class="top-projects table table-condensed table-striped">
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
                </div>
            </div>
            <div class="col-md-7 col-sm-7">
                <div class="panel panel-white no-border-radious">
                    <div class="panel-body p-sm">
                        <h5 class="no-margins text-primary">
                            <fmt:message key="cost.by.month" bundle="${msg}" />
                        </h5>
                        <div class="col-md-12">
				            <div class="p-xxs">
								<div class="row" data-ng-show="showCostByMonthLoader">
									<div class="col-md-12 text-center">
										<img src="images/loading-bars.svg" width="64" height="64" />
									</div>
								</div>
								<div class="flot-chart" data-ng-hide="showCostByMontLoader">
				                    <div flot class="flot-chart-content" dataset="costCharData" options="costChartOptions"></div>
				                </div>
				            </div>
				        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-white no-border-radious dashboard-accordian">
                    <div class="panel-body">
                    	<div class="row">
	                    	<div class="col-md-5">
								<div class="col-md-6 no-padding">
									<div class="bg-info p-xs font-bold text-primary m-b-xxs service-title"><fmt:message key="categories" bundle="${msg}" /></div>
		                            <div class="user-service-first-level slimScroll-220">
		                                <ul>
		                                    <li><a href="javascript:void(0)" data-ng-click="getDepartmentList('department');"><fmt:message key="common.department" bundle="${msg}" /> <span class="fa  fa-chevron-right pull-right"></span></a></li>
		                                    <li><a href="javascript:void(0)" data-ng-click="getApplicationList();"><fmt:message key="common.application" bundle="${msg}" /> <span class="fa  fa-chevron-right pull-right"></span></a></li>
		                                    <li><a href="javascript:void(0)" data-ng-click="getDepartmentList('user');"><fmt:message key="users" bundle="${msg}" /> <span class="fa  fa-chevron-right pull-right"></span></a></li>
		                                </ul>
		                            </div>
	                    		</div>
	                    		<div class="col-md-6 no-padding">
									<div class="select-any" data-ng-hide="listing.department || listing.application">
                                   	<span class="fa fa-hand-o-left fa-3x"></span>
		                                <br> <fmt:message key="select.any" bundle="${msg}" /> <br> <fmt:message key="common.department" bundle="${msg}" />, <fmt:message key="common.application" bundle="${msg}" /> <fmt:message key="or" bundle="${msg}" /> <fmt:message key="common.user" bundle="${msg}" />
		                            </div>
		                                                        	<div data-ng-show="listing.department" class="bg-info p-xs font-bold text-primary m-b-xxs service-title"><fmt:message key="common.departments" bundle="${msg}" /></div>

		                            <div class="user-service-second-level slimScroll-220">
		                                <div data-ng-show="listing.department">

		                                    <ul>
		                                        <li data-ng-repeat="department in listing.departmentList">
		                                            <a href="javascript:void(0)" data-ng-class="{'selected' : listing.activeDepartment == department.id }" data-ng-click="findSubCategoryByDepartment(listing.groupType, department.id);">{{ department.userName }}<span class="fa  fa-chevron-right pull-right"></span></a>
		                                        </li>
		                                    </ul> <!-- data-ng-class="{'selected' : listing.activeDepartment == department.id }" -->
		                                </div>
		                                <div class="user-service-list"  data-ng-show="listing.application">
		                                <div class="bg-info p-xs font-bold text-primary m-b-xxs service-title"><fmt:message key="common.applications" bundle="${msg}" /></div>
		                                    <ul>
		                                        <li  data-ng-repeat="application in listing.applicationList">
		                                            <a  href="javascript:void(0)">{{ application.type }}</a>
		                                          </li>

		                                    </ul>
		                                </div>
		                            </div>
	                    		</div>
	                    	</div>
	                    	<div class="col-md-7" data-ng-hide="listing.application">
								<div  data-ng-if="listing.userList.length > 0 && listing.groupType == 'department' && type == 'Projects'" class="bg-info p-xs font-bold text-primary m-b-xxs service-details-title">{{type}}</div>
                        		<div  data-ng-if="listing.userList.length > 0 && listing.groupType == 'user' && type == 'Users'" class="bg-info p-xs font-bold text-primary m-b-xxs service-details-title">{{type}}</div>
	                            <div class="user-service-detail slimScroll-220">
	                                <div class="text-center" data-ng-show="listing.userList.length == 0">
	                                    <br> <fmt:message key="common.no.records.found" bundle="${msg}" />
	                                </div>
	                                <div class="user-service-single-detail" data-ng-show="listing.userList.length > 0">

	                                    <div class="table-responsive">
	                                        <table cellspacing="1" cellpadding="1" class="table table-condensed table-striped">
	                                            <tbody>
	                                            <tr data-ng-if="listing.groupType == 'department'" data-ng-repeat="project in listing.userList">
	                                                <td>{{ project.name }}</td>
	                                            </tr>
	                                            <tr data-ng-if="listing.groupType == 'user'" data-ng-repeat="user in listing.userList">
	                                                <td>{{ user.userName }}</td>
	                                            </tr>
	                                            </tbody>
	                                        </table>
	                                    </div>
	                                </div>


	                            </div>
	                    	</div>
                    	</div>
                        <!-- <div class="col-md-3 col-sm-3 no-padding">

                        </div>
                        <div class="col-md-3 col-sm-3 no-padding">

                        </div>
                        <div class="col-md-6 col-sm-6" data-ng-hide="listing.application">

                        </div> -->
                    </div>
                   </div>
            </div>
        </div>

        <div class="row">


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

