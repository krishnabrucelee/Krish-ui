<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="table-responsive">
            <table cellspacing="1" cellpadding="1"  class=" w-m table  table-hover table-striped table-mailbox table-bordered ">
                <tr> <td><label>ID</label></td><td>{{ activity.id}}</td></tr>
                <tr> <td><label>Description</label></td> <td>{{ activity.message}}</td></tr>
                 <tr> <td><label>Type</label></td> <td>{{ activity.event}}</td></tr>
                <tr> <td><label>Date</label></td><td>{{ activity.eventDateTime * 1000  | date:'yyyy-MM-dd HH:mm:ss'}}</td></tr>
            </table>
        </div>
    </div>
</div>
