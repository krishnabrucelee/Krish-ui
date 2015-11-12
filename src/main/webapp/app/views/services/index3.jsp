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
<div class="hpanel" ng-controller="templatesCtrl"> 
    <div class="row m-b-sm">
        <div class="col-md-3 col-sm-3 col-xs-3 col-lg-3 font-bold">
            <div class="quick-search">
                <div class="input-group">
                    <input data-ng-model="templateSearch" type="text" class="form-control input-medium" placeholder="Quick Search" aria-describedby="quicksearch-go">
                    <span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
                </div>
            </div>
        </div>
        <div class="col-md-9 col-sm-9 col-xs-9  col-lg-9 no-padding no-margins m-b-md" >

            <span class="pull-right m-l-sm m-r-xs">


                <a class="btn btn-info" data-ng-click="uploadTemplateContainer()"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span> Register Template</a>

                <a class="btn btn-info" ui-sref="template-store" title="Refresh" ui-sref-opts="{reload: true}" ><span class="fa fa-refresh fa-lg "></span></a>
            </span>

        </div>

    </div>
    <div class="panel-body" >
      
        <div class="tab-content">

            
            <div class="row m-t-n-md">
                <ul class="nav nav-tabs" data-ng-init="formElements.category = 'community'">
                    <li class="active"><a href="javascript:void(0)" data-ng-click="formElements.category = 'community'" data-toggle="tab"> Community</a></li>
                    <li class=""><a href="javascript:void(0)" data-ng-click="formElements.category = 'featured'" data-toggle="tab">Featured</a></li>
                    <li class=""><a href="javascript:void(0)" data-ng-click="formElements.category = 'mytemplates'" data-toggle="tab">My Templates</a></li>
                    <li class=""><a href="javascript:void(0)" data-ng-click="formElements.category = 'snapshot'" data-toggle="tab">Snapshot</a></li>
                </ul>
            </div>

            <div class="tab-pane" data-ng-class="{'active' : formElements.category == 'community'}" id="step1-community">
                <div class="row" data-ng-include src="'views/templates/community.html'"></div>
            </div>

            <div class="tab-pane" data-ng-class="{'active' : formElements.category == 'featured'}" id="step1-featured">
                <div class="row" data-ng-include src="'views/templates/featured.html'"></div>
            </div>
            <div class="tab-pane" data-ng-class="{'active' : formElements.category == 'mytemplates'}" id="step1-mytemplates">
                <div class="row" data-ng-include src="'views/templates/mytemplates.html'"></div>
            </div>
            <div class="tab-pane" data-ng-class="{'active' : formElements.category == 'snapshot'}" id="step1-snapshot">
                <div class="row" data-ng-include src="'views/templates/snapshot.html'"></div>
            </div>
        </div>
    </div>
</div>

</div>
</div>

</div>
