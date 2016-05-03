<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="row" data-ng-controller="quotaLimitCtrl">
    <div class="col-lg-12" >
         <div class="hpanel" >
            <div class="page-heading">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="pull-right ">

	                        <panda-quick-search></panda-quick-search>
	                        <span class="pull-right m-r-sm" data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'">
								<select
									class="form-control input-group col-xs-5" name="domainView"
									data-ng-model="domainView"
									data-ng-change="selectDomainView()"
									data-ng-options="domainView.name for domainView in domainList">
									<option value=""> <fmt:message key="common.domain.filter" bundle="${msg}" /></option>
								</select>
							</span>
							<span class="pull-right m-r-sm">
	                        	<a class="btn btn-info" ui-sref="cloud.quota-limit" title="<fmt:message key="common.refresh" bundle="${msg}" /> " ui-sref-opts="{reload: true}" ><span class="fa fa-refresh fa-lg"></span></a>
	                        </span>
                        	<div class="clearfix"></div>

                        </div>

                    </div>
                </div>
            </div>
            <div class="row">
             <div class="col-md-12 m-t-sm">
                <div class="panel">
                    <div class="panel-body p-sm">
                        <div class="text-center m-t-xxxl" data-ng-show="showQuotaLoader">
                             <img src="images/loading-bars.svg" />
                         </div>
                        <div class="row dashboard-quota-area" data-ng-hide="showQuotaLoader">
                            <div data-ng-if="quotaLimit.max != '-1'" class="col-md-2 col-sm-4 col-xs-6 dashboard-quota" data-ng-repeat="quotaLimit in quotaLimits">
                            	<div class="doughnut-fixed-area">
	                                <div class="doughnutchart-value">{{ quotaLimit.percentage}}%</div>
	                                <canvas doughnutchart options="doughnutOptions" data="quotaLimit.doughnutData" width="120" height="85" ></canvas>
	                                <div>{{ quotaLimit.label }}</div> <span>Using {{quotaLimit.usedLimit}} of {{quotaLimit.max}}</span>
                            	</div>
							</div>
							 <div data-ng-if="quotaLimit.max == '-1'" class="col-md-2 col-sm-4 col-xs-6 dashboard-quota" data-ng-repeat="quotaLimit in quotaLimits">
                               	<div class="doughnut-fixed-area">
	                               	<div class="m-b-sm"><img src="images/unlimited-quota.png" ></div>
	                                <div>{{ quotaLimit.label }}</div> <span>Using {{quotaLimit.usedLimit}} of unlimited</span>
                                </div>
                            </div>
                           </div>
                    </div>
                </div>
                </div>
            </div>
	</div>
        </div>

	</div>