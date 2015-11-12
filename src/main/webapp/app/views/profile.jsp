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
            <div class="row panel-body" ng-controller="profileCtrl">
                <input class="hidden" type="checkbox" ng-model="oneAtATime">

                <accordion close-others="oneAtATime">
                    <accordion-group is-open="status.basic">
                        <accordion-heading>
                            Basic Information <i class="pull-right glyphicon" ng-class="{'glyphicon-chevron-down': status.basic, 'glyphicon-chevron-right': !status.basic}"></i>
                        </accordion-heading>
                        <div class="row">
                            <div class="col-md-7 col-sm-7 col-xs-7">
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right">Username</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input  type="text" name="user" data-ng-model="profile.user" class="form-control" focus/>

                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right">Email</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input  type="text" name="email" data-ng-model="profile.email" class="form-control" readonly/>

                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right">Telephone</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input  type="text" name="telephone" data-ng-model="profile.telephone" class="form-control" readonly/>

                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right">Name</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input  type="text" name="name" data-ng-model="profile.name" class="form-control" focus/>

                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right">Company</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input  type="text" name="company" data-ng-model="profile.company" class="form-control" />

                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4 col-sm-4 col-xs-4"></div>
                                    <div class="col-md-6 col-sm-6 col-xs-6">
                                        <input  type="submit"   class="btn btn-info" value="Update"/>
                                    </div>
                                </div>

                            </div>


                        </div>
                    </accordion-group>
                    <accordion-group is-open="status.password">
                        <accordion-heading>
                            Update Password <i class="pull-right glyphicon" ng-class="{'glyphicon-chevron-down': status.password, 'glyphicon-chevron-right': !status.password}"></i>
                        </accordion-heading>
                        <div class="row">
                            <div class="col-md-7 col-sm-7 col-xs-7">
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right">Original Password</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input  type="password" name="password" data-ng-model="profile.password" class="form-control" focus/>

                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right">New Password</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input  type="password" name="newpassword" data-ng-model="profile.newpassword" class="form-control" focus/>

                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right">Confirm Password</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <input  type="password" name="confirm" data-ng-model="profile.confirm" class="form-control" />

                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4 col-sm-4 col-xs-4"></div>
                                    <div class="col-md-6 col-sm-6 col-xs-6">
                                        <input  type="submit"   class="btn btn-info" value="Update"/>
                                    </div>
                                </div>

                            </div>


                        </div> </accordion-group>
                    <accordion-group is-open="status.api">
                        <accordion-heading>
                            API Information<i class="pull-right glyphicon" ng-class="{'glyphicon-chevron-down': status.api, 'glyphicon-chevron-right': !status.api}"></i>
                        </accordion-heading>
                        <div class="row">
                            <div class="col-md-7 col-sm-7 col-xs-7">
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right">User ID:</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            {{profile.userId}}
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-md-4 col-sm-4 control-label"> <span class="pull-right">Project ID:</span></label>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            {{profile.projectId}}

                                        </div>
                                    </div>
                                </div>

                                <div class="row">
<!--                                    <a class="btn btn-info">Download</a>
                                    <div class="col-md-4 col-sm-4 col-xs-4"></div>
                                    <div class="col-md-6 col-sm-6 col-xs-6">
                                        <input  type="submit"   class="btn btn-info" value="Update"/>
                                    </div>-->
                                </div>

                            </div>


                        </div> </accordion-group>
                </accordion>



            </div>
        </div>

    </div>
</div>
