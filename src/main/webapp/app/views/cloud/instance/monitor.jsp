
    <div class="m-l-sm m-r-sm " ng-controller="instanceMonitorCtrl">

        <div class="row " >

            <div class="col-lg-10 col-md-10 col-sm-12 col-md-offset-1 ">

                <div class="hpanel">
                    <div class="row">
                    <div class="pull-left ">
                        <h4 class="m-b-sm ng-binding pull-left">CPU Performance</h4>
                        

                    </div>
                    <div class="pull-right">
                        <a title="Refresh" href="javascript:void(0)" class="btn btn-info" ><span class="fa fa-refresh fa-lg "></span></a>

                    </div>

                    <div class="pull-right m-r-sm">

                        <select  class="form-control" name="actions" data-ng-init="instance.actions = instanceElements.actions[3].name" data-ng-model="instance.actions" ng-options="actions.name for actions in instanceElements.actions" >
                            <option value="">Minutes</option>
                        </select>
                    </div>
                    
                </div>
                    <div class="row"><hr class="m-t-xs"></div>
                    <div class="row">
                    <div class="chart">
                        <canvas linechart options="lineOptions" data="cpu" width="780" height="220"></canvas>
                    </div></div>
                    <table>
                        <tbody>
                            <tr>
                                <td class="legendColorBox p-xs">
                                    <div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #E56919;overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">CPU 0</td>
                                <td class="legendColorBox p-xs"><div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #16658D;overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">CPU 1</td><td class="legendColorBox p-xs"><div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #7208A8;overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">CPU 2</td><td class="legendColorBox p-xs"><div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid rgba(98,203,49,0.5);overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">CPU 3</td></tr></tbody></table>

                </div>
            </div>
                                    <!--<hr class="m-t-xs">-->
                                    

        </div>
        <div class="row" >

            <div class="col-lg-10 col-md-10 col-sm-12 col-md-offset-1 ">

                <div class="hpanel">
                    <div class="row">
                    <div class="pull-left">
                        <h4 class="m-b-sm ng-binding pull-left">Memory Performance</h4>


                    </div>
                    <div class="pull-right">
                        <a href="javascript:void(0);" title="Refresh"  class="btn btn-info" href="#/instance/list"><span class="fa fa-refresh fa-lg "></span></a>

                    </div>

                    <div class="pull-right m-r-sm">

                        <select  class="form-control" name="actions" data-ng-init="instance.actions = instanceElements.actions[3].name" data-ng-model="instance.actions" ng-options="actions.name for actions in instanceElements.actions" >
                            <option value="">Minutes</option>
                        </select>
                    </div>
                    </div>
                    <div class="row"><hr class="m-t-xs"></div>
                    <div class="row">
                    <div class="chart">
                        <canvas linechart options="lineOptions" data="memory" width="780" height="220"></canvas>
                    </div>
                    </div>
                    <table>
                        <tbody>
                            <tr>
                                <td class="legendColorBox p-xs">
                                    <div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #E56919;overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">Used Memory</td>
                                <td class="legendColorBox p-xs"><div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #16658D;overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">Unused Memory</td><td class="legendColorBox p-xs">
                                </td>
                                </tr></tbody></table>

                </div>
            </div>
        </div>
        <div class="row" >

            <div class="col-lg-10 col-md-10 col-sm-12 col-md-offset-1 ">

                <div class="hpanel">
                    <div class="row">
                    <div class="pull-left">
                        <h4 class="m-b-sm ng-binding pull-left">Network Performance</h4>


                    </div>
                    <div class="pull-right">
                        <a href="javascript:void(0);" title="Refresh" class="btn btn-info" href="#/instance/list"><span class="fa fa-refresh fa-lg "></span></a>

                    </div>

                    <div class="pull-right m-r-sm">

                        <select  class="form-control" name="actions" data-ng-init="instance.actions = instanceElements.actions[3].name" data-ng-model="instance.actions" ng-options="actions.name for actions in instanceElements.actions" >
                            <option value="">Minutes</option>
                        </select>
                    </div>
                    </div>
                    <div class="row"><hr class="m-t-xs"></div>
                    <div class="row">
                    <div class="chart">
                        <canvas linechart options="lineOptions" data="network" width="780" height="220"></canvas>
                    </div>
                    </div>
                    <table>
                        <tbody>
                            <tr>
                                <td class="legendColorBox p-xs">
                                    <div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #E56919;overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">NIC 0 - Receive</td>
                                <td class="legendColorBox p-xs"><div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #16658D;overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">NIC 0 - Send</td><td class="legendColorBox p-xs"><div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #7208A8;overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">NIC 1 - Send</td><td class="legendColorBox p-xs"><div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid rgba(98,203,49,0.5);overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">NIC 1 - Receive</td></tr></tbody></table>

                </div>
            </div>
        </div>
        <div class="row " >

            <div class="col-lg-10 col-md-10 col-sm-12 col-md-offset-1 ">

                <div class="hpanel">
                    <div class="row">
                    <div class="pull-left">
                        <h4 class="m-b-sm ng-binding pull-left">Disk Performance</h4>


                    </div>
                    <div class="pull-right">
                        <a href="javascript:void(0);" title="Refresh" class="btn btn-info" href="#/instance/list"><span class="fa fa-refresh fa-lg "></span></a>

                    </div>

                    <div class="pull-right m-r-sm">

                        <select  class="form-control" name="actions" data-ng-init="instance.actions = instanceElements.actions[3].name" data-ng-model="instance.actions" ng-options="actions.name for actions in instanceElements.actions" >
                            <option value="">Minutes</option>
                        </select>
                    </div>
                    </div>
                    <div class="row"><hr class="m-t-xs"></div>
                    <div class="row">
                    <div class="chart">
                        <canvas linechart options="lineOptions" data="disk" width="780" height="220"></canvas>
                    </div>
                    </div>
                    <table>
                        <tbody>
                            <tr>
                                <td class="legendColorBox p-xs">
                                    <div style="border:1px solid #ccc;padding:1px"><div style="width:4px;height:0;border:5px solid #E56919;overflow:hidden"></div></div>
                                </td>
                                <td class="legendLabel">Disk IOPS</td>
                               
                                </tr></tbody></table>

                </div>
            </div>
        </div>
      </div>


