<div ng-controller="sshkeyListCtrl">
    <div class="hpanel">
        <div class="panel-heading">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="pull-left">
                    </div>
                    <div class="pull-right">
                        <panda-quick-search></panda-quick-search>
                        <div class="clearfix"></div>

                        <span class="pull-right m-l-sm m-t-sm m-b-sm">
                            <a class="btn btn-info"  ng-click="showForm('sm')"  data-backdrop="static" data-keyboard="false"><span class="pe-7s-plus pe-lg font-bold m-r-xs"></span>Create SSH Keys</a>
                            <a class="btn btn-info" ui-sref="cloud.list-ssh" href="#/sshkeys/list" title="Refresh"  ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg "></span></a>
                        </span>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12 ">
                    <div class="white-content">
                        <div class="table-responsive">
                            <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Finger Print</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr data-ng-repeat="sshKey in sshKeyList| filter:quickSearch">
                                        <td>
                                            {{ sshKey.name}}
                                        </td>
                                        <td>
                                            {{ sshKey.fingerPrint}}
                                        </td>
                                        <td>
                                            <a title="View" >

                                                <span class="fa fa-eye m-r" ></span>
                                            </a>
                                            <a title="Download"  ><span class="fa fa-cloud-download m-r"></span></a>
                                            <a title="Delete"  ><span class="fa fa-trash"></span></a>
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
</div>