<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="inmodal ">
	<div class="modal-header">
		<panda-modal-header page-icon="fa fa-cloud"
			page-title="<fmt:message key="common.create.instance" bundle="${msg}" />"></panda-modal-header>
	</div>

	<div class="modal-body">
		<div class="row">
			<div id="configuration-setup-panel" class="col-md-7 col-sm-12">


				<div ng-show="step == 1">

					<ul class="nav nav-tabs"
						data-ng-init="templateCategory = 'template'">
						<li class="active"><a href="javascript:void(0)"
							data-ng-click="templateCategory = 'template'" data-toggle="tab">
								<fmt:message key="common.template" bundle="${msg}" /></a></li>
						<li class=""><a href="javascript:void(0)"
							data-ng-click="templateCategory = 'iso'" data-toggle="tab"><fmt:message key="common.iso" bundle="${msg}" /></a></li>
					</ul>

					<div class="tab-content">

						<div class="tab-pane"
							data-ng-class="{'active' : templateCategory == 'template'}"
							id="step1-tempalte">
							<div data-ng-include src="'app/views/cloud/instance/step1.jsp'"></div>

						</div>
						<div class="tab-pane"
							data-ng-class="{'active' : templateCategory == 'iso'}"
							id="step1-iso">
							<div data-ng-include src="'app/views/cloud/instance/step1.jsp'"></div>
						</div>

					</div>



					<div class="panel panel-default" data-ng-show="instance.template">
						<div class="panel-heading">
							<h3 class="panel-title"><fmt:message key="common.configuration" bundle="${msg}" /></h3>

						</div>
						<div class="panel-body no-padding">
							<ul class="list-group">

								<li class="list-group-item ">
									<div class="row">
										<div class="col-sm-12 col-md-12">
											<div class="stats-title">
												<h5 class="font-bold text-info"><fmt:message key="common.template" bundle="${msg}" /></h5>
											</div>

											<div class="row">
												<div class="col-md-12 col-sm-12 m-t-xs">
													{{ instance.template.name}}
													<span class="pull-right text-danger price-text m-l-lg">
														<app-currency></app-currency>{{ instance.template.templateCost[0].cost / 720 | number : 2}}
														<span> / <fmt:message key="common.hour" bundle="${msg}" /></span>
													</span>
												</div>
											</div>
										</div>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>


				<div ng-show="step == 2">
					<form name="instanceForm" method="POST"
						data-ng-submit="validateOffering(instanceForm)" novalidate
						class="form-horizontal">
						<div data-ng-show = "showLoaderOffer" style="margin: 10%">
      							<get-loader-image data-ng-show="showLoaderOffer"></get-loader-image>
      						</div>
						<div data-ng-hide = "showLoaderOffer" data-ng-include src="'app/views/cloud/instance/step2.jsp'"></div>
						<div class="row">
							<button type="button" class="btn btn-info btn-outline"
								ng-click="wizard.show(1)"><fmt:message key="common.previous" bundle="${msg}" /></button>
							<div class="pull-right">
								<a class="btn btn-default" ng-click="cancel()"> <fmt:message key="common.cancel" bundle="${msg}" /> </a>
								<button class="btn btn-info" type="submit"><fmt:message key="common.create" bundle="${msg}" /></button>
							</div>
						</div>
					</form>
				</div>



			</div>

			<div class="col-md-5  col-sm-12" id="configuration-container">

				<div class="row" data-ng-show="instance != null && step == 1">
					<div class="col-md-12">
						<form name="instanceTemplateForm" method="POST"
							data-ng-submit="validateTemplate(instanceTemplateForm)"
							novalidate class="form-horizontal">
							<div data-ng-include src="'app/views/cloud/instance/step3.jsp'"></div>
						</form>
					</div>
				</div>

				<div class="row" data-ng-show="instance != null && step == 2">
					<div class="col-md-12">

						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title"><fmt:message key="common.configuration" bundle="${msg}" /></h3>

							</div>
							<div class="panel-body no-padding">
								<ul class="list-group">

									<li class="list-group-item " data-ng-show="instance.template">
										<div class="row">
											<div class="col-sm-12 col-md-12">
												<div class="stats-title">
													<h5 class="font-bold text-info"><fmt:message key="common.template" bundle="${msg}" /></h5>
												</div>

												<div class="row">
													<div class="col-md-12 col-sm-12 m-t-xs">
														{{ instance.template.name}}
														<span class="pull-right text-danger price-text m-l-lg">
															<app-currency></app-currency> {{ instance.template.templateCost[0].cost/720 | number:2}}<span> / <fmt:message key="common.hour" bundle="${msg}" /></span>
														</span>
													</div>
												</div>
											</div>
										</div>
									</li>
									<li class="list-group-item "
										data-ng-show="instance.computeOffering">
										<div class="row">
											<div class="col-md-12 col-sm-12">
												<div class="stats-title">
													<h5 class="font-bold text-info"><fmt:message key="common.compute.offering" bundle="${msg}" /></h5>
												</div>
												<div class="row">
													<div class="col-md-12 col-sm-12 m-t-xs">
														{{ instance.computeOffering.name}} <span
															class="pull-right text-danger price-text m-l-lg"><app-currency></app-currency>{{
															(instance.computeOffering.computeCost[0].instanceRunningCostIops + instance.computeOffering.computeCost[0].instanceRunningCostMemory + instance.computeOffering.computeCost[0].instanceRunningCostVcpu
															+instance.computeOffering.computeCost[0].instanceStoppageCostIops +instance.computeOffering.computeCost[0].instanceStoppageCostMemory+ instance.computeOffering.computeCost[0].instanceStoppageCostVcpu)/720 |
													number:2 }}<span> / <fmt:message key="common.hour" bundle="${msg}" /></span></span>
													</div>
												</div>
											</div>
										</div>

												<div class="row">
												<div class="col-md-12 col-sm-12 m-t-xs ">
													 <fmt:message key="setup.cost" bundle="${msg}" /><span class="font-bold"> (<fmt:message key="one.time" bundle="${msg}" />)</span> <span
															class="pull-right text-danger price-text m-l-lg">
													<app-currency></app-currency>
															{{instance.computeOffering.computeCost[0].setupCost | number :2}}
															<span></span>
												</span>
												</div>
												</div>
									</li>
									<li class="list-group-item "
										data-ng-show="instance.storageOffering">
										<div class="row">
											<div class="col-sm-12 col-md-12">
												<div class="stats-title pull-left">
													<h5 class="font-bold text-info"><fmt:message key="data.disk.offering" bundle="${msg}" /></h5>
												</div>
												<div class="row">
													<div class="col-md-12 col-sm-12 m-t-xs">
														{{ instance.storageOffering.name}} <span
															class="pull-right text-danger price-text m-l-lg"><app-currency></app-currency>{{
													(instance.storageOffering.storagePrice[0].costGbPerMonth +
													instance.storageOffering.storagePrice[0].costIopsPerMonth )/720 |
													number:2 }}<span> / <fmt:message key="common.hour" bundle="${msg}" /></span></span>
													</div>
												</div>
											</div>
										</div>
									</li>

									<li class="list-group-item ">
										<div class="row">
											<div class="col-md-12 col-sm-12">
												<div class="stats-title">
													<h5 class="font-bold text-info"><fmt:message key="common.average.cost" bundle="${msg}" /></h5>
												</div>
												<div class="row">
													<div class="col-md-12 col-sm-12 m-t-xs">
														<fmt:message key="common.cost" bundle="${msg}" /> <span
															class="pull-right text-danger price-text m-l-lg">
															<app-currency></app-currency>{{(instance.template.templateCost[0].cost + instance.storageOffering.storagePrice[0].costGbPerMonth +instance.storageOffering.storagePrice[0].costIopsPerMonth+
															instance.computeOffering.computeCost[0].instanceRunningCostIops+instance.computeOffering.computeCost[0].instanceRunningCostMemory + instance.computeOffering.computeCost[0].instanceRunningCostVcpu
															+instance.computeOffering.computeCost[0].instanceStoppageCostIops +instance.computeOffering.computeCost[0].instanceStoppageCostMemory+ instance.computeOffering.computeCost[0].instanceStoppageCostVcpu)/720 | number:2
															 }} <span> / <fmt:message key="common.hour" bundle="${msg}" /></span>
														</span>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-12 col-sm-12">
												<small
													class="pull-right text-right font-bold  m-l-lg">
													<app-currency></app-currency>{{(instance.template.templateCost[0].cost + instance.storageOffering.storagePrice[0].costGbPerMonth +instance.storageOffering.storagePrice[0].costIopsPerMonth+
															instance.computeOffering.computeCost[0].instanceRunningCostIops+instance.computeOffering.computeCost[0].instanceRunningCostMemory + instance.computeOffering.computeCost[0].instanceRunningCostVcpu
															+instance.computeOffering.computeCost[0].instanceStoppageCostIops +instance.computeOffering.computeCost[0].instanceStoppageCostMemory+ instance.computeOffering.computeCost[0].instanceStoppageCostVcpu) | number:2
															 }} <span> / <fmt:message key="common.month" bundle="${msg}" />   </span>
												</small>
											</div>
										</div>
										<div class="row">
											<div class="col-md-12 col-sm-12 m-t-xs " data-ng-show="instance.computeOffering">
														<fmt:message key="setup.cost" bundle="${msg}" /><span class="font-bold"> (<fmt:message key="one.time" bundle="${msg}" />)</span> <span
															class="pull-right text-danger price-text m-l-lg">
													<app-currency></app-currency>
															{{instance.computeOffering.computeCost[0].setupCost | number :2}}
															<span></span>
												</span>
											</div>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>