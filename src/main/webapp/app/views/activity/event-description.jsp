<div class="row" >
    <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="table-responsive">
            <table cellspacing="2" cellpadding="5"  class=" w-m table  table-hover table-striped table-mailbox table-bordered ">
                <tr> <td><label>ID</label></td><td>{{ activity.id}}</td></tr>
                <tr> <td><label>Resource ID</label></td><td>{{ activity.resourceUuid}}</td></tr>
                <tr>  <td><label>Description</label></td> <td>{{ activity.message}}</td></tr>
                <tr> <td><label>State</label></td> <td>{{ activity.status}}</td></tr>
                <tr> <td><label>Type</label></td><td>{{ activity.event}}</td></tr>
                <tr> <td><label>Domain</label></td><td>{{activity.owner.domain.name}}</td></tr>
                <tr> <td><label>Department</label></td><td>{{activity.owner.department.userName}}</td></tr>
                <tr> <td><label>Initiated-by</label></td> <td>{{activity.owner.userName}}</td></tr>
                <tr> <td><label>Date</label></td><td>{{activity.eventDateTime * 1000  | date:'yyyy-MM-dd HH:mm:ss'}}</td></tr>
            </table>
        </div>
    </div>
</div>
