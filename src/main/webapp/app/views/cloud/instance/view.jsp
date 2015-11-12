<div class="hpanel">
    <div class="row m-l-sm m-r-sm panel-body" ng-controller="instanceViewCtrl">

        <ul class="nav nav-tabs" data-ng-init="templateCategory = 'dashboard'">
            <li class="active"><a href="javascript:void(0)" data-ng-click="templateCategory = 'dashboard'" data-toggle="tab">  <i class="fa fa-laptop"></i> DASHBOARD</a></li>
            <li class=""><a  data-ng-click="templateCategory = 'config'" data-toggle="tab"> <i class="fa fa-cogs"></i> CONFIGURATION</a></li>
            <li class=""><a  data-ng-click="templateCategory = 'storage'" data-toggle="tab"><i class="fa fa-database"></i> STORAGE</a></li>
            <li class=""><a  data-ng-click="templateCategory = 'network'" data-toggle="tab"> <!--<i class="fa fa-sitemap"></i>--><i class="custom-icon custom-icon-network"></i> NETWORKING</a></li>
            <li class=""><a data-ng-click="templateCategory = 'monitor'" data-toggle="tab"> <i class="fa fa-desktop"></i> MONITOR</a></li>
        </ul>

        <div class="tab-content">

            <div class="tab-pane" data-ng-class="{'active' : templateCategory == 'dashboard'}" id="step1-dashboard">
                <div class="row" >

                    <div class="col-lg-9 col-md-8 col-sm-12">
                        <div class="hpanel">
                            <div class="pull-right">
                                <a title="Refresh"  class="btn btn-info" ui-sref="cloud.list-instance.view-instance"  ui-sref-opts="{reload: true}" ><span class="fa fa-refresh fa-lg "></span></a>

                            </div>
                            <div class="pull-right m-r-sm">
                                <select  class="form-control" name="actions" data-ng-init="instance.actions = instanceElements.actions[3].name" data-ng-model="instance.actions" ng-options="actions.name for actions in instanceElements.actions" >
                                    <option value="">Minutes</option>
                                </select>
                            </div>
                            <div class="clearfix"></div>
                            <div class="chart">

                                <canvas  linechart options="lineOptions" data="lineData" width="800" height="280"></canvas>
                            </div>
                            <table>
                                <tbody>
                                    <tr>
                                        <td class="legendColorBox p-xs">
                                            <div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #E56919;overflow:hidden"></div></div>
                                        </td>
                                        <td class="legendLabel">vCPU (%)</td>
                                        <td class="legendColorBox p-xs"><div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #16658D;overflow:hidden"></div></div>
                                        </td>
                                        <td class="legendLabel">Memory (%)</td><td class="legendColorBox p-xs"><div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #7208A8;overflow:hidden"></div></div>
                                        </td>
                                        <td class="legendLabel">N/W  (kB/s)</td><td class="legendColorBox p-xs"><div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid rgba(98,203,49,0.5);overflow:hidden"></div></div>
                                        </td>
                                        <td class="legendLabel">Disk  (Bytes/sec)</td></tr></tbody></table>

                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4 col-sm-5">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-bolt"></i>&nbsp;&nbsp;Quick Actions</h3>
                            </div>
                            <div class="panel-body no-padding">
                                <ul class="list-group">
                                    <li class="list-group-item">
                                        <a href="javascript:void(0);" title="Stop" data-ng-click="stopVm('sm',instance)" data-ng-show="instance.status == 'Running'"><span class="fa-ban fa font-bold m-xs"></span> Stop</a>
                                        <a href="javascript:void(0);" title="Start" data-ng-click="startVm('sm',instance)" data-ng-show="instance.status == 'Stopped'"><span class="fa-play fa font-bold m-xs"></span> Start</a>
                                    </li>
                                    <li data-ng-if="instance.status == 'Running'" class="list-group-item">
                                        <a href="javascript:void(0);" data-ng-if="instance.status == 'Running'" title="Restart" data-ng-click="rebootVm('sm',instance)"><span class="fa-rotate-left fa font-bold m-xs"></span> Reboot</a>
                                    </li>
                                    <li class="list-group-item" data-ng-if="instance.status == 'Running'">
                                        <a href="javascript:void(0);" title="View Console"><span class="fa-desktop fa font-bold m-xs"></span> View Console</a>
                                    </li>
                                    <li class="list-group-item">
                                        <a href="javascript:void(0);" title="Reset password"><span class="fa-key fa font-bold m-xs"></span> Show/Reset Password</a>
                                    </li>
                                    <li class="list-group-item">
                                        <a href="javascript:void(0);" title="Reinstall vm" data-ng-click="reInstallVm('md',instance)"><span class="fa fa-history m-xs"></span> Reinstall VM</a>
                                    </li>
                                    <li class="list-group-item">
                                        <a href="javascript:void(0);" data-ng-click="reDestroyVm('sm',instance)" title="Destroy vm"><span class="fa-times-circle fa font-bold m-xs"></span> Destroy VM</a>
                                    </li>
                                    <li data-ng-if="instance.status == 'Destroyed'" class="list-group-item">
                                        <a href="javascript:void(0);" data-ng-if="instance.status == 'Destroyed'" data-ng-click="recoverVm('sm',instance)" title="Recover vm"><span class="fa-history fa font-bold m-xs"></span> Recover VM</a>
                                    </li>
                                    <li class="list-group-item">
                                        <a href="javascript:void(0);" title="Attach ISO"><span class="pe-7s-disk pe-1x font-bold m-xs"></span> Attach ISO</a>
                                    </li>
                                    <li class="list-group-item">
                                        <a href="javascript:void(0);" title="Vm Snapshot"><span class="fa-camera fa font-bold m-xs"></span> Take VM snapshot</a>
                                    </li>
                                    <li class="list-group-item">
                                        <!--<a href="#" title="Edit Note">  <span class="fa-edit fa font-bold m-xs"></span> Edit Note</a>-->
                                        <a  title="Edit Note" data-ng-click="showDescription(instance)"><span class="fa-edit fa font-bold m-xs"></span>Edit Note</a>

                                    </li>

                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-7">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-cloud"></i>&nbsp;&nbsp;INSTANCE SUMMARY</h3>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <table class="table table-condensed table-striped" cellspacing="1" cellpadding="1">
                                            <tbody>
                                                <tr>
                                                    <td class="col-md-4 col-sm-4"><b>Zone</b></td>
                                                    <td class="col-md-8 col-sm-8">{{ instance.zone.name}}</td>
                                                </tr>
                                                <tr>
                                                    <td><b>Display Name</b></td>
                                                    <td> {{ instance.name}}</td>
                                                </tr>
                                                <tr>
                                                    <td><b>Status</b></td>
                                                    <td><b class="text-uppercase" data-ng-class="instance.status == 'Stopped' ? 'text-danger' : 'text-success' ">{{ instance.status}} </b></td>
                                                </tr>
                                                <tr>
                                                    <td><b>Offer</b></td>
                                                    <td>{{ instance.computeOffering.name}} <a href="#" class="fa fa-edit m-l-lg"> edit</a></td>
                                                </tr>
                                                <tr>
                                                    <td><b>IP</b></td>
                                                    <td>{{ instance.ipAddress}} | {{instance.network.type}} </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="col-md-6">
                                        <table class="table table-condensed table-striped" cellspacing="1" cellpadding="1">
                                            <tbody>
                                                <tr>
                                                    <td class="col-md-4 col-sm-4"><b>Created On</b></td>
                                                    <td class="col-md-8 col-sm-8">{{ instance.createdDateTime *1000 | date:'yyyy-MM-dd HH:mm:ss'}}</td>
                                                </tr>
                                                <tr>
                                                    <td><b>Instance ID</b></td>
                                                    <td>VM-{{ instance.uuid}}</td>
                                                </tr>
                                                <tr>
                                                    <td><b>Subscription</b></td>
                                                    <td>Free</td>
                                                </tr>
                                                <tr>
                                                    <td><b>Domain</b></td>
                                                    <td>{{ instance.domain.name}}</td>
                                                </tr>
                                                <tr>
                                                    <td><b>Account</b></td>
                                                    <td>{{ instance.instanceOwner.userName}}</td>
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
            <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'config'}" id="step1-config">
                <div data-ng-include src="'app/views/cloud/instance/configuration.jsp'"></div>
            </div>
            <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'storage'}" id="step1-storage">
                <div data-ng-include src="'app/views/cloud/instance/storage.jsp'"></div>
            </div>
            <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'network'}" id="step1-network">
                <div data-ng-include src="'app/views/cloud/instance/network-config.jsp'"></div>
            </div>
            <div class="tab-pane"  data-ng-class="{'active' : templateCategory == 'monitor'}" id="step1-monitor">
                <div data-ng-include src="'app/views/cloud/instance/monitor.jsp'"></div>
            </div>
        </div>


    </div>
</div>
