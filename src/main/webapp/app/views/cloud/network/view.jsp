<div ui-view>
<div class="hpanel">
<div class="row m-l-sm m-r-sm panel-body" ng-controller="networkViewCtrl">

    <ul class="nav nav-tabs" data-ng-init="templateCategory = tabview">
        <li data-ng-class="{'active' : tabview != 'egress'}"><a href="javascript:void(0)" data-ng-click="templateCategory = 'details'" data-toggle="tab">  <i class="fa fa-list"></i> Details</a></li>
        <li data-ng-class="{'active' : tabview == 'egress'}"><a  data-ng-click="templateCategory = 'egress'" data-toggle="tab"><!--<i class="fa fa-sign-in"></i>--> <i class="custom-icon custom-icon-egress"></i> Egress Rule</a></li>
        <li ><a  data-ng-click="templateCategory = 'ip'" data-toggle="tab"> <!--<i class="fa fa-sitemap"></i>--> <i class="custom-icon custom-icon-ip"></i> IP Address</a></li>
        <li ><a data-ng-click="templateCategory = 'instance'" data-toggle="tab"> <i class="fa fa-cloud"></i> Instance</a></li>
    </ul>

    <div class="tab-content">

        <div class="tab-pane" data-ng-class="{'active' : templateCategory == 'details'}" id="step1-dashboard">

            <div data-ng-include src="'app/views/cloud/network/details.jsp'"></div>

        </div>
        <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'egress'}" id="step1-config">
            <div data-ng-include src="'app/views/cloud/network/egress.jsp'"></div>
        </div>
        <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'ip'}" id="step1-storage">
            <div data-ng-include src="'app/views/cloud/network/ip-address.jsp'"></div>
        </div>
        <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'instance'}" id="step1-network">
        <div data-ng-include src="'app/views/cloud/network/instance.jsp'"></div>
        </div>

    </div>


</div>
</div>
</div>

