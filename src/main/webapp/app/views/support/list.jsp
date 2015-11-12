<div ui-view>
    <div class="row" data-ng-controller="supportListCtrl">

        <div class="col-md-12 col-sm-12">
            <div class="hpanel">
                <div class="panel-heading">
                    

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
                                    <span data-ng-hide="oneItemSelected">
                                    <a class="btn btn-info" data-ng-click="openDeleteContainer('sm')"><span class="fa fa-trash"></span> Delete Ticket</a>
                                   </span>
                        
                                    <span data-ng-show="oneItemSelected">
                                    <a class="btn btn-info" data-ng-click="openDeleteTicketContainer('sm')"><span class="fa fa-trash"></span> Delete Ticket</a>
                                    </span>
                                    <a class="btn btn-info"  ng-click="openAddTicketContainer()"><span class="pe pe-7s-plus font-bold fa-lg  m-r-sm"></span>Add Ticket</a>

                                    <a class="btn btn-info" ui-sref="support.tickets" title="Refresh"  ui-sref-opts="{reload: true}"><span class="fa fa-refresh fa-lg"></span></a>
                                    </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="white-content">
                    <div class="table-responsive">
                        <table cellspacing="1" cellpadding="1" class="table table-bordered table-striped table-hover table-mailbox">
                            <thead>
                                <tr>

                                    <th class="col-md-1 col-sm-1"><div class="checkbox checkbox-single checkbox-info">
                                <input type="checkbox" data-ng-model="selectedAll.support" data-ng-click="checkAll();">                                <label></label>
                            </div>
                            </th>  
                            <th class="col-md-1 col-sm-1">Id</th>
                            <th class="col-md-2 col-sm-2">Department</th>
                            <th >Subject</th>
                            <th class="col-md-2 col-sm-2">Priority</th>

                            </tr>
                            </thead>
                            <tbody>
                                <tr data-ng-repeat="support in supportList| filter:quickSearch">
                                    <td class="">
                                        <div class="checkbox checkbox-single checkbox-info">
                                            <input type="checkbox" data-ng-model="support.isSelected" data-ng-click="checkOne(support)">
                                            <label></label>
                                        </div>
                                    </td>
                                    <td>
                                        <a data-ng-click="showDescription(support)"  title="View Ticket">
                                            <div class="w-100">
                                                {{ support.id}}
                                            </div>
                                        </a>
                                    </td>

                                    <td >
                                        <a data-ng-click="showDescription(support)"  title="View Ticket"><div class="w-100">   {{ support.department}}</div></a>
                                    </td>
                                    <td >
                                        <a data-ng-click="showDescription(support)"  title="View Ticket"> <div class="w-100">{{ support.subject}}</div></a>
                                    </td>
                                    <td  >
                                        <a data-ng-click="showDescription(support)"  title="View Ticket"> <div class="w-100">{{ support.priority}}</div></a>
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