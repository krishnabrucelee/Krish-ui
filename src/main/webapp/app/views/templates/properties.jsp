<form name="form.detachForm" >
    <div class="inmodal" >
        <div class="modal-header">
            <panda-modal-header hide-zone="false"  page-title="{{templateObj.name}}"></panda-modal-header>                

        </div>

        <div class="modal-body" >
            <div class=" row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="table-responsive">
                        <table cellspacing="2" cellpadding="5"  class="table table-hover table-striped table-bordered ">
                            <tr> <td><label>Name</label></td><td>{{ templateObj.name}}</td></tr>
                            <tr>  <td><label>Size</label></td> <td>{{templateObj.size}}</td></tr>
                            <tr> <td><label>Status</label></td> <td>{{ templateObj.status}}</td></tr>
                            <tr>  <td><label>Template Owner</label></td> <td>{{templateObj.owner}}</td></tr>
                            <tr> <td><label>Register Date</label></td> <td>{{ templateObj.registerDate}}</td></tr>
                            <tr> <td><label>Format</label></td> <td>{{ templateObj.format}}</td></tr>
                            <tr> <td><label>HVM</label></td><td>{{ templateObj.hvm}}</td></tr>
                            <tr> <td><label>Password Enabled </label></td><td>{{ templateObj.passwordEnabled}}</td></tr>
                             <tr> <td><label>Dynamically Scalable</label></td><td>{{ templateObj.dynamicallyScalable}}</td></tr>
                        </table>
                    </div>
                </div>
                
            </div>    
        </div>
        <div class="modal-footer">
                    <button type="button" class="btn btn-info " ng-click="cancel()" data-dismiss="modal">Ok</button>
                </div>
    </div>

</form>