<div class="col-lg-12" ng-controller="volumeListCtrl">
    <div class="hpanel">
        <div class="panel-heading">
            <div class="">
             
                <div class="pull-right mr-r-15">
                    <div class="input-group">
                        <input data-ng-model="volumeSearch" type="text" class="form-control input-medium ng-pristine ng-valid ng-touched" placeholder="Quick Search" aria-describedby="quicksearch-go" tabindex="0" aria-invalid="false" style="">
                        <span class="input-group-addon" id="quicksearch-go"><span class="pe-7s-search pe-lg font-bold"></span></span>
                    </div>
                </div>

            </div>
            <div class="clearfix"></div>
        </div>

        <div class="panel-body">
            <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th class="col-md-2 col-xs-2">Volume</th>
                        <th class="col-md-1 col-xs-1">Interval Type</th>
                        <th class="col-md-2 col-xs-3">Created Date</th>
                        <th class="col-md-3 col-xs-3">Status</th>
                        <th class="col-md-1 col-xs-1">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- ngRepeat: volume in volumeList | filter:volumeSearch -->
                    <tr class="ng-scope" style="">
                        <td class="ng-binding">
                            Volume-Data-1
                        </td>
                        <td class="ng-binding">Small</td>
                        <td class="ng-binding">20-07-2015</td>
                        <td><div class="loading"></div></td>
                        <td>
                         <a class="fa fa-cogs dropdown-toggle" data-toggle="dropdown" ></a>
                                            <ul class="dropdown-menu pull-right">
                                               <li><a href="#" title="Recurring Snapshot"><span class="pe-7s-repeat font-bold m-xs"></span> Recurring Snapshot</a></li>
                                                <li><a href="#" title="Delete Snapshot" data-ng-click="detachVolume(volume)"><span class="fa fa-unlink m-xs"></span> Delete Snapshot</a></li>
                                                <li><a href="#" title="Download Volume" data-ng-click="downloadVolume(volume)"><span class="pe-7s-cloud-download font-bold m-xs"></span> Download Snapshot</a></li>
                                                </ul>
                            <!--                            <a title="{{ instance.state }}"><span class="pe-7s-power pe-lg m-r"></span></a>
                                                        <a title="Restart"  ><span class="pe-7s-refresh pe-lg m-r"></span></a>
                                                        <a title="Delete"  ><span class="pe-7s-trash pe-lg"></span></a>-->
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
