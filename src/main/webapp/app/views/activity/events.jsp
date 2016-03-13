<div class="hpanel" >
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
                       <!--  <span data-ng-hide="activity.oneItemSelected.events">
                            <a class="btn btn-info" data-ng-click="archiveGlobal()"><span class="fa fa-file-archive-o"></span> Archive Events</a>
                            <a class="btn btn-info" data-ng-click="deleteGlobal()"><span class="fa fa-trash"></span> Delete Events</a>
                        </span>
                        <span data-ng-show="activity.oneItemSelected.events">
                            <a class="btn btn-info" data-ng-click="archive()"><span class="fa fa-file-archive-o"></span> Archive Events</a>
                            <a class="btn btn-info" data-ng-click="delete()"><span class="fa fa-trash"></span> Delete Events</a>
                        </span> -->
                        <a class="btn btn-info" data-ng-click="getActivityByCategory('events',1)" title="Refresh" ><span class="fa fa-refresh fa-lg "></span></a>
                    </span>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>



        <div class="clearfix"></div>
    </div>

    <div class="white-content">
        <div class="table-responsive">
            <table cellspacing="1" cellpadding="1" class="table  table-hover table-striped table-mailbox table-bordered ">
                <thead>
                    <tr>
                        <th><div class="checkbox checkbox-single checkbox-info">
                    <input type="checkbox" data-ng-model="activity.selectedAll.events" data-ng-click="checkAll();"><label></label>
                </div>
                </th>
                <th>Description</th>
                <th>Status</th>
                <th>Type</th>
                <th>Domain</th>
                <th>Account</th>
                <th>Date</th><!--
                <th>Action</th> -->
                </tr>
                </thead>
                <tbody>
                    <tr data-ng-repeat="event in activityList| filter: quickSearch">
                        <td class="">
                            <div class="checkbox checkbox-single checkbox-info">
                                <input type="checkbox" data-ng-model="event.isSelected" data-ng-click="checkOne(event)" >
                                <label></label>
                            </div>
                        </td>
                        <td><a data-ng-click="showDescription(event)">{{ event.message}}</a></td>
                        <td>{{ event.status}}</td>
                        <td>{{ event.event}}</td>
                        <td>{{owner.domain.name}}</td>
                        <td>{{owner.userName}}</td>
                        <td>{{event.eventDateTime * 1000  | date:'yyyy-MM-dd HH:mm:ss'}}</td>
                        <!-- <td>
                            <a class="icon-button"  data-ng-click="archive()" title="Archive"><span class="fa fa-file-archive-o"></span></a>
                            <a class="icon-button" data-ng-click="delete()"title="Delete"><span class="fa fa-trash"></span></a>
                        </td> -->
                    </tr>

                </tbody>
            </table>
        </div>
    </div>
    <pagination-content></pagination-content>
</div>
