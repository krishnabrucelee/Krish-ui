<!-- This is content container for nested view in UI-Router-->
<!-- You can put here any constant element in app content for example: Page title or breadcrum -->

<!-- Header -->
<div id="header" ng-include="'app/views/common/header.jsp'"></div>

<!-- Navigation -->
<aside id="menu" ng-include="'app/views/common/navigation.jsp'"></aside>

<!-- Main Wrapper -->
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
            <div class="hpanel">
                <div class="hpanel">
                    <div class="row m-l-sm m-r-sm panel-body" ng-controller="activityCtrl">
                        <ul class="nav nav-tabs" >
                            <li data-ng-class="{'active' : activity.category == 'events'}"><a   data-ng-click="getActivityByCategory('events', 1)" data-toggle="tab">  <i class="fa fa-calendar"></i> Events</a></li>
                            <li data-ng-if="global.sessionValues.type=='ROOT_ADMIN'" data-ng-class="{'active' : activity.category == 'alerts'}"><a   data-ng-click="getActivityByCategory('alerts', 1)" data-toggle="tab"> <i class="fa fa-warning"></i> Alerts</a></li>
                            <li data-ng-class="{'active' : activity.category == 'notifications'}"><a data-ng-click="getActivityByCategory('notifications', 1)" data-toggle="tab"> <i class="fa fa-bell"></i> Notifications</a></li>
               			</ul>
                      <div class="tab-content">
                      <div data-ng-show="showLoader" style="margin: 1%">
							<get-loader-image data-ng-show="showLoader"></get-loader-image>
						</div>
                            <div data-ng-hide="showLoader" class="tab-pane"  data-ng-class="{'active' : activity.category == 'events'}" id="events">
                                <div data-ng-include src="'app/views/activity/events.jsp'"></div>
                            </div>
                            <div data-ng-hide="showLoader" class="tab-pane"  data-ng-class="{'active' : activity.category == 'alerts'}" id="alerts">
                                <div data-ng-include src="'app/views/activity/alerts.jsp'"></div>
                            </div>
                            <div data-ng-hide="showLoader" class="tab-pane"  data-ng-class="{'active' : activity.category == 'notifications'}" id="notifications">
                                <div data-ng-include src="'app/views/activity/notifications.jsp'"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
