<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<%-- <div data-ng-hide="viewContent" data-ng-controller="servicesCtrl">
    	<div class="" >
        	<div class="hpanel">
            	<div class="panel-heading no-padding">
                	<div class="row">
                    	<div class="col-md-12 col-sm-12 col-xs-12 ">
                        	<div class="pull-left dashboard-btn-area">
                            	<div class="dashboard-box pull-left">
     							<div class="instance-border-content-normal">
                                <span class="pull-left m-t-xs m-l-xs m-r-xs"><fmt:message key="total.services" bundle="${msg}" /></span>
                                <b class="pull-left">{{servicesList.Count}}</b>
                                <div class="clearfix"></div>
                                </div>
                            </div>
                            <a class="btn btn-info" id="service_category_refresh_button" data-ng-click="list(1)" title="<fmt:message
									key="common.refresh" bundle="${msg}" />"  ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
                        </div>
                        <div class="pull-right dashboard-filters-area" id="services_quick_search">
						<form data-ng-submit="searchList(servicesSearch)">
							<div class="quick-search pull-right">
								<div class="input-group">
									<input data-ng-model="servicesSearch" id="service_category_list_search" type="text" valid-characters class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
								   	<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
								</div>
							</div>
							<div class="clearfix"></div>
							<span class="pull-right m-l-sm m-t-sm">
							</span>
						</form>
						</div>

                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
			<div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12 ">

<div class="" >
    <div class="col-md-4 col-lg-3 col-xs-12 col-sm-12 no-padding template-panel-area" data-ng-repeat="serviceObj in servicesList|orderBy:serviceName | filter: quickSearch">
        <div class="hpanel" >
            <div class="panel-body p-xs template-panel" data-ng-class="serviceObj.openDescription ? 'template-panel-active': ''">
                 <div class="row">
                     <div class="white-content">
                    <div class="col-md-12 col-sm-12">
                        <div class="font-extra-bold pull-right" title="<fmt:message key="common.zone" bundle="${msg}" />">
                            <a  title="<fmt:message key="properties" bundle="${msg}" />" data-ng-click="showDescription(serviceObj.id)"><i class="pe-7s-keypad font-extra-bold  m-r-sm"></i></a>
                            <i class="fa fa-map-marker" ></i> {{ global.zone.name}}
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-2 col-sm-2">

                    </div>
                    <div class="col-md-7 col-sm-7 ">
                        <div class="row">
                            <div class="col-md-8 col-sm-6">
                                <div class="row">
                                    <h4>{{ serviceObj.serviceName}}</h4> <h5 class="text-success"><fmt:message key="service.code" bundle="${msg}" />:{{ serviceObj.serviceCode}}</h5>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="small  m-b-sm  "  data-ng-hide="serviceObj.openCommunityDescription">
                                {{ serviceObj.description}}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-3">
                        <div class="row m-t-md">
                            <div class="col-md-12 col-sm-12 ">
                                <span data-ng-show="serviceObj.servicesCost[0].cost > 0" class="font-bold text-danger pricing-text pull-right">{{ serviceObj.servicesCost[0].cost | currency: global.settings.currency }} / <fmt:message key="common.day" bundle="${msg}" /></span>
                            </div>
                        </div>
                        <div class="row m-t-md" >
                            <div class="col-md-10 col-sm-12 col-xs-12 ">
                                <button data-ng-if="serviceObj.isActive == 1" class="btn btn-info btn-sm pull-right" title="<fmt:message key="common.launch" bundle="${msg}" />" data-ng-click="openAddInstance(serviceObj.id)"><i class="fa fa-power-off"></i> <fmt:message key="common.launch" bundle="${msg}" /></button>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="row clearfix" data-ng-show="servicesList.length == 0"  >
		<div  class="col-md-4 col-md-offset-4 clearfix">
			<div class="hpanel">
			    <div  class="panel-body no-records p-xs text-center" >
					 <h5><fmt:message key="common.no.records.found" bundle="${msg}" /></h5><br>
					 <img src="images/no-templates-found.png" border="0" alt="no records found" title="<fmt:message key="common.no.records.found" bundle="${msg}" />">
			    </div>
		    </div>
		</div>
	</div>
</div>

        </div>
        </div>
        </div>
        </div>
    </div> --%>

<div class="row clearfix"  >
		<div  class="col-md-4 col-md-offset-4 clearfix">
			<div class="hpanel">
			    <div  class="panel-body no-records p-xs text-center" >
					 <h5><fmt:message key="common.no.records.found" bundle="${msg}" /></h5><br>
					 <img src="images/no-templates-found.png" border="0" alt="no records found" title="<fmt:message key="common.no.records.found" bundle="${msg}" />">
			    </div>
		    </div>
		</div>
	</div>
</div>
