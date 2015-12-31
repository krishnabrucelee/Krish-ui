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
    <div class="content" >

        <div data-ng-controller="vpcCtrl">

            <div class="row" >

                <div class="col-md-12">
  <div class="row">
                <div class="col-md-12 col-sm-12">
                      <span class="pull-right">
                            <a class="btn btn-info"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>Create Network</a>

                      </span>

                  </div>
                </div>

                    <div class="vpc-manager-area">
                        <div class="vpc pull-left">
                            <div class="hpanel">
                                <div class="v-timeline  vertical-timeline-block"  >
                                    <div class="vertical-timeline-content" >

                                        <div class="timeline-title">
                                            <span class="fa fa-exchange "></span> Router
                                        </div>
                                        <div class="p-sm">
                                            <div class="col-md-6 ">

                                                <div class="media-body">

                                                    <div class="panel panel-info">
                                                        <div class="panel-body  text-info text-center ">
                                                            <h3> 0 </h3>PRIVATE GATEWAY

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">

                                                <div class="media-body">

                                                    <div class="panel panel-info">
                                                        <div class="panel-body  text-info text-center">
                                                            <h3> 1</h3>PUBLIC IP ADDRESS

                                                        </div>
                                                    </div>
                                                </div>
                                            </div></div>
                                        <div class="p-sm">
                                            <div class="col-md-6">

                                                <div class="media-body">

                                                    <div class="panel panel-info">
                                                        <div class="panel-body  text-info text-center">
                                                            <h3> 0</h3>
                                                            SITE TO SITE VPNS
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">

                                                <div class="media-body">

                                                    <div class="panel panel-info">
                                                        <div class="panel-body  text-info text-center" >
                                                            <h3> 2</h3>NETWORK ACL LISTS

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                </div>
                            </div>
                        </div>

                        <div class="vpc-manager pull-right">
                            <div class="hpanel">
                                <div class=" vertical-container" animate-panel child="vertical-timeline-block" >
                                    <div class="v-timeline  vertical-timeline-block" data-ng-class="{'timeline-primary' : network.isDefault == 'YES'}"  data-ng-repeat="network in networkList" >
                                        <div class="h-timeline">
                                            <div class="vertical-timeline-content">

                                                <div class="timeline-title">
                                                    {{network.name}}

                                                </div>
                                                <div class="p-sm">
                                                    <div class="col-md-6">


                                                            <div class="media">
                                                                <div class="media-body">
                                                                    <a href="#">
                                                                        <div class="panel panel-info">
                                                                            <div class="panel-body  text-info text-center">

                                                                                <h3> 0 </h3>
                                                                                INTERNAL LB

                                                                            </div>
                                                                        </div> </a>
                                                                </div>

                                                            </div>
                                                    </div>
                                                    <div class="col-md-6">


                                                            <div class="media">
                                                                <div class="media-body">
                                                                    <a href="#">
                                                                        <div class="panel panel-info">
                                                                            <div class="panel-body  text-info text-center">

                                                                                <h3> 0 </h3>
                                                                                PUBLIC LB IP

                                                                            </div>
                                                                        </div></a>
                                                                </div>
                                                            </div>
                                                    </div>
                                                    <div class="col-md-6">


                                                            <div class="media">
                                                                <div class="media-body">
                                                                    <a href="#">
                                                                        <div class="panel panel-info">
                                                                            <div class="panel-body  text-info text-center" >
                                                                                <h3> 0 </h3>
                                                                                STATIC NATS

                                                                            </div>
                                                                        </div></a>
                                                                </div>
                                                            </div>






                                                    </div> <div class="col-md-6">

                                                            <div class="media">
                                                                <div class="media-body">
                                                                    <a href="#">
                                                                        <div class="panel panel-info">
                                                                            <div class="panel-body  text-info text-center">
                                                                                <h3> 0 </h3>
                                                                                VIRTUAL MACHINES

                                                                            </div>
                                                                        </div></a>
                                                                </div>
                                                            </div>
                                                    </div>
                                                    </div>
                                                <div class="col-md-6"> <div class="p-sm">CIDR: {{network.CIDR}}</div></div>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                            </div>

                                </div>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        <div id="footer" ng-include="'app/views/common/footer.jsp'"></div>




