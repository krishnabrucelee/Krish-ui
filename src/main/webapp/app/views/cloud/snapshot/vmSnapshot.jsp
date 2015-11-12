<div class="row" data-ng-controller="snapshotListCtrl">

    <div class="col-md-12 col-sm-12">
        <div class="hpanel">
            <div class="panel-heading">
                <div class="row" > 

                    <div class="col-md-12 col-sm-12 pull-left m-b-sm">Note:
                        <span class="text-danger ">You cannot attach or detach the storage volume, when the particular Instance have VM snapshots. </span>
                    </div>

                </div>
                
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12 ">
                        <div class="pull-left">
                            <div class="pull-left">

                            </div>
                        </div>
                        <div class="pull-right">
                            <panda-quick-search></panda-quick-search>
                            <div class="clearfix"></div>

                            <span class="pull-right m-l-sm m-t-sm">
                                <a class="btn btn-info"  ng-click="openAddVMSnapshotContainer()"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>Create VM Snapshot</a>
                                <a class="btn btn-info" title="Refresh"  ><span class="fa fa-refresh fa-lg"></span></a>
                            </span>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
                
                
                 </div>

            <div class="white-content">
                

                <div class="table-responsive">
                    <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th class="col-md-2 col-sm-2">Name</th>
                                <th class="col-md-2 col-sm-2">Description</th>
                                <th class="col-md-2 col-sm-2">Instance</th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr data-ng-repeat="snapshot in snapshotList| filter:quickSearch">
                                <td>
                                    {{ snapshot.snapshotName}}
                                </td>
                                <td>
                                    {{ snapshot.volumeName}}
                                </td>
                                <td>
                                    {{ snapshot.instanceName}}
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>