<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div class="row">
	<div class="col-md-12">
		<div class="pull-right dashboard-filters-area m-r-sm" id="instances_quick_search">
						<form data-ng-submit="featureSearchList(featureSearch)">
							<div class="quick-search pull-right">
								<div class="input-group">
									<input data-ng-model="featureSearch" id="featured_grid_search" type="text" valid-characters class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
								   	<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
								</div>
							</div>
							<div class="clearfix"></div>
							<span class="pull-right m-l-sm m-t-sm">
							</span>
						</form>
						</div>
	</div>
	<div class="row clearfix">
		<div  class="col-md-4 col-md-offset-4 clearfix">
			<div class="hpanel">
			    <div  class="panel-body no-records p-xs text-center" data-ng-hide="template.listFeaturedTemplate.length > 0">
					 <h5>No Records Found</h5><br>
					 <img src="images/no-templates-found.png" border="0" alt="no records found" title="no records found">
			    </div>
		    </div>
		</div>
	</div>
</div>
<div class="clearfix"></div>

<div class="m-t-sm" >
    <div  class="col-md-4 col-lg-4 col-xs-12 col-sm-12 no-padding template-panel-area" data-ng-repeat="templateObj in template.listFeaturedTemplate|orderBy:template.name | filter: quickSearch">
        <div class="hpanel" data-ng-show="template.listFeaturedTemplate.length > 0">
            <div  class="panel-body p-xs template-panel" data-ng-class="templateObj.openDescription ? 'template-panel-active': ''">
                <div class="row">
                    <div class="col-md-12 col-sm-12">
                        <div class="font-extra-bold pull-right" title="Zone">
                            <a  title="Properties" data-ng-click="showDescription(templateObj)"><i class="pe-7s-keypad font-extra-bold  m-r-sm"></i></a>
                            <i class="fa fa-map-marker" ></i> {{ global.zone.name}}
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-2 col-sm-2">
                      <img data-ng-show="templateObj.osCategory.name.indexOf('Windows') > -1" src="images/os/windows_logo.png" alt="" height="40" width="40" class="m-r-5 m-t-md" >
                        <img data-ng-show="templateObj.osCategory.name.indexOf('CentOS') > -1" src="images/os/centos_logo.png" alt="" height="40" width="40" class="m-r-5 m-t-md" >
                        <img data-ng-show="templateObj.osCategory.name.indexOf('Ubuntu') > -1" src="images/os/ubuntu_logo.png" alt="" height="40" width="40" class="m-r-5 m-t-md" >
                        <img data-ng-show="templateObj.osCategory.name.indexOf('RedHat') > -1" src="images/os/redhat_logo.png" alt="" height="40" width="40" class="m-r-5 m-t-md" >
                        <img data-ng-show="templateObj.osCategory.name.indexOf('Debian') > -1" src="images/os/debian_logo.png" alt="" height="40" width="40" class="m-r-5 m-t-md" >
                        <img data-ng-show="templateObj.osCategory.name.indexOf('SUSE') > -1" src="images/os/suse-logo.png" alt="" height="40" width="40" class="m-r-5 m-t-md" >
                		<img data-ng-show="templateObj.osCategory.name.indexOf('Oracle') > -1" src="images/os/oracle-os.png" alt="" height="40" width="40" class="m-r-5 m-t-md" >
                		<img data-ng-show="templateObj.osCategory.name.indexOf('Novel') > -1" src="images/os/novell-os.png" alt="" height="40" width="40" class="m-r-5 m-t-md" >
                		<img data-ng-show="templateObj.osCategory.name.indexOf('Unix') > -1" src="images/os/unix-logo.png" alt="" height="40" width="40" class="m-r-5 m-t-md" >
                    </div>
                    <div class="col-md-7 col-sm-7 ">
                        <div class="row">
                            <div class="col-md-8 col-sm-6">
                                <div class="row">
                                    <h4>{{ templateObj.name}}</h4> <h5 class="text-success"><fmt:message key="common.version" bundle="${msg}" />:{{ templateObj.version}}</h5>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="small  m-b-sm  "  data-ng-hide="templateObj.openDescription">
                                {{ templateObj.description}}
                            </div>
                            <div class="small text-justify"    data-ng-show="templateObj.openDescription">
                                <div  class="animate-panel slimScroll" data-child="hpanel" data-effect="fadeInUp">
                                    <div class="animated-panel fadeInUp">
                                    <p data-ng-bind-html="templateObj.detailedDescription"></p>
                                    </div>
                                </div>
                            </div>
                            <a class="text-info font-bold "  data-ng-click="openDescription($index)"><span data-ng-class="templateObj.openDescription ? 'pe-7s-angle-up-circle' : 'pe-7s-angle-down-circle' " class="pe-lg font-bold m-r-xs"></span> <fmt:message key="common.details" bundle="${msg}" /></a>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-3">
                        <div class="row m-t-md">
                            <div class="col-md-12 col-sm-12 ">
                                <span data-ng-show="templateObj.templateCost[0].cost > 0" class="font-bold text-danger pricing-text pull-right">{{ templateObj.templateCost[0].cost | currency: global.settings.currency }} / <fmt:message key="common.day" bundle="${msg}" /></span>
                                <span data-ng-hide="templateObj.templateCost[0].cost > 0" class="font-bold text-success pricing-text pull-right"><fmt:message key="free" bundle="${msg}" /></span>
                            </div>
                        </div>
                        <div class="row m-t-md" >
                            <div class="col-md-12 col-sm-12 col-xs-12 ">
                                <button data-ng-if="templateObj.status == 'ACTIVE'" class="btn btn-info btn-sm pull-right" title="<fmt:message key="common.launch" bundle="${msg}" />" data-ng-click="openAddInstance(templateObj)"><i class="fa fa-power-off"></i> <fmt:message key="common.launch" bundle="${msg}" /></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

