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

        <div data-ng-controller="reportCtrl">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="panel-info panel ">
                        <div class="panel-heading">
                            <h3 class="panel-title"> Last 12 Months Cost - (20/SEP/2014 - 21/SEP/2015)</h3>
                        </div>
                        <div class="p-sm">
                            <a href="#" class="btn btn-info pull-right m-r-xs "><span class="fa fa-file-pdf-o "></span> PDF</a><a href="#" class="btn btn-info pull-right m-r-xs "><span class=" fa fa-file-excel-o "></span> CSV</a>

                            <div class="p-sm">


                            </div>
                        </div>

                        <div class="white-content">
                            <div class="table-responsive p-sm">
                                <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Instance</th>
                                            <th>VM Snapshot</th>
                                            <th>Storage</th>
                                            <th>Snapshot Memory</th>
                                            <th>Public IPs</th>
                                            <th>Port Forwarding</th>
                                            <th>Load Balancer</th>
                                            <th>Total Amount (<app-currency></app-currency>)</th>
                                            <th>Total Paid (<app-currency></app-currency>)</th>

                                    </tr>
                                    </thead>
                                    <tbody>
                                        <tr data-ng-repeat="client in generatedList">
                                            <td class="col-md-1">{{client.date}}</td>
                                            <td>{{client.resource.instance}}</td>
                                            <td>{{client.resource.vmSnapshot}}</td>
                                            <td>{{client.resource.storage}}</td>
                                            <td>{{client.resource.memorySnapshot}}</td>
                                            <td>{{client.resource.ip}}</td>
                                            <td>{{client.resource.port}}</td>
                                            <td>{{client.resource.lb}}</td>
                                            <td>{{client.amount}}</td>
                                            <td>{{client.payable}}</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <label class="pull-right m-r-sm text-danger h4"> <app-currency></app-currency> 4000.00 </label> <label class="pull-right text-info m-r-sm h4">Total Amount</label>
                            </div>
                        </div>


                    </div>
                </div></div>
        </div>
    </div>
</div>
