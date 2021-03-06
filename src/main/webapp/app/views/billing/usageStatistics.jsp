<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />


<div class="row" ng-controller="billingCtrl">
	<div class="hpanel">
		<div class="panel-heading">
			<div class="row">
				<div class="col-lg-10 col-md-10 col-sm-10 col-md-offset-1">
					<div class="panel-info panel ">
						<div class="panel-heading">
							<h3 class="panel-title">
								<fmt:message key="generate" bundle="${msg}" />
								{{ $state.current.data.pageTitle}}
							</h3>
						</div>
						<div class="row m-t-md">
							<div class="col-md-6 col-sm-6">
								<div class="form-group m-l-md"
									ng-class="{'text-danger' : !usageStatisticsObj.startDate && formSubmitted}">
									<div class="row">
										<label class="col-md-3 col-sm-3 control-label"><fmt:message
												key="common.from" bundle="${msg}" /> <fmt:message
												key="common.date" bundle="${msg}" />: <span
											class="text-danger">*</span> </label>
										<div class="col-md-7 col-sm-7 ">
											<div class="input-group">
												<input type="text" readonly
													data-ng-class="{'error': !usageStatisticsObj.startDate && formSubmitted}"
													class="form-control"
													datepicker-popup="{{global.date.format}}"
													max-date="usageStatisticsObj.endDate" name="fromDate"
													data-ng-model="usageStatisticsObj.startDate"
													is-open="usageStatisticsObj.startDateOpened"
													datepicker-options="global.date.dateOptions"
													close-text="Close" /> <span class="input-group-btn">
													<button type="button" class="btn btn-default"
														ng-click="open($event, 'startDateOpened')"
														data-ng-class="{'error': !usageStatisticsObj.startDate && formSubmitted}">
														<i class="glyphicon glyphicon-calendar"></i>
													</button>
												</span>
											</div>
											<div class="error-area"
												data-ng-show="!usageStatisticsObj.startDate && formSubmitted">
												<i
													tooltip="<fmt:message key="from.date.is.required" bundle="${msg}" />"
													class=""></i>
											</div>
										</div>
									</div>
								</div>
								<div class="form-group m-l-md">
									<div class="row">
										<label class="col-md-3 col-sm-3 control-label"><fmt:message
												key="group.by" bundle="${msg}" />: <span
											class="text-danger">*</span> </label>
										<div class="col-md-7 col-sm-7">
											<select class="form-control input-group col-xs-5"
												name="groupBy" data-ng-model="groupBy"
												data-ng-init="groupBy='project';">
												<option value="service">Service</option>
												<option value="project">Project</option>
												<option value="department">Department</option>
											</select>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-6  col-sm-6">
								<div class="form-group m-l-md"
									ng-class="{
                                            'text-danger'
                                            : !usageStatisticsObj.endDate && formSubmitted}">
									<div class="row">
										<label class="col-md-3 col-sm-3 control-label"><fmt:message
												key="common.to" bundle="${msg}" /> <fmt:message
												key="common.date" bundle="${msg}" />: <span
											class="text-danger">*</span> </label>
										<div class="col-md-7 col-sm-7 ">
											<div class="input-group">
												<input type="text"
													data-ng-class="{'error': !usageStatisticsObj.endDate && formSubmitted}"
													readonly class="form-control"
													datepicker-popup="{{global.date.format}}"
													min-date="usageStatisticsObj.startDate" name="endDate"
													data-ng-model="usageStatisticsObj.endDate"
													is-open="usageStatisticsObj.endDateOpened"
													datepicker-options="global.date.dateOptions"
													close-text="Close" /> <span class="input-group-btn">
													<button type="button"
														data-ng-class="{'error': !usageStatisticsObj.endDate && formSubmitted}"
														class="btn btn-default"
														ng-click="open($event, 'endDateOpened')">
														<i class="glyphicon glyphicon-calendar"></i>
													</button>
												</span>
											</div>
											<div class="error-area"
												data-ng-show="!usageStatisticsObj.endDate && formSubmitted">
												<i
													tooltip="<fmt:message key="to.date.is.required" bundle="${msg}" />"
													class=""></i>
											</div>
										</div>
									</div>
								</div>
								<div class="form-group m-l-md"
									data-ng-show="global.sessionValues.type == 'ROOT_ADMIN'">
									<div class="row">
										<label class="col-md-3 col-sm-3 control-label"><fmt:message
												key="common.company" bundle="${msg}" />: <span
											class="text-danger">*</span> </label>
										<div class="col-md-7 col-sm-7">
											<select class="form-control input-group col-xs-5"
												name="domain" data-ng-model="usageStatisticsObj.domain"
												data-ng-options="domainObj.name for domainObj in domainList">
												<option value=""><fmt:message key="common.select"
														bundle="${msg}" /></option>
											</select>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row ">
							<span class="col-md-4 col-sm-4"></span> <span
								class="col-md-7 col-sm-7 p-md">
								<button type="submit" data-ng-click="getUsageStatistics()"
									class="btn btn-info">
									<fmt:message key="generate" bundle="${msg}" />
								</button> <!-- <a class="btn btn-default" data-ng-click="reset()"> Cancel </a> -->
							</span>
						</div>
					</div>
				</div>
			</div>
			<hr>
			<div data-ng-hide="showLoader" style="margin: 1%">
				<get-loader-image data-ng-show="showLoader"></get-loader-image>
			</div>
			<div class="row">
				<div class="report-wrapper white-content" data-ng-show="myframe">
					<div class="label-primary p-sm h6 text-white fa-bold">
						<span data-ng-show="groupBy"><fmt:message key="group.by"
								bundle="${msg}" /> : {{usageStatisticsType}}</span><span
							data-ng-show="usageStatisticsObj.domain"> | <fmt:message
								key="common.company" bundle="${msg}" /> : {{domainName}}
						</span><span data-ng-show="usageStatisticsObj.startDate"> | <fmt:message
								key="start.date" bundle="${msg}" /> :<em>{{reportStartDate
								| date:'dd-MMM-yyyy' }}</em></span><span
							data-ng-show="usageStatisticsObj.endDate"> | <fmt:message
								key="to.date" bundle="${msg}" /> :<em>{{reportEndDate |
								date:'dd-MMM-yyyy' }}</em>
						</span><a
							data-ng-if=" global.sessionValues.type == 'ROOT_ADMIN' && defaultLanguage=='en' "
							href="{{ global.PING_APP_URL }}usage/statistics/report?fromDate={{reportStartDate}}&toDate={{reportEndDate}}&groupingType={{groupBy}}&domainUuid={{usageStatisticsObj.domain.name}}&type=pdf&lang=ENGLISH"
							class="btn btn-default  pull-right m-l-xs"><span
							class="fa fa-file-pdf-o text-danger"></span> PDF</a> <a
							data-ng-if=" global.sessionValues.type !== 'ROOT_ADMIN' && defaultLanguage=='en'"
							href="{{ global.PING_APP_URL }}usage/statistics/report?fromDate={{reportStartDate}}&toDate={{reportEndDate}}&groupingType={{groupBy}}&domainUuid={{global.sessionValues.domainAbbreviationName}}&type=pdf&lang=ENGLISH"
							class="btn btn-default  pull-right m-l-xs"><span
							class="fa fa-file-pdf-o text-danger"></span> PDF</a> <a
							data-ng-if=" global.sessionValues.type == 'ROOT_ADMIN' && defaultLanguage=='zh' "
							href="{{ global.PING_APP_URL }}usage/statistics/report?fromDate={{reportStartDate}}&toDate={{reportEndDate}}&groupingType={{groupBy}}&domainUuid={{usageStatisticsObj.domain.name}}&type=pdf&lang=CHINESE"
							class="btn btn-default  pull-right m-l-xs"><span
							class="fa fa-file-pdf-o text-danger"></span> PDF</a> <a
							data-ng-if=" global.sessionValues.type !== 'ROOT_ADMIN' && defaultLanguage=='zh'"
							href="{{ global.PING_APP_URL }}usage/statistics/report?fromDate={{reportStartDate}}&toDate={{reportEndDate}}&groupingType={{groupBy}}&domainUuid={{global.sessionValues.domainAbbreviationName}}&type=pdf&lang=CHINESE"
							class="btn btn-default  pull-right m-l-xs"><span
							class="fa fa-file-pdf-o text-danger"></span> PDF</a> <a
							data-ng-if=" global.sessionValues.type == 'ROOT_ADMIN' && defaultLanguage=='en' "
							href="{{ global.PING_APP_URL }}usage/statistics/report?fromDate={{reportStartDate}}&toDate={{reportEndDate}}&groupingType={{groupBy}}&domainUuid={{usageStatisticsObj.domain.name}}&type=xlsx&lang=ENGLISH"
							class="btn btn-default  pull-right m-l-xs"><span
							class=" fa fa-file-excel-o text-success"></span> XLSX</a> <a
							data-ng-if=" global.sessionValues.type !== 'ROOT_ADMIN' && defaultLanguage=='en'"
							href="{{ global.PING_APP_URL }}usage/statistics/report?fromDate={{reportStartDate}}&toDate={{reportEndDate}}&groupingType={{groupBy}}&domainUuid={{global.sessionValues.domainAbbreviationName}}&type=xlsx&lang=ENGLISH"
							class="btn btn-default  pull-right m-l-xs"><span
							class=" fa fa-file-excel-o text-success"></span> XLSX</a> <a
							data-ng-if=" global.sessionValues.type == 'ROOT_ADMIN' && defaultLanguage=='zh' "
							href="{{ global.PING_APP_URL }}usage/statistics/report?fromDate={{reportStartDate}}&toDate={{reportEndDate}}&groupingType={{groupBy}}&domainUuid={{usageStatisticsObj.domain.name}}&type=xlsx&lang=CHINESE"
							class="btn btn-default  pull-right m-l-xs"><span
							class=" fa fa-file-excel-o text-success"></span> XLSX</a> <a
							data-ng-if=" global.sessionValues.type !== 'ROOT_ADMIN' && defaultLanguage=='zh'"
							href="{{ global.PING_APP_URL }}usage/statistics/report?fromDate={{reportStartDate}}&toDate={{reportEndDate}}&groupingType={{groupBy}}&domainUuid={{global.sessionValues.domainAbbreviationName}}&type=xlsx&lang=CHINESE"
							class="btn btn-default  pull-right m-l-xs"><span
							class=" fa fa-file-excel-o text-success"></span> XLSX</a>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
			<div class="report-wrapper white-content" data-ng-show="myframe">
				<iframe width="400" height="700" id="myframe" name="myframe"
					class="embed-responsive-item col-md-12 client-usage-report-iframe"></iframe>
			</div>
		</div>
	</div>
</div>

