<form name="form.detachForm">
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header hide-zone="false"  page-title="View Ticket"></panda-modal-header>                

        </div>

        <div class="modal-body" >
            <div class=" row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="table-responsive">
                        <table cellspacing="2" cellpadding="5"  class=" w-m table  table-hover table-striped table-mailbox table-bordered ">
                            <tr> <td><label>ID</label></td><td>{{ support.id}}</td></tr>
                            <tr>  <td><label>Subject</label></td> <td>{{support.subject}}</td></tr>
                            <tr> <td><label>Department</label></td> <td>{{ support.department}}</td></tr>
                            <tr> <td><label>Priority</label></td> <td>{{ support.priority}}</td></tr>
                            <tr> <td><label>Description</label></td><td>{{ support.description}}</td></tr>
                        </table>
                    </div>
                </div>

            </div>    
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-info " ng-click="cancel()" data-dismiss="modal">Close</button>
        </div>
    </div>

</form>