<div class="row" ng-controller="billingCtrl">
    <div class="col-md-12">
        <div class="hpanel">
            <div class="panel-heading"></div>

            <div class="col-md-offset-1 col-md-10">
                <div class="table-responsive">
                    <table cellspacing="1" cellpadding="1"
                        class="table table-bordered white-content">
                        <thead>
                            <tr class="bg-primary">
                                <th width="65%">Services</th>
                                <th width="20%" class="text-center">Usage (Days)</th>
                                <th width="15%" class="text-center">Bill</th>
                            </tr>
                        </thead>
                        <tbody ng-repeat="(key, value) in usageStatistics | groupBy: 'billableType'">
                            <tr >
                                <td colspan="3" class="text-primary font-bold bg-info">{{ key }}</td>
                            </tr>
                            <tr ng-repeat="usage in value">
                                <td><span class="m-l-lg">{{ usage.usageid }} - {{ usage.usagetype}}</span></td>
                                <td class="text-center">{{ usage.usageUnits }}</td>
                                <td class="text-right">{{ usage.planCost }}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="table-responsive">
                    <table cellspacing="1" cellpadding="1"
                        class="table table-bordered white-content">
                        <thead>
                            <tr class="bg-primary">
                                <th width="65%">Department Name</th>
                                <th width="20%" class="text-center">Usage (Days)</th>
                                <th width="15%" class="text-center">Bill</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="3" class="text-primary font-bold bg-info">Department
                                    1</td>
                            </tr>
                            <tr>
                                <td><span class="m-l-lg">VMs</span></td>
                                <td class="text-center">2</td>
                                <td class="text-right">6.50</td>
                            </tr>
                            <tr>
                                <td><span class="m-l-lg">Disk</span></td>
                                <td class="text-center">4</td>
                                <td class="text-right">4.22</td>
                            </tr>
                            <tr>
                                <td class="bg-light font-bold"><span class="m-l-lg">SubTotal</span></td>
                                <td class="bg-light font-bold text-center">13</td>
                                <td class="bg-light font-bold text-right">18.73</td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-primary font-bold bg-info">Department
                                    2</td>
                            </tr>
                            <tr>
                                <td><span class="m-l-lg">IP</span></td>
                                <td class="text-center">2</td>
                                <td class="text-right">3.55</td>
                            </tr>
                            <tr>
                                <td><span class="m-l-lg">Snapshot</span></td>
                                <td class="text-center">3</td>
                                <td class="text-right">1.20</td>
                            </tr>
                            <tr>
                                <td><span class="m-l-lg">Template</span></td>
                                <td class="text-center">2</td>
                                <td class="text-right">3.26</td>
                            </tr>
                            <tr>
                                <td class="bg-light font-bold"><span class="m-l-lg">SubTotal</span></td>
                                <td class="bg-light font-bold text-center">13</td>
                                <td class="bg-light font-bold text-right">18.73</td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-primary font-bold bg-info">Department
                                    3</td>
                            </tr>
                            <tr>
                                <td><span class="m-l-lg">IP</span></td>
                                <td class="text-center">2</td>
                                <td class="text-right">3.55</td>
                            </tr>
                            <tr>
                                <td><span class="m-l-lg">Snapshot</span></td>
                                <td class="text-center">3</td>
                                <td class="text-right">1.20</td>
                            </tr>
                            <tr>
                                <td><span class="m-l-lg">Template</span></td>
                                <td class="text-center">2</td>
                                <td class="text-right">3.26</td>
                            </tr>
                            <tr>
                                <td class="bg-light font-bold"><span class="m-l-lg">SubTotal</span></td>
                                <td class="bg-light font-bold text-center">13</td>
                                <td class="bg-light font-bold text-right">18.73</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="table-responsive">
                    <table cellspacing="1" cellpadding="1"
                        class="table table-bordered white-content">
                        <thead>
                            <tr class="bg-primary">
                                <th width="65%">Project Name</th>
                                <th width="20%" class="text-center">Usage (Days)</th>
                                <th width="15%" class="text-center">Bill</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="3" class="text-primary font-bold bg-info">Project
                                    1</td>
                            </tr>
                            <tr>
                                <td><span class="m-l-lg">VMs</span></td>
                                <td class="text-center">2</td>
                                <td class="text-right">3.55</td>
                            </tr>
                            <tr>
                                <td><span class="m-l-lg">Storage</span></td>
                                <td class="text-center">2</td>
                                <td class="text-right">3.55</td>
                            </tr>
                            <tr>
                                <td><span class="m-l-lg">Public IP</span></td>
                                <td class="text-center">2</td>
                                <td class="text-right">3.55</td>
                            </tr>
                            <tr>
                                <td><span class="m-l-lg">Template</span></td>
                                <td class="text-center">2</td>
                                <td class="text-right">3.26</td>
                            </tr>
                            <tr>
                                <td><span class="m-l-lg">Snapshot</span></td>
                                <td class="text-center">3</td>
                                <td class="text-right">1.20</td>
                            </tr>
                            <tr>
                                <td class="bg-light font-bold"><span class="m-l-lg">SubTotal</span></td>
                                <td class="bg-light font-bold text-center">13</td>
                                <td class="bg-light font-bold text-right">18.73</td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-primary font-bold bg-info">Project
                                    2</td>
                            </tr>
                            <tr>
                                <td><span class="m-l-lg">VMs</span></td>
                                <td class="text-center">2</td>
                                <td class="text-right">3.55</td>
                            </tr>
                            <tr>
                                <td><span class="m-l-lg">Storage</span></td>
                                <td class="text-center">2</td>
                                <td class="text-right">3.55</td>
                            </tr>
                            <tr>
                                <td><span class="m-l-lg">Public IP</span></td>
                                <td class="text-center">2</td>
                                <td class="text-right">3.55</td>
                            </tr>
                            <tr>
                                <td><span class="m-l-lg">Template</span></td>
                                <td class="text-center">2</td>
                                <td class="text-right">3.26</td>
                            </tr>
                            <tr>
                                <td><span class="m-l-lg">Snapshot</span></td>
                                <td class="text-center">3</td>
                                <td class="text-right">1.20</td>
                            </tr>
                            <tr>
                                <td class="bg-light font-bold"><span class="m-l-lg">SubTotal</span></td>
                                <td class="bg-light font-bold text-center">13</td>
                                <td class="bg-light font-bold text-right">18.73</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <br>
            <br>
            <div class="row">
                <div class="col-sm-6">
                    <div aria-live="polite" role="status" id="example2_info"
                        class="dataTables_info"></div>
                </div>
                <div class="col-sm-6">
                    <div id="example2_paginate"
                        class="dataTables_paginate paging_simple_numbers">
                        <ul class="pagination">
                            <li id="example2_previous" tabindex="0" aria-controls="example2"
                                class="paginate_button previous disabled"><a href="#">Previous</a></li>
                            <li tabindex="0" aria-controls="example2"
                                class="paginate_button active"><a href="#">1</a></li>
                            <li tabindex="0" aria-controls="example2"
                                class="paginate_button "><a href="#">2</a></li>
                            <li tabindex="0" aria-controls="example2"
                                class="paginate_button "><a href="#">3</a></li>
                            <li tabindex="0" aria-controls="example2"
                                class="paginate_button "><a href="#">4</a></li>
                            <li tabindex="0" aria-controls="example2"
                                class="paginate_button "><a href="#">5</a></li>
                            <li id="example2_next" tabindex="0" aria-controls="example2"
                                class="paginate_button next"><a href="#">Next</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</div>
.
