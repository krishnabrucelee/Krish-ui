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
                            <a ng-switch-when="false" href="#{{state.url.format($stateParams)}}">{{state.data.pageTitle}}</a>
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
    <div data-ng-controller="departmentCtrl">
<form name="departmentForm" data-ng-submit="validateDepartment(departmentForm)" method="post" novalidate="" >

    <div class="row">
        <div class="col-md-12 col-sm-12">
            <div class="hpanel">

                <div class="panel-body">
                    <div class="col-md-7 col-sm-7">


                        <div class="form-group" ng-class="{
                                            'has-error'
                                            : departmentForm.name.$invalid && formSubmitted}">
                            <div class="row">
                                <label class="col-md-4 col-sm-5 control-label">Name:
                                    <span class="text-danger">*</span>
                                </label>

                                <div class="col-md-6 col-sm-7">
                                    <input required="true" type="text" name="name" data-ng-model="department.name"   class="form-control" >
                                    <span class="help-block m-b-none" ng-show="departmentForm.name.$invalid && formSubmitted" >Name is required.</span>
                                    <i class="pe-7s-help1 pe-lg m-l-n-sm tooltip-icon" tooltip="Name of the department" ></i>

                                </div>

                            </div>
                        </div>
                   <div class="form-group"  data-ng-class="{
                                            'has-error'
                                            : departmentForm.summernoteTextTwo.$invalid && formSubmitted}">
                        <div class="row" >
                            <label class="col-md-4 col-sm-5 control-label ">Description:
                                <span class="text-danger">*</span>
                            </label>

                            <div class="col-md-6 col-sm-7" >

                                <summernote name="summernoteTextTwo" required="true" height="100"  data-ng-model="department.summernoteTextTwo" config="summernoteOpt"></summernote>
                                 <span class="help-block m-b-none " ng-show="departmentForm.summernoteTextTwo.$invalid && formSubmitted" >Description is required.</span>
                         </div>

                        </div>
                        </div>

                         <div class="form-group">
                            <div class="row">
                                <label class="col-md-4 col-sm-5 control-label">
                                </label>
                                <div class="col-md-6 col-sm-7">
                        <button class="btn btn-info" type="submit">Save</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>


        </div>
    </div></form>
</div>
</div>