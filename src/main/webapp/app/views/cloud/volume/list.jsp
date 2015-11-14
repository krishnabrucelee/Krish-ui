<div ui-view >
    <div  data-ng-controller="volumeListCtrl">
        <div class="hpanel">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12 ">
                        <div class="pull-left">
                            <div class="dashboard-box pull-left">
                                <span class="pull-right">Total Volume</span>
                                <div class="clearfix"></div>
                                <span class="pull-left m-t-xs"><img src="images/volume-icon.png"></span>
                                <b class="pull-right">13</b>
                                <div class="clearfix"></div>
                            </div>
                            <div class="dashboard-box pull-left">
                                <span class="pull-right">Running Volume</span>
                                <div class="clearfix"></div>
                                <span class="pull-left m-t-xs"><img src="images/volume-icon.png"></span>
                                <b class="pull-right">04</b>
                                <div class="clearfix"></div>
                            </div>
                            <div class="dashboard-box pull-left">
                                <span class="pull-right">Stopped Volume</span>
                                <div class="clearfix"></div>
                                <span class="pull-left m-t-xs"><img src="images/volume-icon.png"></span>
                                <b class="pull-right">09</b>
                                <div class="clearfix"></div>
                            </div>

                        </div>

                        <div class="pull-right">
                            <panda-quick-search></panda-quick-search>
                            <div class="clearfix"></div>
                            <span class="pull-right m-l-sm m-t-sm">
                                <a class="btn btn-info" data-ng-click="openUploadVolumeContainer()"><span class="pe-7s-cloud-upload pe-lg font-bold m-r-xs"></span> Upload volume</a>
                                <a class="btn btn-info" data-ng-click="openAddVolumeContainer()"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span> Add volume</a>
                                <a class="btn btn-info" ui-sref="cloud.list-volume" title="Refresh" ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
                            </span>
                        </div>

                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12 ">
                    <div class="white-content">
                        <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th class="col-md-2 col-xs-2">Name</th>
                                    <th class="col-md-1 col-xs-1">Type</th>
                                    <th class="col-md-2 col-xs-3">Plan</th>
                                    <th class="col-md-3 col-xs-3">Attached to</th>
                                    <th class="col-md-1 col-xs-1">Size</th>
                                    <th class="col-md-2 col-xs-1">Created Date</th>
                                    <th class="col-md-1 col-xs-1">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr data-ng-repeat="volume in volumeList| filter:quickSearch">
                                    <td>
                                        <a class="text-info" href="javascript:void(0)"  title="View Volume" >{{ volume.name}}</a>

                                    </td>
                                    <td>{{ volume.type.name}}</td>
                                    <td>{{ volume.plan.name}}</td>
                                    <td>{{ volume.attachedTo.name || " - " }}</td>
                                    <td>{{ volume.plan.size}}</td>
                                    <td>{{ volume.createdDate}}</td>
                                    <td>
                                        <div class="btn-group action-menu">
                                            <span data-ng-if="volume.type.id == 2">
                                                <a class="fa fa-cogs dropdown-toggle" data-toggle="dropdown" ></a>
                                                <ul class="dropdown-menu pull-right">
                                                    <img src="images/dropdown-arw2.png" border="0" class="vol-dropdown-arw">
                                                    <li><a class="icon-button" ui-sref="cloud.list-snapshot" title="Snapshot"><span class="fa fa-camera m-xs"></span> Snapshot</a></li>
                                                    <li><a href="javascript:void(0);" data-ng-click="openReccuringSnapshot(volume)" title="Recurring Snapshot"><span class="fa fa-repeat m-xs"></span> Recurring Snapshot</a></li>
                                                    <li><a href="javascript:void(0);" title="Detach Volume" data-ng-click="detachVolume('sm')"><span class="fa fa-unlink m-xs"></span> Detach</a></li>
                                                    <li><a href="javascript:void(0);" title="Download Volume" data-ng-click="downloadVolume('md')"><span class="fa fa-cloud-download m-xs"></span> Download Volume</a></li>
                                                    <li><a href="javascript:void(0);"  data-ng-click="resizeVolume(volume)" title="Resize"><span class="fa fa-expand m-xs"></span> Resize Volume</a></li>
                                                </ul>
                                            </span>
                                            <span data-ng-if="volume.type.id == 1">
                                                <a class="fa fa-cogs dropdown-toggle" data-toggle="dropdown" ></a>
                                                <ul class="dropdown-menu pull-right">
                                                    <img src="images/dropdown-arw2.png" border="0" class="vol-dropdown-arw">
                                                    <li><a class="icon-button" ui-sref="cloud.list-snapshot" title="Snapshot"><span class="fa fa-camera m-xs"></span> Snapshot</a></li>
                                                    <li><a href="javascript:void(0);" data-ng-click="openReccuringSnapshot(volume)"  title="Recurring Snapshot"><span class="fa fa-repeat m-xs"></span> Recurring Snapshot</a></li>
                                                </ul>
                                            </span>
                                        </div>

                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
