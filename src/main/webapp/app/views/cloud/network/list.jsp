<div ui-view ng-controller="networksCtrl">

    <div data-ng-hide="viewContent" ng-controller="networkListCtrl">
        <div class="hpanel">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12 ">
                        <div class="pull-left">
                            <div class="dashboard-box pull-left">
                                <span class="pull-right">Total Network</span>
                                <div class="clearfix"></div>
                                <span class="pull-left m-t-xs"><img src="images/network-icon.png"></span>
                                <b class="pull-right">13</b>
                                <div class="clearfix"></div>
                            </div>
                            <div class="dashboard-box pull-left">
                                <span class="pull-right">Isolated Network</span>
                                <div class="clearfix"></div>
                                <span class="pull-left m-t-xs"><img src="images/network-icon.png"></span>
                                <b class="pull-right">04</b>
                                <div class="clearfix"></div>
                            </div>
                            <div class="dashboard-box pull-left">
                                <span class="pull-right">Shared Network</span>
                                <div class="clearfix"></div>
                                <span class="pull-left m-t-xs"><img src="images/network-icon.png"></span>
                                <b class="pull-right">09</b>
                                <div class="clearfix"></div>
                            </div>
                        </div>

                        <div class="pull-right">
                            <panda-quick-search></panda-quick-search>
                            <span class="pull-right m-r-sm">
                                <select  class="form-control input-group col-xs-5" name="networkView" data-ng-init="network.networkView = networkLists.views[0]" data-ng-model="network.networkView" data-ng-change="selectView(network.networkView.name)" data-ng-options="networkView.name for networkView in networkLists.views"></select>
                            </span>

                            <div class="clearfix"></div>
                            <span class="pull-right m-l-sm m-t-sm">
                                <a class="btn btn-info" data-ng-click="openAddIsolatedNetwork('lg')"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>Add Isolated Network</a>
                                <a ui-sref-opts="{reload: true}" title="Refresh"  data-ng-click="selectedNetwork(network.networkView.name)" class="btn btn-info"><span class="fa fa-refresh fa-lg "></span></a>

                            </span>
                        </div>

                    </div>
                </div>
                <div class="clearfix"></div>
            </div>

            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12 ">
                    <div class="white-content">
                        <div class="table-responsive">

                            <div data-ng-show="network.networkView.name == 'Guest Networks' || network.networkView.name == null" data-ng-include src="'app/views/cloud/network/guest-networks.jsp'"></div>

                            <div data-ng-show="network.networkView.name == 'Security Groups'" data-ng-include src="'app/views/cloud/network/security-groups.jsp'"></div>

                            <div data-ng-show="network.networkView.name == 'VPC'" data-ng-include src="'app/views/cloud/network/vpc.jsp'"></div>

                            <div data-ng-show="network.networkView.name == 'VPN Customer Gateway'" data-ng-include src="'app/views/cloud/network/vpn.jsp'"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
