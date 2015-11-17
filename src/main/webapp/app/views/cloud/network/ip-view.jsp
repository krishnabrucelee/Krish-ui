<div class="hpanel">
<div class="row m-l-sm m-r-sm panel-body" ng-controller="networkViewCtrl">

    <ul class="nav nav-tabs" data-ng-init="templateCategory = tabview">
        <li data-ng-class="{'active' : tabview == 'details'}"><a href="javascript:void(0)" data-ng-click="templateCategory = 'details'" data-toggle="tab">  <i class="fa fa-list"></i> Details</a></li>
        <li data-ng-class="{'active' : tabview == 'firewall'}"><a  data-ng-click="templateCategory = 'firewall'" data-toggle="tab"><i class="custom-icon custom-firewall-ip"></i> Firewall</a></li>
        <li data-ng-class="{'active' : tabview == 'port-forward'}"><a  data-ng-click="templateCategory = 'port-forward'" data-toggle="tab"> <i class="fa fa-mail-forward"></i> Port Forwarding</a></li>
        <li data-ng-class="{'active' : tabview == 'load-balance'}"><a data-ng-click="templateCategory = 'load-balance'" data-toggle="tab"> <i class="custom-icon custom-load-ip"></i> Load Balancing</a></li>
    </ul>

    <div class="tab-content">
        <div class="tab-pane" data-ng-class="{'active' : templateCategory == 'details'}" id="step1-dashboard">

            <div data-ng-include src="'app/views/cloud/network/ip-details.jsp'"></div>

        </div>
        <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'firewall'}" id="step1-config">
            <div data-ng-include src="'app/views/cloud/network/firewall.jsp'"></div>
        </div>
        <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'port-forward'}" id="step1-storage">
            <div data-ng-include src="'app/views/cloud/network/port-forward.jsp'"></div>
        </div>
        <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'load-balance'}" id="step1-network">
        <div data-ng-include src="'app/views/cloud/network/load-balance.jsp'"></div>
        </div>

    </div>


</div>
</div>

