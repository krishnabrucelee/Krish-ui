<!-- This is content container for nested view in UI-Router-->
<!-- You can put here any constant element in app content for example: Page title or breadcrum -->

<!-- Header -->
<div id="header" ng-include="'views/common/header.html'"></div>

<!-- Navigation -->
<aside id="menu" ng-include="'views/common/navigation.html'"></aside>

<!-- Main Wrapper -->
<div id="wrapper">
    <div small-header class="normalheader transition ng-scope small-header">
        <div class="hpanel" tour-step order="1" title="Page header" content="Place your page title and breadcrumb. Select small or large header or give the user choice to change the size." placement="bottom">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a ui-sref="dashboard">Home</a></li>
                        <li ng-repeat="state in $state.$current.path" ng-switch="$last || !!state.abstract" ng-class="{active: $last}">
                            <a ng-switch-when="false" href="#{{state.url.format($stateParams)}}">{{state.data.pageTitle}}</a>
                            <span ng-switch-when="true">{{state.data.pageTitle}}</span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    {{ $state.current.data.pageTitle }}
                </h2>
                <small>{{ $state.current.data.pageDesc }}</small>
            </div>
        </div>
    </div>
    <div class="content">
        <div ui-view >
<div class="hpanel">
            
            
             <div class="panel-body" >
      
        <div class="tab-content">

            
            <div class="row m-t-n-md">
                <ul class="nav nav-tabs" data-ng-init="formElements.category = 'configuration'">
                    <li class="active"><a href="javascript:void(0)" data-ng-click="formElements.category = 'configuration'" data-toggle="tab">General</a></li>
                    <li class=""><a href="javascript:void(0)" data-ng-click="formElements.category = 'chargeback'" data-toggle="tab">Chargeback</a></li>
                    <li class=""><a href="javascript:void(0)" data-ng-click="formElements.category = 'cloudStack'" data-toggle="tab">Cloud Stack</a></li>
                </ul>
            </div>

            <div class="tab-pane" data-ng-class="{'active' : formElements.category == 'configuration'}" id="configuration">
                <div class="row" data-ng-include src="'views/configuration/general.html'"></div>
            </div>

            <div class="tab-pane" data-ng-class="{'active' : formElements.category == 'chargeback'}" id="chargeback">
                <div class="row" data-ng-include src="'views/configuration/chargeback.html'"></div>
            </div>
           <div class="tab-pane" data-ng-class="{'active' : formElements.category == 'cloudStack'}" id="cloudStack">
                <div class="row" data-ng-include src="'views/configuration/cloud-stack.html'"></div>
            </div>
            
        </div>
    </div>
        </div>
</div>
</div>

</div>
