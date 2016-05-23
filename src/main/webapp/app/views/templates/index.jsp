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
        <div class="hpanel" tour-step order="1" title="Page header" content="Place your page title and breadcrumb. Select small or large header or give the user choice to change the size." placement="bottom">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a ui-sref="dashboard">Home</a></li>
                        <li ng-repeat="state in $state.$current.path" ng-switch="$last || !!state.abstract" ng-class="{active: $last}">
                            <a ng-switch-when="false" href="{{state.url.format($stateParams)}}">{{state.data.pageTitle}}</a>
                            <span ng-switch-when="true">{{state.data.pageTitle}}</span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    {{ $state.current.data.pageTitle}}
                </h2>
                <small>{{ $state.current.data.pageDesc}}</small>
            </div>
        </div>
    </div>
    <div class="content">
        <div ui-view >
            <div class="hpanel" ng-controller="templatesCtrl">
                <div class="panel-body" >
                    <div class="tab-content">
                        <div class="row m-t-n-md">
                            <ul class="nav nav-tabs" data-ng-init="formElements.category = 'community'">
                                <li class="active"><a href="javascript:void(0)" data-ng-click="communitylist()" data-toggle="tab"> <fmt:message key="common.community" bundle="${msg}" /></a></li>
                                <li class=""><a href="javascript:void(0)" data-ng-click="featuredlist()" data-toggle="tab"><fmt:message key="common.featured" bundle="${msg}" /></a></li>
                                <li class=""><a href="javascript:void(0)" data-ng-click="usertemplatelist()" data-toggle="tab">My Templates</a></li>
<!--                                 <li class=""><a href="javascript:void(0)" data-ng-click="formElements.category = 'snapshot'" data-toggle="tab">Snapshot</a></li>
 -->                            </ul>
                        </div>
                        <div class="tab-pane" data-ng-class="{'active' : formElements.category == 'community'}" id="step1-community">
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12 ">
                                    <div class="pull-left">
                                        <div class="pull-left">
                                            <a title="Grid View" class="btn btn-info" data-ng-click="showCommunityTemplateContent()"  data-ng-class="!listView ? 'disabled' : ''" > <i class="fa fa-th-large" /></a>
                                            <a title="List View"  class="btn btn-info" data-ng-click="showCommunityTemplateContent()" data-ng-class="listView ? 'disabled' : ''" > <i class="fa fa-list" /></a>
                                            <a class="btn btn-info" data-ng-click="showCommunityRefresh()"
											id="community_refresh_button" title="<fmt:message key="common.refresh" bundle="${msg}" />"
											ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
                                        </div>
                                    </div>
                                   <!--  <div class="pull-right">
                                        <panda-quick-search></panda-quick-search>
                                        <div class="clearfix"></div>
                                        <span class="pull-right m-l-sm m-t-sm">
                                            <a  class="btn btn-info" data-ng-click="uploadTemplateContainer()"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span> Register Template</a>
                                            <a  class="btn btn-info" title="Refresh"><span class="fa fa-refresh fa-lg "></span></a>
                                        </span>
                                    </div> -->

                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="text-center m-t-xxxl" data-ng-show="showLoader">
                                <img src="images/loading-bars.svg" />
                            </div>
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
                                            <a title="Grid View" class="btn btn-info" data-ng-click="showFeaturedTemplateContent()"  data-ng-class="!listView ? 'disabled' : ''" > <i class="fa fa-th-large" /></a>
                                            <a title="List View"  class="btn btn-info" data-ng-click="showFeaturedTemplateContent()"  data-ng-class="listView ? 'disabled' : ''" > <i class="fa fa-list" /></a>
			                                <a class="btn btn-info" data-ng-click="showFeaturedRefresh()"
											id="featured_refresh_button" title="<fmt:message key="common.refresh" bundle="${msg}" />"
											ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
                                        </div>
                                    </div>
                                   <!--  <div class="pull-right">
                                        <panda-quick-search></panda-quick-search>
                                        <div class="clearfix"></div>
                                        <span class="pull-right m-l-sm m-t-sm">
                                            <a  class="btn btn-info" data-ng-click="uploadTemplateContainer()"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span> Register Template</a>
                                            <a  class="btn btn-info" title="Refresh"><span class="fa fa-refresh fa-lg "></span></a>
                                        </span>
                                    </div> -->

                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="text-center m-t-xxxl" data-ng-show="showLoader">
                                <img src="images/loading-bars.svg" />
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
                                            <a title="Grid View" class="btn btn-info"  data-ng-click="showUserTemplateContent()"   data-ng-class="!listView ? 'disabled' : ''" > <i class="fa fa-th-large" /></a>
                                            <a title="List View"  class="btn btn-info" data-ng-click="showUserTemplateContent()"  data-ng-class="listView ? 'disabled' : ''" > <i class="fa fa-list" /></a>
                                          <a class="btn btn-info" data-ng-click="showuserTemplateRefresh()"
											id="featured_refresh_button" title="<fmt:message key="common.refresh" bundle="${msg}" />"
											ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
                                        </div>
                                    </div>
                                    <div class="pull-right">
                                       <div class="clearfix"></div>
                                        <span class="pull-right m-l-sm">
                                            <a  class="btn btn-info" data-ng-hide="global.sessionValues.type =='ROOT_ADMIN'" has-permission = "REGISTER_TEMPLATE" data-ng-click="uploadTemplateContainer(size)"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span> Register Template</a>

                                        </span>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="text-center m-t-xxxl" data-ng-show="showLoader">
                                <img src="images/loading-bars.svg" />
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
                        <!-- <div class="tab-pane" data-ng-class="{'active' : formElements.category == 'snapshot'}" id="step1-snapshot">
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12 ">
                                    <div class="pull-left">
                                        <div class="pull-left">
                                            <a title="Grid View" class="btn btn-info" data-ng-click="showTemplateContent()"  data-ng-class="!listView ? 'disabled' : ''" > <i class="fa fa-th-large" /></a>
                                            <a title="List View"  class="btn btn-info" data-ng-click="showTemplateContent()" data-ng-class="listView ? 'disabled' : ''" > <i class="fa fa-list" /></a>
                                        </div>
                                    </div>
                                    <div class="pull-right">
                                        <panda-quick-search></panda-quick-search>
                                        <div class="clearfix"></div>
                                        <span class="pull-right m-l-sm m-t-sm">
                                            <a  class="btn btn-info" data-ng-click="uploadTemplateContainer()"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span> Register Template</a>
                                            <a  class="btn btn-info" title="Refresh"><span class="fa fa-refresh fa-lg "></span></a>
                                        </span>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="text-center m-t-xxxl" data-ng-show="showLoader">
                                <img src="images/loading-bars.svg" />
                            </div>
                            <div data-ng-hide="showLoader">
                                <div data-ng-show="listView">
                                    <div class="row" data-ng-include src="'app/views/templates/list.jsp'"></div>
                                </div>
                                <div data-ng-hide="listView">
                                    <div class="row" data-ng-include src="'app/views/templates/snapshot.jsp'"></div>
                                </div>
                            </div>
                        </div> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
<div id="footer" ng-include="'app/views/common/footer.jsp'"></div>
</div>
