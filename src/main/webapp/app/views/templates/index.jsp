<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="language" value="${not empty language ? language : pageContext.request.getAttribute('language')}" scope="session" />
<fmt:setBundle basename="i18n/messages_${language}" var="msg" scope="session" />

<div id="header" ng-include="'app/views/common/header.jsp'"></div>
<aside id="menu" ng-include="'app/views/common/navigation.jsp'"></aside>
<div id="wrapper">
    <div small-header class="normalheader transition ng-scope small-header">
        <div class="hpanel" tour-step order="1" content="Place your page title and breadcrumb. Select small or large header or give the user choice to change the size." placement="bottom">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-left">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a ui-sref="dashboard"><fmt:message key="common.home" bundle="${msg}" /></a></li>
                        <li ng-repeat="state in $state.$current.path" ng-switch="$last || !!state.abstract" ng-class="{active: $last}">
                            <a ng-switch-when="false" href="{{state.url.format($stateParams)}}"><fmt:message key="template.store" bundle="${msg}" /></a>
                            <span ng-switch-when="true"><fmt:message key="template.store" bundle="${msg}" /></span>
                        </li>
                    </ol>
                </div>
                <%-- <h2 class="font-light m-b-xs">
                    <fmt:message key="template.store" bundle="${msg}" />
                </h2>
                <small>{{ $state.current.data.pageDesc}}</small> --%>
            </div>
        </div>
    </div>
    <div class="content">
        <div ui-view >
            <div class="hpanel" ng-controller="templatesCtrl">
                <div class="panel-body" >
					<!--  Community grid and list  -->
                       <form data-ng-submit="searchVMList(quickVmSearch,communityGridTemplate)" data-ng-if ="formElements.category == 'community' && !listView">
							 <div class="pull-right m-l-sm" >
							 <a class="btn btn-info" data-ng-click="showCommunityRefresh()"
											id="community_refresh_button" title="<fmt:message key="common.refresh" bundle="${msg}" />"
											ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
											</div>
							<div class="quick-search pull-right">

								<div class="input-group">
									<input data-ng-model="quickVmSearch" id="community_grid_search" type="text" valid-characters class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
								   	<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
								</div>
							</div>
							<span class="pull-right m-r-sm" >
										<select	class="form-control input-group col-xs-5" name="communityGridTemplate" data-ng-model="communityGridTemplate" data-ng-change="templateList(communityGridTemplate.name)" data-ng-options="communityGridTemplate.name for communityGridTemplate in gridElements.communityGridList">
										<option value=""> <fmt:message key="common.all.templates" bundle="${msg}" /></option>
										</select>
										</span>
						</form>
						<form data-ng-submit="searchList(templateCommunityListSearch,communityGridTemplate)" data-ng-if =" formElements.category == 'community' && listView">
							 <div class="pull-right m-l-sm" >
							 <a class="btn btn-info" data-ng-click="showCommunityRefresh()"
											id="community_refresh_button" title="<fmt:message key="common.refresh" bundle="${msg}" />"
											ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
											</div>
							<div class="quick-search pull-right">

								<div class="input-group">
									<input data-ng-model="templateCommunityListSearch" id="community_list_search" type="text" valid-characters class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
								   	<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
								</div>
							</div>
							<span class="pull-right m-r-sm" >
										<select	class="form-control input-group col-xs-5" name="communityGridTemplate" data-ng-model="communityGridTemplate" data-ng-change="list(1,communityGridTemplate.name)" data-ng-options="communityGridTemplate.name for communityGridTemplate in formElements.communitytypeList">
										<option value=""> <fmt:message key="common.all.templates" bundle="${msg}" /></option>
										</select>
										</span>
						</form>

						 <!--  Featured grid and list  -->
						<form data-ng-submit="featureSearchList(featureSearch,templateTypes)" data-ng-if =" formElements.category == 'featured' && !listView">
							  <div class="pull-right m-l-sm" >
							  <a class="btn btn-info" data-ng-click="showFeaturedRefresh()"
											id="featured_refresh_button" title="<fmt:message key="common.refresh" bundle="${msg}" />"
											ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
							</div>
							<div class="quick-search pull-right">
								<div class="input-group">
									<input data-ng-model="featureSearch" id="featured_grid_search" type="text" valid-characters class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
								   	<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
								</div>
							</div>
							<span class="pull-right m-r-sm" >
										<select	class="form-control input-group col-xs-5" name="templateTypes" data-ng-model="templateTypes" data-ng-change="featuredTemplateList(templateTypes.name)" data-ng-options="templateTypes.name for templateTypes in formElements.typeList">
										<option value=""> <fmt:message key="common.all.templates" bundle="${msg}" /></option>
										</select>
										</span>
						</form>
							<form data-ng-submit="searchFeaturedList(templateFeaturedListSearch,templateType)"  data-ng-if =" formElements.category == 'featured' && listView">
							<div class="pull-right m-l-sm" >
							  <a class="btn btn-info" data-ng-click="showFeaturedRefresh()"
											id="featured_refresh_button" title="<fmt:message key="common.refresh" bundle="${msg}" />"
											ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
							</div>
							<div class="quick-search pull-right">
								<div class="input-group">
									<input data-ng-model="templateFeaturedListSearch" id="featured_list_search" type="text" valid-characters class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
								   	<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
								</div>
							</div>
							<span class="pull-right m-r-sm" >
										<select	class="form-control input-group col-xs-5" name="templateType" data-ng-model="templateType" data-ng-change="list(1,templateType.name)" data-ng-options="templateType.name for templateType in formElements.typeList">
										<option value=""> <fmt:message key="common.all.templates" bundle="${msg}" /></option>
										</select>
										</span>
						</form>

						 <!--  My templates grid and list  -->
						<form data-ng-submit="mySearchList(mySearch,userGridTemplate)" data-ng-if =" formElements.category == 'mytemplates' && !listView">
							 <div class="pull-right m-l-sm" >
							 <a class="btn btn-info"  data-ng-click="showuserTemplateRefresh()"
											id="community_refresh_button" title="<fmt:message key="common.refresh" bundle="${msg}" />"
											ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
											</div>
							<div class="quick-search pull-right">
								<div class="input-group">
									<input data-ng-model="mySearch" id="mytemplates_grid_search" type="text" valid-characters class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
								   	<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
								</div>
							</div>
							<span class="pull-right m-r-sm" >
										<select	class="form-control input-group col-xs-5" name="userGridTemplate" data-ng-model="userGridTemplate" data-ng-change="userCreatedtemplatelist(userGridTemplate.name)" data-ng-options="userGridTemplate.name for userGridTemplate in templateElements.usertypeList">
										<option value=""> <fmt:message key="common.all.templates" bundle="${msg}" /></option>
										</select>
										</span>
						</form>
						<form data-ng-submit="vmSearchList(vmSearch,userListTemplateType)" data-ng-if ="formElements.category == 'mytemplates' && listView">
							 <div class="pull-right m-l-sm" >
							 <a class="btn btn-info"  data-ng-click="showuserTemplateRefresh()"
											id="community_refresh_button" title="<fmt:message key="common.refresh" bundle="${msg}" />"
											ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
											</div>
							<div class="quick-search pull-right">
								<div class="input-group">
									<input data-ng-model="vmSearch" id="mytemplates_list_search" type="text" valid-characters class="form-control input-medium" placeholder="<fmt:message key="common.quick.search" bundle="${msg}" />" aria-describedby="quicksearch-go">
								   	<span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
								</div>
							</div>
							<span class="pull-right m-r-sm" >
							<select	class="form-control input-group col-xs-5" name="userListTemplateType" data-ng-model="userListTemplateType" data-ng-change="userTemplatePage(userListTemplateType.name)" data-ng-options="userListTemplateType.name for userListTemplateType in templateElements.usertypeList">
										<option value=""> <fmt:message key="common.all.templates" bundle="${msg}" /></option>
										</select>
										</span>
						</form>
                    <div class="tab-content">
                        <div class="row m-t-n-md">
                            <ul class="nav nav-tabs" data-ng-init="formElements.category = 'community'">
                                <li class="active"><a href="javascript:void(0)" data-ng-click="communitylist()" data-toggle="tab"> <fmt:message key="common.community" bundle="${msg}" /></a></li>
                                <li class=""><a href="javascript:void(0)" data-ng-click="featuredlist()" data-toggle="tab"><fmt:message key="common.featured" bundle="${msg}" /></a></li>
                                <li class=""><a href="javascript:void(0)" data-ng-click="usertemplatelist()" data-toggle="tab"><fmt:message key="my.templates" bundle="${msg}" /></a></li>
