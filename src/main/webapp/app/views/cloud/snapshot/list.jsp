<div class="row" data-ng-controller="snapshotListCtrl">

       <div class="col-md-12 col-sm-12">
        <div class="hpanel">


             <div class="panel-body" >

        <div class="tab-content">


            <div class="row m-t-n-md">
                <ul class="nav nav-tabs" data-ng-init="formElements.category = 'snapshot'">
                    <li class="active"><a href="javascript:void(0)" data-ng-click="formElements.category = 'snapshot'" data-toggle="tab">Snapshot</a></li>
                    <li class=""><a href="javascript:void(0)" data-ng-click="formElements.category = 'VM Snapshot'" data-toggle="tab">VM Snapshot</a></li>

                </ul>
            </div>

            <div class="tab-pane" data-ng-class="{'active' : formElements.category == 'snapshot'}" id="snapshot">
                <div class="row" data-ng-include src="'app/views/cloud/snapshot/snapshot.jsp'"></div>
            </div>

            <div class="tab-pane" data-ng-class="{'active' : formElements.category == 'VM Snapshot'}" id="vmSnapshot">
                <div class="row" data-ng-include src="'app/views/cloud/snapshot/vmSnapshot.jsp'"></div>
            </div>


        </div>
    </div>
        </div>
    </div>
</div>