<!--                                 <li class=""><a href="javascript:void(0)" data-ng-click="formElements.category = 'snapshot'" data-toggle="tab">Snapshot</a></li>
 -->                            </ul>
                        </div>
                        <div class="tab-pane" data-ng-class="{'active' : formElements.category == 'community'}" id="step1-community">
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12 ">
                                    <div class="pull-left">
                                        <div class="pull-left">
                                            <a title="<fmt:message key="grid.view" bundle="${msg}" />" class="btn btn-info" data-ng-click="showCommunityTemplateContent()"  data-ng-class="!listView ? 'disabled' : ''" > <i class="fa fa-th-large" /></a>
                                            <a title="<fmt:message key="list.view" bundle="${msg}" />"  class="btn btn-info" data-ng-click="showCommunityTemplateContent()" data-ng-class="listView ? 'disabled' : ''" > <i class="fa fa-list" /></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="text-center m-t-xxxl" >

<get-loader-image data-ng-show="showLoader"></get-loader-image>                            </div>
                            <div data-ng-hide="showLoader">
                                <div data-ng-show="listView">
                                    <div class="row" data-ng-include src="'app/views/templates/list.jsp'"></div>
                                </div>
                                <div data-ng-hide="listView">
									<div class="" data-ng-include
										src="'app/views/templates/community.jsp'">
									</div>
								</div>
                            </div>
                        </div>
                        <div class="tab-pane" data-ng-class="{'active' : formElements.category == 'featured'}" id="step1-featured">
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12 ">
                                    <div class="pull-left">
                                        <div class="pull-left">
                                            <a title="<fmt:message key="grid.view" bundle="${msg}" />" class="btn btn-info" data-ng-click="showFeaturedTemplateContent()"  data-ng-class="!listView ? 'disabled' : ''" > <i class="fa fa-th-large" /></a>
                                            <a title="<fmt:message key="list.view" bundle="${msg}" />"  class="btn btn-info" data-ng-click="showFeaturedTemplateContent()"  data-ng-class="listView ? 'disabled' : ''" > <i class="fa fa-list" /></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="text-center m-t-xxxl" >

								<get-loader-image data-ng-show="showLoader"></get-loader-image>
                            </div>
                            <div data-ng-hide="showLoader">
                                <div data-ng-show="listView">
                                    <div class="row" data-ng-include src="'app/views/templates/featureList.jsp'"></div>
                                </div>
                                <div data-ng-hide="listView">
                                    <div class="" data-ng-include src="'app/views/templates/featured.jsp'"></div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" data-ng-class="{'active' : formElements.category == 'mytemplates'}" id="step1-mytemplates">
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12 ">
                                    <div class="pull-left">
                                        <div class="pull-left">
                                            <a title="<fmt:message key="grid.view" bundle="${msg}" />" class="btn btn-info"  data-ng-click="showUserTemplateContent()"   data-ng-class="!listView ? 'disabled' : ''" > <i class="fa fa-th-large" /></a>
                                            <a title="<fmt:message key="list.view" bundle="${msg}" />"  class="btn btn-info" data-ng-click="showUserTemplateContent()"  data-ng-class="listView ? 'disabled' : ''" > <i class="fa fa-list" /></a>
                                        </div>
                                    </div>
                                    <div class="pull-right">
                                       <div class="clearfix"></div>
                                        <span class="pull-right m-l-sm">
                                            <a  class="btn btn-info" data-ng-hide="global.sessionValues.type =='ROOT_ADMIN'" has-permission = "REGISTER_TEMPLATE" data-ng-click="uploadTemplateContainer(size)"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span> <fmt:message key="register.template" bundle="${msg}" /></a>

                                        </span>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="text-center m-t-xxxl">
									<get-loader-image></get-loader-image>
                            </div>
                            <div data-ng-hide="showLoader">
                                <div data-ng-show="listView">
                                    <div class="row" data-ng-include src="'app/views/templates/userTemplatelist.jsp'"></div>
                                </div>
                                <div data-ng-hide="listView">
                                    <div class="row" data-ng-include src="'app/views/templates/mytemplates.jsp'"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<div id="footer" ng-include="'app/views/common/footer.jsp'"></div>
</div>
